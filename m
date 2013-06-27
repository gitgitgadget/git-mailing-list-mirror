From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] CYGWIN: Use a TCP socket for pipe()
Date: Thu, 27 Jun 2013 18:31:13 +0200
Message-ID: <201306271831.13865.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: ramsay@ramsay1.demon.co.uk, mlevedahl@gmail.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 27 18:31:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsF6U-0000v6-AA
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 18:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab3F0QbW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 12:31:22 -0400
Received: from mout.web.de ([212.227.15.4]:64237 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab3F0QbV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jun 2013 12:31:21 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb004) with
 ESMTPA (Nemesis) id 0M7Eb0-1U5O4H2LZO-00x4eq; Thu, 27 Jun 2013 18:31:19 +0200
X-Provags-ID: V03:K0:GkcWvPlEwXKZizWx2DwnfStcA2bPjomKQhhEhDbTB70fjE4SJMA
 UJMk6NW7qo6C6GR79tnWWd0XBkKx1vfMI+KTG3oW2JMVBkJhefkH7WUABR5gtVb2e+e2AqV
 baCELrmbFZ7dIbg5RD6R0eLIgFDKvIc77Z2mHNvSqL7E19BvPiRWHxHnbwtfRhATjSnaimm
 tPAoDFGXtFMyRO+RyPfVA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229116>

Work around issues that git hangs when doing fetch or pull under
various protocols under CYGWIN.

Replace pipe() with a socket connection using a TCP/IP.
Introduce a new function socket_pipe() in compat/socket_pipe.c

Re-define the pipe() function into socket_pipe() for CYGWIN.

(This redefinition does not work for MinGW, because here a socket can
not be mixed with a file handle)

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 compat/socket_pipe.c | 68 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 config.mak.uname     |  2 ++
 git-compat-util.h    |  4 ++++
 3 files changed, 74 insertions(+)
 create mode 100644 compat/socket_pipe.c

diff --git a/compat/socket_pipe.c b/compat/socket_pipe.c
new file mode 100644
index 0000000..eee43b5
--- /dev/null
+++ b/compat/socket_pipe.c
@@ -0,0 +1,68 @@
+#include "git-compat-util.h"
+
+int socket_pipe(int filedes[2])
+{
+	int fd_listen, fd_rd;
+	int fd_wr =3D -1;
+	struct sockaddr_in sin;
+	socklen_t length;
+	struct linger linger;
+	int reuse_on =3D 1;
+
+	memset(&sin, 0, sizeof(sin));
+	sin.sin_family =3D AF_INET;
+	sin.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);
+
+	fd_listen =3D socket(AF_INET, SOCK_STREAM, 0);
+	if (fd_listen =3D=3D -1)
+		die_errno("pipe fd_listen socket");
+	(void)setsockopt(fd_listen, SOL_SOCKET, SO_REUSEADDR,
+									 (char*)&reuse_on, sizeof(reuse_on));
+	if (bind(fd_listen, (struct sockaddr *)&sin, sizeof(sin)))
+		die_errno("pipe bind socket");
+
+	length =3D sizeof(sin);
+	if(getsockname(fd_listen, (struct sockaddr *)&sin, &length))
+		die_errno("pipe getsockname");
+	if (listen(fd_listen, SOMAXCONN))
+		die_errno("pipe listen");
+	fd_rd =3D socket(AF_INET, SOCK_STREAM, 0);
+	if (fd_rd =3D=3D -1)
+		die_errno("pipe fd_rd socket");
+	if (connect(fd_rd, (struct sockaddr *)&sin, sizeof(sin)))
+		die_errno("pipe connect");
+
+	length =3D sizeof(struct sockaddr);
+	if(getsockname(fd_rd, (struct sockaddr *)&sin, &length))
+		die_errno("pipe getsockname");
+
+	while (fd_wr =3D=3D -1) {
+		struct sockaddr_in sacc;
+		length =3D sizeof(sacc);
+		memset(&sacc, 0, sizeof(sacc));
+		fd_wr =3D accept(fd_listen, (struct sockaddr *)&sacc, &length);
+		if(fd_wr =3D=3D -1)
+			die_errno("pipe accept");
+		if (sacc.sin_port !=3D sin.sin_port) {
+			// Wrong connecting socket
+			close(fd_wr);
+			fd_wr =3D -1;
+		}
+	}
+
+	close(fd_listen);
+
+	linger.l_onoff =3D 1;
+	linger.l_linger =3D 5;
+	if (setsockopt(fd_wr, SOL_SOCKET, SO_LINGER,
+								 (char*)&linger, sizeof(linger)))
+		die_errno("pipe socket linger");
+	if (shutdown(fd_rd, SHUT_WR))
+		die_errno("pipe socket shutdown fd_rd");
+	if (shutdown(fd_wr, SHUT_RD))
+		die_errno("pipe socket shutdown fd_wr");
+
+	filedes[0] =3D fd_rd;
+	filedes[1] =3D fd_wr;
+	return 0;
+}
diff --git a/config.mak.uname b/config.mak.uname
index d78fd3d..66bf446 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -170,7 +170,9 @@ ifeq ($(uname_O),Cygwin)
 	# Try commenting this out if you suspect MMAP is more efficient
 	NO_MMAP =3D YesPlease
 	X =3D .exe
+	BASIC_CFLAGS +=3D -DGIT_USE_SOCKET_PIPE
 	COMPAT_OBJS +=3D compat/cygwin.o
+	COMPAT_OBJS +=3D compat/socket_pipe.o
 	UNRELIABLE_FSTAT =3D UnfortunatelyYes
 	SPARSE_FLAGS =3D -isystem /usr/include/w32api -Wno-one-bit-signed-bit=
field
 endif
diff --git a/git-compat-util.h b/git-compat-util.h
index c1f8a47..88632ab 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -176,6 +176,10 @@ int get_st_mode_bits(const char *path, int *mode);
 #endif
 #endif
=20
+int socket_pipe(int filedes[2]);
+#ifdef GIT_USE_SOCKET_PIPE
+#define pipe(a) socket_pipe(a)
+#endif
 /* used on Mac OS X */
 #ifdef PRECOMPOSE_UNICODE
 #include "compat/precompose_utf8.h"
--=20
1.8.3
