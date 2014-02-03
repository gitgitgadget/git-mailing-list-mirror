From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 15/26] read-cache: get changed file list from file watcher
Date: Mon,  3 Feb 2014 11:29:03 +0700
Message-ID: <1391401754-15347-16-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:30:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABBI-0001IN-AO
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbaBCEaq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:30:46 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:40742 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbaBCEap (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:30:45 -0500
Received: by mail-pa0-f45.google.com with SMTP id lf10so6624124pab.32
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WECNMAFBSmwmD9VDkC6gKJtdRvWViLCKfM8JrToNnCg=;
        b=eVEf+/L3XHqNBDuWPrI2V9yORlibSlH8sI43HWcZDCCMhUFGunmvHkFGvcg43FumUo
         h7S2MkUxoWPwy451lR6eOM08IpAjWUdvnmtLBfcC+dtv8n4XANZ4wjC69TW8bRbmgqnG
         TboqVA35mhxvJLX/OycluIG4zknDhmVuIPYz185XTKsRPiCqisDqu/lgKAnYGXG9WwvY
         hhiGz84zwaRSFN7307Fha93l1cuSO+pSwvVL9/MsYNGwps+D2bamcMKdZcvcH73XTVZL
         p/7FjLZaGqAwE/gYp3gIa1+FsE/rV1X98y7YviJQn8JLdglAh1/vPXv0Yo/AMf9YpYJN
         oaIQ==
X-Received: by 10.66.179.143 with SMTP id dg15mr35320646pac.52.1391401844839;
        Sun, 02 Feb 2014 20:30:44 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id os1sm134279218pac.20.2014.02.02.20.30.41
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:30:44 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:30:42 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241410>

When some paths are watched, they are added to the "watched" list in
file watcher. When a path in this list is updated, the path is moved
to "changed" list and no longer watched.

With this patch we have a complete path exchanging picture between git
and file-watcher:

1) Hand shake

2) Get the list of changed paths, clear CE_WATCHED on these paths. Set
   CE_VALID on the remaining CE_WATCHED paths

3) (Optionally) Ask to watch more paths. Set CE_WATCHED on
   them. CE_VALID is not set so these are still lstat'd

4) Refresh as usual. lstat is skipped on CE_VALID paths. If one of
   those paths at step 3 are found modified, CE_WATCHED is removed.

5) Write index to disk. Notify file-watcher about new index
   signature. Ask file watcher to remove the "changed paths".

