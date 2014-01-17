From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP v2 04/14] read-cache: ask file watcher to watch files
Date: Fri, 17 Jan 2014 16:47:30 +0700
Message-ID: <1389952060-12297-5-git-send-email-pclouds@gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 10:48:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W462f-0002T2-7R
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 10:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbaAQJsi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 04:48:38 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:47542 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbaAQJsa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 04:48:30 -0500
Received: by mail-pd0-f172.google.com with SMTP id z10so3792451pdj.31
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 01:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NxSLhaaY5RlV7mZ8tIRUoiF7FnlVvrSa5w+GqW3rjIs=;
        b=K+qBacOaQxtrIAW8e7wkUPdcdnuw1B0NRdK0S6HPRxh0l3ldGL+l/sEyoKFDd5fg3m
         JEn+kx5bnvjyvGCJ9Fz+fWaQuTwQTd0Ckr2FXzcTuU29G5JhS5raYAsSDj11cHZajfoZ
         uXXaWfxtr0W6Ms0TmZ440ndeAGtd+/+AFeZ1lWLyhM8EsVxhIpVwTa31QSo5TaCdwZdx
         +R7kDhY68rfxMwFSn8DnHTut5pVLKEZ8gUTA/8ZGtWkmWB2sVSFJMNYjs7eUxA6PggH6
         6oaJJzGTJBQnj1zmIWsbuBFMzODIVV3Gg6s1nNVDfA79uy3UqAJ5ezXEjECjy3/eSZ3N
         LErg==
X-Received: by 10.67.3.34 with SMTP id bt2mr1035749pad.3.1389952109644;
        Fri, 17 Jan 2014 01:48:29 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id zc5sm21310220pbc.41.2014.01.17.01.48.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 01:48:29 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 17 Jan 2014 16:48:24 +0700
X-Mailer: git-send-email 1.8.5.1.208.g05b12ea
In-Reply-To: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240584>

We want to watch files that are never changed because lstat() on those
files is a wasted effort. So we sort unwatched files by date and start
adding them to the file watcher until it barfs (e.g. hits inotify
limit). Recently updated entries are also excluded from watch list.
CE_VALID is used in combination with CE_WATCHED. Those entries that
have CE_VALID already set will never be watched.

We send as many paths as possible in one packet in pkt-line format to
reduce roundtrips. For small projects like git, all entries can be
packed in one packet. For large projects like webkit (182k entries) it
takes two packets. We may do prefix compression as well to send more
in fewer packets..

The file watcher replies how many entries it can watch (because at
least inotify has system limits).

Note that we still do lstat() on these new watched files because they
could have changed before the file watcher could watch them. Watched
files may only skip lstat() at the next git run.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 file-watcher.c |  31 ++++++++++++++++
 pkt-line.c     |   2 +-
 pkt-line.h     |   2 ++
 read-cache.c   | 111 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 4 files changed, 143 insertions(+), 3 deletions(-)

diff --git a/file-watcher.c b/file-watcher.c
index 36a9a8d..3a54168 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -3,6 +3,7 @@
 #include "parse-options.h"
 #include "exec_cmd.h"
 #include "file-watcher-lib.h"
