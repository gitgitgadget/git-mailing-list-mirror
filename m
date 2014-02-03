From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 13/26] read-cache: ask file watcher to watch files
Date: Mon,  3 Feb 2014 11:29:01 +0700
Message-ID: <1391401754-15347-14-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:30:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABBB-0001GQ-Ug
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbaBCEah convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:30:37 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:61281 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902AbaBCEad (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:30:33 -0500
Received: by mail-pd0-f178.google.com with SMTP id y13so6406600pdi.37
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LHU0lCv88dPlkp2ddASsUbTo0fZEegp8pCbZQgRKiXk=;
        b=n56eZe8NbboqulfQIErCoC1DdwpTI+Bx/XbHpB5Qfwx87ubIZj6Qc82QbBA7gGyP9H
         WcJOiBxIvIdqSHO+QI+SK6dlj/upTIYLFWqIegHbFKin9FhP/vEM1RavzVfs9c5r7pGb
         PTT7tTbTjU9+zUg78PwxAPLdy28oImiJunLV/txX4BN+5m+AvzclR02xfWm8+QwExrz9
         3Xi1xGQNd9mtPXccLEYS1cyr5ztUlWJYAv8yRwASKnUiLylcQFuykeQt+L3QagUGvfJL
         ES0wFaWK1DBBeXNXmYDg306GVCbOUgnap/6iUCklcqAGFzHoCVaqOyMAKvPESZ2JIQjI
         pK/g==
X-Received: by 10.68.35.129 with SMTP id h1mr762895pbj.163.1391401833182;
        Sun, 02 Feb 2014 20:30:33 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id nv7sm51412630pbc.31.2014.02.02.20.30.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:30:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:30:30 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241408>

We want to watch files that are never changed because lstat() on those
files is a wasted effort. So we sort unwatched files by date and start
adding them to the file watcher until it barfs (e.g. hits inotify
limit).

Note that we still do lstat() on these new watched files because they
could have changed before the file watcher could watch them. Watched
files may only skip lstat() at the next run.

Also, at this early in the index loading process, we don't know what
files are dirty and thus can skip watching (we do clear CE_WATCHED on
entries that are not verified clean before writing index). So the
watches are set, but git ignores its results. Maybe in future we could
store the list of dirty files in WATC extension and use it as a hint
to skip watching.

In the future, file watcher should figure out what paths are
watchable, what not (e.g. network filesystems) and reject them. For
now it's the user resposibility to set (or unset) filewatcher.path
properly.

The previous attempt sends paths in batch, 64k per pkt-line, then wait
for response. It's designed to stop short in case file watcher is out
of resources. But that's a rare case, and send/wait cycles increase
latency.

Instead we now send everything in one packet, and not in pkt-line to
avoid the 64k limit. Then we wait for the response. On webkit.git,
normal "status -uno" takes 0m1.138s. The sending 14M (of 182k paths)
takes 52ms extra. Previous approach takes 213ms extra. Of course in
the end, extra time is longer because file watcher is basically no-op
so far.

There is not much room for improvement. If we compress paths to reduce
payload, zlib time costs about 300ms (so how small the end result is
no longer matters). Even simple prefix compressing (index v4 style)
would cost 76ms on processing time alone (reducing payload to 3M).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 file-watcher-lib.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++=
+++
 file-watcher-lib.h |  1 +
 file-watcher.c     | 91 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 read-cache.c       | 18 +++++++++--
 4 files changed, 191 insertions(+), 2 deletions(-)

diff --git a/file-watcher-lib.c b/file-watcher-lib.c
index d0636cc..791faae 100644
--- a/file-watcher-lib.c
+++ b/file-watcher-lib.c
@@ -89,3 +89,86 @@ void open_watcher(struct index_state *istate)
 		return;
 	}
 }