A few points:

 - Changed list remains until step 5. If git crashes or do not write
   index down, next time it starts, it'll fed the same changed list.

 - If git writes index down without telling file-watcher about it,
   next time it starts, hand shake should fail and git should clear
   all CE_WATCHED.

 - There's a buffer between starting watch at #3 and saving watch at
   #5. We do verify paths are clean at #4. But that time all watches
   should have been active for a while. No chance for race conditions.

 - #5 is sort of atomic. If git crashes half way through step 5, file
   watcher should not update its index signature. Which means next
   time git starts, hand shake fails (because new index's written) so
   we'll start over.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h            |   1 +
 file-watcher-lib.c |  99 ++++++++++++++++++++++++++++++++++++++
 file-watcher-lib.h |   1 +
 file-watcher.c     | 138 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 read-cache.c       |  21 +++++++-
 5 files changed, 258 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 10ff33e..9f7d952 100644
--- a/cache.h
+++ b/cache.h
@@ -285,6 +285,7 @@ struct index_state {
 	struct hash_table dir_hash;
 	unsigned char sha1[20];
 	int watcher;
+	struct string_list *updated_entries;
 };
=20
 extern struct index_state the_index;
diff --git a/file-watcher-lib.c b/file-watcher-lib.c
index d4949a5..b6b0848 100644
--- a/file-watcher-lib.c
+++ b/file-watcher-lib.c
@@ -2,6 +2,7 @@
 #include "file-watcher-lib.h"
 #include "pkt-line.h"
 #include "unix-socket.h"
+#include "string-list.h"
=20
 static char *watcher_path;
 static int WAIT_TIME =3D 50;	/* in ms */
@@ -25,6 +26,11 @@ static int connect_watcher(const char *path)
 static void reset_watches(struct index_state *istate, int disconnect)
 {
 	int i, changed =3D 0;
+	if (istate->updated_entries) {
+		string_list_clear(istate->updated_entries, 0);
+		free(istate->updated_entries);
+		istate->updated_entries =3D NULL;
+	}
 	for (i =3D 0; i < istate->cache_nr; i++)
 		if (istate->cache[i]->ce_flags & CE_WATCHED) {
 			istate->cache[i]->ce_flags &=3D ~(CE_WATCHED | CE_VALID);
@@ -41,6 +47,58 @@ static void reset_watches(struct index_state *istate=
, int disconnect)
 	}
 }
=20
+static void mark_ce_valid(struct index_state *istate)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	char *line, *end;
+	int i, len;
+	unsigned long n;
+	if (packet_write_timeout(istate->watcher, WAIT_TIME, "get-changed") <=
=3D 0 ||
+	    !(line =3D packet_read_line_timeout(istate->watcher, WAIT_TIME, &=
len)) ||
+	    !starts_with(line, "changed ")) {
+		reset_watches(istate, 1);
+		return;
+	}
+	n =3D strtoul(line + 8, &end, 10);
+	if (end !=3D line + len) {
+		reset_watches(istate, 1);
+		return;
+	}
+	if (!n)
+		goto done;
+	strbuf_grow(&sb, n);
+	if (read_in_full_timeout(istate->watcher, sb.buf, n, WAIT_TIME) !=3D =
n) {
+		strbuf_release(&sb);
+		reset_watches(istate, 1);
+		return;
+	}
+	line =3D sb.buf;
+	end =3D line + n;
+	for (; line < end; line +=3D len + 1) {
+		len =3D strlen(line);
+		i =3D index_name_pos(istate, line, len);
+		if (i < 0)
+			continue;
+		if (istate->cache[i]->ce_flags & CE_WATCHED) {
+			istate->cache[i]->ce_flags &=3D ~CE_WATCHED;
+			istate->cache_changed =3D 1;
+		}
+		if (!istate->updated_entries) {
+			struct string_list *sl;
+			sl =3D xmalloc(sizeof(*sl));
+			memset(sl, 0, sizeof(*sl));
+			sl->strdup_strings =3D 1;
+			istate->updated_entries =3D sl;
+		}
+		string_list_append(istate->updated_entries, line);
+	}
+	strbuf_release(&sb);
+done:
+	for (i =3D 0; i < istate->cache_nr; i++)
+		if (istate->cache[i]->ce_flags & CE_WATCHED)
+			istate->cache[i]->ce_flags |=3D CE_VALID;
+}
+
 static int watcher_config(const char *var, const char *value, void *da=
ta)
 {
 	if (!strcmp(var, "filewatcher.path")) {
@@ -110,6 +168,8 @@ void open_watcher(struct index_state *istate)
 		istate->update_watches =3D 1;
 		return;
 	}
+
+	mark_ce_valid(istate);
 }
=20
 static int sort_by_date(const void *a_, const void *b_)
@@ -200,3 +260,42 @@ void watch_entries(struct index_state *istate)
 	send_watches(istate, sorted, nr);
 	free(sorted);
 }
