Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 040BA1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 21:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeJIFLP (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:11:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49376 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726607AbeJIFLP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 01:11:15 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C92FD607A0;
        Mon,  8 Oct 2018 21:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539035843;
        bh=OC3fDgp4b9OsHC6sXy2aqapI/WcpRWU711G1JorbVsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=AblRorKdjLLuycXkYXpXB42tsloS9XdNVPKmTxKs4DZLUq+7T11+8JkDFyvFibq6T
         lfpYntQttDs3n61jCuqPFIOlVAZCwSw/k4gaJwIWy0UdlHky/YjnTRJANHREjym9Yd
         RqpZbKduI7UZRSnXJ1HtHSXK9gP3FduBm8RcQ8nbUoIBwSxtL65Gmm0/lo/4qzHKe/
         38MO0R69nqE/r6D8dPssanXHRusI3cVmhpRhi6EVu8eT3Eo2VSG6W3QNKQciyPZQoM
         XEyCB4ZkpWWkg/Ly5jvObZIcFGo0Dgc7rI2+kUE9zaFUcGAIFZMitIVdake2VzUL8+
         Sfo1bWVDRGDqiTRixu6hTUgUlKP+8JxC1OZ68sIDcwREWNSPtEWSNQfhp8avWTNwBo
         NlNvKl48vqCp2HzstvJIUvZ8N5Bel57zTmVjs1midyLiO50RpyNoiyTuoq+ll4JSgZ
         mMDHV7e203EqhlSI3J2V4fj6FJA32ZrA9kCZ1xhgF5z33foeoeA
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/14] rerere: convert to use the_hash_algo
Date:   Mon,  8 Oct 2018 21:57:01 +0000
Message-Id: <20181008215701.779099-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c
In-Reply-To: <20181008215701.779099-1-sandals@crustytoothpaste.net>
References: <20181008215701.779099-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since this data is stored in the .git directory, it makes sense for us
to use the same hash algorithm for it as for everything else.  Convert
the remaining uses of SHA-1 to use the_hash_algo.  Use GIT_MAX_RAWSZ for
allocations.  Rename various struct members, local variables, and a
function to be named "hash" instead of "sha1".

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 rerere.c | 81 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/rerere.c b/rerere.c
index 7aa149e849..ceb98015ff 100644
--- a/rerere.c
+++ b/rerere.c
@@ -29,7 +29,7 @@ static int rerere_dir_alloc;
 #define RR_HAS_POSTIMAGE 1
 #define RR_HAS_PREIMAGE 2
 static struct rerere_dir {
-	unsigned char sha1[20];
+	unsigned char hash[GIT_MAX_HEXSZ];
 	int status_alloc, status_nr;
 	unsigned char *status;
 } **rerere_dir;
@@ -52,7 +52,7 @@ static void free_rerere_id(struct string_list_item *item)
 
 static const char *rerere_id_hex(const struct rerere_id *id)
 {
-	return sha1_to_hex(id->collection->sha1);
+	return sha1_to_hex(id->collection->hash);
 }
 
 static void fit_variant(struct rerere_dir *rr_dir, int variant)
@@ -115,7 +115,7 @@ static int is_rr_file(const char *name, const char *filename, int *variant)
 static void scan_rerere_dir(struct rerere_dir *rr_dir)
 {
 	struct dirent *de;
-	DIR *dir = opendir(git_path("rr-cache/%s", sha1_to_hex(rr_dir->sha1)));
+	DIR *dir = opendir(git_path("rr-cache/%s", sha1_to_hex(rr_dir->hash)));
 
 	if (!dir)
 		return;
@@ -133,24 +133,24 @@ static void scan_rerere_dir(struct rerere_dir *rr_dir)
 	closedir(dir);
 }
 
