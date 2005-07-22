From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] tools/applymbox: allow manual fixing and continuing after a failure.
Date: Fri, 22 Jul 2005 16:04:19 -0700
Message-ID: <7vhdemigss.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 01:04:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw6ZB-0001D1-0W
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 01:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVGVXEW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 19:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVGVXEW
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 19:04:22 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:61331 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262213AbVGVXEV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 19:04:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050722230419.UUBF18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 19:04:19 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

With "-c .dotest/0002" flag, the applymbox command can be told
to use existing .dotest/patch file after hand-fixing the patch
conflicts for the second patch in the mailbox, and continue on
from that message, skipping the already applied first patch in
.dotest/0001.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 tools/applymbox |   48 ++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 38 insertions(+), 10 deletions(-)

688c63d625903ea3972deb3ec5c6dc3ef00f950e
diff --git a/tools/applymbox b/tools/applymbox
--- a/tools/applymbox
+++ b/tools/applymbox
@@ -9,20 +9,48 @@
 ## You give it a mbox-format collection of emails, and it will try to
 ## apply them to the kernel using "applypatch"
 ##
-## dotest [ -q ] mail_archive [Signoff_file]
+## applymbox [ -c .dotest/msg-number ] [ -q ] mail_archive [Signoff_file]"
 ##
-rm -rf .dotest
-mkdir .dotest
-case $1 in
+## The patch application may fail in the middle.  In which case:
+## (1) look at .dotest/patch and fix it up to apply
+## (2) re-run applymbox with -c .dotest/msg-number for the current one.
+## Pay a special attention to the commit log message if you do this and
+## use a Signoff_file, because applypatch wants to append the sign-off
+## message to msg-clean every time it is run.
 
-	-q)	touch .dotest/.query_apply
-		shift;;
+query_apply= continue= resume=t
+while case "$#" in 0) break ;; esac
+do
+	case "$1" in
+	-q)	query_apply=t ;;
+	-c)	continue="$2"; resume=f; shift ;;
+	-*)	usage ;;
+	*)	break ;;
+	esac
+	shift
+done
+
+case "$continue" in
+'')
+	rm -rf .dotest
+	mkdir .dotest
+	mailsplit "$1" .dotest || exit 1
 esac
-mailsplit $1 .dotest || exit 1
-for i in .dotest/*
+
+case "$query_apply" in
+t)	touch .dotest/.query_apply
+esac
+
+for i in .dotest/0*
 do
-	mailinfo .dotest/msg .dotest/patch < $i > .dotest/info || exit 1
-	git-stripspace < .dotest/msg > .dotest/msg-clean
+	case "$resume,$continue" in
+	f,$i)	resume=t;;
+	f,*)	continue;;
+	*)
+		mailinfo .dotest/msg .dotest/patch <$i >.dotest/info || exit 1
+		git-stripspace < .dotest/msg > .dotest/msg-clean
+		;;
+	esac
 	applypatch .dotest/msg-clean .dotest/patch .dotest/info "$2"
 	ret=$?
 	if [ $ret -ne 0 ]; then
