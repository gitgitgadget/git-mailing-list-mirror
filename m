From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 2/7] imap-send: use run-command API for tunneling
Date: Sat,  3 Oct 2009 00:39:40 +0000
Message-ID: <1254530385-2824-2-git-send-email-kusmabite@gmail.com>
References: <1254530385-2824-1-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Sat Oct 03 02:40:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtsfN-0004Pj-G5
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 02:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560AbZJCAjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 20:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754542AbZJCAjv
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 20:39:51 -0400
Received: from mail-qy0-f173.google.com ([209.85.221.173]:60096 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442AbZJCAju (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 20:39:50 -0400
Received: by mail-qy0-f173.google.com with SMTP id 3so1339018qyk.4
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 17:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5/P8l5x0ig5MD1upWDIRRHh1Ccf6eqD1toJouqijCD0=;
        b=JV+Hi8aXL2u2QTEni1q54R93YpWDyok8oTOWcjs54HATP8f0dg5B26m16To4gWF4t9
         tagmGH+Si+UlB/wvSg3VAStNlIj9vv/sjo9m4kLQK07zKdptYCOT+GEusCKVWNl304cJ
         x71gnQ6Ee4iN+NA+/J6B/5UZY/RYYW87Cr3Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kbbsJDuVSHWkUrZGuVUPA7qYgX34NqXgO99VBgqy0lYivBHn6MxRsLe8Z4O6imgV42
         ZVdBUWWWDZaajZJR1+5X9cxGG9igi/g/z1pnJneK9teqx6iXNzcPaeLllLtveg7Mfz1K
         a9/JaY+43en7cb9+XSQ598/AX9OKGdJoDvvo8=
Received: by 10.224.3.204 with SMTP id 12mr1661072qao.70.1254530394860;
        Fri, 02 Oct 2009 17:39:54 -0700 (PDT)
Received: from localhost ([75.35.230.210])
        by mx.google.com with ESMTPS id 22sm147621qyk.10.2009.10.02.17.39.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Oct 2009 17:39:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1254530385-2824-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129472>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 imap-send.c |   37 ++++++++++++++++---------------------
 1 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index ba50961..55a663a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -24,6 +24,7 @@
 
 #include "cache.h"
 #include "exec_cmd.h"
+#include "run-command.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #endif
@@ -989,8 +990,7 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 	struct imap_store *ctx;
 	struct imap *imap;
 	char *arg, *rsp;
-	int s = -1, a[2], preauth;
-	pid_t pid;
+	int s = -1, preauth;
 
 	ctx = xcalloc(sizeof(*ctx), 1);
 
@@ -1001,29 +1001,24 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
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
1.6.5.rc2.7.g4f8d3
