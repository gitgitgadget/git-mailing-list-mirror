From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-commit -f <file>: take message from file, and remove file upon completion.
Date: Fri, 4 May 2007 14:30:22 +0000
Message-ID: <20070504143022.8539.qmail@4071cc1c178e73.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 16:30:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjynU-0002V6-8X
	for gcvg-git@gmane.org; Fri, 04 May 2007 16:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348AbXEDOaI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 10:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755354AbXEDOaI
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 10:30:08 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:48686 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1755348AbXEDOaF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 10:30:05 -0400
Received: (qmail 8540 invoked by uid 1000); 4 May 2007 14:30:22 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46182>

Change (undocumented) git commit -f option from a synonym for git-commit -F
to "Take the commit message from the given file, and remove the file upon
successful commit".

git-revert and git-cherry-pick should make use of this to properly cleanup
the automatically created ./.msg file.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Documentation/git-commit.txt |    7 ++++---
 git-commit.sh                |   25 +++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 53a7bb0..da68c81 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git-commit' [-a | --interactive] [-s] [-v]
-	   [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]
+	   [(-c | -C) <commit> | (-F | -f) <file> | -m <msg> | --amend]
 	   [--no-verify] [-e] [--author <author>]
 	   [--] [[-i | -o ]<file>...]
 
@@ -63,9 +63,10 @@ OPTIONS
 	invoked; with '-c' the user can further edit the commit
 	message.
 
--F <file>::
+-F or -f <file>::
 	Take the commit message from the given file.  Use '-' to
-	read the message from the standard input.
+	read the message from the standard input.  With '-f', the
+	file is removed upon successful commit; with '-F' not.
 
 --author <author>::
 	Override the author name used in the commit.  Use
diff --git a/git-commit.sh b/git-commit.sh
index f28fc24..e4518c4 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -74,6 +74,7 @@ also=
 interactive=
 only=
 logfile=
+logfile_rm=
 use_commit=
 amend=
 edit_flag=
@@ -90,15 +91,31 @@ untracked_files=
 while case "$#" in 0) break;; esac
 do
 	case "$1" in
-	-F|--F|-f|--f|--fi|--fil|--file)
+	-f)
 		case "$#" in 1) usage ;; esac
 		shift
 		no_edit=t
 		log_given=t$log_given
 		logfile="$1"
+		test "$logfile" = '-' || logfile_rm=1
 		shift
 		;;
-	-F*|-f*)
+	-F|--F|--f|--fi|--fil|--file)
+		case "$#" in 1) usage ;; esac
+		shift
+		no_edit=t
+		log_given=t$log_given
+		logfile="$1"
+		shift
+		;;
+	-f*)
+		no_edit=t
+		log_given=t$log_given
+		logfile=`expr "z$1" : 'z-[Ff]\(.*\)'`
+		test "$logfile" = '-' || logfile_rm=1
+		shift
+		;;
+	-F*)
 		no_edit=t
 		log_given=t$log_given
 		logfile=`expr "z$1" : 'z-[Ff]\(.*\)'`
@@ -653,6 +670,10 @@ then
 		       --summary --root HEAD --`
 		echo "Created${initial_commit:+ initial} commit $commit"
 	fi
+	if test -n "$logfile_rm"
+	then
+		rm -f "$logfile"
+	fi
 fi
 
 exit "$ret"
-- 
1.5.1.2
