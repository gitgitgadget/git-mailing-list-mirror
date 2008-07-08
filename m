From: Robert Shearman <robertshearman@gmail.com>
Subject: [PATCH 2/4] git-imap-send: Add support for SSL.
Date: Tue,  8 Jul 2008 23:18:14 +0100
Message-ID: <1215555496-21335-2-git-send-email-robertshearman@gmail.com>
Cc: Robert Shearman <robertshearman@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 00:19:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGLXI-0000dv-He
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 00:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091AbYGHWSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 18:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754140AbYGHWSg
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 18:18:36 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:22938 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbYGHWSf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 18:18:35 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1462163fkq.5
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 15:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=0zLxKSrlGbLvxDjbbM6S3npugc5f8U2rqWX9lGP+ybk=;
        b=A8Inihn9aBRkvrJHKQDAQGRmtBz9FXb6jOOWgmSOOVXO7F/SM4LyzNARQliMd80UE1
         +4IUNdbQQX4AODIZKJ41237n0gmhGID0wShsjbeYRElQY3axqYIAXG4PBaVgK4dla6WP
         XcHTvWaXN54NDLr+AHznCRpOREXNzCe48SEq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DNnMYdz/vbq7rIcB5U5uYd72u7Qssvh/YCDeh6KDFQvU0co6p6xMZBe/WO39sbA/ty
         QAQZbOQxaaGrxx+4LV82dhVhbRadTx85SmOibM20ZRXoWQaXytnVJKCg+adW58l7FFuP
         /c4sRHZe/W3u8lgj3joEMO7CaruweQ3BxdACc=
Received: by 10.125.111.14 with SMTP id o14mr1634482mkm.3.1215555510046;
        Tue, 08 Jul 2008 15:18:30 -0700 (PDT)
Received: from localhost.localdomain ( [86.155.123.155])
        by mx.google.com with ESMTPS id p9sm12934768fkb.5.2008.07.08.15.18.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jul 2008 15:18:28 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.2.224.g26efb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87802>

Allow SSL to be used when a imaps:// URL is used for the host name.

Also, automatically use TLS when not using imaps:// by using the IMAP STARTTLS command, if the server supports it.

Tested with Courier and Gimap IMAP servers.
---
 Documentation/git-imap-send.txt |    5 +-
 Makefile                        |    4 +-
 imap-send.c                     |  166 +++++++++++++++++++++++++++++++++++----
 3 files changed, 157 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index b3d8da3..e4a5873 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -37,10 +37,11 @@ configuration file (shown with examples):
     Tunnel = "ssh -q user@server.com /usr/bin/imapd ./Maildir 2> /dev/null"
 
 [imap]
-    Host = imap.server.com
+    Host = imaps://imap.example.com
     User = bob
     Pass = pwd
-    Port = 143
+    Port = 993
+    sslverify = false
 ..........................
 
 
diff --git a/Makefile b/Makefile
index bddd1a7..d9265f7 100644
--- a/Makefile
+++ b/Makefile
@@ -1193,7 +1193,9 @@ endif
 git-%$X: %.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-git-imap-send$X: imap-send.o $(LIB_FILE)
+git-imap-send$X: imap-send.o $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
 
 http.o http-walker.o http-push.o transport.o: http.h
 
diff --git a/imap-send.c b/imap-send.c
index 89a1532..d138726 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -23,6 +23,12 @@
  */
 
 #include "cache.h"
