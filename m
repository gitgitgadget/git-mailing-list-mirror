Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 398621F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbdHPUQ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:16:59 -0400
Received: from vie01a-dmta-pe04-1.mx.upcmail.net ([62.179.121.163]:38772 "EHLO
        vie01a-dmta-pe04-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752266AbdHPUQz (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:16:55 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4kI-0005Ls-GR
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:16:54 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwGk1v00h5BuuEg01wGlME; Wed, 16 Aug 2017 22:16:45 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 5CA0645D4621; Wed, 16 Aug 2017 22:16:44 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [Patch size_t V3 12/19] Convert pack-objects to size_t
Date:   Wed, 16 Aug 2017 22:16:24 +0200
Message-Id: <1502914591-26215-13-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 Documentation/technical/api-parse-options.txt |  2 +-
 builtin/pack-objects.c                        | 46 +++++++++++++--------------
 parse-options.c                               |  6 ++--
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 829b558..22b788e 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -181,7 +181,7 @@ There are some macros to easily define options:
 	Introduce an option with a size argument. The argument must be a
 	non-negative integer and may include a suffix of 'k', 'm' or 'g' to
 	scale the provided value by 1024, 1024^2 or 1024^3 respectively.
-	The scaled value is put into `unsigned_long_var`.
+	The scaled value is put into `size_t`.
 
 `OPT_DATE(short, long, &timestamp_t_var, description)`::
 	Introduce an option with date argument, see `approxidate()`.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fbb07a8..12457ae 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -56,7 +56,7 @@ static struct pack_idx_option pack_idx_opts;
 static const char *base_name;
 static int progress = 1;
 static int window = 10;
-static unsigned long pack_size_limit;
+static size_t pack_size_limit;
 static int depth = 50;
 static int delta_search_threads;
 static int pack_to_stdout;
@@ -72,11 +72,11 @@ static int use_bitmap_index = -1;
 static int write_bitmap_index;
 static uint16_t write_bitmap_options;
 
-static unsigned long delta_cache_size = 0;
-static unsigned long max_delta_cache_size = 256 * 1024 * 1024;
-static unsigned long cache_max_small_delta_size = 1000;
+static size_t delta_cache_size = 0;
+static size_t max_delta_cache_size = 256 * 1024 * 1024;
+static size_t cache_max_small_delta_size = 1000;
 
-static unsigned long window_memory_limit = 0;
+static size_t window_memory_limit = 0;
 
 /*
  * stats
@@ -124,11 +124,11 @@ static void *get_delta(struct object_entry *entry)
 	return delta_buf;
 }
 
-static unsigned long do_compress(void **pptr, unsigned long size)
+static size_t do_compress(void **pptr, size_t size)
 {
 	git_zstream stream;
 	void *in, *out;
-	unsigned long maxsize;
+	size_t maxsize;
 
 	git_deflate_init(&stream, pack_compression_level);
 	maxsize = git_deflate_bound(&stream, size);
@@ -149,13 +149,13 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 	return stream.total_out;
 }
 
-static unsigned long write_large_blob_data(struct git_istream *st, struct sha1file *f,
+static size_t write_large_blob_data(struct git_istream *st, struct sha1file *f,
 					   const unsigned char *sha1)
 {
 	git_zstream stream;
 	unsigned char ibuf[1024 * 16];
 	unsigned char obuf[1024 * 16];
-	unsigned long olen = 0;
+	size_t olen = 0;
 
 	git_deflate_init(&stream, pack_compression_level);
 
@@ -196,7 +196,7 @@ static int check_pack_inflate(struct packed_git *p,
 		struct pack_window **w_curs,
 		off_t offset,
 		off_t len,
-		unsigned long expect)
+		size_t expect)
 {
 	git_zstream stream;
 	unsigned char fakebuf[4096], *in;
@@ -238,13 +238,13 @@ static void copy_pack_data(struct sha1file *f,
 }
 
 /* Return 0 if we will bust the pack-size limit */
-static unsigned long write_no_reuse_object(struct sha1file *f, struct object_entry *entry,
-					   unsigned long limit, int usable_delta)
+static size_t write_no_reuse_object(struct sha1file *f, struct object_entry *entry,
+				    size_t limit, int usable_delta)
 {
 	size_t size, datalen;
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
-	unsigned hdrlen;
+	size_t hdrlen;
 	enum object_type type;
 	void *buf;
 	struct git_istream *st = NULL;
@@ -350,7 +350,7 @@ static unsigned long write_no_reuse_object(struct sha1file *f, struct object_ent
 
 /* Return 0 if we will bust the pack-size limit */
 static off_t write_reuse_object(struct sha1file *f, struct object_entry *entry,
-				unsigned long limit, int usable_delta)
+				size_t limit, int usable_delta)
 {
 	struct packed_git *p = entry->in_pack;
 	struct pack_window *w_curs = NULL;
@@ -360,7 +360,7 @@ static off_t write_reuse_object(struct sha1file *f, struct object_entry *entry,
 	off_t datalen;
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
-	unsigned hdrlen;
+	size_t hdrlen;
 
 	if (entry->delta)
 		type = (allow_ofs_delta && entry->delta->idx.offset) ?
@@ -431,7 +431,7 @@ static off_t write_object(struct sha1file *f,
 			  struct object_entry *entry,
 			  off_t write_offset)
 {
-	unsigned long limit;
+	size_t limit;
 	off_t len;
 	int usable_delta, to_reuse;
 
@@ -1120,7 +1120,7 @@ struct pbase_tree_cache {
 	int ref;
 	int temporary;
 	void *tree_data;
-	unsigned long tree_size;
+	size_t tree_size;
 };
 
 static struct pbase_tree_cache *(pbase_tree_cache[256]);
@@ -1759,8 +1759,8 @@ struct unpacked {
 	unsigned depth;
 };
 
-static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
-			   unsigned long delta_size)
+static int delta_cacheable(size_t src_size, size_t trg_size,
+			   size_t delta_size)
 {
 	if (max_delta_cache_size && delta_cache_size + delta_size > max_delta_cache_size)
 		return 0;
@@ -1801,7 +1801,7 @@ static pthread_mutex_t progress_mutex;
 #endif
 
 static int try_delta(struct unpacked *trg, struct unpacked *src,
-		     unsigned max_depth, unsigned long *mem_usage)
+		     unsigned max_depth, size_t *mem_usage)
 {
 	struct object_entry *trg_entry = trg->entry;
 	struct object_entry *src_entry = src->entry;
@@ -1962,9 +1962,9 @@ static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
 	return m;
 }
 
-static unsigned long free_unpacked(struct unpacked *n)
+static size_t free_unpacked(struct unpacked *n)
 {
-	unsigned long freed_mem = sizeof_delta_index(n->index);
+	size_t freed_mem = sizeof_delta_index(n->index);
 	free_delta_index(n->index);
 	n->index = NULL;
 	if (n->data) {
@@ -1981,7 +1981,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 {
 	uint32_t i, idx = 0, count = 0;
 	struct unpacked *array;
-	unsigned long mem_usage = 0;
+	size_t mem_usage = 0;
 
 	array = xcalloc(window, sizeof(struct unpacked));
 
diff --git a/parse-options.c b/parse-options.c
index 0dd9fc6..3e7c514 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -181,16 +181,16 @@ static int get_value(struct parse_opt_ctx_t *p,
 
 	case OPTION_MAGNITUDE:
 		if (unset) {
-			*(unsigned long *)opt->value = 0;
+			*(size_t *)opt->value = 0;
 			return 0;
 		}
 		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
-			*(unsigned long *)opt->value = opt->defval;
+			*(size_t *)opt->value = opt->defval;
 			return 0;
 		}
 		if (get_arg(p, opt, flags, &arg))
 			return -1;
-		if (!git_parse_ulong(arg, opt->value))
+		if (!git_parse_size_t(arg, opt->value))
 			return opterror(opt,
 				"expects a non-negative integer value with an optional k/m/g suffix",
 				flags);
-- 
2.1.4

