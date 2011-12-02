From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/6] bulk-checkin: support chunked-object encoding
Date: Thu,  1 Dec 2011 16:40:48 -0800
Message-ID: <1322786449-25753-6-git-send-email-gitster@pobox.com>
References: <1322699263-14475-6-git-send-email-gitster@pobox.com>
 <1322786449-25753-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 01:41:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWHCF-0007B0-UP
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 01:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128Ab1LBAlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 19:41:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50133 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756105Ab1LBAlD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 19:41:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63D0A6B35
	for <git@vger.kernel.org>; Thu,  1 Dec 2011 19:41:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zX9X
	59xweQkpHSM6AAvWrW5Lzcw=; b=f0rjUBmK8/+/0pXiiGOAHkr8JQbLNcLE5PMw
	P6ZOP/2b10BLrgsM9nsvPOfY7xx3XoLppbQl/3ofY70ocPvGDm7dk0aGjfoEPBLK
	VO+8E5L6ram3S4EaoCt4zhrGDCc941yGSU6P9/Q61OKLHgp/PvTTM96y4jmnOS4u
	sofOH5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=t0mHWW
	QlZD7OFEtujvHUlD5toy5J9NLsWdT4inMLXyX2IykSlYeCdED/+0Tdfd/+4F1wrw
	moYY6sAYzzngs53wuDueZ4qpxr3E1ltjtAU+vkb+5qAM+0ePgC1blAupXagkFNoO
	0keJrQ/Vd4RuRBSrFNnCzPWAJu+syOYWkVzbA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AA7D6B34
	for <git@vger.kernel.org>; Thu,  1 Dec 2011 19:41:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82C686B33 for
 <git@vger.kernel.org>; Thu,  1 Dec 2011 19:41:01 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc4.177.g4d64
In-Reply-To: <1322786449-25753-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4F0B9ED4-1C7E-11E1-AC83-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186207>

Instead of recording a huge object as a single entry in the packfile,
record it as a concatenation of smaller blob objects. This is primarily to
make it possible to repack repositories with huge objects and transfer
huge objects out of such repositories.

This is the first step of a long and painful journey. We would still need
to teach many codepaths about the new encoding:

 * The streaming checkout codepath must learn how to read these from the
   object store and write a concatenation of component blob contents to
   the working tree. Note that after a repack, a component blob object
   could be represented as a delta to another blob object.

 * The in-core object reading codepath must learn to notice and at least
   reject reading such objects entirely in-core. It is expected that
   nobody is interested in producing a patch out of these huge objects, at
   least initially.

 * The object connectivity machinery must learn that component blob
   objects are reachable from an object that uses them, so that "gc"
   will not lose them, and "fsck" will not complain about them.

 * The pack-object machinery must learn to copy an object that is encoded
   in chunked-object encoding literally to the destination (while perhaps
   validating the object name).

 * The index-pack and verify-pack machineries need to be told about it.

The split-chunk logic used here is kept deliberately useless in order to
avoid distracting the reviewers, and also make sure that the chunked
encoding machinery does not depend any particular chunk splitting
heuristics. We may want to replace it with a better heuristics, perhaps
the one used in "bup" that is based on a self-synchronizing rolling
checksum logic, or something.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile         |    1 +
 bulk-checkin.c   |  127 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 bulk-checkin.h   |    1 +
 cache.h          |    9 +++-
 config.c         |    5 ++
 environment.c    |    1 +
 split-chunk.c    |   28 ++++++++++++
 t/t1050-large.sh |   29 ++++++++++++
 8 files changed, 198 insertions(+), 3 deletions(-)
 create mode 100644 split-chunk.c

diff --git a/Makefile b/Makefile
index 418dd2e..7d2fc3a 100644
--- a/Makefile
+++ b/Makefile
@@ -679,6 +679,7 @@ LIB_OBJS += sha1_name.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
+LIB_OBJS += split-chunk.o
 LIB_OBJS += strbuf.o
 LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6f1ce58..ebdacb8 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -5,6 +5,10 @@
 #include "csum-file.h"
 #include "pack.h"
 
+#ifndef CHUNK_MAX
+#define CHUNK_MAX 2000
+#endif
+
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 
 static struct bulk_checkin_state {
@@ -268,12 +272,131 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 	return 0;
 }
 
