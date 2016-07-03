Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CF9E20179
	for <e@80x24.org>; Sun,  3 Jul 2016 08:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbcGCIAr (ORCPT <rfc822;e@80x24.org>);
	Sun, 3 Jul 2016 04:00:47 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:55435 "EHLO
	homiemail-a21.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752120AbcGCIAK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Jul 2016 04:00:10 -0400
Received: from homiemail-a21.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTP id A3662300091;
	Sun,  3 Jul 2016 00:58:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=novalis.org; bh=A44pk
	kuAR7QStqdxY2ZyweN3JyQ=; b=HqOq8L3l9eGsZ473Wo+/wbfzfHYYSVt7q3790
	3cD3OQwsqnMdM5qTbkF5PB7UCcxLhLg64z/ZZ+b+O1HkQt1rnzzE1eCgmTVvbN2q
	zQC8f3kyMfKvZV6a+nkgKs7WNFURM0n+0prEmHvHZmlYaU8btVWR56o5tKlM7v7A
	nE920g=
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTPSA id ECEC530007B;
	Sun,  3 Jul 2016 00:58:34 -0700 (PDT)
From:	David Turner <novalis@novalis.org>
To:	git@vger.kernel.org, pclouds@gmail.com, kmaggg@gmail.com
Cc:	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v14 09/21] read-cache: add watchman 'WAMA' extension
Date:	Sun,  3 Jul 2016 03:58:01 -0400
Message-Id: <1467532693-20017-10-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.11.g9232872.dirty
In-Reply-To: <1467532693-20017-1-git-send-email-novalis@novalis.org>
References: <1467532693-20017-1-git-send-email-novalis@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

The extension contains a bitmap, one bit for each entry in the
index. If the n-th bit is zero, the n-th entry is considered
unchanged, we can ce_mark_uptodate() it without refreshing. If the bit
is non-zero and we found out the corresponding file is clean after
refresh, we can clear the bit.

In addition, there's a list of directories in the untracked-cache
to invalidate (because they have new or modified entries).

The 'skipping refresh' bit is not in this patch yet as we would need
watchman. More details in later patches.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/index-format.txt |  22 ++++++
 cache.h                                  |   4 +
 dir.h                                    |   3 +
 read-cache.c                             | 127 ++++++++++++++++++++++++++++++-
 4 files changed, 154 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index ade0b0c..86ed3a6 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -295,3 +295,25 @@ The remaining data of each directory block is grouped by type:
     in the previous ewah bitmap.
 
   - One NUL.
+
+== Watchman cache
+
+  The watchman cache tracks files for which watchman has told us about
+  changes.  The signature for this extension is { 'W', 'A', 'M', 'A' }.
+
+  The extension starts with
+
+  - A NUL-terminated string: the watchman vector clock at the last
+    time we heard from watchman.
+
+  - 32-bit bitmap size: the size of the CE_WATCHMAN_DIRTY bitmap
+
+  - 32-bit untracked cache entry count: the number of dirty untracked
+    cache entries
+
+  - An ewah bitmap, the n-th bit indicates whether the n-th index entry
+    is CE_WATCHMAN_DIRTY.
+
+  - a list of N NUL-terminated strings.  Each is a directory that should
+    be marked dirty in the untracked cache because watchman has told us
+    about an update to a file in it.
diff --git a/cache.h b/cache.h
index 4c1529a..f10992d 100644
--- a/cache.h
+++ b/cache.h
@@ -182,6 +182,8 @@ struct cache_entry {
 #define CE_VALID     (0x8000)
 #define CE_STAGESHIFT 12
 
+#define CE_WATCHMAN_DIRTY  (0x0001)
+
 /*
  * Range 0xFFFF0FFF in ce_flags is divided into
  * two parts: in-memory flags and on-disk ones.
@@ -320,6 +322,7 @@ static inline unsigned int canon_mode(unsigned int mode)
 #define CACHE_TREE_CHANGED	(1 << 5)
 #define SPLIT_INDEX_ORDERED	(1 << 6)
 #define UNTRACKED_CHANGED	(1 << 7)
+#define WATCHMAN_CHANGED	(1 << 8)
 
 struct split_index;
 struct untracked_cache;
@@ -353,6 +356,7 @@ struct index_state {
 	struct untracked_cache *untracked;
 	void *mmap;
 	size_t mmap_size;
+	char *last_update;
 };
 
 extern struct index_state the_index;
diff --git a/dir.h b/dir.h
index cd46f30..896b64a 100644
--- a/dir.h
+++ b/dir.h
@@ -139,6 +139,9 @@ struct untracked_cache {
 	int gitignore_invalidated;
 	int dir_invalidated;
 	int dir_opened;
+	/* watchman invalidation data */
+	unsigned int use_watchman : 1;
+	struct string_list invalid_untracked;
 };
 
 struct dir_struct {
diff --git a/read-cache.c b/read-cache.c
index befc499..e0fc634 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -21,6 +21,7 @@
 #include "unix-socket.h"
 #include "pkt-line.h"
 #include "sigchain.h"
+#include "ewah/ewok.h"
 
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
@@ -43,11 +44,13 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
 #define CACHE_EXT_LINK 0x6c696e6b	  /* "link" */
 #define CACHE_EXT_UNTRACKED 0x554E5452	  /* "UNTR" */
+#define CACHE_EXT_WATCHMAN 0x57414D41	  /* "WAMA" */
 
 /* changes that can be kept in $GIT_DIR/index (basically all extensions) */
 #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
 		 CE_ENTRY_ADDED | CE_ENTRY_REMOVED | CE_ENTRY_CHANGED | \
-		 SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED)
+		 SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED | \
+		 WATCHMAN_CHANGED)
 
 struct index_state the_index;
 static const char *alternate_index_output;