+
+static int sort_by_date(const void *a_, const void *b_)
+{
+	const struct cache_entry *a =3D *(const struct cache_entry **)a_;
+	const struct cache_entry *b =3D *(const struct cache_entry **)b_;
+	uint32_t seca =3D a->ce_stat_data.sd_mtime.sec;
+	uint32_t secb =3D b->ce_stat_data.sd_mtime.sec;
+	return seca - secb;
+}
+
+static inline int ce_watchable(struct cache_entry *ce)
+{
+	return
+		!(ce->ce_flags & CE_WATCHED) &&
+		!(ce->ce_flags & CE_VALID) &&
+		/*
+		 * S_IFGITLINK should not be watched
+		 * obviously. S_IFLNK could be problematic because
+		 * inotify may follow symlinks without IN_DONT_FOLLOW
+		 */
+		S_ISREG(ce->ce_mode);
+}
+
+static void send_watches(struct index_state *istate,
+			 struct cache_entry **sorted, int nr)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int i, len =3D 0;
+
+	for (i =3D 0; i < nr; i++)
+		len +=3D ce_namelen(sorted[i]) + 1;
+
+	if (packet_write_timeout(istate->watcher, WAIT_TIME, "watch %d", len)=
 <=3D 0)
+		return;
+
+	strbuf_grow(&sb, len);
+	for (i =3D 0; i < nr; i++)
+		strbuf_add(&sb, sorted[i]->name, ce_namelen(sorted[i]) + 1);
+
+	if (write_in_full_timeout(istate->watcher, sb.buf,
+				  sb.len, WAIT_TIME) !=3D sb.len) {
+		strbuf_release(&sb);
+		return;
+	}
+	strbuf_release(&sb);
+
+	for (;;) {
+		char *line, *end;
+		unsigned long n;
+
+		if (!(line =3D packet_read_line_timeout(istate->watcher,
+						      WAIT_TIME, &len)))
+			return;
+		if (starts_with(line, "watching "))
+			continue;
+		if (!starts_with(line, "watched "))
+			return;
+		n =3D strtoul(line + 8, &end, 10);
+		for (i =3D 0; i < n; i++)
+			sorted[i]->ce_flags |=3D CE_WATCHED;
+		istate->cache_changed =3D 1;
+		break;
+	}
+}
+
+void watch_entries(struct index_state *istate)
+{
+	int i, nr;
+	struct cache_entry **sorted;
+
+	if (istate->watcher <=3D 0)
+		return;
+	for (i =3D nr =3D 0; i < istate->cache_nr; i++)
+		if (ce_watchable(istate->cache[i]))
+			nr++;
+	sorted =3D xmalloc(sizeof(*sorted) * nr);
+	for (i =3D nr =3D 0; i < istate->cache_nr; i++)
+		if (ce_watchable(istate->cache[i]))
+			sorted[nr++] =3D istate->cache[i];
+	qsort(sorted, nr, sizeof(*sorted), sort_by_date);
+	send_watches(istate, sorted, nr);
+	free(sorted);
+}
diff --git a/file-watcher-lib.h b/file-watcher-lib.h
index eb6edf5..1641024 100644
--- a/file-watcher-lib.h
+++ b/file-watcher-lib.h
@@ -2,5 +2,6 @@
 #define __FILE_WATCHER_LIB__
=20
 void open_watcher(struct index_state *istate);
+void watch_entries(struct index_state *istate);
=20
 #endif
diff --git a/file-watcher.c b/file-watcher.c
index 6df3a48..c257414 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -37,6 +37,70 @@ static struct connection **conns;
 static struct pollfd *pfd;
 static int conns_alloc, pfd_nr, pfd_alloc;
