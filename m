From: Eric Kidd <git@randomhacks.net>
Subject: [PATCH v2] filter-branch: Add more error-handling
Date: Wed, 11 Feb 2009 12:15:18 -0500
Message-ID: <1234372518-6924-1-git-send-email-git@randomhacks.net>
References: <1234361365-63711-1-git-send-email-git@randomhacks.net>
Cc: Eric Kidd <git@randomhacks.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 18:17:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXIi2-0003Zw-0F
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 18:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756750AbZBKRP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 12:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756757AbZBKRP2
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 12:15:28 -0500
Received: from randomhacks.net ([69.93.127.95]:59000 "EHLO randomhacks.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756424AbZBKRP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 12:15:27 -0500
Received: from [130.189.179.230] (helo=localhost.localdomain)
	by randomhacks.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <git@randomhacks.net>)
	id 1LXIgG-0002IR-Vf; Wed, 11 Feb 2009 12:15:25 -0500
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1234361365-63711-1-git-send-email-git@randomhacks.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109450>

In commit 9273b56278e64dd47b1a96a705ddf46aeaf6afe3, I fixed an error
that had slipped by the test suites because of a missing check on 'git
read-tree -u -m HEAD'.

I mentioned to Johannes Schindelin that there were several bugs of this
type in git-filter-branch, and he suggested that I send a patch.  I've
tested this patch using t/t7003-filter-branch.sh, and it passes all the
existing tests.

In two places, I've had to break apart pipelines in order to check the
error code for the first stage of the pipeline, as discussed here:

  http://kerneltrap.org/mailarchive/git/2009/1/28/4835614

Thank you to charon on #git for pointing me in the right direction.

This patch causes 'git filter-branch' to fail if the --commit-filter
argument returns an error.  A test case for this behavior is included.

Feedback on the original version of this patch was provided by Johannes
Sixt and Johannes Schindelin.

v2:
  Remove useless $ret variable
  Correctly check the first command in a pipeline, not the second
  Replace verbose 'die' messages with 'exit 1' in most cases

Signed-off-by: Eric Kidd <git@randomhacks.net>
---
 git-filter-branch.sh     |   26 ++++++++++++++------------
 t/t7003-filter-branch.sh |    4 ++++
 2 files changed, 18 insertions(+), 12 deletions(-)

 Thank you for the feedback!  I've tried to incorporate everybody's
 suggestions.  Please let me know if some of those 'exit 1' statements
 should be changed back to 'die'. -Eric

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 86eef56..fff07c8 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -221,7 +221,7 @@ die ""
 trap 'cd ../..; rm -rf "$tempdir"' 0
 
 # Make sure refs/original is empty
-git for-each-ref > "$tempdir"/backup-refs
+git for-each-ref > "$tempdir"/backup-refs || exit 1
 while read sha1 type name
 do
 	case "$force,$name" in
@@ -241,8 +241,9 @@ GIT_WORK_TREE=.
 export GIT_DIR GIT_WORK_TREE
 
 # The refs should be updated if their heads were rewritten
-git rev-parse --no-flags --revs-only --symbolic-full-name --default HEAD "$@" |
-sed -e '/^^/d' >"$tempdir"/heads
+git rev-parse --no-flags --revs-only --symbolic-full-name \
+	--default HEAD "$@" > "$tempdir"/raw-heads || exit 1
+sed -e '/^^/d' "$tempdir"/raw-heads >"$tempdir"/heads
 
 test -s "$tempdir"/heads ||
 	die "Which ref do you want to rewrite?"
@@ -251,8 +252,6 @@ GIT_INDEX_FILE="$(pwd)/../index"
 export GIT_INDEX_FILE
 git read-tree || die "Could not seed the index"
 
-ret=0
-
 # map old->new commit ids for rewriting parents
 mkdir ../map || die "Could not create map/ directory"
 
@@ -315,10 +314,11 @@ while read commit parents; do
 			die "tree filter failed: $filter_tree"
 
 		(
-			git diff-index -r --name-only $commit
+			git diff-index -r --name-only $commit &&
 			git ls-files --others
-		) |
-		git update-index --add --replace --remove --stdin
+		) > "$tempdir"/tree-state || exit 1
+		git update-index --add --replace --remove --stdin \
+			< "$tempdir"/tree-state || exit 1
 	fi
 
 	eval "$filter_index" < /dev/null ||
@@ -339,7 +339,8 @@ while read commit parents; do
 		eval "$filter_msg" > ../message ||
 			die "msg filter failed: $filter_msg"
 	@SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
-		$(git write-tree) $parentstr < ../message > ../map/$commit
+		$(git write-tree) $parentstr < ../message > ../map/$commit ||
+			die "could not write rewritten commit"
 done <../revs
 
 # In case of a subdirectory filter, it is possible that a specified head
@@ -407,7 +408,8 @@ do
 			die "Could not rewrite $ref"
 	;;
 	esac
-	git update-ref -m "filter-branch: backup" "$orig_namespace$ref" $sha1
+	git update-ref -m "filter-branch: backup" "$orig_namespace$ref" $sha1 ||
+		 exit 1
 done < "$tempdir"/heads
 
 # TODO: This should possibly go, with the semantics that all positive given
@@ -483,7 +485,7 @@ test -z "$ORIG_GIT_INDEX_FILE" || {
 }
 
 if [ "$(is_bare_repository)" = false ]; then
-	git read-tree -u -m HEAD
+	git read-tree -u -m HEAD || exit 1
 fi
 
-exit $ret
+exit 0
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index cb04743..39affd9 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -48,6 +48,10 @@ test_expect_success 'result is really identical' '
 	test $H = $(git rev-parse HEAD)
 '
 
+test_expect_success 'Fail if commit filter fails' '
+	! git filter-branch -f --commit-filter "exit 1" HEAD
+'
+
 test_expect_success 'rewrite, renaming a specific file' '
 	git filter-branch -f --tree-filter "mv d doh || :" HEAD
 '
-- 
1.6.0.4
