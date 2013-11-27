From: Anthony Baire <Anthony.Baire@irisa.fr>
Subject: [PATCH] subtree: fix argument validation in add/pull/push
Date: Wed, 27 Nov 2013 19:34:09 +0100
Message-ID: <1385577249-29269-1-git-send-email-Anthony.Baire@irisa.fr>
Cc: Anthony Baire <Anthony.Baire@irisa.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 19:32:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VljuX-0003Jj-Ff
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 19:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547Ab3K0Sc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 13:32:26 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:26289 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752582Ab3K0ScZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Nov 2013 13:32:25 -0500
X-IronPort-AV: E=Sophos;i="4.93,784,1378850400"; 
   d="scan'208";a="45765203"
Received: from halfoat.irisa.fr ([131.254.16.11])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Nov 2013 19:32:23 +0100
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238450>

When working with a remote repository add/pull/push do not accept a
<refspec> as parameter but just a <ref>. They should accept any
well-formatted ref name.

This patch:
 - relaxes the check the <ref> argument in "git subtree add <repo>"
   (previous code would not accept a ref name that does not exist
   locally too, new code only ensures that the ref is well formatted)

 - add the same check in "git subtree pull/push" + check the number of
   parameters

 - update the doc to use <ref> instead of <refspec>

Signed-off-by: Anthony Baire <Anthony.Baire@irisa.fr>
---
 contrib/subtree/git-subtree.sh  |   22 ++++++++++++++++------
 contrib/subtree/git-subtree.txt |   14 +++++++-------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7d7af03..dc59a91 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -9,10 +9,10 @@ if [ $# -eq 0 ]; then
 fi
 OPTS_SPEC="\
 git subtree add   --prefix=<prefix> <commit>
-git subtree add   --prefix=<prefix> <repository> <commit>
+git subtree add   --prefix=<prefix> <repository> <ref>
 git subtree merge --prefix=<prefix> <commit>
-git subtree pull  --prefix=<prefix> <repository> <refspec...>
-git subtree push  --prefix=<prefix> <repository> <refspec...>
+git subtree pull  --prefix=<prefix> <repository> <ref>
+git subtree push  --prefix=<prefix> <repository> <ref>
 git subtree split --prefix=<prefix> <commit...>
 --
 h,help        show the help
@@ -489,6 +489,12 @@ ensure_clean()
 	fi
 }
 
+ensure_valid_ref_format()
+{
+	git check-ref-format "refs/heads/$1" ||
+	    die "'$1' does not look like a ref"
+}
+
 cmd_add()
 {
 	if [ -e "$dir" ]; then
@@ -508,8 +514,7 @@ cmd_add()
 	    # specified directory.  Allowing a refspec might be
 	    # misleading because we won't do anything with any other
 	    # branches fetched via the refspec.
-	    git rev-parse -q --verify "$2^{commit}" >/dev/null ||
-	    die "'$2' does not refer to a commit"
+	    ensure_valid_ref_format "$2"
 
 	    "cmd_add_repository" "$@"
 	else
@@ -699,7 +704,11 @@ cmd_merge()
 
 cmd_pull()
 {
+	if [ $# -ne 2 ]; then
+	    die "You must provide <repository> <ref>"
+	fi
 	ensure_clean
+	ensure_valid_ref_format "$2"
 	git fetch "$@" || exit $?
 	revs=FETCH_HEAD
 	set -- $revs
@@ -709,8 +718,9 @@ cmd_pull()
 cmd_push()
 {
 	if [ $# -ne 2 ]; then
-	    die "You must provide <repository> <refspec>"
+	    die "You must provide <repository> <ref>"
 	fi
+	ensure_valid_ref_format "$2"
 	if [ -e "$dir" ]; then
 	    repository=$1
 	    refspec=$2
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index e0957ee..02669b1 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -9,10 +9,10 @@ git-subtree - Merge subtrees together and split repository into subtrees
 SYNOPSIS
 --------
 [verse]
-'git subtree' add   -P <prefix> <refspec>
-'git subtree' add   -P <prefix> <repository> <refspec>
-'git subtree' pull  -P <prefix> <repository> <refspec...>
-'git subtree' push  -P <prefix> <repository> <refspec...>
+'git subtree' add   -P <prefix> <commit>
+'git subtree' add   -P <prefix> <repository> <ref>
+'git subtree' pull  -P <prefix> <repository> <ref>
+'git subtree' push  -P <prefix> <repository> <ref>
 'git subtree' merge -P <prefix> <commit>
 'git subtree' split -P <prefix> [OPTIONS] [<commit>]
 
@@ -68,7 +68,7 @@ COMMANDS
 --------
 add::
 	Create the <prefix> subtree by importing its contents
-	from the given <refspec> or <repository> and remote <refspec>.
+	from the given <commit> or <repository> and remote <ref>.
 	A new commit is created	automatically, joining the imported
 	project's history with your own.  With '--squash', imports
 	only a single commit from the subproject, rather than its
@@ -90,13 +90,13 @@ merge::
 	
 pull::
 	Exactly like 'merge', but parallels 'git pull' in that
-	it fetches the given commit from the specified remote
+	it fetches the given ref from the specified remote
 	repository.
 	
 push::
 	Does a 'split' (see below) using the <prefix> supplied
 	and then does a 'git push' to push the result to the 
-	repository and refspec. This can be used to push your
+	repository and ref. This can be used to push your
 	subtree to different branches of the remote repository.
 
 split::
-- 
1.7.10.4