+
+void close_watcher(struct index_state *istate, const unsigned char *sh=
a1)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int len, i, nr;
+	if (istate->watcher <=3D 0)
+		return;
+	if (packet_write_timeout(istate->watcher, WAIT_TIME,
+				 "new-index %s", sha1_to_hex(sha1)) <=3D 0)
+		goto done;
+	nr =3D istate->updated_entries ? istate->updated_entries->nr : 0;
+	if (!nr) {
+		packet_write_timeout(istate->watcher, WAIT_TIME, "unchange 0");
+		goto done;
+	}
+	for (i =3D len =3D 0; i < nr; i++) {
+		const char *s =3D istate->updated_entries->items[i].string;
+		len +=3D strlen(s) + 1;
+	}
+	if (packet_write_timeout(istate->watcher, WAIT_TIME,
+				 "unchange %d", len) <=3D 0)
+	    goto done;
+	strbuf_grow(&sb, len);
+	for (i =3D 0; i < nr; i++) {
+		const char *s =3D istate->updated_entries->items[i].string;
+		int len =3D strlen(s);
+		strbuf_add(&sb, s, len + 1);
+	}
+	/*
+	 * it does not matter if it fails anymore, we're closing
+	 * down. If it only gets through partially, file watcher
+	 * should ignore it.
+	 */
+	write_in_full_timeout(istate->watcher, sb.buf, sb.len, WAIT_TIME);
+	strbuf_release(&sb);
+done:
+	close(istate->watcher);
+	istate->watcher =3D -1;
+}
diff --git a/file-watcher-lib.h b/file-watcher-lib.h
index 1641024..df68a73 100644
--- a/file-watcher-lib.h
+++ b/file-watcher-lib.h
@@ -3,5 +3,6 @@
=20
 void open_watcher(struct index_state *istate);
 void watch_entries(struct index_state *istate);
+void close_watcher(struct index_state *istate, const unsigned char *sh=
a1);
=20
 #endif
diff --git a/file-watcher.c b/file-watcher.c
index c257414..aa2daf6 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -3,6 +3,7 @@
 #include "parse-options.h"
 #include "exec_cmd.h"
 #include "unix-socket.h"
+#include "string-list.h"
 #include "pkt-line.h"
=20
 static const char *const file_watcher_usage[] =3D {
@@ -21,6 +22,9 @@ struct repository {
 	 * is probably enough for this case.
 	 */
 	ino_t inode;
+	struct string_list updated;
+	int updated_sorted;
+	int updating;
 };
=20
 const char *invalid_signature =3D "00000000000000000000000000000000000=
00000";
@@ -31,6 +35,8 @@ static int nr_repos;
 struct connection {
 	int sock, polite;
 	struct repository *repo;
+
+	char new_index[41];
 };
=20
 static struct connection **conns;
@@ -42,6 +48,24 @@ static int watch_path(struct repository *repo, char =
*path)
 	return -1;
 }
=20
+static void get_changed_list(int conn_id)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int i, size, fd =3D conns[conn_id]->sock;
+	struct repository *repo =3D conns[conn_id]->repo;
+
+	for (i =3D size =3D 0; i < repo->updated.nr; i++)
+		size +=3D strlen(repo->updated.items[i].string) + 1;
+	packet_write(fd, "changed %d", size);
+	if (!size)
+		return;
+	strbuf_grow(&sb, size);
+	for (i =3D 0; i < repo->updated.nr; i++)
+		strbuf_add(&sb, repo->updated.items[i].string,
+			   strlen(repo->updated.items[i].string) + 1);
+	write_in_full(fd, sb.buf, sb.len);
+}
+
 static inline uint64_t stamp(void)
 {
 	struct timeval tv;
@@ -101,6 +125,43 @@ static void watch_paths(int conn_id, char *buf, in=
t maxlen)
 	packet_write(conns[conn_id]->sock, "watched %u", n);
 }
