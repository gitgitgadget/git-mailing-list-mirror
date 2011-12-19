From: Jeff King <peff@peff.net>
Subject: [PATCHv2 1/2] attr: map builtin userdiff drivers to well-known
 extensions
Date: Mon, 19 Dec 2011 10:49:38 -0500
Message-ID: <20111219154938.GA19829@sigill.intra.peff.net>
References: <20111217033808.GA8683@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 16:49:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcfTL-0002X0-1q
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 16:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098Ab1LSPtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 10:49:41 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45877
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539Ab1LSPtk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 10:49:40 -0500
Received: (qmail 32056 invoked by uid 107); 19 Dec 2011 15:56:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Dec 2011 10:56:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Dec 2011 10:49:38 -0500
Content-Disposition: inline
In-Reply-To: <20111217033808.GA8683@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187451>

We already provide sane hunk-header patterns for specific
languages.

However, the user has to manually map common extensions to
use them. It's not that hard to do, but it's an extra step
that the user might not even know is an option. Let's be
nice and do it automatically.

It could be a problem in the future if the builtin userdiff
drivers started growing more invasive options, like
automatically claiming to be non-binary (i.e., setting
diff.cpp.binary = false by default), but right now we do not
do that, so it should be safe. To help safeguard against
future changes, we add a new test to t4012 making sure that
we don't consider binary files as text by their extension.

We also have to update t4018, which assumed that without a
.gitattributes file, we would receive the default funcname
pattern for a file matching "*.java". This is not covering
up a regression, but rather the feature working as intended.

Signed-off-by: Jeff King <peff@peff.net>
---
This drops the objc mappings from v1. I still have no data on how much
worse the objc funcname performs on Matlab files, but I'd rather be
conservative until an objc person wants to show up and argue about it.

The C mappings are still here, but see the next patch.

 attr.c                   |   22 ++++++++++++++++++++++
 t/t4012-diff-binary.sh   |   13 +++++++++++++
 t/t4018-diff-funcname.sh |   10 +++++++++-
 3 files changed, 44 insertions(+), 1 deletions(-)

diff --git a/attr.c b/attr.c
index 76b079f..10713f3 100644
--- a/attr.c
+++ b/attr.c
@@ -306,6 +306,28 @@ static void free_attr_elem(struct attr_stack *e)
 
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
1.7.8.rc2.38.gd9625
