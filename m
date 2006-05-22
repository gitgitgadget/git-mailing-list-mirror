From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] git status: ignore empty directories (because they cannot be added)
Date: Mon, 22 May 2006 23:02:06 +0200
Message-ID: <E1FiHXS-0008MC-LB@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 22 23:02:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiHXZ-0006SJ-5T
	for gcvg-git@gmane.org; Mon, 22 May 2006 23:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWEVVCK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 17:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWEVVCK
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 17:02:10 -0400
Received: from moooo.ath.cx ([85.116.203.178]:13976 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751183AbWEVVCJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 17:02:09 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20533>

and a new option -u / --untracked-files to show files in untracked
directories.

---
A few things I'm not sure about:
- Should there be another option to disable --no-empty-directory?
- Is the option name --untracked-files ok?
- Should it be documented (probably yes :))? At the moment the
  git-status man page does not tell about any command line option at
  all but for git-commit it does not make sense.

 git-commit.sh |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

---

1921592d5e7809f72a902cca1a38217b150800a9
diff --git a/git-commit.sh b/git-commit.sh
index 6ef1a9d..6785826 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -3,7 +3,7 @@ #
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2006 Junio C Hamano
 
-USAGE='[-a] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit>) [--amend] [-e] [--author <author>] [[-i | -o] <path>...]'
+USAGE='[-a] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit>] [-u] [--amend] [-e] [--author <author>] [[-i | -o] <path>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 
@@ -134,13 +134,17 @@ #'
 	report "Changed but not updated" \
 	    "use git-update-index to mark for commit"
 
+        option=""
+        if test -z "$untracked_files"; then
+            option="--directory --no-empty-directory"
+        fi
 	if test -f "$GIT_DIR/info/exclude"
 	then
-	    git-ls-files -z --others --directory \
+	    git-ls-files -z --others $option \
 		--exclude-from="$GIT_DIR/info/exclude" \
 		--exclude-per-directory=.gitignore
 	else
-	    git-ls-files -z --others --directory \
+	    git-ls-files -z --others $option \
 		--exclude-per-directory=.gitignore
 	fi |
 	perl -e '$/ = "\0";
@@ -203,6 +207,7 @@ verbose=
 signoff=
 force_author=
 only_include_assumed=
+untracked_files=
 while case "$#" in 0) break;; esac
 do
   case "$1" in
@@ -340,6 +345,12 @@ do
       verbose=t
       shift
       ;;
+  -u|--u|--un|--unt|--untr|--untra|--untrac|--untrack|--untracke|--untracked|\
+  --untracked-|--untracked-f|--untracked-fi|--untracked-fil|--untracked-file|\
+  --untracked-files)
+      untracked_files=t
+      shift
+      ;;
   --)
       shift
       break
-- 
1.3.2
