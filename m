From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 12/26] read-cache: basic hand shaking to the file watcher
Date: Mon,  3 Feb 2014 11:29:00 +0700
Message-ID: <1391401754-15347-13-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:30:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABB5-0001DW-ST
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbaBCEa3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:30:29 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:46118 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbaBCEa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:30:27 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so6417790pdj.15
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DKcUSXx5cvUgcZHd2L+RubuuM9pv4HWwI/3IdsyTWdc=;
        b=1GxuwqR91o5oyqsAEzW77+BB+QTWW4EKugkVknZnJrFd4NV32/Buuaok2ad/RE9Jgy
         7FATCVlaVR14apYDUyp/qIiiW9KJg59eVw1Met9pLxYW2Z0kavzzqUCrIEReJX3KL5vX
         0F/r0g5Mv/wXH0aQixEHzyAWxvAAUrUG5f8xF+ZCdGKjR22gH4BOg+XBuZoHCT1FT4Ko
         Z5RdeJhdihIb5rG67QhzacOrMhJUPhLie4YwEopi6ug0DXw8dWPs7+9qv4N8CQp2fkfv
         MLOPgCLCcMtCUGk67UbGWFDZPzztMq+YfVWjS/5Y0O9LaT/fVEGT6WU5RKDVPu2F4RJE
         yaRg==
X-Received: by 10.66.141.165 with SMTP id rp5mr35145129pab.90.1391401827154;
        Sun, 02 Feb 2014 20:30:27 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id y7sm18926203pbb.8.2014.02.02.20.30.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:30:26 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:30:24 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241406>

read_cache() connects to the file watcher, specified by
filewatcher.path config, and performs basic hand shaking. CE_WATCHED
is cleared if git and file watcher have different views on the index
state.

All send/receive calls must be complete within a limited time to avoid
a buggy file-watcher hang "git status" forever. And the whole point of
doing this is speed. If file watcher can't respond fast enough, for
whatever reason, then it should not be used.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt           |  10 +++
 Documentation/git-file-watcher.txt |   4 +-
 Makefile                           |   1 +
 cache.h                            |   1 +
 file-watcher-lib.c (new)           |  91 ++++++++++++++++++++++
 file-watcher-lib.h (new)           |   6 ++
 file-watcher.c                     | 152 +++++++++++++++++++++++++++++=
+++++++-
 read-cache.c                       |   6 ++
 8 files changed, 269 insertions(+), 2 deletions(-)
 create mode 100644 file-watcher-lib.c
 create mode 100644 file-watcher-lib.h

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5f4d793..6ad653a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1042,6 +1042,16 @@ difftool.<tool>.cmd::
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
=20
+filewatcher.path::
+	The directory that contains the socket of `git	file-watcher`.
+	If it's not an absolute path, it's relative to $GIT_DIR. An
+	empty path means no connection to file watcher.
+
+filewatcher.timeout::
+	This is the maximum time in milliseconds that Git waits for
+	the file watcher to respond before giving up. Default value is
+	50. Setting to -1 makes Git wait forever.
+
 fetch.recurseSubmodules::
 	This option can be either set to a boolean value or to 'on-demand'.
 	Setting it to a boolean changes the behavior of fetch and pull to
diff --git a/Documentation/git-file-watcher.txt b/Documentation/git-fil=
e-watcher.txt
index ec81f18..d91caf3 100644
--- a/Documentation/git-file-watcher.txt
+++ b/Documentation/git-file-watcher.txt
@@ -14,7 +14,9 @@ DESCRIPTION
 -----------
 This program watches file changes in a git working directory and let
 Git now what files have been changed so that Git does not have to call
-lstat(2) to detect that itself.
+lstat(2) to detect that itself. Config key filewatcher.path needs to
+be set to `<socket directory>` so Git knows how to contact to the file
+watcher.
=20
 OPTIONS
 -------