=20
+static void unchange(int conn_id, unsigned long size)
+{
+	struct connection *conn =3D conns[conn_id];
+	struct repository *repo =3D conn->repo;
+	if (size) {
+		struct strbuf sb =3D STRBUF_INIT;
+		char *p;
+		int len;
+		strbuf_grow(&sb, size);
+		if (read_in_full(conn->sock, sb.buf, size) <=3D 0)
+			return;
+		if (!repo->updated_sorted) {
+			sort_string_list(&repo->updated);
+			repo->updated_sorted =3D 1;
+		}
+		for (p =3D sb.buf; p - sb.buf < size; p +=3D len + 1) {
+			struct string_list_item *item;
+			len =3D strlen(p);
+			item =3D string_list_lookup(&repo->updated, p);
+			if (!item)
+				continue;
+			unsorted_string_list_delete_item(&repo->updated,
+							 item - repo->updated.items, 0);
+		}
+		strbuf_release(&sb);
+	}
+	memcpy(repo->index_signature, conn->new_index, 40);
+	/*
+	 * If other connections on this repo are in some sort of
+	 * session that depend on the previous repository state, we
+	 * may need to disconnect them to be safe.
+	 */
+
+	/* pfd[0] is the listening socket, can't be a connection */
+	repo->updating =3D 0;
+}
+
 static struct repository *get_repo(const char *work_tree)
 {
 	int first, last;
@@ -129,12 +190,14 @@ static struct repository *get_repo(const char *wo=
rk_tree)
 	memset(repo, 0, sizeof(*repo));
 	repo->work_tree =3D xstrdup(work_tree);
 	memset(repo->index_signature, '0', 40);
+	repo->updated.strdup_strings =3D 1;
 	repos[first] =3D repo;
 	return repo;
 }
=20
 static void reset_repo(struct repository *repo, ino_t inode)
 {
+	string_list_clear(&repo->updated, 0);
 	memcpy(repo->index_signature, invalid_signature, 40);
 	repo->inode =3D inode;
 }
@@ -147,6 +210,8 @@ static int shutdown_connection(int id)
 	if (!conn)
 		return 0;
 	close(conn->sock);
+	if (conn->repo && conn->repo->updating =3D=3D id)
+		conn->repo->updating =3D 0;
 	free(conn);
 	return 0;
 }
@@ -268,6 +333,77 @@ static int handle_command(int conn_id)
 		}
 		watch_paths(conn_id, msg + 6, len - 6);
 	}
+
+	/*
+	 * > "get-changed"
+	 * < changed SP LENGTH
+	 * < PATH-LIST
+	 *
+	 * When watched path gets updated, the path is moved from
+	 * "watched" list to "changed" list and is no longer watched.
+	 * This command get the list of changed paths. PATH-LIST is
+	 * also sent if LENGTH is non-zero.
+	 */
+	else if (!strcmp(msg, "get-changed")) {
+		if (!conns[conn_id]->repo) {
+			packet_write(fd, "error have not received index command");
+			return shutdown_connection(conn_id);
+		}
+		get_changed_list(conn_id);
+	}
+
+	/*
+	 * > "new-index" INDEX-SIGNATURE
+	 * > "unchange" SP LENGTH
+	 * > PATH-LIST
+	 *
+	 * "new-index" passes new index signature from the
+	 * client. "unchange" sends the list of paths to be removed
+	 * from "changed" list.
+	 *
+	 * "new-index" must be sent before "unchange". File watcher
+	 * waits until the last "unchange" line, then update its index
+	 * signature as well as "changed" list.
+	 */
+	else if (starts_with(msg, "new-index ")) {
+		if (len !=3D 50) {
+			packet_write(fd, "error invalid new-index line %s", msg);
+			return shutdown_connection(conn_id);
+		}
+		if (!conns[conn_id]->repo) {
+			packet_write(fd, "error have not received index command");
+			return shutdown_connection(conn_id);
+		}
+		if (conns[conn_id]->repo->updating =3D=3D conn_id) {
+			packet_write(fd, "error received new-index command more than once")=
;
+			return shutdown_connection(conn_id);
+		}
+		memcpy(conns[conn_id]->new_index, msg + 10, 40);
+		/*
+		 * if updating is non-zero the other client will get
+		 * disconnected at the next "unchange" command because
+		 * "updating" no longer points to its connection.
+		 */
+		conns[conn_id]->repo->updating =3D conn_id;
+	}
+	else if (skip_prefix(msg, "unchange ")) {
+		unsigned long n;
+		char *end;
+		n =3D strtoul(msg + 9, &end, 10);
+		if (end !=3D msg + len) {
+			packet_write(fd, "error invalid unchange line %s", msg);
+			return shutdown_connection(conn_id);
+		}
+		if (!conns[conn_id]->repo) {
+			packet_write(fd, "error have not received index command");
+			return shutdown_connection(conn_id);
+		}
+		if (conns[conn_id]->repo->updating !=3D conn_id) {
+			packet_write(fd, "error have not received new-index command");
+			return shutdown_connection(conn_id);
+		}
+		unchange(conn_id, n);
+	}
 	else {
 		packet_write(fd, "error unrecognized command %s", msg);
 		return shutdown_connection(conn_id);
@@ -436,6 +572,8 @@ int main(int argc, const char **argv)
 			if (!conns[i])
 				continue;
 			if (i !=3D new_nr) { /* pfd[] is shrunk, move pfd[i] up */
+				if (conns[i]->repo && conns[i]->repo->updating =3D=3D i)
+					conns[i]->repo->updating =3D new_nr;
 				conns[new_nr] =3D conns[i];
 				pfd[new_nr] =3D pfd[i];
 			}
diff --git a/read-cache.c b/read-cache.c
index dc49858..5540b06 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1567,6 +1567,11 @@ int discard_index(struct index_state *istate)
 	free(istate->cache);
 	istate->cache =3D NULL;
 	istate->cache_alloc =3D 0;
+	if (istate->updated_entries) {
+		string_list_clear(istate->updated_entries, 0);
+		free(istate->updated_entries);
+		istate->updated_entries =3D NULL;
+	}
 	return 0;
 }
