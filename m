From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Make git rebase interactive help match documentation.
Date: Sat, 13 May 2006 23:34:08 -0400
Message-ID: <BAYC1-PASMTP118D932D1C71F5F5A62D1EAEA20@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun May 14 05:39:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ff7SE-00079Z-28
	for gcvg-git@gmane.org; Sun, 14 May 2006 05:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWENDjf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 23:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWENDje
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 23:39:34 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:26961 "EHLO
	BAYC1-PASMTP11.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932344AbWENDje (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 23:39:34 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP11.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 13 May 2006 20:44:11 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 74DCA644C17
	for <git@vger.kernel.org>; Sat, 13 May 2006 23:39:32 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060513233408.0ff18551.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 14 May 2006 03:44:12.0109 (UTC) FILETIME=[A9EEEFD0:01C67708]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>

---

 Documentation/git-rebase.txt |   11 +++++------
 git-am.sh                    |   11 +++++++++--
 git-rebase.sh                |   21 ++++++++++++++++-----
 3 files changed, 30 insertions(+), 13 deletions(-)

0a4f0dac668dcba52e20d71c8503a50a92bc2b86
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 1b482ab..08ee4aa 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -9,9 +9,7 @@ SYNOPSIS
 --------
 'git-rebase' [--onto <newbase>] <upstream> [<branch>]
 
-'git-rebase' --continue
-
-'git-rebase' --abort
+'git-rebase' --continue | --skip | --abort
 
 DESCRIPTION
 -----------
@@ -23,9 +21,10 @@ not exist in the <upstream> branch.
 
 It is possible that a merge failure will prevent this process from being
 completely automatic.  You will have to resolve any such merge failure
-and run `git rebase --continue`.  If you can not resolve the merge
-failure, running `git rebase --abort` will restore the original <branch>
-and remove the working files found in the .dotest directory.
+and run `git rebase --continue`.  Another option is to bypass the commit
+that caused the merge failure with `git rebase --skip`.  To restore the
+original <branch> and remove the .dotest working files, use the command
+`git rebase --abort` instead.
 
 Note that if <branch> is not specified on the command line, the currently
 checked out branch is used.
diff --git a/git-am.sh b/git-am.sh
index 507ae4d..33f208c 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -15,6 +15,10 @@ stop_here () {
 }
 
 stop_here_user_resolve () {
+    if [ -n "$resolvemsg" ]; then
+	    echo "$resolvemsg"
+	    stop_here $1
+    fi
     cmdline=$(basename $0)
     if test '' != "$interactive"
     then
@@ -121,7 +125,7 @@ fall_back_3way () {
 }
 
 prec=4
-dotest=.dotest sign= utf8= keep= skip= interactive= resolved= binary= ws=
+dotest=.dotest sign= utf8= keep= skip= interactive= resolved= binary= ws= resolvemsg=
 
 while case "$#" in 0) break;; esac
 do
@@ -157,6 +161,9 @@ do
 	--whitespace=*)
 	ws=$1; shift ;;
 
+	--resolvemsg=*)
+	resolvemsg=$(echo "$1" | sed -e "s/^--resolvemsg=//"); shift ;;
+
 	--)
 	shift; break ;;
 	-*)
@@ -185,7 +192,7 @@ then
 else
 	# Make sure we are not given --skip nor --resolved
 	test ",$skip,$resolved," = ,,, ||
-		die "we are not resuming."
+		die "Resolve operation not in progress, we are not resuming."
 
 	# Start afresh.
 	mkdir -p "$dotest" || exit
diff --git a/git-rebase.sh b/git-rebase.sh
index 9e25902..6ff6088 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -12,9 +12,10 @@ It then attempts to create a new commit 
 
 It is possible that a merge failure will prevent this process from being
 completely automatic.  You will have to resolve any such merge failure
-and run git-rebase --continue.  If you can not resolve the merge failure,
-running git-rebase --abort will restore the original <branch> and remove
-the working files found in the .dotest directory.
+and run git rebase --continue.  Another option is to bypass the commit
+that caused the merge failure with git rebase --skip.  To restore the
+original <branch> and remove the .dotest working files, use the command
+git rebase --abort instead.
 
 Note that if <branch> is not specified on the command line, the
 currently checked out branch is used.  You must be in the top
@@ -28,6 +29,11 @@ Example:       git-rebase master~1 topic
 '
 . git-sh-setup
 
+RESOLVEMSG="
+When you have resolved this problem run \"git rebase --continue\".
+If you would prefer to skip this patch, instead run \"git rebase --skip\".
+To restore the original branch and stop rebasing run \"git rebase --abort\".
+"
 unset newbase
 while case "$#" in 0) break ;; esac
 do
@@ -40,7 +46,11 @@ do
 			exit 1
 			;;
 		esac
-		git am --resolved --3way
+		git am --resolved --3way --resolvemsg="$RESOLVEMSG"
+		exit
+		;;
+	--skip)
+		git am -3 --skip --resolvemsg="$RESOLVEMSG"
 		exit
 		;;
 	--abort)
@@ -143,4 +153,5 @@ then
 fi
 
 git-format-patch -k --stdout --full-index "$upstream" ORIG_HEAD |
-git am --binary -3 -k
+git am --binary -3 -k --resolvemsg="$RESOLVEMSG"
+
-- 
1.3.2.gd9a4
