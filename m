From: Alam Arias <Alam.GBC@gmail.com>
Subject: [PATCH v2] git-imap-send: Add support for SSL.
Date: Sun, 22 Jun 2008 15:27:47 -0400
Message-ID: <20080622152747.77a0baee@gmail.com>
References: <1096648c0806010829n71de92dcmc19ddb87da19931d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/qSwOC6Gl/6EgQGDgq2Hv7.B"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 21:29:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAVFC-0003lM-D8
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 21:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754491AbYFVT2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 15:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754058AbYFVT2A
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 15:28:00 -0400
Received: from main.gmane.org ([80.91.229.2]:57059 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353AbYFVT17 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 15:27:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KAVEC-0007tf-Vw
	for git@vger.kernel.org; Sun, 22 Jun 2008 19:27:56 +0000
Received: from c-24-128-54-225.hsd1.ma.comcast.net ([24.128.54.225])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 19:27:56 +0000
Received: from Alam.GBC by c-24-128-54-225.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 19:27:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-128-54-225.hsd1.ma.comcast.net
X-Newsreader: Claws Mail 3.4.0 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85798>

--MP_/qSwOC6Gl/6EgQGDgq2Hv7.B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Allow SSL to be used when a new config setting, imap.ssl, is set to
true.

Also, automatically use TLS when imap.ssl is not set by using the IMAP
STARTTLS command, if the server supports it.

Tested with Courier and Gimap IMAP servers.

Signed-off-by: Robert Shearman <robertshearman@gmail.com>
---
 Documentation/git-imap-send.txt |    1 +
 Makefile                        |    4 +-
 imap-send.c                     |  163
+++++++++++++++++++++++++++++++++++---- 3 files changed, 152
insertions(+), 16 deletions(-)
--MP_/qSwOC6Gl/6EgQGDgq2Hv7.B
Content-Type: text/x-patch;
 name=af89f503ddce94c25529b50b3374a80913ca18cc.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=af89f503ddce94c25529b50b3374a80913ca18cc.diff

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index f4fdc24..ecf2958 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -41,6 +41,7 @@ configuration file (shown with examples):
     User = bob
     Pass = pwd
     Port = 143
+    Ssl  = false
 ..........................
 
 
diff --git a/Makefile b/Makefile
index 6a31c9f..0bd18fa 100644
--- a/Makefile
+++ b/Makefile
@@ -1157,7 +1157,9 @@ endif
 git-%$X: %.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-git-imap-send$X: imap-send.o $(LIB_FILE)
+git-imap-send$X: imap-send.o $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
 
 http.o http-walker.o http-push.o transport.o: http.h
 
diff --git a/imap-send.c b/imap-send.c
index 1ec1310..7c95c5c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -23,6 +23,10 @@
  */
 
 #include "cache.h"
+#ifndef NO_OPENSSL
+# include <openssl/ssl.h>
+# include <openssl/err.h>
+#endif
 
 typedef struct store_conf {
 	char *name;
@@ -129,6 +133,7 @@ typedef struct imap_server_conf {
 	int port;
 	char *user;
 	char *pass;
+	int use_ssl;
 } imap_server_conf_t;
 
 typedef struct imap_store_conf {
@@ -148,6 +153,9 @@ typedef struct _list {
 
 typedef struct {
 	int fd;
+#ifndef NO_OPENSSL
+	SSL *ssl;
+#endif
 } Socket_t;
 
 typedef struct {
@@ -201,6 +209,7 @@ enum CAPABILITY {
 	UIDPLUS,
 	LITERALPLUS,
 	NAMESPACE,
+	STARTTLS,
 };
 
 static const char *cap_list[] = {
@@ -208,6 +217,7 @@ static const char *cap_list[] = {
 	"UIDPLUS",
 	"LITERAL+",
 	"NAMESPACE",
+	"STARTTLS",
 };
 
 #define RESP_OK    0
@@ -225,19 +235,104 @@ static const char *Flags[] = {
 	"Deleted",
 };
 
+#ifndef NO_OPENSSL
+static void
+ssl_socket_perror( const char *func )
+{
+	fprintf( stderr, "%s: %s\n", func, ERR_error_string(ERR_get_error(), 0));
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
+		int sslerr = SSL_get_error( sock->ssl, ret );
+		switch (sslerr) {
+			case SSL_ERROR_NONE:
+				break;
+			case SSL_ERROR_SYSCALL:
+				perror( "SSL_connect" );
+				break;
+			default:
+				ssl_socket_perror( "SSL_connect" );
+				break;
+		}
+	} else
+#endif
+	{
+		if (ret < 0)
+			perror( func );
+		else
+			fprintf( stderr, "%s: unexpected EOF\n", func );
+	}
+}
+
+static int
+ssl_socket_connect( Socket_t *sock, int use_tls_only )
+{
+#ifdef NO_OPENSSL
+	fprintf( stderr, "SSL requested but SSL support not compiled in\n" );
+	return 1;
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
+		ssl_socket_perror( "SSLv23_method" );
+		return 1;
+	}
+
+	ctx = SSL_CTX_new( meth );
+
+	/* FIXME! Add a config option for this */
+	if (0)
+		SSL_CTX_set_verify( ctx, SSL_VERIFY_PEER, NULL );
+
+	if (!SSL_CTX_set_default_verify_paths( ctx )) {
+		ssl_socket_perror( "SSL_CTX_set_default_verify_paths" );
+		return 1;
+	}
+	sock->ssl = SSL_new( ctx );
+	if (!sock->ssl) {
+		ssl_socket_perror( "SSL_new" );
+		return 1;
+	}
+	if (!SSL_set_fd( sock->ssl, sock->fd )) {
+		ssl_socket_perror( "SSL_set_fd" );
+		return 1;
+	}
+
+	ret = SSL_connect( sock->ssl );
+	if (ret <= 0) {
+		socket_perror( "SSL_connect", sock, ret );
+		return 1;
+	}
+
+	return 0;
+#endif
 }
 
 static int
 socket_read( Socket_t *sock, char *buf, int len )
 {
-	ssize_t n = xread( sock->fd, buf, len );
+	int n;
+#ifndef NO_OPENSSL
+	if (sock->ssl)
+		n = SSL_read( sock->ssl, buf, len );
+	else
+#endif
+		n = xread( sock->fd, buf, len );
 	if (n <= 0) {
 		socket_perror( "read", sock, n );
 		close( sock->fd );
@@ -249,7 +344,13 @@ socket_read( Socket_t *sock, char *buf, int len )
 static int
 socket_write( Socket_t *sock, const char *buf, int len )
 {
-	int n = write_in_full( sock->fd, buf, len );
+	int n;
+#ifndef NO_OPENSSL
+	if (sock->ssl)
+		n = SSL_write( sock->ssl, buf, len );
+	else
+#endif
+		n = write_in_full( sock->fd, buf, len );
 	if (n != len) {
 		socket_perror( "write", sock, n );
 		close( sock->fd );
@@ -258,6 +359,18 @@ socket_write( Socket_t *sock, const char *buf, int len )
 	return n;
 }
 
+static void
+socket_shutdown( Socket_t *sock )
+{
+#ifndef NO_OPENSSL
+	if (sock->ssl) {
+		SSL_shutdown( sock->ssl );
+		SSL_free( sock->ssl );
+	}
+#endif
+	close( sock->fd );
+}
+
 /* simple line buffering */
 static int
 buffer_gets( buffer_t * b, char **s )
@@ -875,7 +988,7 @@ imap_close_server( imap_store_t *ictx )
 
 	if (imap->buf.sock.fd != -1) {
 		imap_exec( ictx, NULL, "LOGOUT" );
-		close( imap->buf.sock.fd );
+		socket_shutdown( &imap->buf.sock );
 	}
 	free_list( imap->ns_personal );
 	free_list( imap->ns_other );
@@ -958,10 +1071,15 @@ imap_open_store( imap_server_conf_t *srvc )
 			perror( "connect" );
 			goto bail;
 		}
-		imap_info( "ok\n" );
 
 		imap->buf.sock.fd = s;
 
+		if (srvc->use_ssl && ssl_socket_connect( &imap->buf.sock, 0 )) {
+			close( s );
+			goto bail;
+		}
+		imap_info( "ok\n" );
+
 	}
 
 	/* read the greeting string */
@@ -986,7 +1104,17 @@ imap_open_store( imap_server_conf_t *srvc )
 		goto bail;
 
 	if (!preauth) {
-
+#ifndef NO_OPENSSL
+		if (!srvc->use_ssl && CAP(STARTTLS)) {
+			if (imap_exec( ctx, 0, "STARTTLS" ) != RESP_OK)
+				goto bail;
+			if (ssl_socket_connect( &imap->buf.sock, 1 ))
+				goto bail;
+			/* capabilities may have changed, so get the new capabilities */
+			if (imap_exec( ctx, 0, "CAPABILITY" ) != RESP_OK)
+				goto bail;
+		}
+#endif
 		imap_info ("Logging in...\n");
 		if (!srvc->user) {
 			fprintf( stderr, "Skipping server %s, no user\n", srvc->host );
@@ -1014,7 +1142,10 @@ imap_open_store( imap_server_conf_t *srvc )
 			fprintf( stderr, "Skipping account %s@%s, server forbids LOGIN\n", srvc->user, srvc->host );
 			goto bail;
 		}
-		imap_warn( "*** IMAP Warning *** Password is being sent in the clear\n" );
+#ifndef NO_OPENSSL
+		if (!imap->buf.sock.ssl)
+#endif
+			imap_warn( "*** IMAP Warning *** Password is being sent in the clear\n" );
 		if (imap_exec( ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, srvc->pass ) != RESP_OK) {
 			fprintf( stderr, "IMAP error: LOGIN failed\n" );
 			goto bail;
@@ -1242,6 +1373,7 @@ static imap_server_conf_t server =
 	0,	/* port */
 	NULL,	/* user */
 	NULL,	/* pass */
+	0,	/* use_ssl */
 };
 
 static char *imap_folder;
@@ -1262,12 +1394,8 @@ git_imap_config(const char *key, const char *val, void *cb)
 	if (!strcmp( "folder", key )) {
 		imap_folder = xstrdup( val );
 	} else if (!strcmp( "host", key )) {
-		{
-			if (!prefixcmp(val, "imap:"))
-				val += 5;
-			if (!server.port)
-				server.port = 143;
-		}
+		if (!prefixcmp(val, "imap:"))
+			val += 5;
 		if (!prefixcmp(val, "//"))
 			val += 2;
 		server.host = xstrdup( val );
@@ -1280,6 +1408,8 @@ git_imap_config(const char *key, const char *val, void *cb)
 		server.port = git_config_int( key, val );
 	else if (!strcmp( "tunnel", key ))
 		server.tunnel = xstrdup( val );
+	else if (!strcmp( "ssl", key ))
+		server.use_ssl = git_config_bool( key, val );
 	return 0;
 }
 
@@ -1298,6 +1428,9 @@ main(int argc, char **argv)
 
 	git_config(git_imap_config, NULL);
 
+	if (!server.port)
+		server.port = server.use_ssl ? 993 : 143;
+
 	if (!imap_folder) {
 		fprintf( stderr, "no imap store specified\n" );
 		return 1;

--MP_/qSwOC6Gl/6EgQGDgq2Hv7.B--
