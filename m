X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [RFC/PATCH] Implement poor-man's submodule support using commit hooks
Date: Wed, 20 Dec 2006 13:09:01 +0000
Message-ID: <200612201309.02119.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 13:09:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-TUID: ac504a7dd72d37e0
X-UID: 198
X-Length: 5086
Content-Disposition: inline
X-OriginalArrivalTime: 20 Dec 2006 13:11:11.0578 (UTC) FILETIME=[51FEF3A0:01C72438]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34924>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx1C7-0004Sp-LW for gcvg-git@gmane.org; Wed, 20 Dec
 2006 14:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964975AbWLTNJI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 08:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWLTNJI
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 08:09:08 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:30007 "EHLO
 369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S964975AbWLTNJH (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 08:09:07 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Wed, 20 Dec 2006 13:11:11 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1Gx1Bw-0003L6-00 for <git@vger.kernel.org>; Wed, 20 Dec
 2006 13:09:04 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Make a file called .gitmodules.  In it, list the paths containing a
submodule.  Add that file to the index.

This patch adds a check to the pre-commit hook finds that file and pulls
the HEAD hash out of each of the listed submodule repositories.  That
hash is then listed to the .gitmodules file along with the submodule
name and .gitmodules is added back to the repository.

You've now got poor-man's submodule support.  Any commits to the
submodule will change the hash and hence the .gitmodules file will be
different and therefore will show up as "modified" to git.

It's not got any nice UI for checking out (obviously) or merging; but it
does at least record the state of a project. With a bit of manual work you
can easily check out the right commit in the submodule.  If there were a
post-checkout hook script, this could probably be automated.

To prevent git-prune in the submodule from removing references that the
supermodule refers to the post-commit hook reads the .gitmodules file
and creates a file in submodule/.git/refs/superrefs/ that refers to the
hash we've references.  git-prune in the submodule will find that
reference and hence won't remove it from under us.

Problems:
 - git-prune in the supermodule doesn't clean the supermodule refs in
   the submodule
 - no checkout support
 - no reset support
 - no merge support (other than what git provides for the .gitmodule
   file)
 - no check for dirty submodule before commit

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
This is in replacement of the previous patch.

I've used the --show-cdup option of git-rev-parse to make it work even in
subdirectories.  I've also added git-prune protection by adding a post-commit
script to reference the hash in the submodule.

What'd you reckon?  Might be useful until real submodule support arrives.
If there is no .gitmodules file in the root, then git behaves as it always did.

I suppose if this were actually found to be really useful, it should go in
git-commit.sh itself, rather than the hooks.


 templates/hooks--post-commit |   29 +++++++++++++++++++++++++-
 templates/hooks--pre-commit  |   47 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/templates/hooks--post-commit b/templates/hooks--post-commit
index 8be6f34..551d928 100644
--- a/templates/hooks--post-commit
+++ b/templates/hooks--post-commit
@@ -5,4 +5,31 @@
 #
 # To enable this hook, make this file executable.
 
-: Nothing
+# Poor-man's Submodules
+# ---------------------
+# If we're here, then a commit has succeeded. If submodule support is enabled
+# then we need a way of telling the submodule that we now reference a hash
+# owned by it, so that it is not pruned.
+WORKINGTOP=$(git-rev-parse --show-cdup)
+GITMODULES="${WORKINGTOP}.gitmodules"
+if [ -f "$GITMODULES" ]; then
+	cat "$GITMODULES" |
+	while read subdir hash
+	do
+		SUBMODULEPATH="$WORKINGTOP$subdir/.git/refs/superrefs"
+
+		# XXX: check if the line is a comment
+
+		# check if the subdir is a repository
+		if [ ! -d "$WORKINGTOP$subdir/.git" ]; then
+			continue;
+		fi
+
+		# Write the hash to a file of the same name - this means that if we get
+		# multiple commits that refer to the submodule, we only get one file in
+		# the submodule, as the submodule hash is constant across supermodule
+		# commits
+		mkdir -p "$SUBMODULEPATH"
+		echo $hash > "$SUBMODULEPATH/$hash"
+	done
+fi
diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
index 723a9ef..7718369 100644
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit
@@ -67,5 +67,50 @@ perl -e '
 	}
     }
     exit($found_bad);
-'
+' || exit 1
+
+# Poor-man's Submodules
+# ---------------------
+# Enable poor-man's submodule support when .gitmodules is present
+# Simply create a .gitmodules file listing the paths in your repository
+# that contain other git repositories; each line will be replaced with the
+# path followed by the hash of the current HEAD of the submodule.
+# When the submodule changes hash this file will be different from the
+# version in the repository and a change will be noted - voila, submodules.
+# Of course there is no checkout support, but at least the current state
+# will be accurately recorded
+WORKINGTOP=$(git-rev-parse --show-cdup)
+GITMODULES="${WORKINGTOP}.gitmodules"
+if [ -f "$GITMODULES" ]; then
+	cat "$GITMODULES" |
+	while read subdir hash
+	do
+		# check if the line is a comment and output it anyway
+		if (expr "x$subdir" : "x#" >/dev/null) then
+			echo "$subdir $hash"
+			continue;
+		fi
+
+		# check if the subdir is a repository
+		if [ ! -d "$WORKINGTOP$subdir/.git" ]; then
+			echo "$subdir is not a git repository, so it can't be a submodule"
+			exit 1;
+		fi
+
+		# XXX: really need a check here and quit if the submodule is
+		# dirty
+
+		echo "$subdir $(GIT_DIR=$WORKINGTOP$subdir/.git git-rev-parse HEAD)"
+	done > newgitmodules
+	# Update
+	mv newgitmodules "$GITMODULES"
+
+	# This relies on the .gitmodules file having already been added to
+	# the repository - perhaps this should be automated?
+	git-update-index "$GITMODULES" ||
+	(
+	echo "FATAL: Submodule tracker file, $GITMODULES, is not tracked in this repository." >&2
+	exit 1
+	)
+fi
 
-- 
1.4.4.2.g0d2a