=20
@@ -1627,7 +1632,7 @@ static int write_index_ext_header(git_SHA_CTX *co=
ntext, int fd,
 		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
 }
=20
-static int ce_flush(git_SHA_CTX *context, int fd)
+static int ce_flush(git_SHA_CTX *context, int fd, unsigned char *sha1)
 {
 	unsigned int left =3D write_buffer_len;
=20
@@ -1645,6 +1650,8 @@ static int ce_flush(git_SHA_CTX *context, int fd)
=20
 	/* Append the SHA1 signature at the end */
 	git_SHA1_Final(write_buffer + left, context);
+	if (sha1)
+		hashcpy(sha1, write_buffer + left);
 	left +=3D 20;
 	return (write_in_full(fd, write_buffer, left) !=3D left) ? -1 : 0;
 }
@@ -1809,12 +1816,21 @@ int write_index(struct index_state *istate, int=
 newfd)
 	int entries =3D istate->cache_nr;
 	struct stat st;
 	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
+	unsigned char sha1[20];
=20
 	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
 			removed++;
 		else if (cache[i]->ce_flags & CE_WATCHED) {
 			/*
+			 * CE_VALID when used with CE_WATCHED is not
+			 * supposed to be persistent. Next time git
+			 * runs, if this entry is still watched and
+			 * nothing has changed, CE_VALID will be
+			 * reinstated.
+			 */
+			cache[i]->ce_flags &=3D ~CE_VALID;
+			/*
 			 * We may set CE_WATCHED (but not CE_VALID)
 			 * early when refresh has not been done
 			 * yet. At that time we had no idea if the
@@ -1922,8 +1938,9 @@ int write_index(struct index_state *istate, int n=
ewfd)
 			return -1;
 	}
=20
-	if (ce_flush(&c, newfd) || fstat(newfd, &st))
+	if (ce_flush(&c, newfd, sha1) || fstat(newfd, &st))
 		return -1;
+	close_watcher(istate, sha1);
 	istate->timestamp.sec =3D (unsigned int)st.st_mtime;
 	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
 	return 0;
--=20
1.8.5.2.240.g8478abd
