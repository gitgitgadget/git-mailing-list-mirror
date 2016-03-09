From: David Turner <dturner@twopensource.com>
Subject: [PATCH 19/19] hack: watchman/untracked cache mashup
Date: Wed,  9 Mar 2016 13:36:22 -0500
Message-ID: <1457548582-28302-20-git-send-email-dturner@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 09 19:38:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adizg-00088t-JV
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933891AbcCIShc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 13:37:32 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33356 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933793AbcCISgw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:52 -0500
Received: by mail-qg0-f47.google.com with SMTP id t4so49456857qge.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iB8y1oh8rSldw2Dls0VUpFU01oZDZhez4zvBoP8XvcU=;
        b=Y26P2znlFb2DDBRYTZndIARVccqtUoSeX+CJOLnHQPyhYWeYbKcQN6M9RU9/NdqyrB
         SZrOc+xjlakLtu03uhmFfb9n0D4eUsToBkTdkg8oGmCB5McjD+TQN0LbD1s3I7kkc4TQ
         o7wqLuyaOr3GbiZK2o+LZpXg0s8NPsRQtrOpQTGj2rFSWSee/WS4RVX1l5SvN4RMDzlu
         nwKi3zGz5hdvdbFu91PFDU2rMGVzhhEIZd2jm9a97r69rvEMoArLDuv5Hld/3ds3xCtU
         p3zPYwN/c3cIc/lHxD4AS+rFSPmBRdEt2TAk+emla4PbKDGVWe23OHM02u8PxROHNDHM
         BKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iB8y1oh8rSldw2Dls0VUpFU01oZDZhez4zvBoP8XvcU=;
        b=cFL1/WWV+A4ugGvN5ZjQMaNT+Rb1HnM3YMqu/f9JeZDc63NUubAIubAKSTJBBqhXGu
         Ot7lBubQEqlxl/jKO5lR6uwATtdPaQnZHQuQ/gEdmLxS7+0E1OUb26L0spoUvQOcpSnd
         cP+s2qVTiNJVWS0qRqCwTtHQZBXJe2QiAGqospzB0W21d86rnXAhLhe4CxgdBfw9/II0
         Qjv39FDlCDuf28LuSiwOQQn8eSeZjtew4uTf4rFUwYP1WKRh4QZbshTqhBGcZbJ+00+x
         LAdwY/mFGiYJVwoevSSl9oRJgfK9IJrQPA6UOeuBHPIomIfxMCBQm4ltkOQFarvxhGRh
         E2Aw==
X-Gm-Message-State: AD7BkJLJBAryWfajK19SlgCAfzeRzbLDFg5QrtyL5BLDzTfkWSiJYcFEuYaJOAG7kdBuAw==
X-Received: by 10.140.18.163 with SMTP id 32mr44744424qgf.11.1457548610918;
        Wed, 09 Mar 2016 10:36:50 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:50 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288567>

DO NOT APPLY THIS

This is a hack to add untracked cache info to the watchman WAMA
extension.  The idea is that we don't have to stat directories if
watchman hasn't told us of any changes in those dirs.

If this is the right idea, I can go back and add it to the relevant
patch(es).  But I want to see if other folks think it's the right idea
first.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 dir.c              |  23 +++++++--
 dir.h              |   6 +++
 read-cache.c       | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 watchman-support.c |  21 +++++++-
 4 files changed, 182 insertions(+), 10 deletions(-)

diff --git a/dir.c b/dir.c
index 69e0be6..5058b29 100644
--- a/dir.c
+++ b/dir.c
@@ -597,9 +597,9 @@ static void trim_trailing_spaces(char *buf)
  *
  * If "name" has the trailing slash, it'll be excluded in the search.
  */
