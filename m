From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Disable OpenSSL SHA1 implementation by default
Date: Mon, 22 Feb 2010 05:08:14 -0600
Message-ID: <20100222110814.GA3247@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Robert Shearman <robertshearman@gmail.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 12:47:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjW9Q-00061Q-CT
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 12:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446Ab0BVLIM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2010 06:08:12 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:61605 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab0BVLIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 06:08:09 -0500
Received: by yxe38 with SMTP id 38so2372508yxe.4
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 03:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=JKBjDrzja3wvOQBtfWt+tdAfcFIwe3xvFRGCWC2rXWs=;
        b=QVOGChEcmkY7sIn7ySlYySDNCtwUyZPd2Ny2V58dJCgOhZUyeCZU43aE7srumUlJel
         OToipCZmrP7xBSoFSdA8hjMvNV5WwGBss9umJ8k5xosjDS+Xdt3YdFfUHgW3GzfHRlPi
         cN9BFp+Kld/J2iCSNfBqKetUQzGytQpc9bvRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=xXA4FOYkUVLeNZJ1N9JbqUPEa2fC3W5MKc793h4qYY7KMpUs1YfmtJwwXMesGCycxH
         k2TAaw+xSOj+yt0hwpgC798kpq7rj/ouzRjXqpof4N6o2eyULgzz2/Qx2RBzYH337Dm0
         HW9YmnmbRTKzlURDSMnltLxpQz7yl3JggeJP0=
Received: by 10.101.146.5 with SMTP id y5mr6413194ann.218.1266836888211;
        Mon, 22 Feb 2010 03:08:08 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 16sm3272434gxk.13.2010.02.22.03.08.06
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 03:08:07 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140667>

The OpenSSL SHA-1 routine is about as fast as block-sha1, but linking
to libcrypto slows down the startup of git commands by an appreciable
amount.  Use the BLK_SHA1 implementation by default instead.

Even without its SHA-1 functions, OpenSSL is useful for teaching
imap-send to use TLS.  Now people building git can decide separately
whether to use each of these two facilities by setting or unsetting
the OPENSSL_SHA1 and OPENSSL_TLS options.

Let the configure script=E2=80=99s --with-openssl option and SSL librar=
y
checks toggle OPENSSL_TLS without touching OPENSSL_SHA1.  I am
guessing most people will not want to enable OPENSSL_SHA1.  If that
turns out to be false, we can add a new option to the configure
script.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Typed =E2=80=9Cmake NO_OPENSSL=3D1=E2=80=9D for the umpteenth time toda=
y, but this time
I thought I should something about it.

Good idea?  Bad idea?

 Makefile          |   24 +++++++++++++++++-------
 compat/mingw.h    |    2 +-
 config.mak.in     |    2 +-
 configure.ac      |   42 ++++++++++++++++++++++++++++++++++++------
 git-compat-util.h |    2 +-
 imap-send.c       |   16 ++++++++--------
 6 files changed, 64 insertions(+), 24 deletions(-)

diff --git a/Makefile b/Makefile
index afedb54..a82d29c 100644
--- a/Makefile
+++ b/Makefile
@@ -15,8 +15,11 @@ all::
 # Define FREAD_READS_DIRECTORIES if your are on a system which succeed=
s
 # when attempting to read from an fopen'ed directory.
 #
-# Define NO_OPENSSL environment variable if you do not have OpenSSL.
-# This also implies BLK_SHA1.
+# Define OPENSSL_SHA1 if you would like to use the SHA-1 routine from
+# OpenSSL.  Otherwise, BLK_SHA1 will be used.
+#
+# Define OPENSSL_TLS if you would like the imap-send utility to be
+# able to use SSL.
 #
 # Define NO_CURL if you do not have libcurl installed.  git-http-pull =
and
 # git-http-push are not built, and you cannot use http:// and https://
@@ -1103,7 +1106,18 @@ EXTLIBS +=3D -lz
 ifndef NO_POSIX_ONLY_PROGRAMS
 	PROGRAMS +=3D git-daemon$X
 endif
-ifndef NO_OPENSSL
+ifdef OPENSSL_TLS
+	BASIC_CFLAGS +=3D -DOPENSSL_TLS
+	USE_OPENSSL =3D Yes
+endif
+ifdef OPENSSL_SHA1
+	BASIC_CFLAGS +=3D -DOPENSSL_SHA1
+	USE_OPENSSL =3D Yes
+else
+	BLK_SHA1 =3D 1
+endif
+ifdef USE_OPENSSL
+	BASIC_CFLAGS +=3D -DUSE_OPENSSL
 	OPENSSL_LIBSSL =3D -lssl
 	ifdef OPENSSLDIR
 		BASIC_CFLAGS +=3D -I$(OPENSSLDIR)/include
