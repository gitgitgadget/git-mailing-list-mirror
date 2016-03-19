From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 08/17] read-cache: invalidate untracked cache data when reading WAMA
Date: Fri, 18 Mar 2016 21:04:41 -0400
Message-ID: <1458349490-1704-9-git-send-email-dturner@twopensource.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:06:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah5Lh-0008QA-EN
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 02:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbcCSBGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 21:06:32 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34359 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbcCSBGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 21:06:16 -0400
Received: by mail-qg0-f44.google.com with SMTP id w104so114645035qge.1
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 18:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=whHDAO4rV70TiZ+yTpgd1QEB0owgy3tBMYeLERS15KQ=;
        b=UK/wumYJo0Ezwb330ScXjEdq9jXea1Ph0jrsQcQOkRsjC/QPdn5eXCBVpeyZw8CLPn
         Yyxx8Uakjpa8nJUzfdnbvlj9chESfrSd+gLXdebIPucOGxKM1/9d5cIXgZ9owElsZf7J
         rJtXYzXvYju+obrfwFdgcy3WXs/mHc+rTDtlmKGDS7hZF7Qy/V86RyE7QeDpcg0nABSe
         en1t+MVkSQnWXNu0QggFs96oUUVLhAW2OoieqGMvDtbThIm3LUWs8Bq+Pq7chBEP0a1A
         XzVmpiPKIXAL8PaMjfBU0iUS3KgQgIQJEoEQAK2Nbk24ZP1RS/5KQwJhJy5xKSD8WD+y
         PtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=whHDAO4rV70TiZ+yTpgd1QEB0owgy3tBMYeLERS15KQ=;
        b=SHe+sKUvE93u8E1xlEkZ/YuPW0R86uU+UUkI4D+fPjE6ANEnnpvXvvNgSwdeSuUGFR
         Acj2HrejtHBjnart5phUtIP7LAbAw9XytQrFyx4Mmz/QnCoUze/mak4J9wv4Qd/4cj7z
         2hYxtK/3gslMBu6MWAxqDGXsbRT7n2G24itJS+u9jDWlYPqrBdJ1W3c7CmEiig3lYE92
         2ltwWGjoGo1TnDvdBfxxZYs4WHpq1a8n9NSOY2HfOhXmjgc9xjwO7xF1H4SR+eA847sj
         rK50TC7pCatileTNSc0VjSmEH72SXZKI297cal6J5gMANyqEucFxP8lU85aknIUsA/61
         Apng==
X-Gm-Message-State: AD7BkJLy5pADXiy/zHfVhaQGpkEUvEdfBH0Hu28gAg8cIgOf8V4rcX/8srXBMLRi1T0pyg==
X-Received: by 10.140.20.183 with SMTP id 52mr26318644qgj.38.1458349575230;
        Fri, 18 Mar 2016 18:06:15 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id 139sm7186154qho.2.2016.03.18.18.06.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 18:06:14 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289275>

When reading the watchman extension, invalidate the listed
untracked-cache entries.

We don't clear these entries yet; we can only do that once we know
that they came from a live watchman (rather than from disk).

Signed-off-by: David Turner <dturner@twopensource.com>
---
 dir.c        | 11 +++++---
 dir.h        |  3 ++
 read-cache.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 94 insertions(+), 9 deletions(-)

diff --git a/dir.c b/dir.c
index 69e0be6..9b659e6 100644
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
@@ -2625,8 +2625,10 @@ static void free_untracked(struct untracked_cache_dir *ucd)
 
 void free_untracked_cache(struct untracked_cache *uc)
 {
-	if (uc)
+	if (uc) {
 		free_untracked(uc->root);
+		string_list_clear(&uc->invalid_untracked, 0);
+	}
 	free(uc);
 }
 
@@ -2775,6 +2777,7 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 		return NULL;
 
 	uc = xcalloc(1, sizeof(*uc));
+	string_list_init(&uc->invalid_untracked, 1);
 	strbuf_init(&uc->ident, ident_len);
 	strbuf_add(&uc->ident, ident, ident_len);
 	load_sha1_stat(&uc->ss_info_exclude, &ouc->info_exclude_stat,
diff --git a/dir.h b/dir.h
index 3d540de..8fd3f9e 100644
--- a/dir.h
+++ b/dir.h
@@ -315,4 +315,7 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
+struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
+					     struct untracked_cache_dir *dir,
+					     const char *name, int len);
 #endif
diff --git a/read-cache.c b/read-cache.c
index 6d5e871..b4bd15c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1373,11 +1373,76 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
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
+	if (dir)
+		dir->valid = 0;
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
@@ -1407,10 +1472,24 @@ static int read_watchman_ext(struct index_state *istate, const void *data,
 	ewah_each_bit(bitmap, mark_no_watchman, istate);
 	ewah_free(bitmap);
 
-	/*
-	 * TODO: update the untracked cache from the untracked data in this
-	 * extension.
-	 */
+	if (istate->untracked && istate->untracked->root) {
+		int i;
+		const char *untracked;
+
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
+		if (untracked_nr)
+			istate->cache_changed |= WATCHMAN_CHANGED;
+	}
 	return 0;
 }
 
-- 
2.4.2.767.g62658d5-twtrsrc