@@ -1222,8 +1225,23 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 			continue;
 
 		new = refresh_cache_ent(istate, ce, options, &cache_errno, &changed);
-		if (new == ce)
+		if (new == ce) {
+			if (ce->ce_flags & CE_WATCHMAN_DIRTY) {
+				/* The rule is index-helper sets
+				 * CE_WATCHMAN_DIRTY when a file is changed,
+				 * then git clears it when it has verified
+				 * that the in-index entry now matches the
+				 * worktree version. index-helper does not
+				 * clear the bit and git does not set it. We
+				 * have verified here that stat info (and even
+				 * content) matches, so it's safe to clear
+				 * CE_WATCHMAN_DIRTY now.
+				 */
+				ce->ce_flags          &= ~CE_WATCHMAN_DIRTY;
+				istate->cache_changed |= WATCHMAN_CHANGED;
+			}
 			continue;
+		}
 		if (!new) {
 			const char *fmt;
 
@@ -1367,6 +1385,94 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 	return 0;
 }
 
+static void mark_no_watchman(size_t pos, void *data)
+{
+	struct index_state *istate = data;
+	assert(pos < istate->cache_nr);
+	istate->cache[pos]->ce_flags |= CE_WATCHMAN_DIRTY;
+}
+
+static int read_watchman_ext(struct index_state *istate, const void *data,
+			     unsigned long sz)
+{
+	struct ewah_bitmap *bitmap;
+	int ret, len;
+	uint32_t bitmap_size;
+	uint32_t untracked_nr;
+
+	if (memchr(data, 0, sz) == NULL)
+		return error("invalid extension");
+
+	len = strlen(data) + 1;
+	memcpy(&bitmap_size, (const char *)data + len, 4);
+	memcpy(&untracked_nr, (const char *)data + len + 4, 4);
+	untracked_nr = ntohl(untracked_nr);
+	bitmap_size = ntohl(bitmap_size);
+
+	bitmap = ewah_new();
+	ret = ewah_read_mmap(bitmap, (const char *)data + len + 8, bitmap_size);
+	if (ret != bitmap_size) {
+		ewah_free(bitmap);
+		return error("failed to parse ewah bitmap reading watchman index extension");
+	}
+	istate->last_update = xstrdup(data);
+	ewah_each_bit(bitmap, mark_no_watchman, istate);
+	ewah_free(bitmap);
+
+	/*
+	 * TODO: update the untracked cache from the untracked data in this
+	 * extension.
+	 */
+	return 0;
+}
+
+static int untracked_entry_append(struct string_list_item *item, void *sbvoid)
+{
+	struct strbuf *sb = sbvoid;
+
+	strbuf_addstr(sb, item->string);
+	strbuf_addch(sb, 0);
+	return 0;
+}
+
+void write_watchman_ext(struct strbuf *sb, struct index_state *istate)
+{
+	struct ewah_bitmap *bitmap;
+	int i;
+	int ewah_start;
+	int ewah_size = 0;
+	int fixup = 0;
+
+	strbuf_add(sb, istate->last_update, strlen(istate->last_update) + 1);
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
+	bitmap = ewah_new();
+	for (i = 0; i < istate->cache_nr; i++)
+		if (istate->cache[i]->ce_flags & CE_WATCHMAN_DIRTY)
+			ewah_set(bitmap, i);
+	ewah_serialize_strbuf(bitmap, sb);
+	ewah_free(bitmap);
+
+	/* fix up size field */
+	ewah_size = sb->len - ewah_start;
+	ewah_size = htonl(ewah_size);
+	memcpy(sb->buf + fixup, &ewah_size, 4);
+
+	if (istate->untracked)
+		for_each_string_list(&istate->untracked->invalid_untracked,
+				     untracked_entry_append, sb);
+}
+
 static int read_index_extension(struct index_state *istate,
 				const char *ext, void *data, unsigned long sz)
 {
@@ -1384,6 +1490,11 @@ static int read_index_extension(struct index_state *istate,
 	case CACHE_EXT_UNTRACKED:
 		istate->untracked = read_untracked_extension(data, sz);
 		break;
+
+	case CACHE_EXT_WATCHMAN:
+		read_watchman_ext(istate, data, sz);
+		break;
+
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand",
@@ -1815,6 +1926,8 @@ int discard_index(struct index_state *istate)
 	istate->untracked = NULL;
 	istate->from_shm = 0;
 	istate->to_shm   = 0;
+	free(istate->last_update);
+	istate->last_update = NULL;
 	return 0;
 }
 
@@ -2212,6 +2325,16 @@ static int do_write_index(struct index_state *istate, int newfd,
 		if (err)
 			return -1;
 	}
+	if (!strip_extensions && istate->last_update) {
+		struct strbuf sb = STRBUF_INIT;
+
+		write_watchman_ext(&sb, istate);
+		err = write_index_ext_header(&c, newfd, CACHE_EXT_WATCHMAN, sb.len) < 0
+			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
+			return -1;
+	}
 
 	if (ce_flush(&c, newfd, istate->sha1) || fstat(newfd, &st))
 		return -1;
-- 
1.9.1

