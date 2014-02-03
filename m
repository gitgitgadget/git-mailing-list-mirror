From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 05/26] Add git-file-watcher and basic connection handling logic
Date: Mon,  3 Feb 2014 11:28:53 +0700
Message-ID: <1391401754-15347-6-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:29:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABAM-0000xA-Q7
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbaBCE3q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:29:46 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:41409 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbaBCE3q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:29:46 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp16so6588610pbb.20
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GeP0du01RSoFYoSRZhAfbntwUGoGd5aEXT7k6wXqeVk=;
        b=xgxSgEGMgE2YQQaEonMDHfMAWSHNsy+J432RgFuv8fnw8kSSIYfmQatZ5aPdw4cbHR
         XGXsIogFeGpbKbJeSp90AYWiEzzJ2oTawHLdyPUtD82zjiW1m+t+y1M9/VcnC4rD5Jsi
         sH8wCC+v5g+fpJ/5qyx3dlmbB+36XwQXV2105ll/PlRtmbAIMzaIoLpDPeGuY4tj1vns
         NXIGZpAjSQvqsjSoVYL1JdodziWgfhC4DsZNDvOOMQtzTuHVDdPx/2bI4d0Ijm8MJ9im
         OgE7omc9zyf2GOrwB0mbCvJsoq59ha2vo23LBx5OTI62UjkFg8SQeo093AIMVYxmx6Xc
         9E2g==
X-Received: by 10.68.14.130 with SMTP id p2mr35356721pbc.17.1391401785450;
        Sun, 02 Feb 2014 20:29:45 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id pp5sm36792862pbb.33.2014.02.02.20.29.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:29:44 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:29:43 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241400>

git-file-watcher is a daemon (*) that watches file changes and tells
git about them. The intent is to avoid lstat() calls at index refresh
time, which could be a lot on big working directory.

The actual monitoring needs support from OS (inotify, FSEvents,
=46indFirstChangeNotification or kqueue) and is not part of this patch
or the next few yet. This patch only provides a UNIX socket server.

(*) it will be a a daemon in this end, but in this patch it runs in
the foreground.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore                               |   1 +
 Documentation/git-file-watcher.txt (new) |  29 +++++++
 Makefile                                 |   1 +
 file-watcher.c (new)                     | 140 +++++++++++++++++++++++=
++++++++
 4 files changed, 171 insertions(+)
 create mode 100644 Documentation/git-file-watcher.txt
 create mode 100644 file-watcher.c

diff --git a/.gitignore b/.gitignore
index b5f9def..12c78f0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -56,6 +56,7 @@
 /git-fast-import
 /git-fetch
 /git-fetch-pack
+/git-file-watcher
 /git-filter-branch
 /git-fmt-merge-msg
 /git-for-each-ref