@@ -1114,10 +1128,6 @@ ifndef NO_OPENSSL
 	ifdef NEEDS_CRYPTO_WITH_SSL
 		OPENSSL_LINK +=3D -lcrypto
 	endif
-else
-	BASIC_CFLAGS +=3D -DNO_OPENSSL
-	BLK_SHA1 =3D 1
-	OPENSSL_LIBSSL =3D
 endif
 ifdef NEEDS_SSL_WITH_CRYPTO
 	LIB_4_CRYPTO =3D $(OPENSSL_LINK) -lcrypto -lssl
diff --git a/compat/mingw.h b/compat/mingw.h
index e254fb4..70c3392 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -125,7 +125,7 @@ static inline int waitpid(pid_t pid, int *status, u=
nsigned options)
 	return -1;
 }
=20
-#ifndef NO_OPENSSL
+#ifdef USE_OPENSSL
 #include <openssl/ssl.h>
 static inline int mingw_SSL_set_fd(SSL *ssl, int fd)
 {
diff --git a/config.mak.in b/config.mak.in
index 6008ac9..a0cb30e 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -27,7 +27,7 @@ export srcdir VPATH
=20
 ASCIIDOC8=3D@ASCIIDOC8@
 NEEDS_SSL_WITH_CRYPTO=3D@NEEDS_SSL_WITH_CRYPTO@
-NO_OPENSSL=3D@NO_OPENSSL@
+OPENSSL_TLS=3D@OPENSSL_TLS@
 NO_CURL=3D@NO_CURL@
 NO_EXPAT=3D@NO_EXPAT@
 NO_LIBGEN_H=3D@NO_LIBGEN_H@
diff --git a/configure.ac b/configure.ac
index 914ae57..0efcdb9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -80,6 +80,26 @@ else \
 fi \
 ])# GIT_PARSE_WITH
 #
+# GIT_PARSE_WITH_USE(PACKAGE, VARNAME)
+# ------------------------------------
+# For use in AC_ARG_WITH action-if-found, for packages default ON.
+# * Unset VARNAME for --without-PACKAGE
+# * Always set VARNAME=3DYesPlease for --with-PACKAGE
+# * Set PACKAGEDIR=3DPATH for --with-PACKAGE=3DPATH
+AC_DEFUN([GIT_PARSE_WITH_USE],
+[PACKAGE=3Dm4_toupper($1); \
+if test "$withval" =3D "no"; then \
+	m4_toupper($2)=3D; \
+elif test "$withval" =3D "yes"; then \
+	m4_toupper($2)=3DYesPlease; \
+else \
+	m4_toupper($2)=3DYesPlease; \
+	m4_toupper($1)DIR=3D$withval; \
+	AC_MSG_NOTICE([Setting m4_toupper($1)DIR to $withval]); \
+	GIT_CONF_APPEND_LINE(${PACKAGE}DIR=3D$withval); \
+fi \
+])# GIT_PARSE_WITH_USE
+#
 # GIT_PARSE_WITH_SET_MAKE_VAR(WITHNAME, VAR, HELP_TEXT)
 # ---------------------
 # Set VAR to the value specied by --with-WITHNAME.
@@ -190,15 +210,18 @@ AC_MSG_NOTICE([CHECKS for site configuration])
 # Define PPC_SHA1 environment variable when running make to make use o=
f
 # a bundled SHA1 routine optimized for PowerPC.
 #
-# Define NO_OPENSSL environment variable if you do not have OpenSSL.
-# This also implies BLK_SHA1.
+# Define OPENSSL_SHA1 if you would like to use the SHA-1 routine from
+# OpenSSL.  Otherwise, BLK_SHA1 will be used.
+#
+# Define OPENSSL_TLS if you would like the imap-send utility to be
+# able to use SSL.
 #
 # Define OPENSSLDIR=3D/foo/bar if your openssl header and library file=
s are in
 # /foo/bar/include and /foo/bar/lib directories.
 AC_ARG_WITH(openssl,
 AS_HELP_STRING([--with-openssl],[use OpenSSL library (default is YES)]=
)
 AS_HELP_STRING([],              [ARG can be prefix for openssl library=
 and headers]),\
-GIT_PARSE_WITH(openssl))
+GIT_PARSE_WITH_USE(openssl, [OPENSSL_TLS]))
 #
 # Define NO_CURL if you do not have curl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
@@ -383,7 +406,7 @@ AC_SUBST(ASCIIDOC8)
 ## Checks for libraries.
 AC_MSG_NOTICE([CHECKS for libraries])
 #
