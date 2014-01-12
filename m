From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/6] read-cache: ask file watcher to watch files
Date: Sun, 12 Jan 2014 18:03:41 +0700
Message-ID: <1389524622-6702-6-git-send-email-pclouds@gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 12 11:59:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2Ikx-0006rZ-3I
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jan 2014 11:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbaALK65 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jan 2014 05:58:57 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:33279 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbaALK64 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jan 2014 05:58:56 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so6223349pbb.31
        for <git@vger.kernel.org>; Sun, 12 Jan 2014 02:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VHhLlgSnIXQ9BdtsWnchQLwacqjI94hAGzKYV+hlMfo=;
        b=vbvAp8H/H7o2tHitYruWOu6iTsy1ecZnkGz8sFLyuaWANIvEicPAtkMrOX8CX6lUQq
         lEh0/cJPu6IDOzzbO19tb3mqLQkyapl+swFZisAr1LOnSXBKGCFZ0uV5bROE4O7fzDk7
         J4coIKgC9oWAMTfvO0RrtRf5jVo05m5xromwMBxJ3LRcu88u01xFVNCyqnX6Sh1S+1PQ
         NtyFeYAAGc6ekZGnDWc3z6GH3ahgmn5shtO+e8lspICYmXT2delVidOM+c0MXkGn6DJ5
         QoOWBMAhv5whEqSBqB4au4bvMHAB/Yh7zd1BCKj0zFYwdWzISdZFdtb7s3YgmOqaJYwG
         eK8A==
X-Received: by 10.68.162.131 with SMTP id ya3mr23011824pbb.102.1389524336047;
        Sun, 12 Jan 2014 02:58:56 -0800 (PST)
Received: from lanh ([115.73.194.184])
        by mx.google.com with ESMTPSA id ju10sm30160510pbd.33.2014.01.12.02.58.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 Jan 2014 02:58:55 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 12 Jan 2014 18:04:13 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240344>

We want to watch files that are never changed because lstat() on those
files is a wasted effort. So we sort unwatched files by date and start
adding them to the file watcher until it barfs (e.g. hits inotify
limit). Recently updated entries are also excluded from watch list.
CE_VALID is used in combination with CE_WATCHED. Those entries that
have CE_VALID already set will never be watched.

We send as many paths as possible in one packet in pkt-line
format. For small projects like git, all entries can be packed in one
packet. For large projects like webkit (182k entries) it takes two
packets. We may do prefix compression as well to send more in fewer
packets..

The file watcher replies how many entries it can watch (because at
least inotify has system limits).

Note that we still do lstat() on these new watched files because they
could have changed before the file watcher could watch them. Watched
files may only skip lstat() at the next git run.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 file-watcher.c | 27 ++++++++++++++++
 pkt-line.c     |  2 +-
 pkt-line.h     |  2 ++
 read-cache.c   | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/file-watcher.c b/file-watcher.c
index 6aeed4d..35781fa 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -1,17 +1,41 @@
 #include "cache.h"
 #include "sigchain.h"
 #include "string-list.h"
+#include "pkt-line.h"
=20
 static char index_signature[41];
 static struct string_list updated =3D STRING_LIST_INIT_DUP;
 static int updated_sorted;
=20
+static int watch_path(char *path)
+{
+	return -1;
+}
+
 static void reset(const char *sig)
 {
 	string_list_clear(&updated, 0);
 	strlcpy(index_signature, sig, sizeof(index_signature));
 }
=20
+static void watch_paths(char *buf, int maxlen,
+			int fd, struct sockaddr *sock,
+			socklen_t socklen)
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
+	sendtof(fd, 0, sock, socklen, "fine %d", n);
+}
+
 static int handle_command(int fd, char *msg, int msgsize)
 {
 	struct sockaddr_un sun;
@@ -41,6 +65,9 @@ static int handle_command(int fd, char *msg, int msgs=
ize)
 			       strlen(updated.items[i].string),
 			       0, &sun, socklen);
 		sendtof(fd, 0, &sun, socklen, "%c", 0);
+	} else if (starts_with(msg, "watch ")) {
+		watch_paths(msg + 6, len - 6,
+			    fd, (struct sockaddr *)&sun, socklen);
 	} else if ((arg =3D skip_prefix(msg, "forget "))) {
 		struct string_list_item *item;
 		if (!updated_sorted) {
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
index caa2298..839fd7c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -14,6 +14,7 @@
 #include "resolve-undo.h"
 #include "strbuf.h"
 #include "varint.h"
+#include "pkt-line.h"
=20
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,=
 int really);
=20
@@ -1537,6 +1538,90 @@ static void connect_watcher(struct index_state *=
istate, const char *path)
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
+static inline int ce_watchable(struct cache_entry *ce, time_t now)
+{
+	return !(ce->ce_flags & CE_WATCHED) &&
+		!(ce->ce_flags & CE_VALID) &&
+		(ce->ce_stat_data.sd_mtime.sec + 1800 < now);
+}
+
+static int do_watch_entries(struct index_state *istate,
+			    struct cache_entry **cache,
+			    struct strbuf *sb, int start, int now)
+{
+	char line[1024];
+	int i, len;
+
+	write(istate->watcher, sb->buf, sb->len);
+	len =3D read(istate->watcher, line, sizeof(line) - 1);
+	if (len <=3D 0)
+		return -1;
+	line[len] =3D '\0';
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
+static void watch_entries(struct index_state *istate)
+{
+	int i, start, nr;
+	struct cache_entry **sorted;
+	struct strbuf sb =3D STRBUF_INIT;
+	int val;
+	socklen_t vallen =3D sizeof(val);
+	time_t now =3D time(NULL);
+
+	if (istate->watcher =3D=3D -1)
+		return;
+	for (i =3D nr =3D 0; i < istate->cache_nr; i++)
+		if (ce_watchable(istate->cache[i], now))
+			nr++;
+	if (nr < 50)
+		return;
+	sorted =3D xmalloc(sizeof(*sorted) * nr);
+	for (i =3D nr =3D 0; i < istate->cache_nr; i++)
+		if (ce_watchable(istate->cache[i], now))
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
 static void farewell_watcher(struct index_state *istate,
 			     const unsigned char *sha1)
 {
@@ -1637,6 +1722,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	}
 	munmap(mmap, mmap_size);
 	connect_watcher(istate, path);
+	watch_entries(istate);
 	return istate->cache_nr;
=20
 unmap:
@@ -1933,6 +2019,17 @@ int write_index(struct index_state *istate, int =
newfd)
 			 * reinstated.
 			 */
 			cache[i]->ce_flags &=3D ~CE_VALID;
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
 			has_watches++;
 		}
=20
--=20
1.8.5.2.240.g8478abd
