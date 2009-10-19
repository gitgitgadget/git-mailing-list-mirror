From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v4 3/8] imap-send: use run-command API for tunneling
Date: Mon, 19 Oct 2009 17:42:04 +0200
Message-ID: <1255966929-1280-4-git-send-email-kusmabite@gmail.com>
References: <1255966929-1280-1-git-send-email-kusmabite@gmail.com> <1255966929-1280-2-git-send-email-kusmabite@gmail.com> <1255966929-1280-3-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Oct 19 17:43:45 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vw0-f156.google.com ([209.85.212.156])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzuOX-0006H8-O1
	for gcvm-msysgit@m.gmane.org; Mon, 19 Oct 2009 17:43:37 +0200
Received: by mail-vw0-f156.google.com with SMTP id 28so4737983vws.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 Oct 2009 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=L8H8D+JPLKz9IHl3sEm+LtoNSNjDA8FiaUHuQq740U8=;
        b=AAI3+XaDS6PJg2vHHa8SfUZ+HgzGYpZBOE2GB7igh5ZutXHcMmmjl7dy3FxsmaRzb7
         PVwzp/DBaC5q2yRsDDOrWdSj5yeXi+1Apzt/KTrBfqM0qUvrQZX/601lEQN4zFCJq553
         oyhOG+CkLaQCXGFmoHONqpNMr8lUddcCFYcyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=ChipiB91e11vLnJyM0eWONcajEKWaZp7fzWLGykselxUK1FPfbJHY8pzQPPNtMAvc0
         h1gY/6G2d7ECkcVTReISkAQhnc7Ea4FiVGIqAjRP+AtB6CVPaoRZhwIrioFA93fitRAm
         tLBp8znsatQyzSYktTGAQV0rVsahDR4RSgAkI=
Received: by 10.220.16.211 with SMTP id p19mr183984vca.26.1255967009491;
        Mon, 19 Oct 2009 08:43:29 -0700 (PDT)
Received: by 10.176.11.6 with SMTP id 6gr7449yqk.0;
	Mon, 19 Oct 2009 08:43:19 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.174.12 with SMTP id b12mr368387ebp.15.1255966997277; Mon, 19 Oct 2009 08:43:17 -0700 (PDT)
Received: by 10.211.174.12 with SMTP id b12mr368386ebp.15.1255966997229; Mon, 19 Oct 2009 08:43:17 -0700 (PDT)
Received: from mail-ew0-f211.google.com (mail-ew0-f211.google.com [209.85.219.211]) by gmr-mx.google.com with ESMTP id 14si904677ewy.5.2009.10.19.08.43.16; Mon, 19 Oct 2009 08:43:16 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.211 as permitted sender) client-ip=209.85.219.211;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.211 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-ew0-f211.google.com with SMTP id 7so3688486ewy.34 for <msysgit@googlegroups.com>; Mon, 19 Oct 2009 08:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=T/B2SKj9ofCGSkH1kw9+y+rDp4VhKdPcto1oI2TZZYI=; b=TsHE9LL9tm1uSCR1r844XT2EG+NVNKmk81HZli7IcwtZkonj+RRyObEp8RSJRF64vq rBJK1VmV4bwwzC9I4SpnlGIhj+kV8RnPHI7CF6GhuVrFHpVzRVXm3Xok2oPNErfRoDno 8QQy9B4e/ki2TKf+uasrnPcJIgWyH0I5XB3bE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=wM4LvRjRJkfravZeV6h0e8Sz6mmSpzU8EbM2bemzVicnA2u0BWohpO9OE29WqUxTbW GWvHrcBKeEftskCI0jmb7qpaRASkg1WYJbm2tqSR5fwPP78CwbeJoUgDqtVtCbacsrze WNmBPh6/6yPTjFKT3gRtBqdwrWLqxISq79V60=
Received: by 10.210.7.21 with SMTP id 21mr2794843ebg.75.1255966996059; Mon, 19 Oct 2009 08:43:16 -0700 (PDT)
Received: from localhost ([77.40.159.131]) by mx.google.com with ESMTPS id 7sm774541eyg.6.2009.10.19.08.43.14 (version=TLSv1/SSLv3 cipher=RC4-MD5); Mon, 19 Oct 2009 08:43:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1255966929-1280-3-git-send-email-kusmabite@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130703>


Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 imap-send.c |   37 ++++++++++++++++---------------------
 1 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 7216453..72ed640 100644
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
+		argv[0] = "sh";
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
1.6.5.15.g5f078
