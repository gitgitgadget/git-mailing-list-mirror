From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH] diff: simplify cpp funcname regex
Date: Tue, 4 Mar 2014 19:36:40 -0500
Message-ID: <20140305003639.GA9474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <tr@thomasrast.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 01:36:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKzpH-0004te-Hg
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 01:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948AbaCEAgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 19:36:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:33051 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754614AbaCEAgm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 19:36:42 -0500
Received: (qmail 24981 invoked by uid 102); 5 Mar 2014 00:36:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Mar 2014 18:36:42 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Mar 2014 19:36:40 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243408>

The current funcname matcher for C files requires one or
more words before the function name, like:

  static int foo(int arg)
  {

However, some coding styles look like this:

  static int
  foo(int arg)
  {

and we do not match, even though the default regex would.

This patch simplifies the regex significantly. Rather than
trying to handle all the variants of keywords and return
types, we simply look for an identifier at the start of the
line that contains a "(", meaning it is either a function
definition or a function call, and then not containing ";"
which would indicate it is a call or declaration.

This can be fooled by something like:

    if (foo)

but it is unlikely to find that at the very start of a line
with no identation (and without having a complete set of
keywords, we cannot distinguish that from a function called
"if" taking "foo" anyway).

We had no tests at all for .c files, so this attempts to add
a few obvious cases (including the one we are fixing here).

Signed-off-by: Jeff King <peff@peff.net>
---
I tried accommodating this one case in the current regex, but it just
kept getting more complicated and unreadable. Maybe I am being naive to
think that this much simpler version can work. We don't have a lot of
tests or a known-good data set to check.

I did try "git log -1000 -p" before and after on git.git, diff'd the
results and manually inspected. The results were a mix of strict
improvement (mostly instances of the style I was trying to fix here) and
cases where there is no good answer. For example, for top-level changes
outside functions, we might find:

  N_("some text that is long"

that is part of:

  const char *foo =
  N_("some text that is long"
  "and spans multiple lines");

Before this change, we would skip past it (using the cpp regex, that is;
the default one tends to find the same line) and either report nothing,
or whatever random function was before us. So it's a behavior change,
but the existing behavior is really no better.

 t/t4018-diff-funcname.sh | 36 ++++++++++++++++++++++++++++++++++++
 userdiff.c               |  2 +-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 38a092a..1e80b15 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -93,6 +93,29 @@ sed -e '
 	s/song;/song();/
 ' <Beer.perl >Beer-correct.perl
 
+cat >Beer.c <<\EOF
+static int foo(void)
+{
+label:
+	int x = old;
+}
+
+struct foo; /* catch failure below */
+static int
+gnu(int arg)
+{
+	int x = old;
+}
+
+struct foo; /* catch failure below */
+int multiline(int arg,
+	      char *arg2)
+{
+	int x = old;
+}
+EOF
+sed s/old/new/ <Beer.c >Beer-correct.c
+
 test_expect_funcname () {
 	lang=${2-java}
 	test_expect_code 1 git diff --no-index -U1 \
@@ -127,6 +150,7 @@ test_expect_success 'set up .gitattributes declaring drivers to test' '
 	cat >.gitattributes <<-\EOF
 	*.java diff=java
 	*.perl diff=perl
+	*.c diff=cpp
 	EOF
 '
 
@@ -158,6 +182,18 @@ test_expect_success 'perl pattern is not distracted by forward declaration' '
 	test_expect_funcname "package Beer;\$" perl
 '
 
+test_expect_success 'c pattern skips labels' '
+	test_expect_funcname "static int foo(void)" c
+'
+
+test_expect_success 'c pattern matches GNU-style functions' '
+	test_expect_funcname "gnu(int arg)\$" c
+'
+
+test_expect_success 'c pattern matches multiline functions' '
+	test_expect_funcname "int multiline(int arg,\$" c
+'
+
 test_expect_success 'custom pattern' '
 	test_config diff.java.funcname "!static
 !String
diff --git a/userdiff.c b/userdiff.c
index 10b61ec..b9d52b7 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -127,7 +127,7 @@
 	 /* Jump targets or access declarations */
 	 "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:.*$\n"
 	 /* C/++ functions/methods at top level */
-	 "^([A-Za-z_][A-Za-z_0-9]*([ \t*]+[A-Za-z_][A-Za-z_0-9]*([ \t]*::[ \t]*[^[:space:]]+)?){1,}[ \t]*\\([^;]*)$\n"
+	 "^([A-Za-z_].*\\([^;]*)$\n"
 	 /* compound type at top level */
 	 "^((struct|class|enum)[^;]*)$",
 	 /* -- */
-- 
1.8.5.2.500.g8060133
