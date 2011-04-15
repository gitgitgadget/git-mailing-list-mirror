From: Seth Jennings <spartacus06@gmail.com>
Subject: [PATCH] git-daemon: fix segfaulting in child_handler() in AIX
Date: Fri, 15 Apr 2011 11:51:00 -0500
Message-ID: <1302886260-25860-1-git-send-email-spartacus06@gmail.com>
Cc: Seth Jennings <spartacus06@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 18:52:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAmFW-0003r7-PU
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 18:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846Ab1DOQv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 12:51:57 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60143 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773Ab1DOQv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 12:51:56 -0400
Received: by ywj3 with SMTP id 3so735167ywj.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 09:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=IzQrpyj2PTTbUrqIrxw+HoSCPbASyLkQwGMVh8f6F3Q=;
        b=gx5YHecYL35nKD/KfIuIBBVMMGNVfqg8ap4XmWgABIn62xlrGSa6m3W46y7cmBsBI2
         YXzyRyOeTq3JpReDIQCe9CBdczGcseDw8qsSnKEPeyOAJPInfe+t4dViLU0D4g0VZdY6
         y8hyOEnz7cbOfH1vZbzedMhzkcH9Hdl1G+Y3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=fZeuZbY3I/844VTIvPKovZ2Ttq7XFAMjqV+hPgL322jMqZ34DsnINqXiMAFzMf+5Wo
         dvGE/vkWC1FUAK5FgMiXzHLAlC+wIEiKcbnud5sUdUHTBR/FZo0fw1eXq9DpLOlatFHB
         zCDQpiT/pJGSR+J8da/iuO0Malae7EhQrh21Q=
Received: by 10.101.184.12 with SMTP id l12mr1306644anp.93.1302886315905;
        Fri, 15 Apr 2011 09:51:55 -0700 (PDT)
Received: from localhost.localdomain ([32.97.110.56])
        by mx.google.com with ESMTPS id c4sm2776064ana.23.2011.04.15.09.51.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 09:51:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171616>

This issue seems to be specific to git-daemon on AIX built with xlc.
After commit 695605b5080e1957bd9dab1fed35a7fee9814297 (from Aug 2008),
git-daemon segfaults in child_handler() inside the signal() syscall
immediately after any remote clone/pull operation.  While it is not
fully understood why this happens, changing signal() to sigaction()
resolves the issue.

This commit converts singal() to sigaction() in child_handler().
---
 daemon.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index 4c8346d..3ea5b2c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -715,7 +715,10 @@ static void child_handler(int signo)
 	 * upon signal receipt
 	 * SysV needs the handler to be rearmed
 	 */
-	signal(SIGCHLD, child_handler);
+	struct sigaction sigact;
+	memset(&sigact, 0, sizeof(sigact));
+	sigact.sa_handler = child_handler;
+	sigaction(SIGCHLD, &sigact, NULL);
 }
 
 static int set_reuse_addr(int sockfd)
@@ -889,7 +892,10 @@ static int service_loop(struct socketlist *socklist)
 		pfd[i].events = POLLIN;
 	}
 
-	signal(SIGCHLD, child_handler);
+	struct sigaction sigact;
+	memset(&sigact, 0, sizeof(sigact));
+	sigact.sa_handler = child_handler;
+	sigaction(SIGCHLD, &sigact, NULL);
 
 	for (;;) {
 		int i;
-- 
1.7.0.4