-static struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
-						    struct untracked_cache_dir *dir,
-						    const char *name, int len)
+struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
+					     struct untracked_cache_dir *dir,
+					     const char *name, int len)
 {
 	int first, last;
 	struct untracked_cache_dir *d;
@@ -1726,6 +1726,17 @@ static int valid_cached_dir(struct dir_struct *dir,
 	if (!untracked)
 		return 0;
 
+	if (dir->untracked->use_watchman) {
+		/*
+		 * With watchman, we can trust the untracked cache's
+		 * valid field.
+		 */
+		if (untracked->valid)
+			goto skip_stat;
+		else
+			invalidate_directory(dir->untracked, untracked);
+	}
+
 	if (stat(path->len ? path->buf : ".", &st)) {
 		invalidate_directory(dir->untracked, untracked);
 		memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
@@ -1739,6 +1750,7 @@ static int valid_cached_dir(struct dir_struct *dir,
 		return 0;
 	}
 
+skip_stat:
 	if (untracked->check_only != !!check_only) {
 		invalidate_directory(dir->untracked, untracked);
 		return 0;
@@ -2625,8 +2637,10 @@ static void free_untracked(struct untracked_cache_dir *ucd)
 
 void free_untracked_cache(struct untracked_cache *uc)
 {
-	if (uc)
+	if (uc) {
 		free_untracked(uc->root);
+		string_list_clear(&uc->invalid_untracked, 0);
+	}
 	free(uc);
 }
 
@@ -2775,6 +2789,7 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 		return NULL;
 
 	uc = xcalloc(1, sizeof(*uc));
+	string_list_init(&uc->invalid_untracked, 1);
 	strbuf_init(&uc->ident, ident_len);
 	strbuf_add(&uc->ident, ident, ident_len);
 	load_sha1_stat(&uc->ss_info_exclude, &ouc->info_exclude_stat,
diff --git a/dir.h b/dir.h
index 3ec3fb0..8fd3f9e 100644
--- a/dir.h
+++ b/dir.h
@@ -142,6 +142,9 @@ struct untracked_cache {
 	int gitignore_invalidated;
 	int dir_invalidated;
 	int dir_opened;
+	/* watchman invalidation data */
+	unsigned int use_watchman : 1;
+	struct string_list invalid_untracked;
 };
 
 struct dir_struct {
@@ -312,4 +315,7 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
+struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
+					     struct untracked_cache_dir *dir,
+					     const char *name, int len);
 #endif
diff --git a/read-cache.c b/read-cache.c
index 40d789a..66438d8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1237,7 +1237,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		if (!new) {
 			const char *fmt;
 
-			if (really && cache_errno == EINVAL) {
+			if (really || cache_errno == EINVAL) {
 				/* If we are doing --really-refresh that
 				 * means the index is not valid anymore.
 				 */
@@ -1377,11 +1377,82 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 	return 0;
 }
 
+static struct untracked_cache_dir *find_untracked_cache_dir(
+	struct untracked_cache *uc, struct untracked_cache_dir *ucd,
+	const char *name)
+{
+	int component_len;
+	const char *end;
+	struct untracked_cache_dir *dir;
+
+	if (!*name)
+		return ucd;
+
+	end = strchr(name, '/');
+	if (end)
+		component_len = end - name;
+	else
+		component_len = strlen(name);
+
+	dir = lookup_untracked(uc, ucd, name, component_len);
+	if (dir)
+		return find_untracked_cache_dir(uc, dir, name + component_len + 1);
+
+	return NULL;
+}
+
 static void mark_no_watchman(size_t pos, void *data)
 {
 	struct index_state *istate = data;
+	struct cache_entry *ce = istate->cache[pos];
+	struct strbuf sb = STRBUF_INIT;
+	char *c;
+	struct untracked_cache_dir *dir;
+
 	assert(pos < istate->cache_nr);
-	istate->cache[pos]->ce_flags |= CE_WATCHMAN_DIRTY;
+	ce->ce_flags |= CE_WATCHMAN_DIRTY;
+
+	if (!istate->untracked || !istate->untracked->root)
+		return;
+
+	strbuf_add(&sb, ce->name, ce_namelen(ce));
+
+	for (c = sb.buf + sb.len - 1; c > sb.buf; c--) {
+		if (*c == '/') {
+			strbuf_setlen(&sb, c - sb.buf);
+			break;
+		}
+	}
+
+	if (c == sb.buf) {
+		strbuf_setlen(&sb, 0);
+	}
+
+	dir = find_untracked_cache_dir(istate->untracked,
+				       istate->untracked->root, sb.buf);
+	if (dir) {
+		fprintf(stderr, "from '%s', dir '%s', invalidated '%s'\n",
+			ce->name, sb.buf, dir->name);
+		dir->valid = 0;
+	} else {
+		fprintf(stderr, "from '%s', dir '%s', not found\n",
+			ce->name, sb.buf);
+	}
+
+	strbuf_release(&sb);
+}
+
+static int mark_untracked_invalid(struct string_list_item *item, void *uc)
+{
+	struct untracked_cache *untracked = uc;
+	struct untracked_cache_dir *dir;
+
+	dir = find_untracked_cache_dir(untracked, untracked->root,
+				       item->string);
+	if (dir)
+		dir->valid = 0;
+
+	return 0;
 }
 
 static int read_watchman_ext(struct index_state *istate, const void *data,
@@ -1389,19 +1460,56 @@ static int read_watchman_ext(struct index_state *istate, const void *data,
 {
 	struct ewah_bitmap *bitmap;
 	int ret, len;
+	uint32_t bitmap_size;
+	uint32_t untracked_nr;
+	const char *untracked;
 
 	if (memchr(data, 0, sz) == NULL)
 		return error("invalid extension");
+
 	len = strlen(data) + 1;
+	memcpy(&bitmap_size, (const char *)data + len, 4);
+	memcpy(&untracked_nr, (const char *)data + len + 4, 4);
+	untracked_nr = ntohl(untracked_nr);
+	bitmap_size = ntohl(bitmap_size);
+
 	bitmap = ewah_new();
-	ret = ewah_read_mmap(bitmap, (const char *)data + len, sz - len);
-	if (ret != sz - len) {
+	ret = ewah_read_mmap(bitmap, (const char *)data + len + 8, bitmap_size);
+	if (ret != bitmap_size) {
 		ewah_free(bitmap);
 		return error("failed to parse ewah bitmap reading watchman index extension");
 	}
 	istate->last_update = xstrdup(data);
 	ewah_each_bit(bitmap, mark_no_watchman, istate);
 	ewah_free(bitmap);
+
+	if (istate->untracked && istate->untracked->root) {
+		int i;
+
+		istate->untracked->use_watchman = 1;
+		untracked = data + len + 8 + bitmap_size;
+		for (i = 0; i < untracked_nr; ++i) {
+			int len = strlen(untracked);
+			string_list_append(&istate->untracked->invalid_untracked,
+					   untracked);
+			untracked += len + 1;
+		}
+
+		for_each_string_list(&istate->untracked->invalid_untracked,
+			 mark_untracked_invalid, istate->untracked);
+
+		string_list_clear(&istate->untracked->invalid_untracked, 0);
+		istate->cache_changed |= WATCHMAN_CHANGED;
+	}
+	return 0;
+}
+
+int untracked_entry_append(struct string_list_item *item, void *sbvoid)
+{
+	struct strbuf *sb = sbvoid;
+
+	strbuf_addstr(sb, item->string);
+	strbuf_addch(sb, 0);
 	return 0;
 }
 
@@ -1409,14 +1517,38 @@ void write_watchman_ext(struct strbuf *sb, struct index_state* istate)
 {
 	struct ewah_bitmap *bitmap;
 	int i;
+	int ewah_start;
+	int ewah_size = 0;
+	int fixup = 0;
 
 	strbuf_add(sb, istate->last_update, strlen(istate->last_update) + 1);
+	fixup = sb->len;
+	strbuf_add(sb, &ewah_size, 4); /* we'll fix this up later */
+	if (istate->untracked) {
+		uint32_t nr = istate->untracked->invalid_untracked.nr;
+		nr = htonl(nr);
+		strbuf_add(sb, &nr, 4);
+	} else {
+		/* zero */
+		strbuf_add(sb, &ewah_size, 4);
+	}
+
+	ewah_start = sb->len;
 	bitmap = ewah_new();
 	for (i = 0; i < istate->cache_nr; i++)
 		if (istate->cache[i]->ce_flags & CE_WATCHMAN_DIRTY)
 			ewah_set(bitmap, i);
 	ewah_serialize_strbuf(bitmap, sb);
 	ewah_free(bitmap);
+
+	/* fix up size field */
+	ewah_size = sb->len - ewah_start;
+	ewah_size = htonl(ewah_size);
+	memcpy(sb->buf + fixup, &ewah_size, 4);
+
+	if (istate->untracked)
+		for_each_string_list(&istate->untracked->invalid_untracked,
+				     untracked_entry_append, sb);
 }
 
 static int read_index_extension(struct index_state *istate,
@@ -1956,7 +2088,7 @@ int unmerged_index(const struct index_state *istate)
 	return 0;
 }
 
-#define WRITE_BUFFER_SIZE 8192
+#define WRITE_BUFFER_SIZE 8192*16
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
 static unsigned long write_buffer_len;
 
diff --git a/watchman-support.c b/watchman-support.c
index 08e37ae..b7302b9 100644
--- a/watchman-support.c
+++ b/watchman-support.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "watchman-support.h"
 #include "strbuf.h"
+#include "dir.h"
 #include <watchman.h>
 
 static struct watchman_query *make_query(const char *last_update)
@@ -60,8 +61,24 @@ static void update_index(struct index_state *istate,
 			continue;
 
 		pos = index_name_pos(istate, wm->name, strlen(wm->name));
-		if (pos < 0)
+		if (pos < 0) {
+			if (istate->untracked) {
+				char *name = xstrdup(wm->name);
+				char *dname = dirname(name);
+
+				/*
+				 * dirname() returns '.' for the root,
+				 * but we call it ''.
+				 */
+				if (dname[0] == '.' && dname[1] == 0)
+					string_list_append(&istate->untracked->invalid_untracked, "");
+				else
+					string_list_append(&istate->untracked->invalid_untracked,
+							   dname);
+				free(name);
+			}
 			continue;
+		}
 		/* FIXME: ignore staged entries and gitlinks too? */
 
 		istate->cache[pos]->ce_flags |= CE_WATCHMAN_DIRTY;
@@ -71,6 +88,8 @@ done:
 	free(istate->last_update);
 	istate->last_update    = xstrdup(result->clock);
 	istate->cache_changed |= WATCHMAN_CHANGED;
+	if (istate->untracked)
+		string_list_remove_duplicates(&istate->untracked->invalid_untracked, 0);
 }
 
 int check_watchman(struct index_state *istate)
-- 
2.4.2.767.g62658d5-twtrsrc
