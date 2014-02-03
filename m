From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 14/26] read-cache: put some limits on file watching
Date: Mon,  3 Feb 2014 11:29:02 +0700
Message-ID: <1391401754-15347-15-git-send-email-pclouds@gmail.com>
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
	id 1WABBH-0001IN-Il
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbaBCEak convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:30:40 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:40647 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbaBCEaj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:30:39 -0500
Received: by mail-pb0-f48.google.com with SMTP id rr13so6562299pbb.7
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1VVudYHCuPRukpMVRthgBgwp8XdD1fFUZGI0OvGqZSo=;
        b=EEp2u1J2iFC80J7aTQxW+29o1eprepXbrkQiiSr0TChSAGMpEz8SCvQ6LR9qviK0bq
         3POgUxfoa/eEjPwETk3RuDIA2kI/LQmhGHXpCaYy47TAToqteKOPgBRBb92Lc5IvHMTu
         hw56MgAJYUmtiZ4Bi+CXyW4YFN9JlrGETnoSMSQ00CnS0JTmAtKabdiJs1PIvtWTOBuq
         i+AnSfwve3vlePVypOVV637YQ6ZU3VE9sFHoFQFADzfr9fNgRLJH9wDucAhgI5BD9aFp
         g03qyQIaDIhH+1cywUrTpJ6B7WUDX4KdhWqrpUOSX2uH3MTzPbgeirw4R2lCnVrWoZF+
         NZ+w==
X-Received: by 10.68.143.231 with SMTP id sh7mr35413818pbb.7.1391401839110;
        Sun, 02 Feb 2014 20:30:39 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id ac5sm22009424pbc.37.2014.02.02.20.30.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:30:38 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:30:36 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241409>

watch_entries() is a lot of computation and could trigger a lot more
lookups in file-watcher. Normally after the first set of watches are
in place, we do not need to update often. Moreover if the number of
entries is small, the overhead of file watcher may actually slow git
down.

This patch only allows to update watches if the number of watchable
files is over a limit (and there are new files added if this is not
the first time). Measurements on Core i5-2520M and Linux 3.7.6, about
920 lstat() take 1ms. Somewhere between 2^16 and 2^17 lstat calls that
it starts to take longer than 100ms. 2^16 is chosen at the minimum
limit to start using file watcher.

Of course this is only sensible default for single-repo use
case. Lower it when you need to work with many small repos.

Recently updated files are not considered watchable because they are
likely to be updated again soon, not worth the ping-pong game with
file watcher. The default limit 10min is just a random value. Recent
limit is ignored if there are no watched files (e.g. a fresh clone, or
after a bad hand shake with file watcher).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt                 |  9 +++++++
 Documentation/technical/index-format.txt |  3 +++
 cache.h                                  |  1 +
 file-watcher-lib.c                       | 42 ++++++++++++++++++++++++=
++------
 read-cache.c                             | 11 ++++++---
 5 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6ad653a..451c100 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1052,6 +1052,15 @@ filewatcher.timeout::
 	the file watcher to respond before giving up. Default value is
 	50. Setting to -1 makes Git wait forever.
=20
+filewatcher.minfiles::
+	Start watching files if the number of watchable files are
+	above this limit. Default value is 65536.
+
+filewatcher.recentlimit::
+	Files that are last updated within filewatcher.recentlimit
+	seconds from now are not considered watchable. Default value
+	is 600 (5 minutes).
+
 fetch.recurseSubmodules::
 	This option can be either set to a boolean value or to 'on-demand'.
 	Setting it to a boolean changes the behavior of fetch and pull to
diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
index 24fd0ae..7081e55 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -204,3 +204,6 @@ Git index format
=20
   - A bit map of all entries in the index, n-th bit of m-th byte
     corresponds to CE_WATCHED of the <m * 8+ n>-th index entry.
+
+  - 1-byte, non-zero indicates the index should be scanned for new
+    watched entries.
diff --git a/cache.h b/cache.h
index b3ea574..10ff33e 100644
--- a/cache.h
+++ b/cache.h
@@ -279,6 +279,7 @@ struct index_state {
 	struct cache_tree *cache_tree;
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
+		 update_watches : 1,
 		 initialized : 1;
 	struct hash_table name_hash;
 	struct hash_table dir_hash;
diff --git a/file-watcher-lib.c b/file-watcher-lib.c
index 791faae..d4949a5 100644
--- a/file-watcher-lib.c
+++ b/file-watcher-lib.c
@@ -5,6 +5,8 @@
=20
 static char *watcher_path;
 static int WAIT_TIME =3D 50;	/* in ms */
+static int watch_lowerlimit =3D 65536;
+static int recent_limit =3D 600;
=20
 static int connect_watcher(const char *path)
 {
@@ -22,12 +24,17 @@ static int connect_watcher(const char *path)
=20
 static void reset_watches(struct index_state *istate, int disconnect)
 {
-	int i;
+	int i, changed =3D 0;
 	for (i =3D 0; i < istate->cache_nr; i++)
 		if (istate->cache[i]->ce_flags & CE_WATCHED) {
 			istate->cache[i]->ce_flags &=3D ~(CE_WATCHED | CE_VALID);
-			istate->cache_changed =3D 1;
+			changed =3D 1;
 		}
+	recent_limit =3D 0;
+	if (changed) {
+		istate->update_watches =3D 1;
+		istate->cache_changed =3D 1;
+	}
 	if (disconnect && istate->watcher > 0) {
 		close(istate->watcher);
 		istate->watcher =3D -1;
@@ -49,6 +56,14 @@ static int watcher_config(const char *var, const cha=
r *value, void *data)
 		WAIT_TIME =3D git_config_int(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "filewatcher.minfiles")) {
+		watch_lowerlimit =3D git_config_int(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "filewatcher.recentlimit")) {
+		recent_limit =3D git_config_int(var, value);
+		return 0;
+	}
 	return 0;
 }
=20
@@ -63,12 +78,18 @@ void open_watcher(struct index_state *istate)
 	}
=20
 	if (!read_config) {
+		int i;
 		/*
 		 * can't hook into git_default_config because
 		 * read_cache() may be called even before git_config()
 		 * call.
 		 */
 		git_config(watcher_config, NULL);
+		for (i =3D 0; i < istate->cache_nr; i++)
+			if (istate->cache[i]->ce_flags & CE_WATCHED)
+				break;
+		if (i =3D=3D istate->cache_nr)
+			recent_limit =3D 0;
 		read_config =3D 1;
 	}
=20
@@ -86,6 +107,7 @@ void open_watcher(struct index_state *istate)
 	    (msg =3D packet_read_line_timeout(istate->watcher, WAIT_TIME, NUL=
L)) =3D=3D NULL ||
 	    strcmp(msg, "ok")) {
 		reset_watches(istate, 0);
+		istate->update_watches =3D 1;
 		return;
 	}
 }
