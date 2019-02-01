Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 564041F453
	for <e@80x24.org>; Fri,  1 Feb 2019 08:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfBAIgR (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 03:36:17 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:49258
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726760AbfBAIgQ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 Feb 2019 03:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1549010174;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=xNc7SDO6Hnp6lertrWuSRyxoU9IdQT4/JMrTXKvNves=;
        b=DB8jAFU1/G8pFu9Rv18TXTt7niR9JBa3h9mv/BFGttgIsHc/KeFdGms1ZL1nhBlc
        WmM04wdogCvAqP7/rVybKsR7S0ftRGxSPT/6itdqekYkj/WJoZPj/IbFFOLfQ2wQc3J
        1MuqVPETrPJFJOFxbGL4vfsmjm7HWrwotwYGyySQ=
From:   Shahzad Lone <shahzadlone@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020168a8338064-b1c054c4-3e05-4825-b8dc-636d9c63dcfc-000000@eu-west-1.amazonses.com>
Subject: [PATCH 1/3] [Enhancement] Improve internals / refactoring.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 1 Feb 2019 08:36:14 +0000
X-SES-Outgoing: 2019.02.01-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changed to ```consts``` and tried to save arithmetic cost where I could.

Sorry my coding OCD bothered me when I didn't see them being ```consts```.
---
 builtin/diff.c           |  2 +-
 builtin/pack-objects.c   | 19 ++++++++++---------
 builtin/pack-redundant.c |  4 ++--
 pack-revindex.c          | 13 ++++++-------
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index f0393bba23a7d..84a362ff5625b 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -102,7 +102,7 @@ static int builtin_diff_blobs(struct rev_info *revs,
 			      int argc, const char **argv,
 			      struct object_array_entry **blob)
 {
-	unsigned mode = canon_mode(S_IFREG | 0644);
+	const unsigned mode = canon_mode(S_IFREG | 0644);
 
 	if (argc > 1)
 		usage(builtin_diff_usage);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0a70d046043ec..c1ec9ef3232cb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -197,8 +197,9 @@ static unsigned long write_large_blob_data(struct git_istream *st, struct hashfi
 					   const struct object_id *oid)
 {
 	git_zstream stream;
-	unsigned char ibuf[1024 * 16];
-	unsigned char obuf[1024 * 16];
+	const unsigned bufsize = 16384;
+	unsigned char ibuf[bufsize];
+	unsigned char obuf[bufsize];
 	unsigned long olen = 0;
 
 	git_deflate_init(&stream, pack_compression_level);
@@ -1901,10 +1902,10 @@ static int type_size_sort(const void *_a, const void *_b)
 {
 	const struct object_entry *a = *(struct object_entry **)_a;
 	const struct object_entry *b = *(struct object_entry **)_b;
-	enum object_type a_type = oe_type(a);
-	enum object_type b_type = oe_type(b);
-	unsigned long a_size = SIZE(a);
-	unsigned long b_size = SIZE(b);
+	const enum object_type a_type = oe_type(a);
+	const enum object_type b_type = oe_type(b);
+	const unsigned long a_size = SIZE(a);
+	const unsigned long b_size = SIZE(b);
 
 	if (a_type > b_type)
 		return -1;
@@ -1919,7 +1920,7 @@ static int type_size_sort(const void *_a, const void *_b)
 	if (a->preferred_base < b->preferred_base)
 		return 1;
 	if (use_delta_islands) {
-		int island_cmp = island_delta_cmp(&a->idx.oid, &b->idx.oid);
+		const int island_cmp = island_delta_cmp(&a->idx.oid, &b->idx.oid);
 		if (island_cmp)
 			return island_cmp;
 	}
@@ -2171,7 +2172,7 @@ static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
 	struct object_entry *child = DELTA_CHILD(me);
 	unsigned int m = n;
 	while (child) {
-		unsigned int c = check_delta_limit(child, n + 1);
+		const unsigned int c = check_delta_limit(child, n + 1);
 		if (m < c)
 			m = c;
 		child = DELTA_SIBLING(child);
@@ -2226,7 +2227,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		while (window_memory_limit &&
 		       mem_usage > window_memory_limit &&
 		       count > 1) {
-			uint32_t tail = (idx + window - count) % window;
+			const uint32_t tail = (idx + window - count) % window;
 			mem_usage -= free_unpacked(array + tail);
 			count--;
 		}
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index cf9a9aabd4eb2..11bc51456631e 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -166,7 +166,7 @@ static inline struct llist_item * llist_sorted_remove(struct llist *list, const
 	l = (hint == NULL) ? list->front : hint;
 	prev = NULL;
 	while (l) {
-		int cmp = oidcmp(l->oid, oid);
+		const int cmp = oidcmp(l->oid, oid);
 		if (cmp > 0) /* not in list, since sorted */
 			return prev;
 		if (!cmp) { /* found */
@@ -264,7 +264,7 @@ static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
 	while (p1_off < p1->pack->num_objects * p1_step &&
 	       p2_off < p2->pack->num_objects * p2_step)
 	{
-		int cmp = hashcmp(p1_base + p1_off, p2_base + p2_off);
+		const int cmp = hashcmp(p1_base + p1_off, p2_base + p2_off);
 		/* cmp ~ p1 - p2 */
 		if (cmp == 0) {
 			p1_hint = llist_sorted_remove(p1->unique_objects,
diff --git a/pack-revindex.c b/pack-revindex.c
index 3c58784a5f4de..202981b39c6b6 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -119,7 +119,7 @@ static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
  */
 static void create_pack_revindex(struct packed_git *p)
 {
-	unsigned num_ent = p->num_objects;
+	const unsigned num_ent = p->num_objects;
 	unsigned i;
 	const char *index = p->index_data;
 	const unsigned hashsz = the_hash_algo->rawsz;
@@ -132,7 +132,7 @@ static void create_pack_revindex(struct packed_git *p)
 			(uint32_t *)(index + 8 + p->num_objects * (hashsz + 4));
 		const uint32_t *off_64 = off_32 + p->num_objects;
 		for (i = 0; i < num_ent; i++) {
-			uint32_t off = ntohl(*off_32++);
+			const uint32_t off = ntohl(*off_32++);
 			if (!(off & 0x80000000)) {
 				p->revindex[i].offset = off;
 			} else {
@@ -143,7 +143,7 @@ static void create_pack_revindex(struct packed_git *p)
 		}
 	} else {
 		for (i = 0; i < num_ent; i++) {
-			uint32_t hl = *((uint32_t *)(index + (hashsz + 4) * i));
+			const uint32_t hl = *((uint32_t *)(index + (hashsz + 4) * i));
 			p->revindex[i].offset = ntohl(hl);
 			p->revindex[i].nr = i;
 		}
@@ -168,10 +168,10 @@ int find_revindex_position(struct packed_git *p, off_t ofs)
 {
 	int lo = 0;
 	int hi = p->num_objects + 1;
-	struct revindex_entry *revindex = p->revindex;
+	const struct revindex_entry *revindex = p->revindex;
 
 	do {
-		unsigned mi = lo + (hi - lo) / 2;
+		const unsigned mi = lo + (hi - lo) / 2;
 		if (revindex[mi].offset == ofs) {
 			return mi;
 		} else if (ofs < revindex[mi].offset)
@@ -186,10 +186,9 @@ int find_revindex_position(struct packed_git *p, off_t ofs)
 
 struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
 {
-	int pos;
 
 	load_pack_revindex(p);
-	pos = find_revindex_position(p, ofs);
+	const int pos = find_revindex_position(p, ofs);
 
 	if (pos < 0)
 		return NULL;

--
https://github.com/git/git/pull/572
