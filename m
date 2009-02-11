From: Eric Kidd <git@randomhacks.net>
Subject: [PATCH] git-filter-branch: Add more error-handling
Date: Wed, 11 Feb 2009 09:09:25 -0500
Message-ID: <1234361365-63711-1-git-send-email-git@randomhacks.net>
Cc: Eric Kidd <git@randomhacks.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 15:11:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXFnp-0006Am-ED
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 15:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703AbZBKOJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 09:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754701AbZBKOJe
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 09:09:34 -0500
Received: from randomhacks.net ([69.93.127.95]:55086 "EHLO randomhacks.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754410AbZBKOJd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 09:09:33 -0500
Received: from pool-64-222-85-242.burl.east.myfairpoint.net ([64.222.85.242] helo=localhost.localdomain)
	by randomhacks.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <git@randomhacks.net>)
	id 1LXFmO-0001Xj-Gk; Wed, 11 Feb 2009 09:09:32 -0500
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109418>

In commit 9273b56278e64dd47b1a96a705ddf46aeaf6afe3, I fixed an error
that had slipped by the test suites because of a missing check on 'git
read-tree -u -m HEAD'.

I mentioned to Johannes Schindelin that there were several bugs of this
type in git-filter-branch, and he suggested that I send a patch.

I've tested this patch using t/t7003-filter-branch.sh, and it passes all
the existing tests.  But it's entirely possible that this patch contains
errors, and I would love input from people who have more experience with
sh and who know more about git-filter-branch.

In particular, the following hunk may change the public UI to
git-filter-branch, although I'm not sure whether the change is for
better or for worse.  As I understand it, this hunk would allow
$filter_commit to abort the rewriting process by returning a non-0 exit
status:

 	@SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
-		$(git write-tree) $parentstr < ../message > ../map/$commit
+		$(git write-tree) $parentstr < ../message > ../map/$commit ||
+			die "could not write rewritten commit"
 done <../revs

I'd be happy to add a test case for what happens when $filter_commit
returns a non-0 exit status.  Is the old behavior preferable?
---
 git-filter-branch.sh |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

 I'm trying to do the constructive thing, and send patches instead of bug
 reports. :-) -Eric

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 86eef56..9d50978 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -221,7 +221,7 @@ die ""
 trap 'cd ../..; rm -rf "$tempdir"' 0
 
 # Make sure refs/original is empty
-git for-each-ref > "$tempdir"/backup-refs
+git for-each-ref > "$tempdir"/backup-refs || die "Can't back up refs"
 while read sha1 type name
 do
 	case "$force,$name" in
@@ -242,7 +242,7 @@ export GIT_DIR GIT_WORK_TREE
 
 # The refs should be updated if their heads were rewritten
 git rev-parse --no-flags --revs-only --symbolic-full-name --default HEAD "$@" |
-sed -e '/^^/d' >"$tempdir"/heads
+sed -e '/^^/d' >"$tempdir"/heads || die "Can't make list of original refs"
 
 test -s "$tempdir"/heads ||
 	die "Which ref do you want to rewrite?"
@@ -315,10 +315,11 @@ while read commit parents; do
 			die "tree filter failed: $filter_tree"
 
 		(
-			git diff-index -r --name-only $commit
+			git diff-index -r --name-only $commit &&
 			git ls-files --others
 		) |
-		git update-index --add --replace --remove --stdin
+		git update-index --add --replace --remove --stdin ||
+			die "unable to update index with results of tree filter"
 	fi
 
 	eval "$filter_index" < /dev/null ||
@@ -339,7 +340,8 @@ while read commit parents; do
 		eval "$filter_msg" > ../message ||
 			die "msg filter failed: $filter_msg"
 	@SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
-		$(git write-tree) $parentstr < ../message > ../map/$commit
+		$(git write-tree) $parentstr < ../message > ../map/$commit ||
+			die "could not write rewritten commit"
 done <../revs
 
 # In case of a subdirectory filter, it is possible that a specified head
@@ -407,7 +409,8 @@ do
 			die "Could not rewrite $ref"
 	;;
 	esac
-	git update-ref -m "filter-branch: backup" "$orig_namespace$ref" $sha1
+	git update-ref -m "filter-branch: backup" "$orig_namespace$ref" $sha1 ||
+		 die "Could not back up branch ref"
 done < "$tempdir"/heads
 
 # TODO: This should possibly go, with the semantics that all positive given
@@ -483,7 +486,7 @@ test -z "$ORIG_GIT_INDEX_FILE" || {
 }
 
 if [ "$(is_bare_repository)" = false ]; then
-	git read-tree -u -m HEAD
+	git read-tree -u -m HEAD || die "Unable to checkout rewritten tree"
 fi
 
 exit $ret
-- 
1.6.0.4