+#include "pkt-line.h"
=20
 static const char *const file_watcher_usage[] =3D {
 	N_("git file-watcher [options]"),
@@ -11,6 +12,34 @@ static const char *const file_watcher_usage[] =3D {
=20
 static char index_signature[41];
=20
+static int watch_path(char *path)
+{
+	/*
+	 * Consider send "wait" every 10ms or so, in case there are
+	 * many paths to process that takes more than 20ms or the
+	 * sender won't keep waiting. This is usually one-time cost,
+	 * waiting a bit is ok.
+	 */
+	return -1;
+}
+
+static void watch_paths(char *buf, int maxlen,
+			int fd, struct sockaddr_un *sock)
+{
+	char *end =3D buf + maxlen;
+	int n, ret, len;
+	for (n =3D ret =3D 0; buf < end && !ret; buf +=3D len) {
+		char ch;
+		len =3D packet_length(buf);
+		ch =3D buf[len];
+		buf[len] =3D '\0';
+		if (!(ret =3D watch_path(buf + 4)))
+			n++;
+		buf[len] =3D ch;
+	}
+	send_watcher(fd, sock, "fine %d", n);
+}
+
 static int handle_command(int fd)
 {
 	struct sockaddr_un sun;
@@ -29,6 +58,8 @@ static int handle_command(int fd)
 			 * wrong. Clean up and start over.
 			 */
 			index_signature[0] =3D '\0';
+	} else if (starts_with(msg, "watch ")) {
+		watch_paths(msg + 6, len - 6, fd, &sun);
 	} else if (!strcmp(msg, "die")) {
 		exit(0);
 	} else {
diff --git a/pkt-line.c b/pkt-line.c
index bc63b3b..b5af84e 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -135,7 +135,7 @@ static int get_packet_data(int fd, char **src_buf, =
size_t *src_size,
 	return ret;
 }
=20
-static int packet_length(const char *linelen)
+int packet_length(const char *linelen)
 {
 	int n;
 	int len =3D 0;
diff --git a/pkt-line.h b/pkt-line.h
index 0a838d1..40470b9 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -75,6 +75,8 @@ char *packet_read_line(int fd, int *size);
  */
 char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size)=
;
=20
+int packet_length(const char *linelen);
+
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
 extern char packet_buffer[LARGE_PACKET_MAX];
diff --git a/read-cache.c b/read-cache.c
index 76cf0e3..21c3207 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -15,6 +15,7 @@
 #include "strbuf.h"
 #include "varint.h"
 #include "file-watcher-lib.h"
+#include "pkt-line.h"
=20
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,=
 int really);
=20
@@ -1479,6 +1480,98 @@ static void validate_watcher(struct index_state =
*istate, const char *path)
 		}
 }
=20
+static int sort_by_date(const void *a_, const void *b_)
+{
+	const struct cache_entry *a =3D *(const struct cache_entry **)a_;
+	const struct cache_entry *b =3D *(const struct cache_entry **)b_;
+	uint32_t seca =3D a->ce_stat_data.sd_mtime.sec;
+	uint32_t secb =3D b->ce_stat_data.sd_mtime.sec;
+	return seca - secb;
+}
+
+static int do_watch_entries(struct index_state *istate,
+			    struct cache_entry **cache,
+			    struct strbuf *sb, int start, int now)
+{
+	char *line;
+	int i;
+	ssize_t len;
+
+	send_watcher(istate->watcher, NULL, "%s", sb->buf);
+	line =3D read_watcher(istate->watcher, &len, NULL);
+	if (!line) {
+		if (!len) {
+			close(istate->watcher);
+			istate->watcher =3D -1;
+		}
+		return -1;
+	}
+	if (starts_with(line, "fine ")) {
+		char *end;
+		long n =3D strtoul(line + 5, &end, 10);
+		if (end !=3D line + len)
+			return -1;
+		for (i =3D 0; i < n; i++)
+			cache[start + i]->ce_flags |=3D CE_WATCHED;
+		istate->cache_changed =3D 1;
+		if (i !=3D now)
+			return -1;
+	} else
+		return -1;
+	start =3D i;
+	strbuf_reset(sb);
+	strbuf_addstr(sb, "watch ");
+	return 0;
+}
+
+static inline int ce_watchable(struct cache_entry *ce)
+{
+	return ce_uptodate(ce) && /* write_index will catch late ce_uptodate =
bits */
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
+static void watch_entries(struct index_state *istate)
+{
+	int i, start, nr;
+	struct cache_entry **sorted;
+	struct strbuf sb =3D STRBUF_INIT;
+	int val;
+	socklen_t vallen =3D sizeof(val);
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
+
+	getsockopt(istate->watcher, SOL_SOCKET, SO_SNDBUF, &val, &vallen);
+	strbuf_grow(&sb, val);
+	strbuf_addstr(&sb, "watch ");
+
+	qsort(sorted, nr, sizeof(*sorted), sort_by_date);
+	for (i =3D start =3D 0; i < nr; i++) {
+		if (sb.len + 4 + ce_namelen(sorted[i]) >=3D val &&
+		    do_watch_entries(istate, sorted, &sb, start, i))
+			break;
+		packet_buf_write(&sb, "%s", sorted[i]->name);
+	}
+	if (i =3D=3D nr && start < i)
+		do_watch_entries(istate, sorted, &sb, start, i);
+	strbuf_release(&sb);
+	free(sorted);
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
@@ -1565,6 +1658,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	}
 	munmap(mmap, mmap_size);
 	validate_watcher(istate, path);
+	watch_entries(istate);
 	return istate->cache_nr;
=20
 unmap:
@@ -1844,8 +1938,21 @@ int write_index(struct index_state *istate, int =
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
1.8.5.1.208.g05b12ea
