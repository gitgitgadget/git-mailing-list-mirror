From: Adrian Johnson <ajohnson@redneon.com>
Subject: [PATCHv2] Add userdiff patterns for Ada
Date: Mon, 17 Sep 2012 22:12:20 +0930
Message-ID: <50571AAC.5070607@redneon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 14:42:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDaem-0000FB-N7
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 14:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016Ab2IQMmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 08:42:24 -0400
Received: from redneon.com ([76.191.252.68]:44264 "EHLO redneon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782Ab2IQMmX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 08:42:23 -0400
Received: from bearcat.lan (ppp121-45-48-176.lns20.adl2.internode.on.net [121.45.48.176])
	by redneon.com (Postfix) with ESMTPA id 302D1193027D
	for <git@vger.kernel.org>; Mon, 17 Sep 2012 22:12:22 +0930 (CST)
Received: from [192.168.1.1] (bearcat.lan [192.168.1.1])
	by bearcat.lan (Postfix) with ESMTP id 51FAD40256B2
	for <git@vger.kernel.org>; Mon, 17 Sep 2012 22:12:20 +0930 (CST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205683>

Add Ada xfuncname and wordRegex patterns to the list of builtin
patterns.

Signed-off-by: Adrian Johnson <ajohnson@redneon.com>
---
On 17/09/12 14:29, Junio C Hamano wrote:
> You could add test vectors to check if the built-in xfuncname
> catches beginning of functions in Ada correctly if you wanted to,
> but I think observing what appears on @@ lines in t4034 test vector
> would be a sufficient test.

I've added additional Ada code to the t4034 test to test xfuncname.

 Documentation/gitattributes.txt |  2 ++
 t/t4018-diff-funcname.sh        |  2 +-
 t/t4034-diff-words.sh           |  1 +
 t/t4034/ada/expect              | 56 ++++++++++++++++++++++++++++++++++++++
 t/t4034/ada/post                | 59 +++++++++++++++++++++++++++++++++++++++++
 t/t4034/ada/pre                 | 59 +++++++++++++++++++++++++++++++++++++++++
 userdiff.c                      |  9 +++++++
 7 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 t/t4034/ada/expect
 create mode 100644 t/t4034/ada/post
 create mode 100644 t/t4034/ada/pre

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 462b79c..99ed04d 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -511,6 +511,8 @@ configuration file (you still need to enable this with the
 attribute mechanism, via `.gitattributes`).  The following built in
 patterns are available:
 
+- `ada` suitable for source code in the Ada language.
+
 - `bibtex` suitable for files with BibTeX coded references.
 
 - `cpp` suitable for source code in the C and C++ languages.
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 4bd2a1c..082d3e8 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -105,7 +105,7 @@ test_expect_funcname () {
 	grep "^@@.*@@ $1" diff
 }
 
-for p in bibtex cpp csharp fortran html java matlab objc pascal perl php python ruby tex
+for p in ada bibtex cpp csharp fortran html java matlab objc pascal perl php python ruby tex
 do
 	test_expect_success "builtin $p pattern compiles" '
 		echo "*.java diff=$p" >.gitattributes &&
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 30d42cb..40ab333 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -298,6 +298,7 @@ test_expect_success 'unset default driver' '
 	test_unconfig diff.wordregex
 '
 
+test_language_driver ada
 test_language_driver bibtex
 test_language_driver cpp
 test_language_driver csharp
diff --git a/t/t4034/ada/expect b/t/t4034/ada/expect
new file mode 100644
index 0000000..b193519
--- /dev/null
+++ b/t/t4034/ada/expect
@@ -0,0 +1,56 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 6874c06..851f9e8 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -4,7 +4,7 @@<RESET> <RESET><MAGENTA>package body Beer is<RESET>
+
+   package Text_IO renames Ada.Text_IO;<RESET>
+
+   type Bottle_Num is range 0 .. <RED>99<RESET><GREEN>98<RESET>;
+
+   package Bottle_Num_IO is new Text_IO.Integer_IO(Bottle_Num);<RESET>
+   use Bottle_Num_IO;<RESET>
+<CYAN>@@ -13,7 +13,7 @@<RESET> <RESET><MAGENTA>function Take_Beer (Beer : Bottle_Num) return Bottle_Num is<RESET>
+   begin<RESET>
+      -- Add two lines to ensure function<RESET>
+      -- name appears in the hunk header.<RESET>
+      return Beer - <RED>1<RESET><GREEN>2<RESET>;
+   end Take_Beer;<RESET>
+
+   procedure Main is<RESET>
+<CYAN>@@ -27,7 +27,7 @@<RESET> <RESET><MAGENTA>procedure Main is<RESET>
+	 Put(" bottles of beer on the wall ");<RESET>
+	 Put(Bottles);<RESET>
+	 Put_Line(" bottles of beer");<RESET>
+	 Bottles := <RED>Take_Beer<RESET><GREEN>Take_Two_Beers<RESET>(Bottles);
+	 Put("Take one down, pass it around, ");<RESET>
+	 Put(Bottles);<RESET>
+	 Put_Line(" bottles of beer on the wall.");<RESET>
+<CYAN>@@ -41,18 +41,18 @@<RESET> <RESET><MAGENTA>procedure Word_Diff is<RESET>
+   -- Test wordDiff regex with Ada operators<RESET>
+   begin<RESET>
+
+1 1e-10 16#FE12#E2 3.141_592 '<RED>x<RESET><GREEN>y<RESET>'
+<RED>a<RESET><GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>**<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>(<RED>b<RESET><GREEN>y<RESET>)
+<RED>a<RESET><GREEN>x<RESET>:=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>/= <RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>,<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>=><RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>..<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><><RED>b<RESET><GREEN>y<RESET>
+
+   end Word_Diff;<RESET>
+
diff --git a/t/t4034/ada/post b/t/t4034/ada/post
new file mode 100644
index 0000000..851f9e8
--- /dev/null
+++ b/t/t4034/ada/post
@@ -0,0 +1,59 @@
+with Ada.Text_IO;
+
+package body Beer is
+
+   package Text_IO renames Ada.Text_IO;
+
+   type Bottle_Num is range 0 .. 98;
+
+   package Bottle_Num_IO is new Text_IO.Integer_IO(Bottle_Num);
+   use Bottle_Num_IO;
+
+   function Take_Beer (Beer : Bottle_Num) return Bottle_Num is
+   begin
+      -- Add two lines to ensure function
+      -- name appears in the hunk header.
+      return Beer - 2;
+   end Take_Beer;
+
+   procedure Main is
+      procedure Put_Line (Item: String) renames Text_IO.Put_Line;
+      procedure Put (Item: String) renames Text_IO.Put;
+      Bottles : Bottle_Num;
+   begin
+      Bottles := Bottle_Num'Last;
+      while Bottles > Bottle_Num'First loop
+	 Put(Bottles);
+	 Put(" bottles of beer on the wall ");
+	 Put(Bottles);
+	 Put_Line(" bottles of beer");
+	 Bottles := Take_Two_Beers(Bottles);
+	 Put("Take one down, pass it around, ");
+	 Put(Bottles);
+	 Put_Line(" bottles of beer on the wall.");
+      end loop;
+      Put_Line("Go to the store, buy some more,");
+      Put_Line("99 bottles of beer on the wall.");
+   end Main;
+
+
+   procedure Word_Diff is
+   -- Test wordDiff regex with Ada operators
+   begin
+
+1 1e-10 16#FE12#E2 3.141_592 'y'
+x+y x-y
+x*y x/y
+x**y
+x(y)
+x:=y
+x=y x/= y
+x<y x<=y x>y x>=y
+x,y
+x=>y
+x..y
+x<>y
+
+   end Word_Diff;
+
+end Beer;
diff --git a/t/t4034/ada/pre b/t/t4034/ada/pre
new file mode 100644
index 0000000..6874c06
--- /dev/null
+++ b/t/t4034/ada/pre
@@ -0,0 +1,59 @@
+with Ada.Text_IO;
+
+package body Beer is
+
+   package Text_IO renames Ada.Text_IO;
+
+   type Bottle_Num is range 0 .. 99;
+
+   package Bottle_Num_IO is new Text_IO.Integer_IO(Bottle_Num);
+   use Bottle_Num_IO;
+
+   function Take_Beer (Beer : Bottle_Num) return Bottle_Num is
+   begin
+      -- Add two lines to ensure function
+      -- name appears in the hunk header.
+      return Beer - 1;
+   end Take_Beer;
+
+   procedure Main is
+      procedure Put_Line (Item: String) renames Text_IO.Put_Line;
+      procedure Put (Item: String) renames Text_IO.Put;
+      Bottles : Bottle_Num;
+   begin
+      Bottles := Bottle_Num'Last;
+      while Bottles > Bottle_Num'First loop
+	 Put(Bottles);
+	 Put(" bottles of beer on the wall ");
+	 Put(Bottles);
+	 Put_Line(" bottles of beer");
+	 Bottles := Take_Beer(Bottles);
+	 Put("Take one down, pass it around, ");
+	 Put(Bottles);
+	 Put_Line(" bottles of beer on the wall.");
+      end loop;
+      Put_Line("Go to the store, buy some more,");
+      Put_Line("99 bottles of beer on the wall.");
+   end Main;
+
+
+   procedure Word_Diff is
+   -- Test wordDiff regex with Ada operators
+   begin
+
+1 1e-10 16#FE12#E2 3.141_592 'x'
+a+b a-b
+a*b a/b
+a**b
+a(b)
+a:=b
+a=b a/= b
+a<b a<=b a>b a>=b
+a,b
+a=>b
+a..b
+a<>b
+
+   end Word_Diff;
+
+end Beer;
diff --git a/userdiff.c b/userdiff.c
index 1e7184f..ed958ef 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -14,6 +14,15 @@ static int drivers_alloc;
 	{ name, NULL, -1, { pattern, REG_EXTENDED | REG_ICASE }, \
 	  word_regex "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" }
 static struct userdiff_driver builtin_drivers[] = {
+IPATTERN("ada",
+	 "!^(.*[ \t])?(is new|renames|is separate)([ \t].*)?$\n"
+	 "!^[ \t]*with[ \t].*$\n"
+	 "^[ \t]*((procedure|function)[ \t]+.*)$\n"
+	 "^[ \t]*((package|protected|task)[ \t]+.*)$",
+	 /* -- */
+	 "[a-zA-Z][a-zA-Z0-9_]*"
+	 "|[0-9][-+0-9#_.eE]"
+	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
 IPATTERN("fortran",
 	 "!^([C*]|[ \t]*!)\n"
 	 "!^[ \t]*MODULE[ \t]+PROCEDURE[ \t]\n"
-- 
1.7.12.465.g03a9b82
