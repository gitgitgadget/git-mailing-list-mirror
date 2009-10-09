From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH 3/8] imap-send: use run-command API for tunneling
Date: Fri,  9 Oct 2009 17:04:37 +0200
Message-ID: <1255100682-13952-3-git-send-email-kusmabite@gmail.com>
References: <1255100682-13952-1-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-2-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 17:11:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwH8A-0007fT-Ol
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 17:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761050AbZJIPGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 11:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761045AbZJIPGT
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 11:06:19 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:52606 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761041AbZJIPGS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 11:06:18 -0400
Received: by ewy4 with SMTP id 4so697646ewy.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 08:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=LeGqYM0HXhPG18W4mwKLO+aLaYyDk73F7FZXo0ekgo4=;
        b=rdB2kd/Lvdzp9b7qIXwmtAi5+FmHsOu6TkokAW2lwkB5TcUsCkFWhzM2JWjKtapL37
         kjT4Xh6hgWHSFypIFQ0+W9cYwZn8HwFK+tgw3RWevZJF2gRRJbLkOheNoWHurB2NMQbu
         xsitlh5xyGJrfF0vaNHAmZaHd/Hq5ekw1ewSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EP0E0ljOyXfMrM+ZWBICv3pG7sFqE+w5DrLvbN/g96WvPWyWTnuwArB1vM6uI4pdfC
         sQqkXYncIcq5YeYMqyftJKFumV6EWQI2toilH6yuFFsGEligtxWAf3F+rYZdLUpTs9lu
         ooz7WBwGwA5QQ3Wcf2PohAN73lSoE+mkfuCkk=
Received: by 10.210.154.9 with SMTP id b9mr350123ebe.34.1255100741114;
        Fri, 09 Oct 2009 08:05:41 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 10sm506948eyz.40.2009.10.09.08.05.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 08:05:40 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1255100682-13952-2-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129810>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 imap-send.c |   37 ++++++++++++++++---------------------
 1 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 7216453..dc3da98 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -24,6 +24,7 @@
 
 #include "cache.h"
 #include "exec_cmd.h"
+#include "run-command.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #endif
@@ -940,8 +941,7 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 	struct imap_store *ctx;
 	struct imap *imap;
 	char *arg, *rsp;
-	int s = -1, a[2], preauth;
-	pid_t pid;
+	int s = -1, preauth;
 
 	ctx = xcalloc(sizeof(*ctx), 1);
 
@@ -952,29 +952,24 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 	/* open connection to IMAP server */
 
 	if (srvc->tunnel) {
-		imap_info("Starting tunnel '%s'... ", srvc->tunnel);
+		const char *argv[4];
+		struct child_process tunnel = {0};
 
-		if (socketpair(PF_UNIX, SOCK_STREAM, 0, a)) {
-			perror("socketpair");
-			exit(1);
-		}
+		imap_info("Starting tunnel '%s'... ", srvc->tunnel);
 
-		pid = fork();
-		if (pid < 0)
-			_exit(127);
-		if (!pid) {
-			if (dup2(a[0], 0) == -1 || dup2(a[0], 1) == -1)
-				_exit(127);
-			close(a[0]);
-			close(a[1]);
-			execl("/bin/sh", "sh", "-c", srvc->tunnel, NULL);
-			_exit(127);
-		}
+		argv[0] = "/bin/sh";
+		argv[1] = "-c";
+		argv[2] = srvc->tunnel;
+		argv[3] = NULL;
 
-		close(a[0]);
+		tunnel.argv = argv;
+		tunnel.in = -1;
+		tunnel.out = -1;
+		if (start_command(&tunnel))
+			die("cannot start proxy %s", argv[0]);
 
-		imap->buf.sock.fd[0] = a[1];
-		imap->buf.sock.fd[1] = dup(a[1]);
+		imap->buf.sock.fd[0] = tunnel.out;
+		imap->buf.sock.fd[1] = tunnel.in;
 
 		imap_info("ok\n");
 	} else {
-- 
1.6.5.rc1.60.g41795