@@ -99,7 +121,7 @@ static int sort_by_date(const void *a_, const void *=
b_)
 	return seca - secb;
 }
=20
-static inline int ce_watchable(struct cache_entry *ce)
+static inline int ce_watchable(struct cache_entry *ce, time_t now)
 {
 	return
 		!(ce->ce_flags & CE_WATCHED) &&
@@ -109,7 +131,8 @@ static inline int ce_watchable(struct cache_entry *=
ce)
 		 * obviously. S_IFLNK could be problematic because
 		 * inotify may follow symlinks without IN_DONT_FOLLOW
 		 */
-		S_ISREG(ce->ce_mode);
+		S_ISREG(ce->ce_mode) &&
+		(ce->ce_stat_data.sd_mtime.sec + recent_limit <=3D now);
 }
=20
 static void send_watches(struct index_state *istate,
@@ -158,15 +181,20 @@ void watch_entries(struct index_state *istate)
 {
 	int i, nr;
 	struct cache_entry **sorted;
+	time_t now =3D time(NULL);
=20
-	if (istate->watcher <=3D 0)
+	if (istate->watcher <=3D 0 || !istate->update_watches)
 		return;
+	istate->update_watches =3D 0;
+	istate->cache_changed =3D 1;
 	for (i =3D nr =3D 0; i < istate->cache_nr; i++)
-		if (ce_watchable(istate->cache[i]))
+		if (ce_watchable(istate->cache[i], now))
 			nr++;
+	if (nr < watch_lowerlimit)
+		return;
 	sorted =3D xmalloc(sizeof(*sorted) * nr);
 	for (i =3D nr =3D 0; i < istate->cache_nr; i++)
-		if (ce_watchable(istate->cache[i]))
+		if (ce_watchable(istate->cache[i], now))
 			sorted[nr++] =3D istate->cache[i];
 	qsort(sorted, nr, sizeof(*sorted), sort_by_date);
 	send_watches(istate, sorted, nr);
diff --git a/read-cache.c b/read-cache.c
index cb2188f..dc49858 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1009,6 +1009,7 @@ int add_index_entry(struct index_state *istate, s=
truct cache_entry *ce, int opti
 			(istate->cache_nr - pos - 1) * sizeof(ce));
 	set_index_entry(istate, pos, ce);
 	istate->cache_changed =3D 1;
+	istate->update_watches =3D 1;
 	return 0;
 }
=20
@@ -1295,13 +1296,14 @@ static void read_watch_extension(struct index_s=
tate *istate, uint8_t *data,
 				 unsigned long sz)
 {
 	int i;
-	if ((istate->cache_nr + 7) / 8 !=3D sz) {
+	if ((istate->cache_nr + 7) / 8 + 1 !=3D sz) {
 		error("invalid 'WATC' extension");
 		return;
 	}
 	for (i =3D 0; i < istate->cache_nr; i++)
 		if (data[i / 8] & (1 << (i % 8)))
 			istate->cache[i]->ce_flags |=3D CE_WATCHED;
+	istate->update_watches =3D data[sz - 1];
 }
=20
 static int read_index_extension(struct index_state *istate,
@@ -1488,6 +1490,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	istate->cache_alloc =3D alloc_nr(istate->cache_nr);
 	istate->cache =3D xcalloc(istate->cache_alloc, sizeof(*istate->cache)=
);
 	istate->initialized =3D 1;
+	istate->update_watches =3D 1;
=20
 	if (istate->version =3D=3D 4)
 		previous_name =3D &previous_name_buf;
@@ -1896,8 +1899,9 @@ int write_index(struct index_state *istate, int n=
ewfd)
 		if (err)
 			return -1;
 	}
-	if (has_watches) {
-		int id, sz =3D (entries - removed + 7) / 8;
+	if (has_watches ||
+	    (istate->watcher !=3D -1 && !istate->update_watches)) {
+		int id, sz =3D (entries - removed + 7) / 8 + 1;
 		uint8_t *data =3D xmalloc(sz);
 		memset(data, 0, sz);
 		for (i =3D 0, id =3D 0; i < entries && has_watches; i++) {
@@ -1910,6 +1914,7 @@ int write_index(struct index_state *istate, int n=
ewfd)
 			}
 			id++;
 		}
+		data[sz - 1] =3D istate->update_watches;
 		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_WATCH, sz) < 0
 			|| ce_write(&c, newfd, data, sz) < 0;
 		free(data);
--=20
1.8.5.2.240.g8478abd