-static const unsigned char *rerere_dir_sha1(size_t i, void *table)
+static const unsigned char *rerere_dir_hash(size_t i, void *table)
 {
 	struct rerere_dir **rr_dir = table;
-	return rr_dir[i]->sha1;
+	return rr_dir[i]->hash;
 }
 
 static struct rerere_dir *find_rerere_dir(const char *hex)
 {
-	unsigned char sha1[20];
+	unsigned char hash[GIT_MAX_RAWSZ];
 	struct rerere_dir *rr_dir;
 	int pos;
 
-	if (get_sha1_hex(hex, sha1))
+	if (get_sha1_hex(hex, hash))
 		return NULL; /* BUG */
-	pos = sha1_pos(sha1, rerere_dir, rerere_dir_nr, rerere_dir_sha1);
+	pos = sha1_pos(hash, rerere_dir, rerere_dir_nr, rerere_dir_hash);
 	if (pos < 0) {
 		rr_dir = xmalloc(sizeof(*rr_dir));
-		hashcpy(rr_dir->sha1, sha1);
+		hashcpy(rr_dir->hash, hash);
 		rr_dir->status = NULL;
 		rr_dir->status_nr = 0;
 		rr_dir->status_alloc = 0;
@@ -207,26 +207,27 @@ static void read_rr(struct string_list *rr)
 		return;
 	while (!strbuf_getwholeline(&buf, in, '\0')) {
 		char *path;
-		unsigned char sha1[20];
+		unsigned char hash[GIT_MAX_RAWSZ];
 		struct rerere_id *id;
 		int variant;
+		const unsigned hexsz = the_hash_algo->hexsz;
 
 		/* There has to be the hash, tab, path and then NUL */
-		if (buf.len < 42 || get_sha1_hex(buf.buf, sha1))
+		if (buf.len < hexsz + 2 || get_sha1_hex(buf.buf, hash))
 			die(_("corrupt MERGE_RR"));
 
-		if (buf.buf[40] != '.') {
+		if (buf.buf[hexsz] != '.') {
 			variant = 0;
-			path = buf.buf + 40;
+			path = buf.buf + hexsz;
 		} else {
 			errno = 0;
-			variant = strtol(buf.buf + 41, &path, 10);
+			variant = strtol(buf.buf + hexsz + 1, &path, 10);
 			if (errno)
 				die(_("corrupt MERGE_RR"));
 		}
 		if (*(path++) != '\t')
 			die(_("corrupt MERGE_RR"));
-		buf.buf[40] = '\0';
+		buf.buf[hexsz] = '\0';
 		id = new_rerere_id_hex(buf.buf);
 		id->variant = variant;
 		string_list_insert(rr, path)->util = id;
@@ -360,7 +361,7 @@ static void rerere_strbuf_putconflict(struct strbuf *buf, int ch, size_t size)
 }
 
 static int handle_conflict(struct strbuf *out, struct rerere_io *io,
-			   int marker_size, git_SHA_CTX *ctx)
+			   int marker_size, git_hash_ctx *ctx)
 {
 	enum {
 		RR_SIDE_1 = 0, RR_SIDE_2, RR_ORIGINAL
@@ -398,10 +399,12 @@ static int handle_conflict(struct strbuf *out, struct rerere_io *io,
 			strbuf_addbuf(out, &two);
 			rerere_strbuf_putconflict(out, '>', marker_size);
 			if (ctx) {
-				git_SHA1_Update(ctx, one.buf ? one.buf : "",
-					    one.len + 1);
-				git_SHA1_Update(ctx, two.buf ? two.buf : "",
-					    two.len + 1);
+				the_hash_algo->update_fn(ctx, one.buf ?
+							 one.buf : "",
+							 one.len + 1);
+				the_hash_algo->update_fn(ctx, two.buf ?
+							 two.buf : "",
+							 two.len + 1);
 			}
 			break;
 		} else if (hunk == RR_SIDE_1)
@@ -430,18 +433,18 @@ static int handle_conflict(struct strbuf *out, struct rerere_io *io,
  * Return 1 if conflict hunks are found, 0 if there are no conflict
  * hunks and -1 if an error occured.
  */
-static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_size)
+static int handle_path(unsigned char *hash, struct rerere_io *io, int marker_size)
 {
-	git_SHA_CTX ctx;
+	git_hash_ctx ctx;
 	struct strbuf buf = STRBUF_INIT, out = STRBUF_INIT;
 	int has_conflicts = 0;
-	if (sha1)
-		git_SHA1_Init(&ctx);
+	if (hash)
+		the_hash_algo->init_fn(&ctx);
 
 	while (!io->getline(&buf, io)) {
 		if (is_cmarker(buf.buf, '<', marker_size)) {
 			has_conflicts = handle_conflict(&out, io, marker_size,
-							sha1 ? &ctx : NULL);
+							hash ? &ctx : NULL);
 			if (has_conflicts < 0)
 				break;
 			rerere_io_putmem(out.buf, out.len, io);
@@ -452,8 +455,8 @@ static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_siz
 	strbuf_release(&buf);
 	strbuf_release(&out);
 
-	if (sha1)
-		git_SHA1_Final(sha1, &ctx);
+	if (hash)
+		the_hash_algo->final_fn(hash, &ctx);
 
 	return has_conflicts;
 }
@@ -462,7 +465,7 @@ static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_siz
  * Scan the path for conflicts, do the "handle_path()" thing above, and
  * return the number of conflict hunks found.
  */
-static int handle_file(const char *path, unsigned char *sha1, const char *output)
+static int handle_file(const char *path, unsigned char *hash, const char *output)
 {
 	int has_conflicts = 0;
 	struct rerere_io_file io;
@@ -484,7 +487,7 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 		}
 	}
 
-	has_conflicts = handle_path(sha1, (struct rerere_io *)&io, marker_size);
+	has_conflicts = handle_path(hash, (struct rerere_io *)&io, marker_size);
 
 	fclose(io.input);
 	if (io.io.wrerror)
@@ -814,7 +817,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 	 */
 	for (i = 0; i < conflict.nr; i++) {
 		struct rerere_id *id;
-		unsigned char sha1[20];
+		unsigned char hash[GIT_MAX_RAWSZ];
 		const char *path = conflict.items[i].string;
 		int ret;
 
@@ -823,7 +826,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		 * conflict ID.  No need to write anything out
 		 * yet.
 		 */
-		ret = handle_file(path, sha1, NULL);
+		ret = handle_file(path, hash, NULL);
 		if (ret != 0 && string_list_has_string(rr, path)) {
 			remove_variant(string_list_lookup(rr, path)->util);
 			string_list_remove(rr, path, 1);
@@ -831,7 +834,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		if (ret < 1)
 			continue;
 
-		id = new_rerere_id(sha1);
+		id = new_rerere_id(hash);
 		string_list_insert(rr, path)->util = id;
 
 		/* Ensure that the directory exists. */
@@ -942,7 +945,7 @@ static int rerere_mem_getline(struct strbuf *sb, struct rerere_io *io_)
 	return 0;
 }
 
-static int handle_cache(const char *path, unsigned char *sha1, const char *output)
+static int handle_cache(const char *path, unsigned char *hash, const char *output)
 {
 	mmfile_t mmfile[3] = {{NULL}};
 	mmbuffer_t result = {NULL, 0};
@@ -1001,7 +1004,7 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	 * Grab the conflict ID and optionally write the original
 	 * contents with conflict markers out.
 	 */
-	has_conflicts = handle_path(sha1, (struct rerere_io *)&io, marker_size);
+	has_conflicts = handle_path(hash, (struct rerere_io *)&io, marker_size);
 	strbuf_release(&io.input);
 	if (io.io.output)
 		fclose(io.io.output);
@@ -1012,7 +1015,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 {
 	const char *filename;
 	struct rerere_id *id;
-	unsigned char sha1[20];
+	unsigned char hash[GIT_MAX_RAWSZ];
 	int ret;
 	struct string_list_item *item;
 
@@ -1020,12 +1023,12 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	 * Recreate the original conflict from the stages in the
 	 * index and compute the conflict ID
 	 */
-	ret = handle_cache(path, sha1, NULL);
+	ret = handle_cache(path, hash, NULL);
 	if (ret < 1)
 		return error(_("could not parse conflict hunks in '%s'"), path);
 
 	/* Nuke the recorded resolution for the conflict */
-	id = new_rerere_id(sha1);
+	id = new_rerere_id(hash);
 
 	for (id->variant = 0;
 	     id->variant < id->collection->status_nr;
@@ -1037,7 +1040,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 		if (!has_rerere_resolution(id))
 			continue;
 
-		handle_cache(path, sha1, rerere_path(id, "thisimage"));
+		handle_cache(path, hash, rerere_path(id, "thisimage"));
 		if (read_mmfile(&cur, rerere_path(id, "thisimage"))) {
 			free(cur.ptr);
 			error(_("failed to update conflicted state in '%s'"), path);
@@ -1069,7 +1072,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	 * conflict in the working tree, run us again to record
 	 * the postimage.
 	 */
-	handle_cache(path, sha1, rerere_path(id, "preimage"));
+	handle_cache(path, hash, rerere_path(id, "preimage"));
 	fprintf_ln(stderr, _("Updated preimage for '%s'"), path);
 
 	/*
