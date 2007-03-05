From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: [PATCH, properly formatted] git-commit: add a --interactive option
Date: Mon, 05 Mar 2007 08:57:53 +0100
Message-ID: <45EBCD81.8020605@lu.unisi.ch>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 08:58:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO853-0005xz-8U
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 08:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbXCEH56 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 02:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbXCEH56
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 02:57:58 -0500
Received: from server.usilu.net ([195.176.178.200]:10239 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932151AbXCEH56 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 02:57:58 -0500
Received: from [192.168.76.141] ([192.168.76.141] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 5 Mar 2007 08:57:53 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
X-OriginalArrivalTime: 05 Mar 2007 07:57:53.0977 (UTC) FILETIME=[FABBEA90:01C75EFB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41409>

The --interactive option behaves like "git commit", except that
"git add --interactive" is executed before committing.  It is
incompatible with -a and -i.

Signed-off-by: Paolo Bonzini  <bonzini@gnu.org>

---
While I agree with the point you make, I suggest that the flow
indicated in your message (stash, pick, test, commit, repeat) could be
activated exactly by a "commit --interactive" command.  Since
interactive stuff does not require backward compatibility in general,
I would ask to commit my patch anyway, assuming that in the future the
feature is rewritten to conform to the flow you indicate -- and at the
same time, "add --interactive" is deprecated or even removed.

 Documentation/git-commit.txt |    9 +++++++--
 git-commit.sh                |   21 ++++++++++++++++-----
 2 files changed, 23 insertions(+), 7 deletions(-)


diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 2187eee..3a4d456 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,8 +8,9 @@ git-commit - Record changes to the repository
 SYNOPSIS
 --------
 [verse]
-'git-commit' [-a] [-s] [-v] [(-c | -C) <commit> | -F <file> | -m <msg> |
-	    --amend] [--no-verify] [-e] [--author <author>]
+'git-commit' [-a | --interactive] [-s] [-v]
+	   [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]
+	   [--no-verify] [-e] [--author <author>]
 	   [--] [[-i | -o ]<file>...]
 
 DESCRIPTION
@@ -35,6 +36,10 @@ methods:
    before, and to automatically "rm" files that have been
    removed from the working tree, and perform the actual commit.
 
+5. by using the --interactive switch with the 'commit' command to decide one
+   by one which files should be part of the commit, before finalizing the
+   operation.  Currently, this is done by invoking `git-add --interactive`.
+
 The gitlink:git-status[1] command can be used to obtain a
 summary of what is included by any of the above for the next
 commit by giving the same set of parameters you would give to
diff --git a/git-commit.sh b/git-commit.sh
index be3677c..e8ec3b9 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2006 Junio C Hamano
 
-USAGE='[-a] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [[-i | -o] <path>...]'
+USAGE='[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [[-i | -o] <path>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 require_work_tree
@@ -71,6 +71,7 @@ trap '
 
 all=
 also=
+interactive=
 only=
 logfile=
 use_commit=
@@ -131,6 +132,11 @@ do
 		also=t
 		shift
 		;;
+	--int|--inte|--inter|--intera|--interac|--interact|--interacti|\
+	--interactiv|--interactive)
+		interactive=t
+		shift
+		;;
 	-o|--o|--on|--onl|--only)
 		only=t
 		shift
@@ -304,12 +310,14 @@ case "$#,$also,$only,$amend" in
 	;;
 esac
 unset only
-case "$all,$also,$#" in
-t,t,*)
-	die "Cannot use -a and -i at the same time." ;;
+case "$all,$interactive,$also,$#" in
+*t,*t,*)
+	die "Cannot use -a, --interactive or -i at the same time." ;;
 t,,[1-9]*)
 	die "Paths with -a does not make sense." ;;
-,t,0)
+,t,[1-9]*)
+	die "Paths with --interactive does not make sense." ;;
+,,t,0)
 	die "No paths with -i does not make sense." ;;
 esac
 
@@ -344,6 +352,9 @@ t,)
 	) || exit
 	;;
 ,)
+	if test "$interactive" = t; then
+		git add --interactive || exit
+	fi
 	case "$#" in
 	0)
 		;; # commit as-is
