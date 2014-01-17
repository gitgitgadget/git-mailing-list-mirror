From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP v2 05/14] read-cache: put some limits on file watching
Date: Fri, 17 Jan 2014 16:47:31 +0700
Message-ID: <1389952060-12297-6-git-send-email-pclouds@gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 10:49:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W462y-0002uW-9y
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 10:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbaAQJsr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 04:48:47 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:56514 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbaAQJsf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 04:48:35 -0500
Received: by mail-pb0-f52.google.com with SMTP id jt11so1830626pbb.11
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 01:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BKL8bWXYnLjlpTEZBJjhXlFMC07cnMzyuLIlpyz62/8=;
        b=tScbibJbj07DfxOVhmpk7Oiojvm2m7qJa33/E/vvlJTtoLmyDJ4TVv4a3Y5gQK5L6H
         hHcnrYTXSHOzCyl0UE7B4+adWVd8FxPn6lLZtD8BsX49B6YNMZAEAx0fchKCErgKsdW5
         8538O3QZzFPfNB0PM05uJ6jdLOL7mzhlxmHU3jw/AbXSHUKvIu7Rmf5s/gH0FNc5oC5L
         1+lS3DS/9OpdhlKJ8FxrKaZLPr0oUA2f73KjVxokyWmLEBUZWL2ZN/49qPxqvJU5gCEU
         SMh2hPB1LcV2loyMd+WJR6maPYEgAwjqR9c+SMJxGuBn61hEJHdfTa3ULTVYB7mEQIKG
         H8lQ==
X-Received: by 10.66.165.4 with SMTP id yu4mr1112264pab.88.1389952115371;
        Fri, 17 Jan 2014 01:48:35 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id ns7sm21324281pbc.32.2014.01.17.01.48.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 01:48:34 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 17 Jan 2014 16:48:29 +0700
X-Mailer: git-send-email 1.8.5.1.208.g05b12ea
In-Reply-To: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240585>

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

Recently updated files are not considered watchable because they are
likely to be updated again soon, not worth the ping-pong game with
file watcher. The default limit 30min is just a random value.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |  9 +++++++++
 cache.h                  |  1 +
 read-cache.c             | 44 ++++++++++++++++++++++++++++++++++++----=
----
 3 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a405806..e394399 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1038,6 +1038,15 @@ difftool.<tool>.cmd::
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
=20
+filewatcher.minfiles::
+	Start watching files if the number of watchable files are
+	above this limit. Default value is 65536.
+
+filewatcher.recentlimit::
+	Files that are last updated within filewatcher.recentlimit
+	seconds from now are not considered watchable. Default value
+	is 1800 (30 minutes).
+
 fetch.recurseSubmodules::
 	This option can be either set to a boolean value or to 'on-demand'.
 	Setting it to a boolean changes the behavior of fetch and pull to
diff --git a/cache.h b/cache.h
index 0d55551..bcec29b 100644
--- a/cache.h
+++ b/cache.h
@@ -278,6 +278,7 @@ struct index_state {
 	struct cache_tree *cache_tree;
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
+		 update_watches : 1,
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
diff --git a/read-cache.c b/read-cache.c
index 21c3207..406834a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -38,6 +38,8 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce, int reall
 #define CACHE_EXT_WATCH 0x57415443	  /* "WATC" */
=20
 struct index_state the_index;
+static int watch_lowerlimit =3D 65536;
+static int recent_limit =3D 1800;
=20
 static void set_index_entry(struct index_state *istate, int nr, struct=
 cache_entry *ce)
 {
@@ -1014,6 +1016,7 @@ int add_index_entry(struct index_state *istate, s=
truct cache_entry *ce, int opti
 			(istate->cache_nr - pos - 1) * sizeof(ce));
 	set_index_entry(istate, pos, ce);
 	istate->cache_changed =3D 1;
+	istate->update_watches =3D 1;
 	return 0;
 }
=20
@@ -1300,13 +1303,14 @@ static void read_watch_extension(struct index_s=
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
@@ -1449,6 +1453,19 @@ static struct cache_entry *create_from_disk(stru=
ct ondisk_cache_entry *ondisk,
 	return ce;
 }
=20
+static int watcher_config(const char *var, const char *value, void *da=
ta)
+{
+	if (!strcmp(var, "filewatcher.minfiles")) {
+		watch_lowerlimit =3D git_config_int(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "filewatcher.recentlimit")) {
+		recent_limit =3D git_config_int(var, value);
+		return 0;
+	}
+	return 0;
+}
+
 static void validate_watcher(struct index_state *istate, const char *p=
ath)
 {
 	int i;
@@ -1458,6 +1475,7 @@ static void validate_watcher(struct index_state *=
istate, const char *path)
 		return;
 	}
=20
+	git_config(watcher_config, NULL);
 	istate->watcher =3D connect_watcher(path);
 	if (istate->watcher !=3D -1) {
 		struct strbuf sb =3D STRBUF_INIT;
@@ -1478,6 +1496,7 @@ static void validate_watcher(struct index_state *=
istate, const char *path)
 			istate->cache[i]->ce_flags &=3D ~CE_WATCHED;
 			istate->cache_changed =3D 1;
 		}
+	istate->update_watches =3D 1;
 }
=20
 static int sort_by_date(const void *a_, const void *b_)
@@ -1524,7 +1543,7 @@ static int do_watch_entries(struct index_state *i=
state,
 	return 0;
 }
=20
-static inline int ce_watchable(struct cache_entry *ce)
+static inline int ce_watchable(struct cache_entry *ce, time_t now)
 {
 	return ce_uptodate(ce) && /* write_index will catch late ce_uptodate =
bits */
 		!(ce->ce_flags & CE_WATCHED) &&
@@ -1534,7 +1553,8 @@ static inline int ce_watchable(struct cache_entry=
 *ce)
 		 * obviously. S_IFLNK could be problematic because
 		 * inotify may follow symlinks without IN_DONT_FOLLOW
 		 */
-		S_ISREG(ce->ce_mode);
+		S_ISREG(ce->ce_mode) &&
+		(ce->ce_stat_data.sd_mtime.sec + recent_limit < now);
 }
=20
 static void watch_entries(struct index_state *istate)
@@ -1544,15 +1564,20 @@ static void watch_entries(struct index_state *i=
state)
 	struct strbuf sb =3D STRBUF_INIT;
 	int val;
 	socklen_t vallen =3D sizeof(val);
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
=20
 	getsockopt(istate->watcher, SOL_SOCKET, SO_SNDBUF, &val, &vallen);
@@ -1616,6 +1641,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	istate->cache_alloc =3D alloc_nr(istate->cache_nr);
 	istate->cache =3D xcalloc(istate->cache_alloc, sizeof(*istate->cache)=
);
 	istate->initialized =3D 1;
+	istate->update_watches =3D 1;
=20
 	if (istate->version =3D=3D 4)
 		previous_name =3D &previous_name_buf;
@@ -2024,8 +2050,9 @@ int write_index(struct index_state *istate, int n=
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
@@ -2038,6 +2065,7 @@ int write_index(struct index_state *istate, int n=
ewfd)
 			}
 			id++;
 		}
+		data[sz - 1] =3D istate->update_watches;
 		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_WATCH, sz) < 0
 			|| ce_write(&c, newfd, data, sz) < 0;
 		free(data);
--=20
1.8.5.1.208.g05b12ea