=20
+static int watch_path(struct repository *repo, char *path)
+{
+	return -1;
+}
+
+static inline uint64_t stamp(void)
+{
+	struct timeval tv;
+	gettimeofday(&tv, NULL);
+	return (uint64_t)tv.tv_sec * 1000000 + tv.tv_usec;
+}
+
+static int shutdown_connection(int id);
+static void watch_paths(int conn_id, char *buf, int maxlen)
+{
+	int ret, len, n;
+	uint64_t start, now;
+	char *end;
+
+	n =3D strtol(buf, &end, 10);
+	if (end !=3D buf + maxlen) {
+		packet_write(conns[conn_id]->sock,
+			     "error invalid watch number %s", buf);
+		shutdown_connection(conn_id);
+		return;
+	}
+
+	buf =3D xmallocz(n);
+	end =3D buf + n;
+	/*
+	 * Careful if this takes longer than 50ms, it'll upset other
+	 * connections
+	 */
+	if (read_in_full(conns[conn_id]->sock, buf, n) !=3D n) {
+		shutdown_connection(conn_id);
+		return;
+	}
+	if (chdir(conns[conn_id]->repo->work_tree)) {
+		packet_write(conns[conn_id]->sock,
+			     "error chdir %s", strerror(errno));
+		return;
+	}
+	start =3D stamp();
+	for (n =3D ret =3D 0; buf < end; buf +=3D len + 1) {
+		len =3D strlen(buf);
+		if (watch_path(conns[conn_id]->repo, buf))
+			break;
+		n++;
+		if (n & 0x3ff)
+			continue;
+		now =3D stamp();
+		/*
+		 * If we process for too long, the client may timeout
+		 * and give up. Let the client know we're not dead
+		 * yet, every 30ms.
+		 */
+		if (start + 30000 < now) {
+			packet_write(conns[conn_id]->sock, "watching %d", n);
+			start =3D now;
+		}
+	}
+	packet_write(conns[conn_id]->sock, "watched %u", n);
+}
+
 static struct repository *get_repo(const char *work_tree)
 {
 	int first, last;
@@ -177,6 +241,33 @@ static int handle_command(int conn_id)
 		}
 		packet_write(fd, "ok");
 	}
+
+	/*
+	 * > "watch" SP LENGTH
+	 * > PATH-LIST
+	 * < "watching" SP NUM
+	 * < "watched" SP NUM
+	 *
+	 * PATH-LIST is the list of paths, each terminated with
+	 * NUL. PATH-LIST is not wrapped in pkt-line format. LENGTH is
+	 * the size of PATH-LIST in bytes.
+	 *
+	 * The client asks file watcher to watcher a number of
+	 * paths. File watcher starts to process from path by path in
+	 * received order. File watcher returns the actual number of
+	 * watched paths with "watched" command.
+	 *
+	 * File watcher may send any number of "watching" messages
+	 * before "watched". This packet is to keep the connection
+	 * alive and has no other values.
+	 */
+	else if (starts_with(msg, "watch ")) {
+		if (!conns[conn_id]->repo) {
+			packet_write(fd, "error have not received index command");
+			return shutdown_connection(conn_id);
+		}
+		watch_paths(conn_id, msg + 6, len - 6);
+	}
 	else {
 		packet_write(fd, "error unrecognized command %s", msg);
 		return shutdown_connection(conn_id);
diff --git a/read-cache.c b/read-cache.c
index a7e5735..cb2188f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1530,6 +1530,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	}
 	munmap(mmap, mmap_size);
 	open_watcher(istate);
+	watch_entries(istate);
 	return istate->cache_nr;
=20
 unmap:
@@ -1809,8 +1810,21 @@ int write_index(struct index_state *istate, int =
newfd)
 	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
 			removed++;
-		else if (cache[i]->ce_flags & CE_WATCHED)
-			has_watches++;
+		else if (cache[i]->ce_flags & CE_WATCHED) {
+			/*
+			 * We may set CE_WATCHED (but not CE_VALID)
+			 * early when refresh has not been done
+			 * yet. At that time we had no idea if the
+			 * entry may have been updated. If it has
+			 * been, remove CE_WATCHED so CE_VALID won't
+			 * incorrectly be set next time if the file
+			 * watcher reports no changes.
+			 */
+			if (!ce_uptodate(cache[i]))
+				cache[i]->ce_flags &=3D ~CE_WATCHED;
+			else
+				has_watches++;
+		}
=20
 		/* reduce extended entries if possible */
 		cache[i]->ce_flags &=3D ~CE_EXTENDED;
--=20
1.8.5.2.240.g8478abd
