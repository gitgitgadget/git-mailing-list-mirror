From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v5 2/8] imap-send: use separate read and write fds
Date: Wed, 21 Oct 2009 19:04:45 +0200
Message-ID: <1256144691-2908-3-git-send-email-kusmabite@gmail.com>
References: <1256144691-2908-1-git-send-email-kusmabite@gmail.com> <1256144691-2908-2-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Oct 21 19:06:04 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f163.google.com ([209.85.221.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0edN-0007fq-5C
	for gcvm-msysgit@m.gmane.org; Wed, 21 Oct 2009 19:06:01 +0200
Received: by mail-qy0-f163.google.com with SMTP id 35so5684134qyk.24
        for <gcvm-msysgit@m.gmane.org>; Wed, 21 Oct 2009 10:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=5FX7foVdqaHpsQKhAqLJACyOsa0XcyJdCAbIg8FZtxw=;
        b=jtaMlAxcadhtHgWWVErpiPI5RMrZzsp+U0g5xDG6lSechYl3Dtj6qVQR+pARVpmL4z
         lz7zRFUPZ9Xb+Kk0N715D3c9o9klvl4u1EHdy/1XATEa2rVwMZNA25T0wJ8/p7BTkizj
         X43aztVaAG8Bz+a14JnUSDtigJQDYXwuzI/uE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=0Ygj1quj8cggt7JfQOIFfCb77sPB0dbnNFAyzswMSfBHxWjax+OF/yBehi+Pah9qlT
         YLPE1OIghSGQLQjgcDzNlsTbT8I7I5gQxUE98pGH4uB97I1zEZwN1jv/KcNA7jHhJqU6
         0Y1zgsVsWRs2YDRTBOtLly06YhftKOjp4gQcs=
Received: by 10.224.49.81 with SMTP id u17mr404129qaf.10.1256144754503;
        Wed, 21 Oct 2009 10:05:54 -0700 (PDT)
Received: by 10.176.140.25 with SMTP id n25gr7477yqd.0;
	Wed, 21 Oct 2009 10:05:18 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.132.33 with SMTP id j33mr255771ebn.0.1256144716388; Wed, 21 Oct 2009 10:05:16 -0700 (PDT)
Received: by 10.211.132.33 with SMTP id j33mr255770ebn.0.1256144716330; Wed, 21 Oct 2009 10:05:16 -0700 (PDT)
Received: from mail-ew0-f212.google.com (mail-ew0-f212.google.com [209.85.219.212]) by gmr-mx.google.com with ESMTP id 15si39686ewy.0.2009.10.21.10.05.15; Wed, 21 Oct 2009 10:05:15 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.212 as permitted sender) client-ip=209.85.219.212;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.212 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by ewy8 with SMTP id 8so1440360ewy.44 for <msysgit@googlegroups.com>; Wed, 21 Oct 2009 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=5/WwoMPvVcRzE5itQUkfAYEkcfsjhIbVTvHG+YoYzg4=; b=I79Q07Be8LY/RjJ5jJrm0zNyRYtxdoEG6SHjP8MZLmZfe+12X6Capkp6Z4iZDwzKjt RVKoOCYbY8CAC7/xbER9Nkdd2t3V6uYYjEqKe1ZDmB5NF0hpU4NOUnwPTlqUBlYaRgZ4 NJEF3X9EU4yQpGYowa95EegFPaRyaKgJEtX30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=lKNbLBQeqUKDShitvo+bbTfgTHknLC1yodF7jMB3NmcbV1PCdpG9lqQWoIDMcnO9LU nXM3ggvlDddJ5F+pRg1/4tGfe5MX3uU2YuTZln5780jWzcxNh031PuXf+fONMl0k8S0/ 754bNuVC3E6zpIDjyjxB4rHTSXsKOD3/vt73o=
Received: by 10.211.132.36 with SMTP id j36mr7089688ebn.51.1256144714238; Wed, 21 Oct 2009 10:05:14 -0700 (PDT)
Received: from localhost ([77.40.159.131]) by mx.google.com with ESMTPS id 24sm72486eyx.7.2009.10.21.10.05.13 (version=TLSv1/SSLv3 cipher=RC4-MD5); Wed, 21 Oct 2009 10:05:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1256144691-2908-2-git-send-email-kusmabite@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130937>


This is a patch that enables us to use the run-command
API, which is supported on Windows.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 imap-send.c |   37 +++++++++++++++++++++++--------------
 1 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 8da7a94..7216453 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -151,7 +151,7 @@ struct imap_list {
 };
 
 struct imap_socket {
-	int fd;
+	int fd[2];
 	SSL *ssl;
 };
 
@@ -301,8 +301,12 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
 		ssl_socket_perror("SSL_new");
 		return -1;
 	}