diff --git a/Makefile b/Makefile
index 8eef0d6..1c4d659 100644
--- a/Makefile
+++ b/Makefile
@@ -798,6 +798,7 @@ LIB_OBJS +=3D entry.o
 LIB_OBJS +=3D environment.o
 LIB_OBJS +=3D exec_cmd.o
 LIB_OBJS +=3D fetch-pack.o
+LIB_OBJS +=3D file-watcher-lib.o
 LIB_OBJS +=3D fsck.o
 LIB_OBJS +=3D gettext.o
 LIB_OBJS +=3D gpg-interface.o
diff --git a/cache.h b/cache.h
index a0af2a5..b3ea574 100644
--- a/cache.h
+++ b/cache.h
@@ -283,6 +283,7 @@ struct index_state {
 	struct hash_table name_hash;
 	struct hash_table dir_hash;
 	unsigned char sha1[20];
+	int watcher;
 };
=20
 extern struct index_state the_index;
diff --git a/file-watcher-lib.c b/file-watcher-lib.c
new file mode 100644
index 0000000..d0636cc
--- /dev/null
+++ b/file-watcher-lib.c
@@ -0,0 +1,91 @@
+#include "cache.h"
+#include "file-watcher-lib.h"
+#include "pkt-line.h"
+#include "unix-socket.h"
+
+static char *watcher_path;
+static int WAIT_TIME =3D 50;	/* in ms */
+
+static int connect_watcher(const char *path)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int fd;
+
+	if (!path || !*path)
+		return -1;
+
+	strbuf_addf(&sb, "%s/socket", path);
+	fd =3D unix_stream_connect(sb.buf);
+	strbuf_release(&sb);
+	return fd;
+}
+
+static void reset_watches(struct index_state *istate, int disconnect)
+{
+	int i;
+	for (i =3D 0; i < istate->cache_nr; i++)
+		if (istate->cache[i]->ce_flags & CE_WATCHED) {
+			istate->cache[i]->ce_flags &=3D ~(CE_WATCHED | CE_VALID);
+			istate->cache_changed =3D 1;
+		}
+	if (disconnect && istate->watcher > 0) {
+		close(istate->watcher);
+		istate->watcher =3D -1;
+	}
+}
+
+static int watcher_config(const char *var, const char *value, void *da=
ta)
+{
+	if (!strcmp(var, "filewatcher.path")) {
+		if (is_absolute_path(value))
+			watcher_path =3D xstrdup(value);
+		else if (*value =3D=3D '~')
+			watcher_path =3D expand_user_path(value);
+		else
+			watcher_path =3D git_pathdup("%s", value);
+		return 0;
+	}
+	if (!strcmp(var, "filewatcher.timeout")) {
+		WAIT_TIME =3D git_config_int(var, value);
+		return 0;
+	}
+	return 0;
+}
+
+void open_watcher(struct index_state *istate)
+{
+	static int read_config =3D 0;
+	char *msg;
+
+	if (!get_git_work_tree()) {
+		reset_watches(istate, 1);
+		return;
+	}
+
+	if (!read_config) {
+		/*
+		 * can't hook into git_default_config because
+		 * read_cache() may be called even before git_config()
+		 * call.
+		 */
+		git_config(watcher_config, NULL);
+		read_config =3D 1;
+	}
+
+	istate->watcher =3D connect_watcher(watcher_path);
+	if (packet_write_timeout(istate->watcher, WAIT_TIME, "hello") <=3D 0 =
||
+	    (msg =3D packet_read_line_timeout(istate->watcher, WAIT_TIME, NUL=
L)) =3D=3D NULL ||
+	    strcmp(msg, "hello")) {
+		reset_watches(istate, 1);
+		return;
+	}
+
+	if (packet_write_timeout(istate->watcher, WAIT_TIME, "index %s %s",
+				 sha1_to_hex(istate->sha1),
+				 get_git_work_tree()) <=3D 0 ||
+	    (msg =3D packet_read_line_timeout(istate->watcher, WAIT_TIME, NUL=
L)) =3D=3D NULL ||
+	    strcmp(msg, "ok")) {
+		reset_watches(istate, 0);
+		return;
+	}
+}
diff --git a/file-watcher-lib.h b/file-watcher-lib.h
new file mode 100644
index 0000000..eb6edf5
--- /dev/null
+++ b/file-watcher-lib.h
@@ -0,0 +1,6 @@
+#ifndef __FILE_WATCHER_LIB__
+#define __FILE_WATCHER_LIB__
+
+void open_watcher(struct index_state *istate);
+
+#endif
diff --git a/file-watcher.c b/file-watcher.c
index 1e1ccad..6df3a48 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -3,20 +3,78 @@
 #include "parse-options.h"
 #include "exec_cmd.h"
 #include "unix-socket.h"
