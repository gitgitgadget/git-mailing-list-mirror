From: David Michael Barr <b@rr-dav.id.au>
Subject: [RFC] pack-objects: compression level for non-blobs
Date: Mon, 26 Nov 2012 17:25:54 +1100
Message-ID: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
Cc: David Michael Barr <b@rr-dav.id.au>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 07:26:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcs91-0001bg-Qp
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 07:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767Ab2KZG0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 01:26:00 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:38749 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab2KZGZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 01:25:59 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so4795284pad.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 22:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=kPC1RuF36RWe/soJQ8jMB/cjKRmpsAAEMQB1VM0Swi0=;
        b=KeJA0k2LHCEZdkOlS2FDPfu9SJYREVC1U0FN1RpmRqHpzqzsams2fxaIn4ir6QJhwZ
         KlzZojwBB3eUrgIZf9sSLMggUj5+Sr9o22sHV0TGdMd5jnaFHHjvpzrCLxijlSzswrE3
         lBDZJAFg8TV5iJRhUxsKLO+Q8ftoA7P51uL3Gei+nunm9sjPoPrNugw5D96klIS2pGyu
         HDAu0I4fvZZ6DhTBn32rxp6FxW4Lpamny7hiMoj9RwtoiZXDUDqdWOln6WeQT8gDa26E
         gMrhsdFtEUrkcqtQxIvZu+4SBRp6ezEclMMomulAGfI/ikIpuAiNVGEptlPh3CkTAyuZ
         Guvg==
Received: by 10.68.209.133 with SMTP id mm5mr35034082pbc.42.1353911158918;
        Sun, 25 Nov 2012 22:25:58 -0800 (PST)
