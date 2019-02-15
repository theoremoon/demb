module demb.parser;

import pegged.grammar;
import demb.peg;
import demb.ast;
import std.conv;

AST toAST(ParseTree p) {
  final switch (p.name) {
    case "Demb":
    case "Demb.TopLevel":
    case "Demb.Stmt":
    case "Demb.Expression":
      return p.children[0].toAST;

    case "Demb.PrintStmt":
      return new PrintAST([p.children[0].toAST]);

    case "Demb.AddExpression":
      return new AddAST([p.children[0].toAST, p.children[1].toAST]);

    case "Demb.Primary":
      return p.children[0].toAST;

    case "Demb.Number":
      return new NumberAST(p.matches[0].to!long);
  }
}
unittest {
  auto ast = Demb("1 + 1").toAST;
  assert((cast(AddAST)ast));
}