+#include "pkt-line.h"
=20
 static const char *const file_watcher_usage[] =3D {
 	N_("git file-watcher [options] <socket directory>"),
 	NULL
 };
=20
+struct repository {
+	char *work_tree;
+	char index_signature[41];
+	/*
+	 * At least with inotify we don't keep track down to "/". So
+	 * if worktree is /abc/def and someone moves /abc to /ghi, and
+	 * /jlk to /abc (and /jlk/def exists before the move), we
+	 * cant' detect that /abc/def is totally new. Checking inode
+	 * is probably enough for this case.
+	 */
+	ino_t inode;
+};
+
+const char *invalid_signature =3D "00000000000000000000000000000000000=
00000";
+
+static struct repository **repos;
+static int nr_repos;
+
 struct connection {
-	int sock;
+	int sock, polite;
+	struct repository *repo;
 };
=20
 static struct connection **conns;
 static struct pollfd *pfd;
 static int conns_alloc, pfd_nr, pfd_alloc;
=20
+static struct repository *get_repo(const char *work_tree)
+{
+	int first, last;
+	struct repository *repo;
+
+	first =3D 0;
+	last =3D nr_repos;
+	while (last > first) {
+		int next =3D (last + first) >> 1;
+		int cmp =3D strcmp(work_tree, repos[next]->work_tree);
+		if (!cmp)
+			return repos[next];
+		if (cmp < 0) {
+			last =3D next;
+			continue;
+		}
+		first =3D next+1;
+	}
+
+	nr_repos++;
+	repos =3D xrealloc(repos, sizeof(*repos) * nr_repos);
+	if (nr_repos > first + 1)
+		memmove(repos + first + 1, repos + first,
+			(nr_repos - first - 1) * sizeof(*repos));
+	repo =3D xmalloc(sizeof(*repo));
+	memset(repo, 0, sizeof(*repo));
+	repo->work_tree =3D xstrdup(work_tree);
+	memset(repo->index_signature, '0', 40);
+	repos[first] =3D repo;
+	return repo;
+}
+
+static void reset_repo(struct repository *repo, ino_t inode)
+{
+	memcpy(repo->index_signature, invalid_signature, 40);
+	repo->inode =3D inode;
+}
+
 static int shutdown_connection(int id)
 {
 	struct connection *conn =3D conns[id];
@@ -31,6 +89,98 @@ static int shutdown_connection(int id)
=20
 static int handle_command(int conn_id)
 {
+	int fd =3D conns[conn_id]->sock;
+	int len;
+	const char *arg;
+	char *msg;
+
+	/*
+	 * ">" denotes an incoming packet, "<" outgoing. The lack of
+	 * "<" means no reply expected.
+	 *
+	 * < "error" SP ERROR-STRING
+	 *
+	 * This can be sent whenever the client violates the protocol.
+	 */
+
+	msg =3D packet_read_line(fd, &len);
+	if (!msg) {
+		packet_write(fd, "error invalid pkt-line");
+		return shutdown_connection(conn_id);
+	}
+
+	/*
+	 * > "hello" [SP CAP [SP CAP..]]
+	 * < "hello" [SP CAP [SP CAP..]]
+	 *
+	 * Advertise capabilities of both sides. File watcher may
+	 * disconnect if the client does not advertise the required
+	 * capabilities. Capabilities in uppercase MUST be
+	 * supported. If any side does not understand any of the
+	 * advertised uppercase capabilities, it must disconnect.
+	 */
+	if ((arg =3D skip_prefix(msg, "hello"))) {
+		if (*arg) {	/* no capabilities supported yet */
+			packet_write(fd, "error capabilities not supported");
+			return shutdown_connection(conn_id);
+		}
+		packet_write(fd, "hello");
+		conns[conn_id]->polite =3D 1;
+	}
+
+	/*
+	 * > "index" SP INDEX-SIGNATURE SP WORK-TREE-PATH
+	 * < "ok" | "inconsistent"
+	 *
+	 * INDEX-SIGNATURE consists of 40 hexadecimal letters
+	 * WORK-TREE-PATH must be absolute and normalized path
+	 *
+	 * Watch file changes in index. The client sends the index and
+	 * work tree info. File watcher validates that it holds the
+	 * same info. If so it sends "ok" back indicating both sides
+	 * are on the same page and CE_WATCHED bits can be ketpt.
+	 *
+	 * Otherwise it sends "inconsistent" and both sides must reset
+	 * back to initial state. File watcher keeps its index
+	 * signature all-zero until the client has updated the index
+	 * ondisk and request to update index signature.
+	 *
+	 * "hello" must be exchanged first. After this command the
+	 * connection is associated with a worktree/index. Many
+	 * commands may require this to proceed.
+	 */
+	else if (starts_with(msg, "index ")) {
+		struct repository *repo;
+		struct stat st;
+		if (!conns[conn_id]->polite) {
+			packet_write(fd, "error why did you not greet me? go away");
+			return shutdown_connection(conn_id);
+		}
+		if (len < 47 || msg[46] !=3D ' ' || !is_absolute_path(msg + 47)) {
+			packet_write(fd, "error invalid index line %s", msg);
+			return shutdown_connection(conn_id);
+		}
+
+		if (lstat(msg + 47, &st) || !S_ISDIR(st.st_mode)) {
+			packet_write(fd, "error work tree does not exist: %s",
+				     strerror(errno));
+			return shutdown_connection(conn_id);
+		}
+		repo =3D get_repo(msg + 47);
+		conns[conn_id]->repo =3D repo;
+		if (memcmp(msg + 6, repo->index_signature, 40) ||
+		    !memcmp(msg + 6, invalid_signature, 40) ||
+		    repo->inode !=3D st.st_ino) {
+			packet_write(fd, "inconsistent");
+			reset_repo(repo, st.st_ino);
+			return 0;
+		}
+		packet_write(fd, "ok");
+	}
+	else {
+		packet_write(fd, "error unrecognized command %s", msg);
+		return shutdown_connection(conn_id);
+	}
 	return 0;
 }
=20
diff --git a/read-cache.c b/read-cache.c
index 8961864..a7e5735 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -14,6 +14,7 @@
 #include "resolve-undo.h"
 #include "strbuf.h"
 #include "varint.h"
+#include "file-watcher-lib.h"
=20
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,=
 int really);
=20
@@ -1528,6 +1529,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 		src_offset +=3D extsize;
 	}
 	munmap(mmap, mmap_size);
+	open_watcher(istate);
 	return istate->cache_nr;
=20
 unmap:
@@ -1553,6 +1555,10 @@ int discard_index(struct index_state *istate)
 	istate->timestamp.nsec =3D 0;
 	free_name_hash(istate);
 	cache_tree_free(&(istate->cache_tree));
+	if (istate->watcher > 0) {
+		close(istate->watcher);
+		istate->watcher =3D -1;
+	}
 	istate->initialized =3D 0;
 	free(istate->cache);
 	istate->cache =3D NULL;
--=20
1.8.5.2.240.g8478abd
