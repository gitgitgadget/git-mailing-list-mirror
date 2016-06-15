From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v3 10/12] filter-branch: invoke post-rewrite hook
Date: Sat, 20 Feb 2010 23:16:31 +0100
Message-ID: <dc9d990e10afbe262bbb5e12a8c33483bdd15198.1266703765.git.trast@student.ethz.ch>
References: <cover.1266703765.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 20 23:40:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nixe6-0006OX-HS
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 23:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756910Ab0BTWRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 17:17:21 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:6942 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756689Ab0BTWRO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 17:17:14 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 23:16:57 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 23:16:39 +0100
X-Mailer: git-send-email 1.7.0.137.gfe3f1
In-Reply-To: <cover.1266703765.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140560>

With a twist: since this is supposed to be the be-all end-all of
rewriting, we give the user the chance to override the hook.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-filter-branch.txt |    7 ++++++-
 git-filter-branch.sh                |   21 +++++++++++++++++++++
 t/t5407-post-rewrite-hook.sh        |   28 ++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 020028c..28a705f 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 	[--index-filter <command>] [--parent-filter <command>]
 	[--msg-filter <command>] [--commit-filter <command>]
 	[--tag-name-filter <command>] [--subdirectory-filter <directory>]
-	[--prune-empty]
+	[--prune-empty] [--post-rewrite <command>]
 	[--original <namespace>] [-d <directory>] [-f | --force]
 	[--] [<rev-list options>...]
 
@@ -182,6 +182,11 @@ the nearest ancestor that was not excluded.
 	of the `git commit-tree "$@"` idiom in your commit filter to make that
 	happen.
 
+--post-rewrite <command>::
+	Overrides the post-rewrite hook (if you have one).  To bypass
+	the hook for this invocation, pass `:`.  See
+	linkgit:githooks[1].
+
 --original <namespace>::
 	Use this option to set the namespace where the original commits
 	will be stored. The default value is 'refs/original'.
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 88fb0f0..301c497 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -101,6 +101,7 @@ USAGE="[--env-filter <command>] [--tree-filter <command>]
             [--index-filter <command>] [--parent-filter <command>]
             [--msg-filter <command>] [--commit-filter <command>]
             [--tag-name-filter <command>] [--subdirectory-filter <directory>]
+	    [--post-rewrite <command>]
             [--original <namespace>] [-d <directory>] [-f | --force]
             [<rev-list options>...]"
 
@@ -126,6 +127,13 @@ orig_namespace=refs/original/
 force=
 prune_empty=
 remap_to_ancestor=
+
+if test -x "$GIT_DIR"/hooks/post-rewrite; then
+	post_rewrite=$(git rev-parse --sq-quote "$GIT_DIR"/hooks/post-rewrite)
+else
+	post_rewrite=:
+fi
+
 while :
 do
 	case "$1" in
@@ -190,6 +198,10 @@ do
 		filter_subdir="$OPTARG"
 		remap_to_ancestor=t
 		;;
+	--post-rewrite)
+		post_rewrite="$OPTARG"
+		post_rewrite_given=t
+		;;
 	--original)
 		orig_namespace=$(expr "$OPTARG/" : '\(.*[^/]\)/*$')/
 		;;
@@ -358,6 +370,10 @@ while read commit parents; do
 	@SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
 		$(git write-tree) $parentstr < ../message > ../map/$commit ||
 			die "could not write rewritten commit"
+	new_commit=$(map $commit)
+	if test $commit != $new_commit; then
+		echo $commit $new_commit >> "$workdir"/../rewritten
+	fi
 done <../revs
 
 # If we are filtering for paths, as in the case of a subdirectory
@@ -484,6 +500,11 @@ if [ "$filter_tag_name" ]; then
 fi
 
 cd ../..
+
+if test -s "$workdir"/../rewritten; then
+	eval "$post_rewrite" 'filter-branch < "$workdir"/../rewritten'
+fi
+
 rm -rf "$tempdir"
 
 trap - 0
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 488d4a0..fa81fd4 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -157,4 +157,32 @@ EOF
 	verify_hook_input
 '
 
+test_expect_success 'git filter-branch' '
+	git reset --hard D &&
+	clear_hook_input &&
+	git filter-branch -f --tree-filter "touch newfile" B..HEAD &&
+	echo filter-branch >expected.args &&
+	cat >expected.data <<EOF &&
+$(git rev-parse C) $(git rev-parse HEAD^)
+$(git rev-parse D) $(git rev-parse HEAD)
+EOF
+	verify_hook_input
+'
+
+test_expect_success 'git filter-branch (no-op)' '
+	git reset --hard D &&
+	clear_hook_input &&
+	git filter-branch -f B..HEAD &&
+	test ! -f post-rewrite.args &&
+	test ! -f post-rewrite.data
+'
+
+test_expect_success 'git filter-branch --post-rewrite :' '
+	git reset --hard D &&
+	clear_hook_input &&
+	git filter-branch -f --post-rewrite : --tree-filter "touch newfile" B..HEAD &&
+	test ! -f post-rewrite.args &&
+	test ! -f post-rewrite.data
+'
+
 test_done
-- 
1.7.0.59.g783f8
