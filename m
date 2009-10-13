From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v3 2/8] imap-send: use separate read and write fds
Date: Tue, 13 Oct 2009 19:25:19 +0000
Message-ID: <1255461925-2244-3-git-send-email-kusmabite@gmail.com>
References: <1255461925-2244-1-git-send-email-kusmabite@gmail.com> <1255461925-2244-2-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Oct 13 21:26:06 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f143.google.com ([209.85.221.143])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxn0X-0006Yc-Db
	for gcvm-msysgit@m.gmane.org; Tue, 13 Oct 2009 21:26:05 +0200
Received: by qyk7 with SMTP id 7so10658267qyk.15
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Oct 2009 12:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=sB5iKF7jgLIKx8Mmmb7xNfm2yTwNuo+/IMW479cATTw=;
        b=mQ9UH+b6Elnybp6XK1ENeZJl0FM28U9VQ/8IF4/hr3G8SjL4DuZ/AQadyvPkxYTouz
         NH8Cfypw7vm8FO4nZvGHEhFc4iv9TJtHtmeeksFayycCty5M2WH2HufCqsWxyCKP7pmN
         YxM6h6G6k2HXkaI5xz76Ag+NvcIBHcxNZD8sI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=34YQ+QzY28sd2gpIS/rNx6SgiJt/SeRK4d7sh++uX+x7pzYUlYmz+OInK1r4+xYp2m
         TfT9oTQi5uU1xwzCrgpkMx/Sd1W50mO/9SPzkv8EShhXVvOLog2WQeMfaqAO6R4Hj4zQ
         QmDe1rsbLJsO2yDAU2cMKdUEbsDMAQslvNJhE=
Received: by 10.224.69.148 with SMTP id z20mr365228qai.45.1255461958303;
        Tue, 13 Oct 2009 12:25:58 -0700 (PDT)
Received: by 10.177.128.16 with SMTP id f16gr7396yqn.0;
	Tue, 13 Oct 2009 12:25:57 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.128.10 with SMTP id f10mr1059814ebn.17.1255461956604; Tue, 13 Oct 2009 12:25:56 -0700 (PDT)
Received: by 10.211.128.10 with SMTP id f10mr1059811ebn.17.1255461956256; Tue, 13 Oct 2009 12:25:56 -0700 (PDT)
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.25]) by gmr-mx.google.com with ESMTP id 15si322559ewy.0.2009.10.13.12.25.55; Tue, 13 Oct 2009 12:25:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.25 as permitted sender) client-ip=74.125.78.25;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.25 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by ey-out-2122.google.com with SMTP id 22so2194226eye.37 for <msysgit@googlegroups.com>; Tue, 13 Oct 2009 12:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=0aF2yue7O41/TTANfdvluVG+04cfWGjV2Rdy/mcia5c=; b=oNUys+k4Vt2Ya0pTDatNMKjGUUzCevTrI30w1v/sS3OeRKrXABP2jqHZZQPLMC71dv MAY6dNhoWmYgF2/IIUtdVa8Hy65gA/F2EanB6Tpvf4LeOIsKYVs7hDfNRRb5snlb6IEU wk1aeoyk/5iokmPZbxUkLtU7rNFrvK3INueYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=xD79mXfg+1Xu+mSwaZzEmxwiSsDzyEFdgcCift8GUCXCFp2NqoDQST9ql7bIM2koiT cJp0kp3extcAo0SNOQfqkCXIDy0rDyjvWBfauFzNjlIwLYiiBNJCpmgHgu8cQb4Il7na BGwTBAI4vzTB3oY6tbo0ThKxn6buMm98C54Ck=
Received: by 10.211.159.13 with SMTP id l13mr9063980ebo.82.1255461955138; Tue, 13 Oct 2009 12:25:55 -0700 (PDT)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12]) by mx.google.com with ESMTPS id 7sm4155699eyb.8.2009.10.13.12.25.53 (version=TLSv1/SSLv3 cipher=RC4-MD5); Tue, 13 Oct 2009 12:25:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1255461925-2244-2-git-send-email-kusmabite@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130184>


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
1.6.4
