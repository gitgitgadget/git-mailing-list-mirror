From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v5 3/8] imap-send: use run-command API for tunneling
Date: Wed, 21 Oct 2009 19:04:46 +0200
Message-ID: <1256144691-2908-4-git-send-email-kusmabite@gmail.com>
References: <1256144691-2908-1-git-send-email-kusmabite@gmail.com> <1256144691-2908-2-git-send-email-kusmabite@gmail.com> <1256144691-2908-3-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Oct 21 19:05:33 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vw0-f156.google.com ([209.85.212.156])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0ecq-0007iA-Ny
	for gcvm-msysgit@m.gmane.org; Wed, 21 Oct 2009 19:05:29 +0200
Received: by vws28 with SMTP id 28so7316377vws.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 21 Oct 2009 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=xF0yzXXOedsLG/aYwxhVZJ0nJi5q2tbF/ZFKn/3VUoQ=;
        b=Z9btPVxR4OQlEjqCVGwJdPoUW4j2JS2GPkLyPIG9u7hmBShbQlOiQKT56S7kIS2nuZ
         kWhveoHq6ztXNfYE6pQr2tlavm61HpPm9nprfdZx2bkyt/u8kNh9kWS9LCaXftOKpvPf
         0kaJXR/r+sCuti5h+CpKLd53e9CaBOXYbUOIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=zbXChN5VIJuL6SQn3V7H1OiZIUDcdE9gFHfLgn546fOofUaSUHHkELsWDsZOYQXSOc
         IcSvGEioMhPX7Hb8f8Up8ZebV0cKtRjOLkFEEgvohG9CSor+J4tLL/U9ZFiHp/7qbGND
         ZU7vvsXKiuhA9kbtXsH2rBmRmL2MHvmSi4/Mg=
Received: by 10.220.104.6 with SMTP id m6mr1000836vco.2.1256144721704;
        Wed, 21 Oct 2009 10:05:21 -0700 (PDT)
Received: by 10.176.241.26 with SMTP id o26gr7478yqh.0;
	Wed, 21 Oct 2009 10:05:20 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.3.25 with SMTP id 25mr623044ebc.14.1256144719305; Wed, 21 Oct 2009 10:05:19 -0700 (PDT)
Received: by 10.210.3.25 with SMTP id 25mr623042ebc.14.1256144719277; Wed, 21 Oct 2009 10:05:19 -0700 (PDT)
Received: from mail-ew0-f205.google.com (mail-ew0-f205.google.com [209.85.219.205]) by gmr-mx.google.com with ESMTP id 16si38447ewy.7.2009.10.21.10.05.18; Wed, 21 Oct 2009 10:05:18 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.205 as permitted sender) client-ip=209.85.219.205;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.205 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-ew0-f205.google.com with SMTP id 1so6520610ewy.3 for <msysgit@googlegroups.com>; Wed, 21 Oct 2009 10:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=FTx/qowdiwbDHZMOOjF1ndDE9hLgK0ZzVUtD3trPLJo=; b=keAeZMkMC+z834mj7ob2Xw3V5QbN1Cp/9h3jmFAclXCU2tEySdJJdE7FexY78ksEkd izbcDM0hH3uI9M+inftHz/xjVDtsE2FMvt8k0/80c1SUsyr4eMF1IRaF8jvuzz6ppl/0 LUc60rNVqJezige14t/yY+aWsnuk7p0WdKNmI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=A1JPhBGXtYQNvpYmwO79YttUU/5DNLmVSnT/3lGw8LF4OzAEwQbqJse8GD3sllwqXu hp2UYuA1SdvjH2KQKntASCRyVoM9IYNwFSnny1BByDA8YFyYkip3yxj8r3GtCEWeay69 A3/i5fn9Tle1xFt4Ibg/4fXQJTdoEchstH1Aw=
Received: by 10.211.143.10 with SMTP id v10mr9232494ebn.57.1256144718131; Wed, 21 Oct 2009 10:05:18 -0700 (PDT)
Received: from localhost ([77.40.159.131]) by mx.google.com with ESMTPS id 23sm452389eya.44.2009.10.21.10.05.17 (version=TLSv1/SSLv3 cipher=RC4-MD5); Wed, 21 Oct 2009 10:05:17 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1256144691-2908-3-git-send-email-kusmabite@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130931>


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
1.6.4.msysgit.0
