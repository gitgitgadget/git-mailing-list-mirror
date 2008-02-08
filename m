From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] git help -w should not create nohup.out
Date: Fri,  8 Feb 2008 04:33:41 +0300
Message-ID: <1202434421-8066-1-git-send-email-dpotapov@gmail.com>
Cc: Dmitry Potapov <dpotapov@gmail.com>
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 02:34:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNI8C-0002Bd-KE
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 02:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935360AbYBHBdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 20:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935281AbYBHBdo
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 20:33:44 -0500
Received: from smtp04.mtu.ru ([62.5.255.51]:56092 "EHLO smtp04.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935053AbYBHBdn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 20:33:43 -0500
Received: from smtp04.mtu.ru (localhost [127.0.0.1])
	by smtp04.mtu.ru (Postfix) with ESMTP id BCC4F823D82;
	Fri,  8 Feb 2008 04:33:41 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-191-183.pppoe.mtu-net.ru [85.141.191.183])
	by smtp04.mtu.ru (Postfix) with ESMTP id 7F886823C45;
	Fri,  8 Feb 2008 04:33:41 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JNI7Z-00026R-Bv; Fri, 08 Feb 2008 04:33:41 +0300
X-Mailer: git-send-email 1.5.4
X-DCC-STREAM-Metrics: smtp04.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73024>

git-help--browse uses 'nohup' to launch some browsers. If the output is not
redirected, 'nohup' creates 'nohup.out' and prints a warning about that. It
was mighty annoying to see this warning as well as to have empty nohup.out
files scattered everywhere you happened to use 'git help -w'.

This patch redirects the output to /dev/null when a GUI browser is launched
using the 'nohup' command; thus 'nohup.out' is not created.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

Initially I thought to redict the output to $HOME/.git-nohup.out instead of
/dev/null, so no output will be lost if an error happen. But the only error
that a GUI browser may want to report to the stderr or stdout is a problem
inside Xlib (like connection to X display or something like that), and when
it happens you cannot run your favorite browser from the command line anyway.
So, it is very noticeably and no problem to diagnose without any nohup.out
created by git help.

 git-help--browse.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-help--browse.sh b/git-help--browse.sh
index 10b0a36..320e836 100755
--- a/git-help--browse.sh
+++ b/git-help--browse.sh
@@ -122,7 +122,7 @@ case "$browser" in
 	vers=$(expr "$($browser_path -version)" : '.* \([0-9][0-9]*\)\..*')
 	NEWTAB='-new-tab'
 	test "$vers" -lt 2 && NEWTAB=''
-	nohup "$browser_path" $NEWTAB $pages &
+	nohup "$browser_path" $NEWTAB $pages > /dev/null &
 	;;
     konqueror)
 	case "$(basename "$browser_path")" in
@@ -136,7 +136,7 @@ case "$browser" in
 		eval "$browser_path" newTab $pages
 		;;
 	    *)
-	        nohup "$browser_path" $pages &
+	        nohup "$browser_path" $pages > /dev/null &
 		;;
 	esac
 	;;
@@ -144,6 +144,6 @@ case "$browser" in
 	eval "$browser_path" $pages
 	;;
     dillo)
-	nohup "$browser_path" $pages &
+	nohup "$browser_path" $pages > /dev/null &
 	;;
 esac
-- 
1.5.4