diff --git a/Documentation/git-file-watcher.txt b/Documentation/git-fil=
e-watcher.txt
new file mode 100644
index 0000000..625a389
--- /dev/null
+++ b/Documentation/git-file-watcher.txt
@@ -0,0 +1,29 @@
+git-file-watcher(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-file-watcher - File update notification daemon
+
+SYNOPSIS
+--------
+[verse]
+'git file-watcher' [options] <socket directory>
+
+DESCRIPTION
+-----------
+This program watches file changes in a git working directory and let
+Git now what files have been changed so that Git does not have to call
+lstat(2) to detect that itself.
+
+OPTIONS
+-------
+
+SEE ALSO
+--------
+linkgit:git-update-index[1],
+linkgit:git-config[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index dddaf4f..8eef0d6 100644
--- a/Makefile
+++ b/Makefile
@@ -536,6 +536,7 @@ PROGRAMS +=3D $(EXTRA_PROGRAMS)
 PROGRAM_OBJS +=3D credential-store.o
 PROGRAM_OBJS +=3D daemon.o
 PROGRAM_OBJS +=3D fast-import.o
+PROGRAM_OBJS +=3D file-watcher.o
 PROGRAM_OBJS +=3D http-backend.o
 PROGRAM_OBJS +=3D imap-send.o
 PROGRAM_OBJS +=3D sh-i18n--envsubst.o
diff --git a/file-watcher.c b/file-watcher.c
new file mode 100644
index 0000000..a6d7f17
--- /dev/null
+++ b/file-watcher.c
@@ -0,0 +1,140 @@
+#include "cache.h"
+#include "sigchain.h"
+#include "parse-options.h"
+#include "exec_cmd.h"
+#include "unix-socket.h"
+
+static const char *const file_watcher_usage[] =3D {
+	N_("git file-watcher [options] <socket directory>"),
+	NULL
+};
+
+struct connection {
+	int sock;
+};
+
+static struct connection **conns;
+static struct pollfd *pfd;
+static int conns_alloc, pfd_nr, pfd_alloc;
+
+static int shutdown_connection(int id)
+{
+	struct connection *conn =3D conns[id];
+	conns[id] =3D NULL;
+	pfd[id].fd =3D -1;
+	if (!conn)
+		return 0;
+	close(conn->sock);
+	free(conn);
+	return 0;
+}
+
+static int handle_command(int conn_id)
+{
+	return 0;
+}
+
+static void accept_connection(int fd)
+{
+	struct connection *conn;
+	int client =3D accept(fd, NULL, NULL);
+	if (client < 0) {
+		warning(_("accept failed: %s"), strerror(errno));
+		return;
+	}
+
+	ALLOC_GROW(pfd, pfd_nr + 1, pfd_alloc);
+	pfd[pfd_nr].fd =3D client;
+	pfd[pfd_nr].events =3D POLLIN;
+	pfd[pfd_nr].revents =3D 0;
+
+	ALLOC_GROW(conns, pfd_nr + 1, conns_alloc);
+	conn =3D xmalloc(sizeof(*conn));
+	memset(conn, 0, sizeof(*conn));
+	conn->sock =3D client;
+	conns[pfd_nr] =3D conn;
+	pfd_nr++;
+}
+
+int main(int argc, const char **argv)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int i, new_nr, fd, quit =3D 0, nr_common;
+	const char *socket_path =3D NULL;
+	struct option options[] =3D {
+		OPT_END()
+	};
+
+	git_extract_argv0_path(argv[0]);
+	git_setup_gettext();
+	argc =3D parse_options(argc, argv, NULL, options,
+			     file_watcher_usage, 0);
+	if (argc < 1)
+		die(_("socket path missing"));
+	else if (argc > 1)
+		die(_("too many arguments"));
+
+	socket_path =3D argv[0];
+	strbuf_addf(&sb, "%s/socket", socket_path);
+	fd =3D unix_stream_listen(sb.buf, 0);
+	if (fd =3D=3D -1)
+		die_errno(_("unable to listen at %s"), sb.buf);
+	strbuf_reset(&sb);
+
+	nr_common =3D 1;
+	pfd_alloc =3D pfd_nr =3D nr_common;
+	pfd =3D xmalloc(sizeof(*pfd) * pfd_alloc);
+	pfd[0].fd =3D fd;
+	pfd[0].events =3D POLLIN;
+
+	while (!quit) {
+		if (poll(pfd, pfd_nr, -1) < 0) {
+			if (errno !=3D EINTR) {
+				error("Poll failed, resuming: %s",
+				      strerror(errno));
+				sleep(1);
+			}
+			continue;
+		}
+
+		for (new_nr =3D i =3D nr_common; i < pfd_nr; i++) {
+			if (pfd[i].revents & (POLLERR | POLLNVAL))
+				shutdown_connection(i);
+			else if ((pfd[i].revents & POLLIN) && conns[i]) {
+				unsigned int avail =3D 1;
+				/*
+				 * pkt-line is not gentle with eof, at
+				 * least not with
+				 * packet_read_line(). Avoid feeding
+				 * eof to it.
+				 */
+				if ((pfd[i].revents & POLLHUP) &&
+				    ioctl(pfd[i].fd, FIONREAD, &avail))
+					die_errno("unable to FIONREAD inotify handle");
+				/*
+				 * We better have a way to handle all
+				 * packets in one go...
+				 */
+				if (avail)
+					handle_command(i);
+				else
+					shutdown_connection(i);
+			} else if (pfd[i].revents & POLLHUP)
+				shutdown_connection(i);
+			if (!conns[i])
+				continue;
+			if (i !=3D new_nr) { /* pfd[] is shrunk, move pfd[i] up */
+				conns[new_nr] =3D conns[i];
+				pfd[new_nr] =3D pfd[i];
+			}
+			new_nr++; /* keep the good socket */
+		}
+		pfd_nr =3D new_nr;
+
+		if (pfd[0].revents & POLLIN)
+			accept_connection(pfd[0].fd);
+		if (pfd[0].revents & (POLLHUP | POLLERR | POLLNVAL))
+			die(_("error on listening socket"));
+	}
+	return 0;
+}
--=20
1.8.5.2.240.g8478abd
