From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] add commit --interactive
Date: Thu, 01 Mar 2007 11:56:21 +0100
Message-ID: <es6bgl$t3f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080600000704060909090700"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 11:56:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMixj-0008Bs-56
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 11:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbXCAK4h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 05:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbXCAK4h
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 05:56:37 -0500
Received: from main.gmane.org ([80.91.229.2]:52010 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964959AbXCAK4g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 05:56:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HMixY-0003iR-RV
	for git@vger.kernel.org; Thu, 01 Mar 2007 11:56:28 +0100
Received: from usilu-ge.ti-edu.ch ([195.176.176.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 11:56:28 +0100
Received: from bonzini by usilu-ge.ti-edu.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 11:56:28 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: usilu-ge.ti-edu.ch
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41082>

This is a multi-part message in MIME format.
--------------080600000704060909090700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The --interactive option behaves like "git commit", except that
"git add --interactive" is executed before committing.  It is
incompatible with -a and -i.

Paolo

--------------080600000704060909090700
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="git-commit-interactive.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-commit-interactive.patch"

* git-commit: add a --interactive option.
    
The --interactive option behaves like "git commit", except that
"git add --interactive" is executed before committing.  It is
incompatible with -a and -i.


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
 
+5. by using the --interactive switch with the 'commit' command to invoke "add"
+   in interactive mode, which lets the user decide one by one which files
+   to add or remove.
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

--------------080600000704060909090700--
