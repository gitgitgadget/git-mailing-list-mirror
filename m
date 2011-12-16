From: Jeff King <peff@peff.net>
Subject: [PATCH] attr: map builtin userdiff drivers to well-known extensions
Date: Fri, 16 Dec 2011 06:00:00 -0500
Message-ID: <20111216110000.GA15676@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 12:00:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbVWL-0007LN-5J
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 12:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879Ab1LPLAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 06:00:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43962
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921Ab1LPLAC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 06:00:02 -0500
Received: (qmail 2483 invoked by uid 107); 16 Dec 2011 11:06:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Dec 2011 06:06:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2011 06:00:00 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187269>

We already provide sane hunk-header patterns for specific
languages.

However, the user has to manually map common extensions to
use them. It's not that hard to do, but it's an extra step
that the user might not even know is an option. Let's be
nice and do it automatically.

It could be a problem in the future if the builtin userdiff
drivers started growing more invasive options, like
automatically claiming to be non-binary (e.g., setting
diff.cpp.binary = false by default), but right now we do not
do that, so it should be safe. To help safeguard against
future changes, we add a new test to t4012 making sure that
we don't consider binary files as text by their extension.

We also have to update t4018, which assumed that without a
.gitattributes file, we would receive the default funcname
pattern for a file matching "*.java". Changing this behavior
is not covering up a regression, but rather the feature
working as intended.

Signed-off-by: Jeff King <peff@peff.net>
---
I forgot to send this out in time for v1.7.8.

Prior discussion here:

  http://thread.gmane.org/gmane.comp.version-control.git/180103

and here:

  http://thread.gmane.org/gmane.comp.version-control.git/181253

The list of extensions is collected from those threads. The tests are
new since the last time I posted (and the t4018 is slightly different
than what you queued in pu).

I punted on the question of case-sensitivity. Brandon mentioned using
fnmatch_icase to handle this, which sounds sane, but I think it is
really a separate topic.

 attr.c                   |   24 ++++++++++++++++++++++++
 t/t4012-diff-binary.sh   |   13 +++++++++++++
 t/t4018-diff-funcname.sh |   10 +++++++++-
 3 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/attr.c b/attr.c
index 76b079f..2ad7cc4 100644
--- a/attr.c
+++ b/attr.c
@@ -306,6 +306,30 @@ static void free_attr_elem(struct attr_stack *e)
 
 static const char *builtin_attr[] = {
 	"[attr]binary -diff -text",
+	"*.html diff=html",
+	"*.htm diff=html",
+	"*.java diff=java",
+	"*.perl diff=perl",
+	"*.pl diff=perl",
+	"*.php diff=php",
+	"*.py diff=python",
+	"*.rb diff=ruby",
+	"*.bib diff=bibtex",
+	"*.tex diff=tex",
+	"*.c diff=cpp",
+	"*.cc diff=cpp",
+	"*.cxx diff=cpp",
+	"*.cpp diff=cpp",
+	"*.h diff=cpp",
+	"*.hpp diff=cpp",
+	"*.cs diff=csharp",
+	"*.[Ff] diff=fortran",
+	"*.[Ff][0-9][0-9] diff=fortran",
+	"*.m diff=objc",
+	"*.mm diff=objc",
+	"*.pas diff=pascal",
+	"*.pp diff=pascal",
+	"*.lpr diff=pascal",
 	NULL,
 };
 
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 2d9f9a0..b2fc807 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -90,4 +90,17 @@ test_expect_success 'diff --no-index with binary creation' '
 	test_cmp expected actual
 '
 
+test_expect_success 'binary files are not considered text by file extension' '
+	echo Q | q_to_nul >binary.c &&
+	git add binary.c &&
+	cat >expect <<-\EOF &&
+	diff --git a/binary.c b/binary.c
+	new file mode 100644
+	index 0000000..1f2a4f5
+	Binary files /dev/null and b/binary.c differ
+	EOF
+	git diff --cached binary.c >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 4bd2a1c..a6227ef 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -124,7 +124,9 @@ do
 done
 
 test_expect_success 'default behaviour' '
-	rm -f .gitattributes &&
+	cat >.gitattributes <<-\EOF &&
+	*.java diff=default
+	EOF
 	test_expect_funcname "public class Beer\$"
 '
 
@@ -187,4 +189,10 @@ test_expect_success 'alternation in pattern' '
 	test_expect_funcname "public static void main("
 '
 
+test_expect_success 'custom diff drivers override built-in extension matches' '
+	test_config diff.foo.funcname "int special" &&
+	echo "*.java diff=foo" >.gitattributes &&
+	test_expect_funcname "int special"
+'
+
 test_done
-- 
1.7.7.4.13.g57bf4