Received: from battlestation.for-the.biz (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id g10sm8225762pav.9.2012.11.25.22.25.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Nov 2012 22:25:58 -0800 (PST)
X-Mailer: git-send-email 1.8.0
X-Gm-Message-State: ALoCoQmOjojT7LGvfZNP1m9M8tiIGhInYoqc9lnaPGJBc9F9qw7Vajy86cnJkgZusG+TCg148srR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210419>

Add config pack.graphcompression similar to pack.compression.
Applies to non-blob objects and if unspecified falls back to pack.compression.

We may identify objects compressed with level 0 by their leading bytes.
Use this to force recompression when the source and target levels mismatch.
Limit its application to when the config pack.graphcompression is set.

Signed-off-by: David Michael Barr <b@rr-dav.id.au>
---
 builtin/pack-objects.c | 49 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

 I started working on this just before taking a vacation,
 so it's been a little while coming.

 The intent is to allow selective recompression of pack data.
 For small objects/deltas the overhead of deflate is significant.
 This may improve read performance for the object graph.

 I ran some unscientific experiments with the chromium repository.
 With pack.graphcompression = 0, there was a 2.7% increase in pack size.
 I saw a 35% improvement with cold caches and 43% otherwise on git log --raw.

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f069462..9518daf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -40,6 +40,7 @@ struct object_entry {
 	unsigned long z_delta_size;	/* delta data size (compressed) */
 	unsigned int hash;	/* name hint hash */
 	enum object_type type;
+	enum object_type actual_type;
 	enum object_type in_pack_type;	/* could be delta */
 	unsigned char in_pack_header_size;
 	unsigned char preferred_base; /* we do not pack this, but is available
@@ -81,6 +82,8 @@ static int num_preferred_base;
 static struct progress *progress_state;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 static int pack_compression_seen;
+static int pack_graph_compression_level = Z_DEFAULT_COMPRESSION;
+static int pack_graph_compression_seen;
 
 static unsigned long delta_cache_size = 0;
 static unsigned long max_delta_cache_size = 256 * 1024 * 1024;
@@ -125,14 +128,14 @@ static void *get_delta(struct object_entry *entry)
 	return delta_buf;
 }
 
-static unsigned long do_compress(void **pptr, unsigned long size)
+static unsigned long do_compress(void **pptr, unsigned long size, int level)
 {
 	git_zstream stream;
 	void *in, *out;
 	unsigned long maxsize;
 
 	memset(&stream, 0, sizeof(stream));
-	git_deflate_init(&stream, pack_compression_level);
+	git_deflate_init(&stream, level);
 	maxsize = git_deflate_bound(&stream, size);
 
 	in = *pptr;
@@ -191,6 +194,18 @@ static unsigned long write_large_blob_data(struct git_istream *st, struct sha1fi
 	return olen;
 }
 
+static int check_pack_compressed(struct packed_git *p,
+		struct pack_window **w_curs,
+		off_t offset)
+{
+	unsigned long avail;
+	int compressed = 0;
+	unsigned char *in = use_pack(p, w_curs, offset, &avail);
+	if (avail >= 3)
+		compressed = !!(in[2] & 0x6);
+	return compressed;
+}
+
 /*
  * we are going to reuse the existing object data as is.  make
  * sure it is not corrupt.
@@ -240,6 +255,8 @@ static void copy_pack_data(struct sha1file *f,
 	}
 }
 
+#define compression_level(type) ((type) && (type) != OBJ_BLOB ? pack_graph_compression_level : pack_compression_level)
+
 /* Return 0 if we will bust the pack-size limit */
 static unsigned long write_no_reuse_object(struct sha1file *f, struct object_entry *entry,
 					   unsigned long limit, int usable_delta)
@@ -286,7 +303,7 @@ static unsigned long write_no_reuse_object(struct sha1file *f, struct object_ent
 	else if (entry->z_delta_size)
 		datalen = entry->z_delta_size;
 	else
-		datalen = do_compress(&buf, size);
+		datalen = do_compress(&buf, size, compression_level(entry->actual_type));
 
 	/*
 	 * The object header is a byte of 'type' followed by zero or
@@ -379,6 +396,13 @@ static unsigned long write_reuse_object(struct sha1file *f, struct object_entry
 	offset += entry->in_pack_header_size;
 	datalen -= entry->in_pack_header_size;
 
+	if (!pack_to_stdout &&
+	    pack_graph_compression_seen &&
+	    check_pack_compressed(p, &w_curs, offset) != !!compression_level(entry->actual_type)) {
+		unuse_pack(&w_curs);
+		return write_no_reuse_object(f, entry, limit, usable_delta);
+	}
+
 	if (!pack_to_stdout && p->index_version == 1 &&
 	    check_pack_inflate(p, &w_curs, offset, datalen, entry->size)) {
 		error("corrupt packed object for %s", sha1_to_hex(entry->idx.sha1));
@@ -955,6 +979,8 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	memset(entry, 0, sizeof(*entry));
 	hashcpy(entry->idx.sha1, sha1);
 	entry->hash = hash;
+	if (pack_graph_compression_seen)
+		entry->actual_type = sha1_object_info(sha1, NULL);
 	if (type)
 		entry->type = type;
 	if (exclude)
@@ -1758,7 +1784,8 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		 */
 		if (entry->delta_data && !pack_to_stdout) {
 			entry->z_delta_size = do_compress(&entry->delta_data,
-							  entry->delta_size);
+							  entry->delta_size,
+							  compression_level(entry->actual_type));
 			cache_lock();
 			delta_cache_size -= entry->delta_size;
 			delta_cache_size += entry->z_delta_size;
@@ -2159,6 +2186,16 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			    pack_idx_opts.version);
 		return 0;
 	}
+	if (!strcmp(k, "pack.graphcompression")) {
+		int level = git_config_int(k, v);
+		if (level == -1)
+			level = Z_DEFAULT_COMPRESSION;
+		else if (level < 0 || level > Z_BEST_COMPRESSION)
+			die("bad pack graph compression level %d", level);
+		pack_graph_compression_level = level;
+		pack_graph_compression_seen = 1;
+		return 0;
+	}
 	return git_default_config(k, v, cb);
 }
 
@@ -2519,6 +2556,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, pack_objects_options,
 			     pack_usage, 0);
 
+	/* Fall back after option parsing to catch --compression */
+	if (!pack_graph_compression_seen)
+		pack_graph_compression_level = pack_compression_level;
+
 	if (argc) {
 		base_name = argv[0];
 		argc--;
-- 
1.8.0