+#ifdef NO_OPENSSL
+typedef void *SSL;
+#else
+# include <openssl/ssl.h>
+# include <openssl/err.h>
+#endif
 
 typedef struct store_conf {
 	char *name;
@@ -129,6 +135,8 @@ typedef struct imap_server_conf {
 	int port;
 	char *user;
 	char *pass;
+	int use_ssl;
+	int ssl_verify;
 } imap_server_conf_t;
 
 typedef struct imap_store_conf {
@@ -148,6 +156,7 @@ typedef struct _list {
 
 typedef struct {
 	int fd;
+	SSL *ssl;
 } Socket_t;
 
 typedef struct {
@@ -201,6 +210,7 @@ enum CAPABILITY {
 	UIDPLUS,
 	LITERALPLUS,
 	NAMESPACE,
+	STARTTLS,
 };
 
 static const char *cap_list[] = {
@@ -208,6 +218,7 @@ static const char *cap_list[] = {
 	"UIDPLUS",
 	"LITERAL+",
 	"NAMESPACE",
+	"STARTTLS",
 };
 
 #define RESP_OK    0
@@ -225,19 +236,101 @@ static const char *Flags[] = {
 	"Deleted",
 };
 
+#ifndef NO_OPENSSL
+static void ssl_socket_perror(const char *func)
+{
+	fprintf(stderr, "%s: %s\n", func, ERR_error_string(ERR_get_error(), 0));
+}
+#endif
+
 static void
 socket_perror( const char *func, Socket_t *sock, int ret )
 {
-	if (ret < 0)
-		perror( func );
+#ifndef NO_OPENSSL
+	if (sock->ssl) {
+		int sslerr = SSL_get_error(sock->ssl, ret);
+		switch (sslerr) {
+		case SSL_ERROR_NONE:
+			break;
+		case SSL_ERROR_SYSCALL:
+			perror("SSL_connect");
+			break;
+		default:
+			ssl_socket_perror("SSL_connect");
+			break;
+		}
+	} else
+#endif
+	{
+		if (ret < 0)
+			perror(func);
+		else
+			fprintf(stderr, "%s: unexpected EOF\n", func);
+	}
+}
+
+static int ssl_socket_connect(Socket_t *sock, int use_tls_only, int verify)
+{
+#ifdef NO_OPENSSL
+	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
+	return -1;
+#else
+	SSL_METHOD *meth;
+	SSL_CTX *ctx;
+	int ret;
+
+	SSL_library_init();
+	SSL_load_error_strings();
+
+	if (use_tls_only)
+		meth = TLSv1_method();
 	else
-		fprintf( stderr, "%s: unexpected EOF\n", func );
+		meth = SSLv23_method();
+
+	if (!meth) {
+		ssl_socket_perror("SSLv23_method");
+		return -1;
+	}
+
+	ctx = SSL_CTX_new(meth);
+
+	if (verify)
+		SSL_CTX_set_verify(ctx, SSL_VERIFY_PEER, NULL);
+
+	if (!SSL_CTX_set_default_verify_paths(ctx)) {
+		ssl_socket_perror("SSL_CTX_set_default_verify_paths");
+		return -1;
+	}
+	sock->ssl = SSL_new(ctx);
+	if (!sock->ssl) {
+		ssl_socket_perror("SSL_new");
+		return -1;
+	}
+	if (!SSL_set_fd(sock->ssl, sock->fd)) {
+		ssl_socket_perror("SSL_set_fd");
+		return -1;
+	}
+
+	ret = SSL_connect(sock->ssl);
+	if (ret <= 0) {
+		socket_perror("SSL_connect", sock, ret);
+		return -1;
+	}
+
+	return 0;
+#endif
 }
 
 static int
 socket_read( Socket_t *sock, char *buf, int len )
 {
-	ssize_t n = xread( sock->fd, buf, len );
+	ssize_t n;
+#ifndef NO_OPENSSL
+	if (sock->ssl)
+		n = SSL_read(sock->ssl, buf, len);
+	else
+#endif
+		n = xread( sock->fd, buf, len );
 	if (n <= 0) {
 		socket_perror( "read", sock, n );
 		close( sock->fd );
@@ -249,7 +342,13 @@ socket_read( Socket_t *sock, char *buf, int len )
 static int
 socket_write( Socket_t *sock, const char *buf, int len )
 {
-	int n = write_in_full( sock->fd, buf, len );
+	int n;
+#ifndef NO_OPENSSL
+	if (sock->ssl)
+		n = SSL_write(sock->ssl, buf, len);
+	else
+#endif
+		n = write_in_full( sock->fd, buf, len );
 	if (n != len) {
 		socket_perror( "write", sock, n );
 		close( sock->fd );
@@ -258,6 +357,17 @@ socket_write( Socket_t *sock, const char *buf, int len )
 	return n;
 }
 
+static void socket_shutdown(Socket_t *sock)
+{
+#ifndef NO_OPENSSL
+	if (sock->ssl) {
+		SSL_shutdown(sock->ssl);
+		SSL_free(sock->ssl);
+	}
+#endif
+	close(sock->fd);
+}
+
 /* simple line buffering */
 static int
 buffer_gets( buffer_t * b, char **s )
@@ -875,7 +985,7 @@ imap_close_server( imap_store_t *ictx )
 
 	if (imap->buf.sock.fd != -1) {
 		imap_exec( ictx, NULL, "LOGOUT" );
-		close( imap->buf.sock.fd );
+		socket_shutdown( &imap->buf.sock );
 	}
 	free_list( imap->ns_personal );
 	free_list( imap->ns_other );
@@ -906,6 +1016,7 @@ imap_open_store( imap_server_conf_t *srvc )
 
 	ctx->imap = imap = xcalloc( sizeof(*imap), 1 );
 	imap->buf.sock.fd = -1;
+	imap->buf.sock.ssl = NULL;
 	imap->in_progress_append = &imap->in_progress;
 
 	/* open connection to IMAP server */
@@ -958,10 +1069,15 @@ imap_open_store( imap_server_conf_t *srvc )
 			perror( "connect" );
 			goto bail;
 		}
-		imap_info( "ok\n" );
-
+		
 		imap->buf.sock.fd = s;
 
+		if (srvc->use_ssl &&
+		    ssl_socket_connect(&imap->buf.sock, 0, srvc->ssl_verify)) {
+			close(s);
+			goto bail;
+		}
+		imap_info( "ok\n" );
 	}
 
 	/* read the greeting string */
@@ -986,7 +1102,18 @@ imap_open_store( imap_server_conf_t *srvc )
 		goto bail;
 
 	if (!preauth) {
-
+#ifndef NO_OPENSSL
+		if (!srvc->use_ssl && CAP(STARTTLS)) {
+			if (imap_exec(ctx, 0, "STARTTLS") != RESP_OK)
+				goto bail;
+			if (ssl_socket_connect(&imap->buf.sock, 1,
+					       srvc->ssl_verify))
+				goto bail;
+			/* capabilities may have changed, so get the new capabilities */
+			if (imap_exec(ctx, 0, "CAPABILITY") != RESP_OK)
+				goto bail;
+		}
+#endif
 		imap_info ("Logging in...\n");
 		if (!srvc->user) {
 			fprintf( stderr, "Skipping server %s, no user\n", srvc->host );
@@ -1014,7 +1141,9 @@ imap_open_store( imap_server_conf_t *srvc )
 			fprintf( stderr, "Skipping account %s@%s, server forbids LOGIN\n", srvc->user, srvc->host );
 			goto bail;
 		}
-		imap_warn( "*** IMAP Warning *** Password is being sent in the clear\n" );
+		if (!imap->buf.sock.ssl)
+			imap_warn( "*** IMAP Warning *** Password is being "
+				   "sent in the clear\n" );
 		if (imap_exec( ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, srvc->pass ) != RESP_OK) {
 			fprintf( stderr, "IMAP error: LOGIN failed\n" );
 			goto bail;
@@ -1242,6 +1371,8 @@ static imap_server_conf_t server =
 	0,	/* port */
 	NULL,	/* user */
 	NULL,	/* pass */
+	0,   	/* use_ssl */
+	1,   	/* ssl_verify */
 };
 
 static char *imap_folder;
@@ -1262,11 +1393,11 @@ git_imap_config(const char *key, const char *val, void *cb)
 	if (!strcmp( "folder", key )) {
 		imap_folder = xstrdup( val );
 	} else if (!strcmp( "host", key )) {
-		{
-			if (!prefixcmp(val, "imap:"))
-				val += 5;
-			if (!server.port)
-				server.port = 143;
+		if (!prefixcmp(val, "imap:"))
+			val += 5;
+		else if (!prefixcmp(val, "imaps:")) {
+			val += 6;
+			server.use_ssl = 1;
 		}
 		if (!prefixcmp(val, "//"))
 			val += 2;
@@ -1280,6 +1411,8 @@ git_imap_config(const char *key, const char *val, void *cb)
 		server.port = git_config_int( key, val );
 	else if (!strcmp( "tunnel", key ))
 		server.tunnel = xstrdup( val );
+	else if (!strcmp( "ssl_verify", key ))
+		server.ssl_verify = git_config_bool( key, val );
 	return 0;
 }
 
@@ -1299,6 +1432,9 @@ main(int argc, char **argv)
 	setup_git_directory_gently( NULL );
 	git_config(git_imap_config, NULL);
 
+	if (!server.port)
+		server.port = server.use_ssl ? 993 : 143;
+
 	if (!imap_folder) {
 		fprintf( stderr, "no imap store specified\n" );
 		return 1;
-- 
1.5.6.GIT
