From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH 2/8] imap-send: use separate read and write fds
Date: Fri,  9 Oct 2009 17:04:36 +0200
Message-ID: <1255100682-13952-2-git-send-email-kusmabite@gmail.com>
References: <1255100682-13952-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 17:11:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwH89-0007fT-2z
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 17:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760978AbZJIPFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 11:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760951AbZJIPFx
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 11:05:53 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:39022 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758831AbZJIPFw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 11:05:52 -0400
Received: by ewy4 with SMTP id 4so697240ewy.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8Ij8Hn9xXPcIPO9hGpy4jRsFc8JcWO93jHIWTt6gAOE=;
        b=mreiVbaESUO7L4paH/IKPYQyboKVvUJKj5gnSFJiNl+JuEHm5kW1roK9o2k2MwO0MJ
         my/Opm1ZvpgzXbQxH7aSMY0rBFXLdAdkfexuh/JxBpzwAzbcXRlyXoezB24akCj0mIGL
         aCYYszA40ShTu1EO74co2NRasC1WAsftOze8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Wj0Vl/yu+kp0hR8QGgutmz73NY7UM1RoD/E0xJC0Hhhm/AvxvOqw85YWvhT8SkX3iC
         +ISTyfmMG4ar2LbcCe5h087hJx0MiWHkTw4104JxyeRbgFuPP511U7ovNR4VdtLDDAVl
         GIAz5pk7ZuZZmSsYaCJE/oc6NdXoFWmmdJH+k=
Received: by 10.211.128.5 with SMTP id f5mr3291002ebn.85.1255100714556;
        Fri, 09 Oct 2009 08:05:14 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 7sm42703eyg.11.2009.10.09.08.05.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 08:05:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1255100682-13952-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129809>

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
1.6.5.rc1.60.g41795
