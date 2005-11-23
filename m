From: Linus Torvalds <torvalds@osdl.org>
Subject: Allow editing of a revert-message
Date: Wed, 23 Nov 2005 09:57:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511230954440.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Nov 23 19:00:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eeysv-0005aI-N5
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 18:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVKWR6S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 12:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVKWR6S
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 12:58:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55241 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932113AbVKWR6R (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2005 12:58:17 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jANHvtnO032125
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 23 Nov 2005 09:57:55 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jANHvsfb014549;
	Wed, 23 Nov 2005 09:57:54 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12641>


I think all commit operations should allow editing of the message (ie we 
should do this for merges too), but that's _particularly_ true of doing a 
"git revert".

We should always explain why we needed to revert something.

This patch adds a "-e" or "--edit" flag to "git revert", although I 
actually suspect it should be on by default (and we should have a 
"--no-edit" flag to disable it, probably together with an automatic 
disable if stdin isn't a terminal).

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/git-revert.sh b/git-revert.sh
index 4154fe0..05bd854 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -25,7 +25,7 @@ usage () {
 	esac
 }
 
-no_commit= replay=
+no_commit= replay= edit=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -36,6 +36,9 @@ do
 	-r|--r|--re|--rep|--repl|--repla|--replay)
 		replay=t
 		;;
+	-e|--edit)
+		edit=t
+		;;
 	-*)
 		usage
 		;;
@@ -161,6 +164,7 @@ echo >&2 "Finished one $me."
 # If we are revert, or if our cherry-pick results in a hand merge,
 # we had better say that the current user is responsible for that.
 
+[ "$edit" ] && ${EDITOR:-${VISUAL:-vi}} .msg
 case "$no_commit" in
 '')
 	git-commit -n -F .msg
