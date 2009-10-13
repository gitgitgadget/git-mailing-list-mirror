From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v3 3/8] imap-send: use run-command API for tunneling
Date: Tue, 13 Oct 2009 19:25:20 +0000
Message-ID: <1255461925-2244-4-git-send-email-kusmabite@gmail.com>
References: <1255461925-2244-1-git-send-email-kusmabite@gmail.com> <1255461925-2244-2-git-send-email-kusmabite@gmail.com> <1255461925-2244-3-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Oct 13 21:26:38 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f161.google.com ([209.85.211.161])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxn0w-0006e1-QC
	for gcvm-msysgit@m.gmane.org; Tue, 13 Oct 2009 21:26:30 +0200
Received: by mail-yw0-f161.google.com with SMTP id 33so5083562ywh.24
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Oct 2009 12:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=5soi3tX5HqJ9CHQazHKhcK+4YGmBv6Oo/bLiZVVwo8I=;
        b=hIL1hK7i97eYJT+gjuwCwX4IA6nPqg12TH1Yg0RmAtDh1aNfLCOhZDAhmkXlFGUZEo
         f8ZfOX48vhyIeUBY9y9MJDWfqETehhcL5dyay1Yz0v+IQol8zKco6l3nR4jI/FSQp0G9
         crp9MoNiMONVf5l8oIHQ+ZOEbsHb//cUFjIMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=Ow13YPR8r3Lum1g6N3crj80bZ5j9mTxxCBCU3wT/WuNaEkWPu9jBsggAKlt14imafL
         q6zLz6Sa4EIt+3YQDWuDs0YUwfB2xVbSSJO6vOkCbxO9ZxUKL19v4RFOwBYBwZ3jHqqP
         ve5Jqy/eqd8avbCYE6rKghjnBj2csQbEM57iU=
Received: by 10.151.16.1 with SMTP id t1mr909595ybi.0.1255461984123;
        Tue, 13 Oct 2009 12:26:24 -0700 (PDT)
Received: by 10.176.149.32 with SMTP id w32gr7397yqd.0;
	Tue, 13 Oct 2009 12:26:12 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.2.9 with SMTP id 9mr1321181ebb.29.1255461970841; Tue, 13 Oct 2009 12:26:10 -0700 (PDT)
Received: by 10.210.2.9 with SMTP id 9mr1321171ebb.29.1255461968002; Tue, 13 Oct 2009 12:26:08 -0700 (PDT)
Received: from mail-ew0-f217.google.com (mail-ew0-f217.google.com [209.85.219.217]) by gmr-mx.google.com with ESMTP id 15si322583ewy.0.2009.10.13.12.26.06; Tue, 13 Oct 2009 12:26:06 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.217 as permitted sender) client-ip=209.85.219.217;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.217 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by ewy17 with SMTP id 17so5954036ewy.15 for <msysgit@googlegroups.com>; Tue, 13 Oct 2009 12:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=H4S7NSeeuIKrxtHTWaStCO9EHjMNDIWFywINzZHH3ik=; b=SliziTCeUZrXqeM5Y0WEvnewhh8BLifgQK3I/s2wFb7U31ChAkgOU+cw7i7oMl52JU sZeOWi2s/87bP/WLaqYzy3WMXkWOPUk47wX+K+FOORvPknjuK2TlivQlaMO+0yod1YaH qA89/SKGAGU7HxHA2MrUtwzeK07GWFPmIS4PM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=SCAM9ldT3uU5GRnwdPxsZk3yaZzkbSJyf0LOSeKMkTJne/UM3/DfIxIP6owkK9q6Md /nbQL0RJYHZCueERPN89Vm2LeomzY4uiA90nAIHXOBLemaScrf3BdgsxayF4AA4PBaX5 8yvOB22FcyGMFMr0zLNsX4u+fAocmtKnfWeBo=
Received: by 10.216.90.81 with SMTP id d59mr2571314wef.29.1255461966778; Tue, 13 Oct 2009 12:26:06 -0700 (PDT)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12]) by mx.google.com with ESMTPS id 10sm3328eyd.6.2009.10.13.12.25.59 (version=TLSv1/SSLv3 cipher=RC4-MD5); Tue, 13 Oct 2009 12:26:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1255461925-2244-3-git-send-email-kusmabite@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130186>


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
1.6.4
