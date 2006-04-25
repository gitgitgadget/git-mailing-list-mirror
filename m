From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 5/5] git-commit: add --prior to set prior link
Date: Tue, 25 Apr 2006 16:31:07 +1200
Message-ID: <20060425043107.18382.34865.stgit@localhost.localdomain>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
X-From: git-owner@vger.kernel.org Tue Apr 25 06:32:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYFDT-0000IJ-T6
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 06:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWDYEbz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 00:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWDYEby
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 00:31:54 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:49386 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751028AbWDYEbw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 00:31:52 -0400
Received: from samv by mail1.catalyst.net.nz with local (Exim 4.50)
	id 1FYFDK-0004Ds-NU
	for git@vger.kernel.org; Tue, 25 Apr 2006 16:31:50 +1200
To: git@vger.kernel.org
In-Reply-To: <20060425035421.18382.51677.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19123>

From: Sam Vilain <sam.vilain@catalyst.net.nz>

Add command-line support for --prior and add a description to the
ASCIIDOC
---

 Documentation/git-commit.txt |   10 ++++++++++
 git-commit.sh                |   19 +++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 6f2c495..ca5073c 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git-commit' [-a] [-s] [-v] [(-c | -C) <commit> | -F <file> | -m <msg>]
 	   [--no-verify] [--amend] [-e] [--author <author>]
+           [-p <commit>]
 	   [--] [[-i | -o ]<file>...]
 
 DESCRIPTION
@@ -106,6 +107,15 @@ but can be used to amend a merge commit.
 	index and the latest commit does not match on the
 	specified paths to avoid confusion.
 
+-p|--prior <commit>::
+	Specify a commit that this new commit is the next version of.
+        Use when you want a branch to supercede another branch, but
+        with a new commit history.  It is also use for sub-projects,
+        where commits on the parent tree mirror commits in the
+        sub-project.  <commit> does not have to exist in the local
+        repository, if it is specified as a full 40-digit hex SHA1
+        sum.  Otherwise it is parsed as a local revision.
+
 --::
 	Do not interpret any more arguments as options.
 
diff --git a/git-commit.sh b/git-commit.sh
index 26cd7ca..3feb60d 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -3,7 +3,7 @@ #
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2006 Junio C Hamano
 
-USAGE='[-a] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit>) [--amend] [-e] [--author <author>] [[-i | -o] <path>...]'
+USAGE='[-a] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit>) [--amend] [-e] [--author <author>] [-p <commit>] [[-i | -o] <path>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 
@@ -200,6 +200,7 @@ log_given=
 log_message=
 verify=t
 verbose=
+prior=
 signoff=
 force_author=
 only_include_assumed=
@@ -344,6 +345,19 @@ do
       shift
       break
       ;;
+  -p|--p|--pr|--pri|--prio|--prior)
+      shift
+      prior="$1"
+      if echo $prior | perl -ne 'exit 1 unless /^[0-9a-f]{40}$/i'
+      then
+          prior=`echo "$prior" | tr '[A-Z]' '[a-z]'`
+      else
+	  prior=`git-rev-parse "$prior"`
+	  [ -n "$prior" ] || exit 1
+      fi
+      PRIOR="-r $prior"
+      shift
+      ;;
   -*)
       usage
       ;;
@@ -602,6 +616,7 @@ then
 		PARENTS=$(git-cat-file commit HEAD |
 			sed -n -e '/^$/q' -e 's/^parent /-p /p')
 	fi
+	
 	current=$(git-rev-parse --verify HEAD)
 else
 	if [ -z "$(git-ls-files)" ]; then
@@ -673,7 +688,7 @@ then
 		tree=$(GIT_INDEX_FILE="$TMP_INDEX" git-write-tree) &&
 		rm -f "$TMP_INDEX"
 	fi &&
-	commit=$(cat "$GIT_DIR"/COMMIT_MSG | git-commit-tree $tree $PARENTS) &&
+	commit=$(cat "$GIT_DIR"/COMMIT_MSG | git-commit-tree $tree $PARENTS $PRIOR) &&
 	git-update-ref HEAD $commit $current &&
 	rm -f -- "$GIT_DIR/MERGE_HEAD" &&
 	if test -f "$NEXT_INDEX"