+/* This is only called when actually writing the object out */
+static int store_in_chunks(struct bulk_checkin_state *state,
+			   unsigned char result_sha1[],
+			   int fd, size_t size,
+			   enum object_type type, const char *path,
+			   unsigned flags,
+			   struct chunk_ctx *up)
+{
+	struct pack_idx_entry *idx;
+	struct chunk_ctx ctx;
+	unsigned char chunk[CHUNK_MAX][20];
+	unsigned char header[100];
+	unsigned header_len;
+	unsigned chunk_cnt, i;
+	size_t remainder = size;
+	size_t write_size;
+	int status;
+
+	header_len = sprintf((char *)header, "%s %" PRIuMAX,
+			     typename(type), (uintmax_t)size) + 1;
+
+	memset(&ctx, 0, sizeof(ctx));
+	ctx.up = up;
+	git_SHA1_Init(&ctx.ctx);
+	git_SHA1_Update(&ctx.ctx, header, header_len);
+
+	for (chunk_cnt = 0, remainder = size;
+	     remainder && chunk_cnt < CHUNK_MAX - 1;
+	     chunk_cnt++) {
+		size_t chunk_size = carve_chunk(fd, remainder);
+		status = deflate_to_pack(state, chunk[chunk_cnt], fd,
+					 chunk_size, OBJ_BLOB, path, flags,
+					 &ctx);
+		if (status)
+			return status;
+		remainder -= chunk_size;
+	}
+
+	if (remainder) {
+		if (split_size_limit_cfg && split_size_limit_cfg < remainder)
+			status = store_in_chunks(state, chunk[chunk_cnt], fd,
+						 remainder, OBJ_BLOB, path, flags,
+						 &ctx);
+		else
+			status = deflate_to_pack(state, chunk[chunk_cnt], fd,
+						 remainder, OBJ_BLOB, path, flags,
+						 &ctx);
+		if (status)
+			return status;
+		chunk_cnt++;
+	}
+
+	/*
+	 * Now we have chunk_cnt chunks (the last one may be a large
+	 * blob that itself is represented as concatenation of
+	 * multiple blobs).
+	 */
+	git_SHA1_Final(result_sha1, &ctx.ctx);
+	if (already_written(state, result_sha1))
+		return 0;
+
+	/*
+	 * The standard type & size header is followed by
+	 * - the number of chunks (varint)
+	 * - the object names of the chunks (20 * chunk_cnt bytes)
+	 * - the resulting object name (20 bytes)
+	 */
+	type = OBJ_CHUNKED(type);
+	header_len = encode_in_pack_object_header(type, size, header);
+	header_len += encode_in_pack_varint(chunk_cnt, header + header_len);
+
+	write_size = header_len + 20 * (chunk_cnt + 1);
+
+	prepare_to_stream(state, flags);
+	if (state->nr_written &&
+	    pack_size_limit_cfg &&
+	    pack_size_limit_cfg < (state->offset + write_size)) {
+		finish_bulk_checkin(state);
+		prepare_to_stream(state, flags);
+	}
+
+	idx = xcalloc(1, sizeof(*idx));
+	idx->offset = state->offset;
+
+	crc32_begin(state->f);
+	sha1write(state->f, header, header_len);
+	for (i = 0; i < chunk_cnt; i++)
+		sha1write(state->f, chunk[i], 20);
+	sha1write(state->f, result_sha1, 20);
+	idx->crc32 = crc32_end(state->f);
+	hashcpy(idx->sha1, result_sha1);
+	ALLOC_GROW(state->written,
+		   state->nr_written + 1,
+		   state->alloc_written);
+	state->written[state->nr_written++] = idx;
+	state->offset += write_size;
+
+	return 0;
+}
+
 int index_bulk_checkin(unsigned char *sha1,
 		       int fd, size_t size, enum object_type type,
 		       const char *path, unsigned flags)
 {
-	int status = deflate_to_pack(&state, sha1, fd, size, type,
-				     path, flags, NULL);
+	int status;
+
+	/*
+	 * For now, we only deal with blob objects, as validation
+	 * of a huge tree object that is split into chunks will be
+	 * too cumbersome to be worth it.
+	 *
+	 * Note that we only have to use store_in_chunks() codepath
+	 * when we are actually writing things out. deflate_to_pack()
+	 * codepath can hash arbitrarily huge object without keeping
+	 * everything in core just fine.
+	 */
+	if ((flags & HASH_WRITE_OBJECT) &&
+	    type == OBJ_BLOB &&
+	    split_size_limit_cfg &&
+	    split_size_limit_cfg < size)
+		status = store_in_chunks(&state, sha1, fd, size, type,
+					 path, flags, NULL);
+	else
+		status = deflate_to_pack(&state, sha1, fd, size, type,
+					 path, flags, NULL);
 	if (!state.plugged)
 		finish_bulk_checkin(&state);
 	return status;
diff --git a/bulk-checkin.h b/bulk-checkin.h
index 4f599f8..89f1741 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -12,5 +12,6 @@ extern int index_bulk_checkin(unsigned char sha1[],
 
 extern void plug_bulk_checkin(void);
 extern void unplug_bulk_checkin(void);
+extern size_t carve_chunk(int fd, size_t size);
 
 #endif
diff --git a/cache.h b/cache.h
index 4a3b421..374f712 100644
--- a/cache.h
+++ b/cache.h
@@ -384,11 +384,17 @@ enum object_type {
 	OBJ_EXT = 5,
 	OBJ_OFS_DELTA = 6,
 	OBJ_REF_DELTA = 7,
+	/* OBJ_CHUNKED_COMMIT = 8 */
+	/* OBJ_CHUNKED_TREE = 9 */
+	OBJ_CHUNKED_BLOB = 10,
+	/* OBJ_CHUNKED_TAG = 11 */
 	OBJ_ANY,
 	OBJ_MAX
 };
 #define OBJ_LAST_BASE_TYPE OBJ_REF_DELTA
-#define OBJ_LAST_VALID_TYPE OBJ_REF_DELTA
+#define OBJ_LAST_VALID_TYPE OBJ_CHUNKED_BLOB
+#define OBJ_CHUNKED(type) ((type) + 7)
+#define OBJ_DEKNUHC(type) ((type) - 7)
 
 static inline enum object_type object_type(unsigned int mode)
 {
@@ -602,6 +608,7 @@ extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
 extern unsigned long pack_size_limit_cfg;
+extern unsigned long split_size_limit_cfg;
 extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
diff --git a/config.c b/config.c
index c736802..bdc3be1 100644
--- a/config.c
+++ b/config.c
@@ -801,6 +801,11 @@ int git_default_config(const char *var, const char *value, void *dummy)
 		pack_size_limit_cfg = git_config_ulong(var, value);
 		return 0;
 	}
+
+	if (!strcmp(var, "pack.splitsizelimit")) {
+		split_size_limit_cfg = git_config_ulong(var, value);
+		return 0;
+	}
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 31e4284..b66df28 100644
--- a/environment.c
+++ b/environment.c
@@ -61,6 +61,7 @@ int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
 struct startup_info *startup_info;
 unsigned long pack_size_limit_cfg;
+unsigned long split_size_limit_cfg;
 
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
diff --git a/split-chunk.c b/split-chunk.c
new file mode 100644
index 0000000..1b60e63
--- /dev/null
+++ b/split-chunk.c
@@ -0,0 +1,28 @@
+#include "git-compat-util.h"
+#include "bulk-checkin.h"
+
+/* Cut at around 512kB */
+#define TARGET_CHUNK_SIZE_LOG2 19
+#define TARGET_CHUNK_SIZE (1U << TARGET_CHUNK_SIZE_LOG2)
+
+/*
+ * Carve out around 500kB to be stored as a separate blob
+ */
+size_t carve_chunk(int fd, size_t size)
+{
+	size_t chunk_size;
+	off_t seekback = lseek(fd, 0, SEEK_CUR);
+
+	if (seekback == (off_t) -1)
+		die("cannot find the current offset");
+
+	/* Next patch will do something complex to find out where to cut */
+	chunk_size = size;
+	if (TARGET_CHUNK_SIZE < chunk_size)
+		chunk_size = TARGET_CHUNK_SIZE;
+
+	if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
+		return error("cannot seek back");
+
+	return chunk_size;
+}
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 29d6024..d6cb66d 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -100,4 +100,33 @@ test_expect_success 'packsize limit' '
 	)
 '
 
+test_expect_success 'split limit' '
+	test_create_repo split &&
+	(
+		cd split &&
+		git config core.bigfilethreshold 2m &&
+		git config pack.splitsizelimit 1m &&
+
+		test-genrandom "a" $(( 4800 * 1024 )) >split &&
+		git add split &&
+
+		# This should result in a new chunked object "tail"
+		# that shares most of the component blobs in its
+		# early part with "split".
+		cat split >tail &&
+		echo cruft >>tail &&
+		git add tail &&
+
+		# This should result in a new chunked object "head"
+		# that begins with its own unique component blobs
+		# but quickly synchronize and start using the same
+		# component blobs with "split" and "tail", once we
+		# switch to a better chunking heuristics.
+		echo cruft >head &&
+		cat split >>head &&
+		git add head
+
+	)
+'
+
 test_done
-- 
1.7.8.rc4.177.g4d64