-	if (!SSL_set_fd(sock->ssl, sock->fd)) {
-		ssl_socket_perror("SSL_set_fd");
+	if (!SSL_set_rfd(sock->ssl, sock->fd[0])) {
+		ssl_socket_perror("SSL_set_rfd");
+		return -1;
+	}
+	if (!SSL_set_wfd(sock->ssl, sock->fd[1])) {
+		ssl_socket_perror("SSL_set_wfd");
 		return -1;
 	}
 
@@ -324,11 +328,12 @@ static int socket_read(struct imap_socket *sock, char *buf, int len)
 		n = SSL_read(sock->ssl, buf, len);
 	else
 #endif
-		n = xread(sock->fd, buf, len);
+		n = xread(sock->fd[0], buf, len);
 	if (n <= 0) {
 		socket_perror("read", sock, n);
-		close(sock->fd);
-		sock->fd = -1;
+		close(sock->fd[0]);
+		close(sock->fd[1]);
+		sock->fd[0] = sock->fd[1] = -1;
 	}
 	return n;
 }
@@ -341,11 +346,12 @@ static int socket_write(struct imap_socket *sock, const char *buf, int len)
 		n = SSL_write(sock->ssl, buf, len);
 	else
 #endif
-		n = write_in_full(sock->fd, buf, len);
+		n = write_in_full(sock->fd[1], buf, len);
 	if (n != len) {
 		socket_perror("write", sock, n);
-		close(sock->fd);
-		sock->fd = -1;
+		close(sock->fd[0]);
+		close(sock->fd[1]);
+		sock->fd[0] = sock->fd[1] = -1;
 	}
 	return n;
 }
@@ -358,7 +364,8 @@ static void socket_shutdown(struct imap_socket *sock)
 		SSL_free(sock->ssl);
 	}
 #endif
-	close(sock->fd);
+	close(sock->fd[0]);
+	close(sock->fd[1]);
 }
 
 /* simple line buffering */
@@ -911,7 +918,7 @@ static void imap_close_server(struct imap_store *ictx)
 {
 	struct imap *imap = ictx->imap;
 
-	if (imap->buf.sock.fd != -1) {
+	if (imap->buf.sock.fd[0] != -1) {
 		imap_exec(ictx, NULL, "LOGOUT");
 		socket_shutdown(&imap->buf.sock);
 	}
@@ -939,7 +946,7 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 	ctx = xcalloc(sizeof(*ctx), 1);
 
 	ctx->imap = imap = xcalloc(sizeof(*imap), 1);
-	imap->buf.sock.fd = -1;
+	imap->buf.sock.fd[0] = imap->buf.sock.fd[1] = -1;
 	imap->in_progress_append = &imap->in_progress;
 
 	/* open connection to IMAP server */
@@ -966,7 +973,8 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 
 		close(a[0]);
 
-		imap->buf.sock.fd = a[1];
+		imap->buf.sock.fd[0] = a[1];
+		imap->buf.sock.fd[1] = dup(a[1]);
 
 		imap_info("ok\n");
 	} else {
@@ -1043,7 +1051,8 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 			goto bail;
 		}
 
-		imap->buf.sock.fd = s;
+		imap->buf.sock.fd[0] = s;
+		imap->buf.sock.fd[1] = dup(s);
 
 		if (srvc->use_ssl &&
 		    ssl_socket_connect(&imap->buf.sock, 0, srvc->ssl_verify)) {
-- 
1.6.4.msysgit.0
