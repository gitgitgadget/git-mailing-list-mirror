From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v4 2/8] imap-send: use separate read and write fds
Date: Mon, 19 Oct 2009 17:42:03 +0200
Message-ID: <1255966929-1280-3-git-send-email-kusmabite@gmail.com>
References: <1255966929-1280-1-git-send-email-kusmabite@gmail.com>
 <1255966929-1280-2-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 17:43:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzuOE-0006Jw-Ta
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 17:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756662AbZJSPnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 11:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756643AbZJSPnJ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 11:43:09 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:8386 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbZJSPnH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 11:43:07 -0400
Received: by ey-out-2122.google.com with SMTP id 9so956920eyd.19
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Dsm2G0MlgyMuoIQ/BZKcH23RWzRkXlqZIEEw3b6J23s=;
        b=dGDVMIDWpWLKMByIuMu2Fo9k55MjOLiSDusx5t+MlFYp6++C9bTfngtKm6/i/oMJgW
         pELy070F/cuGAT0ZVVvBM2iU5Z+90+11jfBilozhNv03LHLDt+yTbc34SWeHHBZs43JG
         l5kl+917/uOYVvIH6vSNrmnPyqlbYvN3Q3IZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=j562jMN/HTzXBSj6f6NBJFYrwj9SyKQMomz2rUkJWkmoqLyWH1ndCZzlrTo0oaC9jr
         nV09wONShoGLE6NXg22AEWQMJch9clcS4NZBK7Il/plEZvxu+VrqQYPKUXjmOpN2wqYQ
         f24YMJjqeTjyLClKriUjw47eMq+dX4ydx0uvY=
Received: by 10.210.6.8 with SMTP id 8mr5088989ebf.41.1255966991601;
        Mon, 19 Oct 2009 08:43:11 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 7sm4970962eyb.32.2009.10.19.08.43.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Oct 2009 08:43:10 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1255966929-1280-2-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130702>

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
1.6.5.15.g5f078
