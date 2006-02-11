From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix fetch-clone in the presense of signals
Date: Sat, 11 Feb 2006 10:41:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602111038400.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Feb 11 19:41:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7zgZ-0000dh-4w
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 19:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWBKSl2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 13:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWBKSl2
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 13:41:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11239 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932347AbWBKSl1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 13:41:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1BIfNDZ013685
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 11 Feb 2006 10:41:23 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1BIfMHd008883;
	Sat, 11 Feb 2006 10:41:22 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15956>


We shouldn't fail a fetch just because a signal might have interrupted
the read.

Normally, we don't install any signal handlers, so EINTR really shouldn't 
happen. That said, really old versions of Linux will interrupt an 
interruptible system call even for signals that turn out to be ignored 
(SIGWINCH is the classic example - resizing your xterm would cause it). 
The same might well be true elsewhere too.

Also, since receive_keep_pack() doesn't control the caller, it can't know 
that no signal handlers exist.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

diff --git a/fetch-clone.c b/fetch-clone.c
index b67d976..d8216cb 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -153,10 +153,13 @@ int receive_keep_pack(int fd[2], const c
 		if (sz == 0)
 			break;
 		if (sz < 0) {
-			error("error reading pack (%s)", strerror(errno));
-			close(ofd);
-			unlink(tmpfile);
-			return -1;
+			if (errno != EINTR && errno != EAGAIN) {
+				error("error reading pack (%s)", strerror(errno));
+				close(ofd);
+				unlink(tmpfile);
+				return -1;
+			}
+			sz = 0;
 		}
 		pos = 0;
 		while (pos < sz) {
