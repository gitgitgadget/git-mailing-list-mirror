Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A241D2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 15:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbcGMPxS (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 11:53:18 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33205 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbcGMPxR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 11:53:17 -0400
Received: by mail-qk0-f194.google.com with SMTP id n202so1388531qke.0
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 08:53:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=vDvyc+/iYvqW3Gx2uDp8SqaTEX8yeKRpLyr8Dl/VIPo=;
        b=QEM2Eih5UJlmtWvFn6rqNdwxqiFq1AZf6aDPFu4/MGECGVMrQP//LEEbLYLNjDX5zH
         nKWOOjt5pnnz1ly3mv42HOkGMmT7k3x9qZdFNpepFthHOVr6dPTL/mdFPyD2gXK52Xlo
         zOI3SQ3vbP85dS6hpeNl076S4sWexqFl9HNGGcgXGYejwmx5zoeg9BgmzgZyaY2NoqM1
         BJL4CVvYAMBSw3GnbdyM9pYoyt0j72NKx8l+aWo6hcviR7mhNTsl/LIbR9cf7x0PufLZ
         4FQ+2k8eC4T+FzNZDm6oFFZRxD5Utg/Jl+8mTpAGF4m9Xdmafi0kmOp8JvrViq2kZwKN
         Y5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vDvyc+/iYvqW3Gx2uDp8SqaTEX8yeKRpLyr8Dl/VIPo=;
        b=KjVjv1k0B9S2DHza893e13Hfgb3mQis43SBCs5Xl7RpZyi1zJQ9yMqJ+7OpS/6bEKf
         DKE5exhXv2IeEoZvXBGx0x3y0K0JaYWcQQ0DdFfTX/TGTTiTeEgxAtDdr0dmqhcZfSho
         2DvYCvxtAvGD/IB1BWXhGTQ0TJf68Yn/ulfxhKf5ysPyqDSVEM6bQzBLdw5fxK5dLnhM
         Gw6WGDJjS+Ick1/fGQQBiSKuGFrjF4ocNNc6eMQg3VCKh1FvOxfLWY4vMPJRs1EhLr4K
         dQOEdAGDBL2bq/NhGhXubFpUyxH7gEyDzjGsnuOpewrgtdCk77SMk2/rT1OMiLRcncO+
         5s+w==
X-Gm-Message-State: ALyK8tKvJdzhBOGN41XYSvQt4hwfRcCfe3NvJjvsogTD83qMOPRa64qF1SbIIo83sp2/1Q==
X-Received: by 10.55.89.197 with SMTP id n188mr3967885qkb.169.1468424327666;
        Wed, 13 Jul 2016 08:38:47 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id o2sm3596821qkd.0.2016.07.13.08.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jul 2016 08:38:47 -0700 (PDT)
From:	Ben Peart <peartben@gmail.com>
To:	git@vger.kernel.org
Cc:	pclouds@gmail.com, Ben Peart <peartben@gmail.com>
Subject: [RFC] Speed up git status via a file system daemon
Date:	Wed, 13 Jul 2016 11:38:37 -0400
Message-Id: <1468424317-5368-1-git-send-email-peartben@gmail.com>
X-Mailer: git-send-email 2.8.2.windows.1.4.gdf2cc46.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Idea taken and code refactored from [1]:

The intent of this patch series is to separate the index-helper logic
from the Watchman logic.  With very large repos, the percentage of time
required to read the index from disk becomes a much smaller percentage
of the overall time.  The Watchman logic provides a huge performance win
for git status (8 seconds vs 12 minutes in our testing) vs the minimal
benefits index-helper provides (<1 second).

The current index-helper/watchman combination design requires two
daemons, IPC between git and the index-helper, IPC between the index
helper and Watchman, shared memory, adding a WAMA extension to the
index, etc.

The benefit of splitting these two efforts is a significantly simpler
set of changes that give the benefits of utilizing a file system
monitoring daemon like Watchman without the additional complexity and
overhead associated with index-helper.

The overall design of this refactored patch series is that when the
index is read from disk, a hook proc is called that returns the list of
potentially changed files.  Git then uses this set of files to flag the
potentially dirty index and untracked cache entries.

The logic to use this information to limit the scope of which files and
directories need to be checked for changes is the largely the same as
the original patch series.

One benefit of the hook proc is that it provides a simple, platform 
independent way to interface with the file system daemon.  It does not
require another daemon to be running to act as an intermediary between
git and the file system daemon to support communicating via named pipes 
or sockets.

The prototype currently has no mechanism for saving the date/time of the
query into the index so the list of potentially changed files grows
unbounded. Writing the additional 64 bit date/time data into an optional
extension seems like a lot of overhead but changing the on disk index
format is expensive as well from a compatibility perspective.  Other
ideas or suggestions welcome.

Thanks,

Ben

[1] http://article.gmane.org/gmane.comp.version-control.git/298243

---
 cache.h      |   4 ++
 dir.c        |  14 ++++-
 dir.h        |   5 ++
 read-cache.c | 174 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 194 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index f1dc289..45c2eff 100644
--- a/cache.h
+++ b/cache.h
@@ -182,6 +182,8 @@ struct cache_entry {
 #define CE_VALID     (0x8000)
 #define CE_STAGESHIFT 12
 
+#define CE_FSDAEMON_DIRTY  (0x0001)
+
 /*
  * Range 0xFFFF0FFF in ce_flags is divided into
  * two parts: in-memory flags and on-disk ones.
@@ -338,6 +340,8 @@ struct index_state {
 	struct hashmap dir_hash;
 	unsigned char sha1[20];
 	struct untracked_cache *untracked;
+	/* BENPEART-TODO: persist last_update in the index, use gmtime? */
+	time_t last_update;
 };
 
 extern struct index_state the_index;
diff --git a/dir.c b/dir.c
index 6172b34..bce921f 100644
--- a/dir.c
+++ b/dir.c
@@ -584,7 +584,7 @@ static void trim_trailing_spaces(char *buf)
  *
  * If "name" has the trailing slash, it'll be excluded in the search.
  */
-static struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
+struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
 						    struct untracked_cache_dir *dir,
 						    const char *name, int len)
 {
@@ -1551,6 +1551,17 @@ static int valid_cached_dir(struct dir_struct *dir,
 	if (!untracked)
 		return 0;
 
+	if (dir->untracked->use_fsdaemon) {
+		/*
+		 * With file system daemon, we can trust the untracked cache's
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
@@ -1564,6 +1575,7 @@ static int valid_cached_dir(struct dir_struct *dir,
 		return 0;
 	}
 
+skip_stat:
 	if (untracked->check_only != !!check_only) {
 		invalidate_directory(dir->untracked, untracked);
 		return 0;
diff --git a/dir.h b/dir.h
index bfde698..8b7b98a 100644
--- a/dir.h
+++ b/dir.h
@@ -139,6 +139,8 @@ struct untracked_cache {
 	int gitignore_invalidated;
 	int dir_invalidated;
 	int dir_opened;
+	/* file system daemon invalidation data */
+	unsigned int use_fsdaemon : 1;
 };
 
 struct dir_struct {
@@ -308,4 +310,7 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
+struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
+					     struct untracked_cache_dir *dir,
+					     const char *name, int len);
 #endif
diff --git a/read-cache.c b/read-cache.c
index db27766..5478c49 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -18,6 +18,7 @@
 #include "varint.h"
 #include "split-index.h"
 #include "utf8.h"
+#include "run-command.h"
 
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
@@ -1222,8 +1223,11 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 			continue;
 
 		new = refresh_cache_ent(istate, ce, options, &cache_errno, &changed);
-		if (new == ce)
+		if (new == ce) {
+			ce->ce_flags &= ~CE_FSDAEMON_DIRTY;
 			continue;
+		}
+
 		if (!new) {
 			const char *fmt;
 
@@ -1367,6 +1371,30 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
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
+	end = strrchr(name, '/');
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
 static int read_index_extension(struct index_state *istate,
 				const char *ext, void *data, unsigned long sz)
 {
@@ -1544,6 +1572,143 @@ static void post_read_index_from(struct index_state *istate)
 	tweak_untracked_cache(istate);
 }
 
+/*
+* Call the query-fsdaemon hook passing the date time of the last saved results.
+* Returns the list of files changed on success (may be empty) or NULL on error.
+*/
+struct string_list *query_fsdaemon(time_t last_update)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	char date[64];
+	struct strbuf buffer = STRBUF_INIT;
+	struct string_list *res;
+	const char *argv[3];
+	char *buf, *entry;
+	int i, ret;
+
+	if (!(argv[0] = find_hook("query-fsdaemon")))
+		return NULL;
+
+	snprintf(date, sizeof(date), "%lu", last_update);
+	argv[1] = date;
+	argv[2] = NULL;
+	cp.argv = argv;
+	cp.out = -1;
+
+	ret = capture_command(&cp, &buffer, 1024);
+	if (ret) {
+		strbuf_release(&buffer);
+		return NULL;
+	}
+
+	/*
+	 * Read the results into a string_list for easy processing
+	 */
+	res = xcalloc(1, sizeof(struct string_list));
+	res->strdup_strings = 1;
+	buf = entry = buffer.buf;
+	for (i = 0; i < buffer.len; i++) {
+		if (buf[i] == '\n') {
+			if (entry != buf + i) {
+				buf[i - (i && buf[i - 1] == '\r')] = 0;
+				string_list_append(res, entry);
+			}
+			entry = buf + i + 1;
+		}
+	}
+
+	strbuf_release(&buffer);
+	return res;
+}
+
+static int update_istate(struct string_list_item *item, void *is)
+{
+	struct index_state *istate = is;
+	int pos;
+
+	/*
+	 * find it in the index and mark that entry as dirty
+	 */
+	pos = index_name_pos(istate, item->string, strlen(item->string));
+	if (pos >= 0)
+		istate->cache[pos]->ce_flags |= CE_FSDAEMON_DIRTY;
+
+	/*
+	 * Find the corresponding directory in the untracked cache
+	 * and mark it as invalid
+	 */
+	if (istate->untracked) {
+		struct untracked_cache_dir *dir;
+
+		dir = find_untracked_cache_dir(istate->untracked, istate->untracked->root, item->string);
+		if (dir)
+			dir->valid = 0;
+	}
+
+	return 0;
+}
+
+static void refresh_by_fsdaemon(struct index_state *istate)
+{
+	struct string_list *changes = NULL;
+	time_t last_update;
+	int i;
+
+	/*
+	 * This could be racy so save the date/time now and the hook
+	 * should be inclusive to ensure we don't miss potential changes.
+	 */
+	last_update = time(NULL);
+
+	changes = query_fsdaemon(istate->last_update);
+
+	// if we can't update the cache, fall back to checking them all
+	if (!changes) {
+		/* let refresh clear them later */
+		for (i = 0; i < istate->cache_nr; i++)
+			istate->cache[i]->ce_flags |= CE_FSDAEMON_DIRTY;
+
+		/* mark all untracked cache entries as invalid */
+		if (istate->untracked)
+			istate->untracked->use_fsdaemon = 0;
+		return;
+	}
+
+	/* TODO: potential optimizations
+	 *	- dedupe entries via string_list_remove_duplicates
+	 *  - build seperate list of directories for untracked cache
+	 *    and dedupe it before marking them invalid
+	 */
+
+	/*
+	 * Loop through list of changed files and mark all corresponding
+	 * index entries and untracked cache directories as dirty.
+	 */
+	for_each_string_list(changes, update_istate, istate);
+
+	/*
+	 * Now that we've marked the invalid entries in the
+	 * untracked-cache itself, we can mark the untracked cache for
+	 * fsdaemon usage.
+	 */
+	if (istate->untracked)
+		istate->untracked->use_fsdaemon = 1;
+
+	/*
+	 * Mark all clean entries up-to-date
+	 */
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+		if (ce_stage(ce) || (ce->ce_flags & CE_FSDAEMON_DIRTY))
+			continue;
+		ce_mark_uptodate(ce);
+	}
+	string_list_clear(changes, 0);
+
+	/* Now that we've updated istate, save the last_update time */
+	istate->last_update = last_update;
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_exist)
 {
@@ -1651,7 +1816,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	split_index = istate->split_index;
 	if (!split_index || is_null_sha1(split_index->base_sha1)) {
 		post_read_index_from(istate);
-		return ret;
+		goto done;
 	}
 
 	if (split_index->base)
@@ -1669,6 +1834,11 @@ int read_index_from(struct index_state *istate, const char *path)
 		    sha1_to_hex(split_index->base->sha1));
 	merge_base_index(istate);
 	post_read_index_from(istate);
+
+done:
+	if (ret > 0)
+		refresh_by_fsdaemon(istate);
+
 	return ret;
 }
 
-- 
2.8.2.windows.1.4.gdf2cc46.dirty

