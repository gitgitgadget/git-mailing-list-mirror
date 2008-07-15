From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] git rev-parse: Fix --show-cdup inside symlinked directory
Date: Tue, 15 Jul 2008 16:59:45 +0200
Message-ID: <20080715145920.13529.25603.stgit@localhost>
References: <1216131208.19334.171.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 15 17:01:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIm1P-0000Vp-5U
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 17:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbYGOO74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 10:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbYGOO74
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 10:59:56 -0400
Received: from [212.249.11.140] ([212.249.11.140]:25922 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750908AbYGOO7z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 10:59:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id 263DD2ACC7D;
	Tue, 15 Jul 2008 16:59:45 +0200 (CEST)
In-Reply-To: <1216131208.19334.171.camel@gemini>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88562>

Consider the scenario when someone makes a symlink into a working tree
subdirectory at an unrelated place, then attempts to work inside the
symlinked directory. The scenario is a bit unwieldly, but most of
the Git will handle it fine - except git rev-parse --show-cdup. That
will output a sequence of ../ which will work wrong inside the symlink
using shell cd builtin.

This patch changes --show-cdup to always show absolute workdir path
instead. I think this should hopefully cause no compatibility problems;
the testsuite is passing fine, at least.  The patch also adds
a --show-cdup check and this particular scenartio to the t1500 test.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-rev-parse.txt |    4 ++--
 builtin-rev-parse.c             |   15 +++++----------
 t/t1500-rev-parse.sh            |   18 ++++++++++++++++--
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 088f971..4c289d0 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -103,8 +103,8 @@ OPTIONS
 
 --show-cdup::
 	When the command is invoked from a subdirectory, show the
-	path of the top-level directory relative to the current
-	directory (typically a sequence of "../", or an empty string).
+	path of the top-level directory, or an empty string if the
+	current directory is the top-level directory.
 
 --git-dir::
 	Show `$GIT_DIR` if defined else show the path to the .git directory.
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index a7860ed..011d16c 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -500,22 +500,17 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--show-cdup")) {
-				const char *pfx = prefix;
-				if (!is_inside_work_tree()) {
+				if (prefix) {
+					/* We are not at the top level yet */
 					const char *work_tree =
 						get_git_work_tree();
 					if (work_tree)
 						printf("%s\n", work_tree);
 					continue;
+				} else {
+					/* Backwards compatibility */
+					putchar('\n');
 				}
-				while (pfx) {
-					pfx = strchr(pfx, '/');
-					if (pfx) {
-						pfx++;
-						printf("../");
-					}
-				}
-				putchar('\n');
 				continue;
 			}
 			if (!strcmp(arg, "--git-dir")) {
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 85da4ca..2f0bf15 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -26,9 +26,14 @@ test_rev_parse() {
 	"test '$1' = \"\$(git rev-parse --show-prefix)\""
 	shift
 	[ $# -eq 0 ] && return
+
+	test_expect_success "$name: cdup" \
+	"test '$1' = \"\$(git rev-parse --show-cdup)\""
+	shift
+	[ $# -eq 0 ] && return
 }
 
-# label is-bare is-inside-git is-inside-work prefix
+# label is-bare is-inside-git is-inside-work prefix cdup
 
 test_rev_parse toplevel false false true ''
 
@@ -38,11 +43,20 @@ cd objects || exit 1
 test_rev_parse .git/objects/ false true false ''
 cd ../.. || exit 1
 
+basedir=$(pwd)
 mkdir -p sub/dir || exit 1
 cd sub/dir || exit 1
-test_rev_parse subdirectory false false true sub/dir/
+test_rev_parse subdirectory false false true sub/dir/ "$basedir"
 cd ../.. || exit 1
 
+# Scenario: Working within a subdirectory symlinked out of the working tree
+mkdir -p maindir || exit 1
+(mv .git maindir && mkdir -p maindir/sub2 && ln -s maindir/sub2 .) || exit 1
+cd sub2 || exit 1
+test_rev_parse 'symlinked subdirectory' false false true sub2/ "$basedir"/maindir
+cd .. || exit 1
+(rm sub2 && mv maindir/.git . && rm -r maindir) || exit 1
+
 git config core.bare true
 test_rev_parse 'core.bare = true' true false false
 