-# Define NO_OPENSSL environment variable if you do not have OpenSSL.
+# Define OPENSSL_TLS to empty if you do not have OpenSSL.
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl (Darwin=
).
=20
 GIT_STASH_FLAGS($OPENSSLDIR)
@@ -392,12 +415,19 @@ AC_CHECK_LIB([crypto], [SHA1_Init],
 [NEEDS_SSL_WITH_CRYPTO=3D],
 [AC_CHECK_LIB([ssl], [SHA1_Init],
  [NEEDS_SSL_WITH_CRYPTO=3DYesPlease],
- [NEEDS_SSL_WITH_CRYPTO=3D NO_OPENSSL=3DYesPlease])])
+ [NEEDS_SSL_WITH_CRYPTO=3D])])
+
+if test -z "${OPENSSL_TLS+set}"
+then
+AC_CHECK_LIB([ssl], [SSL_CTX_new],
+ [OPENSSL_TLS=3DYesPlease],
+ [OPENSSL_TLS=3D])
+fi
=20
 GIT_UNSTASH_FLAGS($OPENSSLDIR)
=20
 AC_SUBST(NEEDS_SSL_WITH_CRYPTO)
-AC_SUBST(NO_OPENSSL)
+AC_SUBST(OPENSSL_TLS)
=20
 #
 # Define NO_CURL if you do not have libcurl installed.  git-http-pull =
and
diff --git a/git-compat-util.h b/git-compat-util.h
index a3c4537..c095b61 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -135,7 +135,7 @@ extern char *gitbasename(char *);
 #include <iconv.h>
 #endif
=20
-#ifndef NO_OPENSSL
+#ifdef USE_OPENSSL
 #include <openssl/ssl.h>
 #include <openssl/err.h>
 #endif
diff --git a/imap-send.c b/imap-send.c
index 5631930..9318c7f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -25,7 +25,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "run-command.h"
-#ifdef NO_OPENSSL
+#ifndef OPENSSL_TLS
 typedef void *SSL;
 #endif
=20
@@ -238,7 +238,7 @@ static const char *Flags[] =3D {
 	"Deleted",
 };
=20
-#ifndef NO_OPENSSL
+#ifdef OPENSSL_TLS
 static void ssl_socket_perror(const char *func)
 {
 	fprintf(stderr, "%s: %s\n", func, ERR_error_string(ERR_get_error(), N=
ULL));
@@ -247,7 +247,7 @@ static void ssl_socket_perror(const char *func)
=20
 static void socket_perror(const char *func, struct imap_socket *sock, =
int ret)
 {
-#ifndef NO_OPENSSL
+#ifdef OPENSSL_TLS
 	if (sock->ssl) {
 		int sslerr =3D SSL_get_error(sock->ssl, ret);
 		switch (sslerr) {
@@ -272,7 +272,7 @@ static void socket_perror(const char *func, struct =
imap_socket *sock, int ret)
=20
 static int ssl_socket_connect(struct imap_socket *sock, int use_tls_on=
ly, int verify)
 {
-#ifdef NO_OPENSSL
+#ifndef OPENSSL_TLS
 	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
 	return -1;
 #else
@@ -333,7 +333,7 @@ static int ssl_socket_connect(struct imap_socket *s=
ock, int use_tls_only, int ve
 static int socket_read(struct imap_socket *sock, char *buf, int len)
 {
 	ssize_t n;
-#ifndef NO_OPENSSL
+#ifdef OPENSSL_TLS
 	if (sock->ssl)
 		n =3D SSL_read(sock->ssl, buf, len);
 	else
@@ -351,7 +351,7 @@ static int socket_read(struct imap_socket *sock, ch=
ar *buf, int len)
 static int socket_write(struct imap_socket *sock, const char *buf, int=
 len)
 {
 	int n;
-#ifndef NO_OPENSSL
+#ifdef OPENSSL_TLS
 	if (sock->ssl)
 		n =3D SSL_write(sock->ssl, buf, len);
 	else
@@ -368,7 +368,7 @@ static int socket_write(struct imap_socket *sock, c=
onst char *buf, int len)
=20
 static void socket_shutdown(struct imap_socket *sock)
 {
-#ifndef NO_OPENSSL
+#ifdef OPENSSL_TLS
 	if (sock->ssl) {
 		SSL_shutdown(sock->ssl);
 		SSL_free(sock->ssl);
@@ -1087,7 +1087,7 @@ static struct store *imap_open_store(struct imap_=
server_conf *srvc)
 		goto bail;
=20
 	if (!preauth) {
-#ifndef NO_OPENSSL
+#ifdef OPENSSL_TLS
 		if (!srvc->use_ssl && CAP(STARTTLS)) {
 			if (imap_exec(ctx, 0, "STARTTLS") !=3D RESP_OK)
 				goto bail;
--=20
1.7.0
