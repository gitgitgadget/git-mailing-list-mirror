From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 1/7] imap-send: use separate read and write fds
Date: Sat,  3 Oct 2009 00:39:39 +0000
Message-ID: <1254530385-2824-1-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Sat Oct 03 02:39:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtsfB-0004Kp-2E
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 02:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337AbZJCAjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 20:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754312AbZJCAjm
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 20:39:42 -0400
Received: from mail-qy0-f173.google.com ([209.85.221.173]:60096 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbZJCAjl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 20:39:41 -0400
Received: by qyk3 with SMTP id 3so1339018qyk.4
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 17:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=vWtKXJeti2/nDlkERVgnlh8u9t6XB+G6xDJRN5kHjfE=;
        b=RAlb21mon99+lj82NV82Df+ocnAmrqZye4fOwrSl9PQ1Wu0OjGVZTqHwdCf0I2gzpF
         suUK6XRoTBrTUSkIu0FFcrG4QcCeK+x9e6XqfoYcqFWiWjf8m+tXWxEFZY3f2BD3tZM3
         Y4xGK9aD63oFbexBFkoyWvBe97//bKbtBEBLA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=g1BvFTn5Hl7ZH0iSVedVtXwH0QcjyCau5N0vdkOurHr+Ck5OI5UWitXt0bL/ZcdPK/
         tt3L8bEpwGT857Ke7qeMXDwf/TXGH+jw/CiuUDXhUtLbFsy7dEUSZFRbIyG1gpynvXnj
         rmSs1eao4iqxRnuoAhZjXZQG+aMZ6FY/q20FQ=
Received: by 10.224.100.13 with SMTP id w13mr1601800qan.292.1254530385729;
        Fri, 02 Oct 2009 17:39:45 -0700 (PDT)
Received: from localhost ([75.35.230.210])
        by mx.google.com with ESMTPS id 20sm155494qyk.13.2009.10.02.17.39.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Oct 2009 17:39:44 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129471>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 imap-send.c |   37 +++++++++++++++++++++++--------------
 1 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 3847fd1..ba50961 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -154,7 +154,7 @@ struct imap_list {
 };
 
 struct imap_socket {
-	int fd;
+	int fd[2];
 	SSL *ssl;
 };
 
@@ -304,8 +304,12 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
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
 
@@ -327,11 +331,12 @@ static int socket_read(struct imap_socket *sock, char *buf, int len)
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
@@ -344,11 +349,12 @@ static int socket_write(struct imap_socket *sock, const char *buf, int len)
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
@@ -361,7 +367,8 @@ static void socket_shutdown(struct imap_socket *sock)
 		SSL_free(sock->ssl);
 	}
 #endif
-	close(sock->fd);
+	close(sock->fd[0]);
+	close(sock->fd[1]);
 }
 
 /* simple line buffering */
@@ -960,7 +967,7 @@ static void imap_close_server(struct imap_store *ictx)
 {
 	struct imap *imap = ictx->imap;
 
-	if (imap->buf.sock.fd != -1) {
+	if (imap->buf.sock.fd[0] != -1) {
 		imap_exec(ictx, NULL, "LOGOUT");
 		socket_shutdown(&imap->buf.sock);
 	}
@@ -988,7 +995,7 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 	ctx = xcalloc(sizeof(*ctx), 1);
 
 	ctx->imap = imap = xcalloc(sizeof(*imap), 1);
-	imap->buf.sock.fd = -1;
+	imap->buf.sock.fd[0] = imap->buf.sock.fd[1] = -1;
 	imap->in_progress_append = &imap->in_progress;
 
 	/* open connection to IMAP server */
@@ -1015,7 +1022,8 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 
 		close(a[0]);
 
-		imap->buf.sock.fd = a[1];
+		imap->buf.sock.fd[0] = a[1];
+		imap->buf.sock.fd[1] = dup(a[1]);
 
 		imap_info("ok\n");
 	} else {
@@ -1092,7 +1100,8 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 			goto bail;
 		}
 
-		imap->buf.sock.fd = s;
+		imap->buf.sock.fd[0] = s;
+		imap->buf.sock.fd[1] = dup(s);
 
 		if (srvc->use_ssl &&
 		    ssl_socket_connect(&imap->buf.sock, 0, srvc->ssl_verify)) {
-- 
1.6.5.rc2.7.g4f8d3
