From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 10/10] userdiff: have 'cpp' hunk header pattern catch more C++ anchor points
Date: Fri, 21 Mar 2014 22:07:22 +0100
Message-ID: <49db8b0f66c725ef6ff0b8a4d536c43e6397879a.1395433874.git.j6t@kdbg.org>
References: <53282741.5010609@web.de> <cover.1395433874.git.j6t@kdbg.org>
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:09:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR6gq-0003oA-Ep
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbaCUVJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 17:09:12 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:62485 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751241AbaCUVJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 17:09:09 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 1863ECEA73
	for <git@vger.kernel.org>; Fri, 21 Mar 2014 22:09:08 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1FDBEA7EB3;
	Fri, 21 Mar 2014 22:08:55 +0100 (CET)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id C0C7119F6A4;
	Fri, 21 Mar 2014 22:08:54 +0100 (CET)
X-Mailer: git-send-email 1.8.5.2.244.g9fb3fb1
In-Reply-To: <cover.1395433874.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244748>

The hunk header pattern 'cpp' is intended for C and C++ source code, but
it is actually not particularly useful for the latter, and even misses
some use-cases for the former.

The parts of the pattern have the following flaws:

- The first part matches an identifier followed immediately by a colon
  and arbitrary text and is intended to reject goto labels and C++
  access specifiers (public, private, protected). But this pattern also
  rejects C++ constructs, which look like this:

    MyClass::MyClass()
    MyClass::~MyClass()
    MyClass::Item MyClass::Find(...

- The second part matches an identifier followed by a list of qualified
  names (i.e. identifiers separated by the C++ scope operator '::')
  separated by space or '*' followed by an opening parenthesis (with
  space between the tokens). It matches function declarations like

    struct item* get_head(...
    int Outer::Inner::Func(...

  Since the pattern requires at least two identifiers, GNU-style
  function definitions are ignored:

    void
    func(...

  Moreover, since the pattern does not allow punctuation other than '*',
  the following C++ constructs are not recognized:

  . template definitions:
      template<class T> int func(T arg)

  . functions returning references:
      const string& get_message()

  . functions returning templated types:
      vector<int> foo()

  . operator definitions:
      Value operator+(Value l, Value r)

- The third part of the pattern finally matches compound definitions.
  But it forgets about unions and namespaces, and also skips single-line
  definitions

    struct random_iterator_tag {};

  because no semicolon can occur on the line.

Change the first pattern to require a colon at the end of the line
(except for trailing space and comments), so that it does not reject
constructor or destructor definitions.

Notice that all interesting anchor points begin with an identifier or
keyword. But since there is a large variety of syntactical constructs
after the first "word", the simplest is to require only this word and
accept everything else. Therefore, this boils down to a line that begins
with a letter or underscore (optionally preceded by the C++ scope
operator '::' to accept functions returning a type anchored at the
global namespace). Replace the second and third part by a single pattern
that picks such a line.

This has the following desirable consequence:

- All constructs mentioned above are recognized.

and the following likely desirable consequences:

- Definitions of global variables and typedefs are recognized:

    int num_entries = 0;
    extern const char* help_text;
    typedef basic_string<wchar_t> wstring;

- Commonly used marco-ized boilerplate code is recognized:

    BEGIN_MESSAGE_MAP(CCanvas,CWnd)
    Q_DECLARE_METATYPE(MyStruct)
    PATTERNS("tex",...)

  (The last one is from this very patch.)

but also the following possibly undesirable consequence:

- When a label is not on a line by itself (except for a comment) it is
  no longer rejected, but can appear as a hunk header if it occurs at
  the beginning of a line:

    next:;

IMO, the benefits of the change outweigh the (possible) regressions by a
large margin.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4018/cpp-class-constructor              | 1 -
 t/t4018/cpp-class-constructor-mem-init     | 1 -
 t/t4018/cpp-class-destructor               | 1 -
 t/t4018/cpp-function-returning-global-type | 1 -
 t/t4018/cpp-function-returning-nested      | 1 -
 t/t4018/cpp-function-returning-reference   | 1 -
 t/t4018/cpp-gnu-style-function             | 1 -
 t/t4018/cpp-namespace-definition           | 1 -
 t/t4018/cpp-operator-definition            | 1 -
 t/t4018/cpp-struct-single-line             | 1 -
 t/t4018/cpp-template-function-definition   | 1 -
 t/t4018/cpp-union-definition               | 1 -
 userdiff.c                                 | 8 +++-----
 13 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/t/t4018/cpp-class-constructor b/t/t4018/cpp-class-constructor
index 4c4925c..ec4f115 100644
--- a/t/t4018/cpp-class-constructor
+++ b/t/t4018/cpp-class-constructor
@@ -1,5 +1,4 @@
 Item::Item(int RIGHT)
 {
 	ChangeMe;
-	broken;
 }
diff --git a/t/t4018/cpp-class-constructor-mem-init b/t/t4018/cpp-class-constructor-mem-init
index eec1d7c..49a69f3 100644
--- a/t/t4018/cpp-class-constructor-mem-init
+++ b/t/t4018/cpp-class-constructor-mem-init
@@ -2,5 +2,4 @@ Item::Item(int RIGHT) :
 	member(0)
 {
 	ChangeMe;
-	broken;
 }
diff --git a/t/t4018/cpp-class-destructor b/t/t4018/cpp-class-destructor
index 03aa51c..5487665 100644
--- a/t/t4018/cpp-class-destructor
+++ b/t/t4018/cpp-class-destructor
@@ -1,5 +1,4 @@
 RIGHT::~RIGHT()
 {
 	ChangeMe;
-	broken;
 }
diff --git a/t/t4018/cpp-function-returning-global-type b/t/t4018/cpp-function-returning-global-type
index bff3e5f..1084d59 100644
--- a/t/t4018/cpp-function-returning-global-type
+++ b/t/t4018/cpp-function-returning-global-type
@@ -1,5 +1,4 @@
 ::Item get::it::RIGHT()
 {
 	ChangeMe;
-	broken;
 }
diff --git a/t/t4018/cpp-function-returning-nested b/t/t4018/cpp-function-returning-nested
index 41700f2..d9750aa 100644
--- a/t/t4018/cpp-function-returning-nested
+++ b/t/t4018/cpp-function-returning-nested
@@ -1,6 +1,5 @@
 get::Item get::it::RIGHT()
 {
 	ChangeMe;
-	broken;
 }
 
diff --git a/t/t4018/cpp-function-returning-reference b/t/t4018/cpp-function-returning-reference
index 29e2bd4..01b051d 100644
--- a/t/t4018/cpp-function-returning-reference
+++ b/t/t4018/cpp-function-returning-reference
@@ -1,5 +1,4 @@
 string& get::it::RIGHT(char *ptr)
 {
 	ChangeMe;
-	broken;
 }
diff --git a/t/t4018/cpp-gnu-style-function b/t/t4018/cpp-gnu-style-function
index d65fc74..08c7c75 100644
--- a/t/t4018/cpp-gnu-style-function
+++ b/t/t4018/cpp-gnu-style-function
@@ -2,5 +2,4 @@ const char *
 RIGHT(int arg)
 {
 	ChangeMe;
-	broken;
 }
diff --git a/t/t4018/cpp-namespace-definition b/t/t4018/cpp-namespace-definition
index 6b88dd9..6749980 100644
--- a/t/t4018/cpp-namespace-definition
+++ b/t/t4018/cpp-namespace-definition
@@ -1,5 +1,4 @@
 namespace RIGHT
 {
 	ChangeMe;
-	broken;
 }
diff --git a/t/t4018/cpp-operator-definition b/t/t4018/cpp-operator-definition
index f2bd167..1acd827 100644
--- a/t/t4018/cpp-operator-definition
+++ b/t/t4018/cpp-operator-definition
@@ -1,5 +1,4 @@
 Value operator+(Value LEFT, Value RIGHT)
 {
 	ChangeMe;
-	broken;
 }
diff --git a/t/t4018/cpp-struct-single-line b/t/t4018/cpp-struct-single-line
index ad6fa8b..a0de5fb 100644
--- a/t/t4018/cpp-struct-single-line
+++ b/t/t4018/cpp-struct-single-line
@@ -5,4 +5,3 @@ void wrong()
 struct RIGHT_iterator_tag {};
 
 int ChangeMe;
-// broken
diff --git a/t/t4018/cpp-template-function-definition b/t/t4018/cpp-template-function-definition
index a410298..0cdf5ba 100644
--- a/t/t4018/cpp-template-function-definition
+++ b/t/t4018/cpp-template-function-definition
@@ -1,5 +1,4 @@
 template<class T> int RIGHT(T arg)
 {
 	ChangeMe;
-	broken;
 }
diff --git a/t/t4018/cpp-union-definition b/t/t4018/cpp-union-definition
index 133b662..7ec94df 100644
--- a/t/t4018/cpp-union-definition
+++ b/t/t4018/cpp-union-definition
@@ -1,5 +1,4 @@
 union RIGHT {
 	double v;
 	int ChangeMe;
-	broken;
 };
diff --git a/userdiff.c b/userdiff.c
index 8830417..fad52d6 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -125,11 +125,9 @@
 	 "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\x80-\xff]+"),
 PATTERNS("cpp",
 	 /* Jump targets or access declarations */
-	 "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:.*$\n"
-	 /* C/++ functions/methods at top level */
-	 "^([A-Za-z_][A-Za-z_0-9]*([ \t*]+[A-Za-z_][A-Za-z_0-9]*([ \t]*::[ \t]*[^[:space:]]+)?){1,}[ \t]*\\([^;]*)$\n"
-	 /* compound type at top level */
-	 "^((struct|class|enum)[^;]*)$",
+	 "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:[[:space:]]*($|/[/*])\n"
+	 /* functions/methods, variables, and compounds at top level */
+	 "^((::[[:space:]]*)?[A-Za-z_].*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lLuU]*"
-- 
1.8.5.2.244.g9fb3fb1
