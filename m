From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/5] bulk-checkin: replace fast-import based
 implementation
Date: Wed, 30 Nov 2011 16:27:43 -0800
Message-ID: <1322699263-14475-6-git-send-email-gitster@pobox.com>
References: <1322699263-14475-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 01:28:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVuVX-0003xt-Ps
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 01:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350Ab1LAA17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 19:27:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64998 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753275Ab1LAA14 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 19:27:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D343E5D9E
	for <git@vger.kernel.org>; Wed, 30 Nov 2011 19:27:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=tlR9
	CUZ1wcl6FBi0Z9uqRp1ma1Y=; b=N3zSikZllrKC/IP2dg6hQsNweePVVRyVjTF2
	lvxcnMgs9PJoHr9YAYqsKKSZ9DdYAT0vY9qGP1+rK8e6H7Y5lVi74c9lZQBmHcZz
	eQ0nPIf2jO72LoC0fMSav51p+0JPaUrQGz4xT3uUkCMaqUhfQ/28icBPa7GzDVmK
	W3I6suM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=eMDbo7
	5eN9tkEE1Q/MjxSBcOiu7C875wI+CmO8DMfexgM+CGW6wfd5SWcr/qQa20CcblAN
	GvWEpRW/lKWScr0Zm8dRVpyv2SB8VJJpLGVrvhYCXgrlLLiGaJ3KASCJYELAnIZ4
	r+KoAbdM7v42OEmptxjSsnL6vUahW53e+6SRk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C96875D94
	for <git@vger.kernel.org>; Wed, 30 Nov 2011 19:27:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B07F95D93 for
 <git@vger.kernel.org>; Wed, 30 Nov 2011 19:27:54 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc4.177.g4d64
In-Reply-To: <1322699263-14475-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4FA7F246-1BB3-11E1-BC57-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186148>

This extends the earlier approach to stream a large file directly from the
filesystem to its own packfile, and allows "git add" to send large files
directly into a single pack. Older code used to spawn fast-import, but the
new bulk-checkin API replaces it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile               |    2 +
 builtin/add.c          |    5 +
 builtin/pack-objects.c |    6 +-
 bulk-checkin.c         |  275 ++++++++++++++++++++++++++++++++++++++++++++++++
 bulk-checkin.h         |   16 +++
 cache.h                |    2 +
 config.c               |    4 +
 environment.c          |    1 +
 sha1_file.c            |   67 +-----------
 t/t1050-large.sh       |   94 +++++++++++++++--
 zlib.c                 |    9 ++-
 11 files changed, 403 insertions(+), 78 deletions(-)
 create mode 100644 bulk-checkin.c
 create mode 100644 bulk-checkin.h

diff --git a/Makefile b/Makefile
index 3139c19..418dd2e 100644
--- a/Makefile
+++ b/Makefile
@@ -505,6 +505,7 @@ LIB_H += argv-array.h
 LIB_H += attr.h
 LIB_H += blob.h
 LIB_H += builtin.h
+LIB_H += bulk-checkin.h
 LIB_H += cache.h
 LIB_H += cache-tree.h
 LIB_H += color.h
@@ -591,6 +592,7 @@ LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
 LIB_OBJS += blob.o
 LIB_OBJS += branch.o
+LIB_OBJS += bulk-checkin.o
 LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
 LIB_OBJS += color.o
diff --git a/builtin/add.c b/builtin/add.c
index c59b0c9..1c42900 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -13,6 +13,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "revision.h"
+#include "bulk-checkin.h"
 
 static const char * const builtin_add_usage[] = {
 	"git add [options] [--] <filepattern>...",
@@ -458,11 +459,15 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		free(seen);
 	}
 
+	plug_bulk_checkin();
+
 	exit_status |= add_files_to_cache(prefix, pathspec, flags);
 
 	if (add_new_files)
 		exit_status |= add_files(&dir, flags);
 
+	unplug_bulk_checkin();
+
  finish:
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b458b6d..dde913e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -76,7 +76,7 @@ static struct pack_idx_option pack_idx_opts;
 static const char *base_name;
 static int progress = 1;
 static int window = 10;
-static unsigned long pack_size_limit, pack_size_limit_cfg;
+static unsigned long pack_size_limit;
 static int depth = 50;
 static int delta_search_threads;
 static int pack_to_stdout;
@@ -2009,10 +2009,6 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			    pack_idx_opts.version);
 		return 0;
 	}
-	if (!strcmp(k, "pack.packsizelimit")) {
-		pack_size_limit_cfg = git_config_ulong(k, v);
-		return 0;
-	}
 	return git_default_config(k, v, cb);
 }
 
diff --git a/bulk-checkin.c b/bulk-checkin.c
new file mode 100644
index 0000000..807463e
--- /dev/null
+++ b/bulk-checkin.c
@@ -0,0 +1,275 @@
+/*
+ * Copyright (c) 2011, Google Inc.
+ */
+#include "bulk-checkin.h"
+#include "csum-file.h"
+#include "pack.h"
+
+static int pack_compression_level = Z_DEFAULT_COMPRESSION;
+
+static struct bulk_checkin_state {
+	unsigned plugged:1;
+
+	char *pack_tmp_name;
+	struct sha1file *f;
+	off_t offset;
+	struct pack_idx_option pack_idx_opts;
+
+	struct pack_idx_entry **written;
+	uint32_t alloc_written;
+	uint32_t nr_written;
+} state;
+
+static void finish_bulk_checkin(struct bulk_checkin_state *state)
+{
+	unsigned char sha1[20];
+	char packname[PATH_MAX];
+	int i;
+
+	if (!state->f)
+		return;
+
+	if (state->nr_written == 0) {
+		close(state->f->fd);
+		unlink(state->pack_tmp_name);
+		goto clear_exit;
+	} else if (state->nr_written == 1) {
+		sha1close(state->f, sha1, CSUM_FSYNC);
+	} else {
+		int fd = sha1close(state->f, sha1, 0);
+		fixup_pack_header_footer(fd, sha1, state->pack_tmp_name,
+					 state->nr_written, sha1,
+					 state->offset);
+		close(fd);
+	}
+
+	sprintf(packname, "%s/pack/pack-", get_object_directory());
+	finish_tmp_packfile(packname, state->pack_tmp_name,
+			    state->written, state->nr_written,
+			    &state->pack_idx_opts, sha1);
+	for (i = 0; i < state->nr_written; i++)
+		free(state->written[i]);
+
+clear_exit:
+	free(state->written);
+	memset(state, 0, sizeof(*state));
+
+	/* Make objects we just wrote available to ourselves */
+	reprepare_packed_git();
+}
+
+static int already_written(struct bulk_checkin_state *state, unsigned char sha1[])
+{
+	int i;
+
+	/* The object may already exist in the repository */
+	if (has_sha1_file(sha1))
+		return 1;
+
+	/* Might want to keep the list sorted */
+	for (i = 0; i < state->nr_written; i++)
+		if (!hashcmp(state->written[i]->sha1, sha1))
+			return 1;
+
+	/* This is a new object we need to keep */
+	return 0;
+}
+
+/*
+ * Read the contents from fd for size bytes, streaming it to the
+ * packfile in state while updating the hash in ctx. Signal a failure
+ * by returning a negative value when the resulting pack would exceed
+ * the pack size limit and this is not the first object in the pack,
+ * so that the caller can discard what we wrote from the current pack
+ * by truncating it and opening a new one. The caller will then call
+ * us again after rewinding the input fd.
+ *
+ * The already_hashed_to pointer is kept untouched by the caller to
+ * make sure we do not hash the same byte when we are called
+ * again. This way, the caller does not have to checkpoint its hash
+ * status before calling us just in case we ask it to call us again
+ * with a new pack.
+ */
+static int stream_to_pack(struct bulk_checkin_state *state,
+			  git_SHA_CTX *ctx, off_t *already_hashed_to,
+			  int fd, size_t size, enum object_type type,
+			  const char *path, unsigned flags)
+{
+	git_zstream s;
+	unsigned char obuf[16384];
+	unsigned hdrlen;
+	int status = Z_OK;
+	int write_object = (flags & HASH_WRITE_OBJECT);
+	off_t offset = 0;
+
+	memset(&s, 0, sizeof(s));
+	git_deflate_init(&s, pack_compression_level);
+
+	hdrlen = encode_in_pack_object_header(type, size, obuf);
+	s.next_out = obuf + hdrlen;
+	s.avail_out = sizeof(obuf) - hdrlen;
+
+	while (status != Z_STREAM_END) {
+		unsigned char ibuf[16384];
+
+		if (size && !s.avail_in) {
+			ssize_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
+			if (xread(fd, ibuf, rsize) != rsize)
+				die("failed to read %d bytes from '%s'",
+				    (int)rsize, path);
+			offset += rsize;
+			if (*already_hashed_to < offset) {
+				size_t hsize = offset - *already_hashed_to;
+				if (rsize < hsize)
+					hsize = rsize;
+				if (hsize)
+					git_SHA1_Update(ctx, ibuf, hsize);
+				*already_hashed_to = offset;
+			}
+			s.next_in = ibuf;
+			s.avail_in = rsize;
+			size -= rsize;
+		}
+
+		status = git_deflate(&s, size ? 0 : Z_FINISH);
+
+		if (!s.avail_out || status == Z_STREAM_END) {
+			if (write_object) {
+				size_t written = s.next_out - obuf;
+
+				/* would we bust the size limit? */
+				if (state->nr_written &&
+				    pack_size_limit_cfg &&
+				    pack_size_limit_cfg < state->offset + written) {
+					git_deflate_abort(&s);
+					return -1;
+				}
+
+				sha1write(state->f, obuf, written);
+				state->offset += written;
+			}
+			s.next_out = obuf;
+			s.avail_out = sizeof(obuf);
+		}
+
+		switch (status) {
+		case Z_OK:
+		case Z_BUF_ERROR:
+		case Z_STREAM_END:
+			continue;
+		default:
+			die("unexpected deflate failure: %d", status);
+		}
+	}
+	git_deflate_end(&s);
+	return 0;
+}
+
+/* Lazily create backing packfile for the state */
+static void prepare_to_stream(struct bulk_checkin_state *state,
+			      unsigned flags)
+{
+	if (!(flags & HASH_WRITE_OBJECT) || state->f)
+		return;
+
+	state->f = create_tmp_packfile(&state->pack_tmp_name);
+	reset_pack_idx_option(&state->pack_idx_opts);
+
+	/* Pretend we are going to write only one object */
+	state->offset = write_pack_header(state->f, 1);
+	if (!state->offset)
+		die_errno("unable to write pack header");
+}
+
+static int deflate_to_pack(struct bulk_checkin_state *state,
+			   unsigned char result_sha1[],
+			   int fd, size_t size,
+			   enum object_type type, const char *path,
+			   unsigned flags)
+{
+	off_t seekback, already_hashed_to;
+	git_SHA_CTX ctx;
+	unsigned char obuf[16384];
+	unsigned header_len;
+	struct sha1file_checkpoint checkpoint;
+	struct pack_idx_entry *idx = NULL;
+
+	seekback = lseek(fd, 0, SEEK_CUR);
+	if (seekback == (off_t) -1)
+		return error("cannot find the current offset");
+
+	header_len = sprintf((char *)obuf, "%s %" PRIuMAX,
+			     typename(type), (uintmax_t)size) + 1;
+	git_SHA1_Init(&ctx);
+	git_SHA1_Update(&ctx, obuf, header_len);
+
+	/* Note: idx is non-NULL when we are writing */
+	if ((flags & HASH_WRITE_OBJECT) != 0)
+		idx = xcalloc(1, sizeof(*idx));
+
+	already_hashed_to = seekback;
+
+	while (1) {
+		prepare_to_stream(state, flags);
+		if (idx) {
+			sha1file_checkpoint(state->f, &checkpoint);
+			idx->offset = state->offset;
+			crc32_begin(state->f);
+		}
+		if (!stream_to_pack(state, &ctx, &already_hashed_to,
+				    fd, size, type, path, flags))
+			break;
+		/*
+		 * Writing this object to the current pack will make
+		 * it too big; we need to truncate it, start a new
+		 * pack, and write into it.
+		 */
+		if (!idx)
+			die("BUG: should not happen");
+		sha1file_truncate(state->f, &checkpoint);
+		state->offset = checkpoint.offset;
+		finish_bulk_checkin(state);
+		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
+			return error("cannot seek back");
+	}
+	git_SHA1_Final(result_sha1, &ctx);
+	if (!idx)
+		return 0;
+
+	if (already_written(state, result_sha1)) {
+		sha1file_truncate(state->f, &checkpoint);
+		state->offset = checkpoint.offset;
+		free(idx);
+	} else {
+		idx->crc32 = crc32_end(state->f);
+		hashcpy(idx->sha1, result_sha1);
+		ALLOC_GROW(state->written,
+			   state->nr_written + 1,
+			   state->alloc_written);
+		state->written[state->nr_written++] = idx;
+	}
+	return 0;
+}
+
+int index_bulk_checkin(unsigned char *sha1,
+		       int fd, size_t size, enum object_type type,
+		       const char *path, unsigned flags)
+{
+	int status = deflate_to_pack(&state, sha1, fd, size, type,
+				     path, flags);
+	if (!state.plugged)
+		finish_bulk_checkin(&state);
+	return status;
+}
+
+void plug_bulk_checkin(void)
+{
+	state.plugged = 1;
+}
+
+void unplug_bulk_checkin(void)
+{
+	state.plugged = 0;
+	if (state.f)
+		finish_bulk_checkin(&state);
+}
diff --git a/bulk-checkin.h b/bulk-checkin.h
new file mode 100644
index 0000000..4f599f8
--- /dev/null
+++ b/bulk-checkin.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (c) 2011, Google Inc.
+ */
+#ifndef BULK_CHECKIN_H
+#define BULK_CHECKIN_H
+
+#include "cache.h"
+
+extern int index_bulk_checkin(unsigned char sha1[],
+			      int fd, size_t size, enum object_type type,
+			      const char *path, unsigned flags);
+
+extern void plug_bulk_checkin(void);
+extern void unplug_bulk_checkin(void);
+
+#endif
diff --git a/cache.h b/cache.h
index 2e6ad36..4f20861 100644
--- a/cache.h
+++ b/cache.h
@@ -35,6 +35,7 @@ int git_inflate(git_zstream *, int flush);
 void git_deflate_init(git_zstream *, int level);
 void git_deflate_init_gzip(git_zstream *, int level);
 void git_deflate_end(git_zstream *);
+int git_deflate_abort(git_zstream *);
 int git_deflate_end_gently(git_zstream *);
 int git_deflate(git_zstream *, int flush);
 unsigned long git_deflate_bound(git_zstream *, unsigned long);
@@ -598,6 +599,7 @@ extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
+extern unsigned long pack_size_limit_cfg;
 extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
diff --git a/config.c b/config.c
index edf9914..c736802 100644
--- a/config.c
+++ b/config.c
@@ -797,6 +797,10 @@ int git_default_config(const char *var, const char *value, void *dummy)
 		return 0;
 	}
 
+	if (!strcmp(var, "pack.packsizelimit")) {
+		pack_size_limit_cfg = git_config_ulong(var, value);
+		return 0;
+	}
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 0bee6a7..31e4284 100644
--- a/environment.c
+++ b/environment.c
@@ -60,6 +60,7 @@ char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
 struct startup_info *startup_info;
+unsigned long pack_size_limit_cfg;
 
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
diff --git a/sha1_file.c b/sha1_file.c
index 27f3b9b..c96e366 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -18,6 +18,7 @@
 #include "refs.h"
 #include "pack-revindex.h"
 #include "sha1-lookup.h"
+#include "bulk-checkin.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -2679,10 +2680,8 @@ static int index_core(unsigned char *sha1, int fd, size_t size,
 }
 
 /*
- * This creates one packfile per large blob, because the caller
- * immediately wants the result sha1, and fast-import can report the
- * object name via marks mechanism only by closing the created
- * packfile.
+ * This creates one packfile per large blob unless bulk-checkin
+ * machinery is "plugged".
  *
  * This also bypasses the usual "convert-to-git" dance, and that is on
  * purpose. We could write a streaming version of the converting
@@ -2696,65 +2695,7 @@ static int index_stream(unsigned char *sha1, int fd, size_t size,
 			enum object_type type, const char *path,
 			unsigned flags)
 {
-	struct child_process fast_import;
-	char export_marks[512];
-	const char *argv[] = { "fast-import", "--quiet", export_marks, NULL };
-	char tmpfile[512];
-	char fast_import_cmd[512];
-	char buf[512];
-	int len, tmpfd;
-
-	strcpy(tmpfile, git_path("hashstream_XXXXXX"));
-	tmpfd = git_mkstemp_mode(tmpfile, 0600);
-	if (tmpfd < 0)
-		die_errno("cannot create tempfile: %s", tmpfile);
-	if (close(tmpfd))
-		die_errno("cannot close tempfile: %s", tmpfile);
-	sprintf(export_marks, "--export-marks=%s", tmpfile);
-
-	memset(&fast_import, 0, sizeof(fast_import));
-	fast_import.in = -1;
-	fast_import.argv = argv;
-	fast_import.git_cmd = 1;
-	if (start_command(&fast_import))
-		die_errno("index-stream: git fast-import failed");
-
-	len = sprintf(fast_import_cmd, "blob\nmark :1\ndata %lu\n",
-		      (unsigned long) size);
-	write_or_whine(fast_import.in, fast_import_cmd, len,
-		       "index-stream: feeding fast-import");
-	while (size) {
-		char buf[10240];
-		size_t sz = size < sizeof(buf) ? size : sizeof(buf);
-		ssize_t actual;
-
-		actual = read_in_full(fd, buf, sz);
-		if (actual < 0)
-			die_errno("index-stream: reading input");
-		if (write_in_full(fast_import.in, buf, actual) != actual)
-			die_errno("index-stream: feeding fast-import");
-		size -= actual;
-	}
-	if (close(fast_import.in))
-		die_errno("index-stream: closing fast-import");
-	if (finish_command(&fast_import))
-		die_errno("index-stream: finishing fast-import");
-
-	tmpfd = open(tmpfile, O_RDONLY);
-	if (tmpfd < 0)
-		die_errno("index-stream: cannot open fast-import mark");
-	len = read(tmpfd, buf, sizeof(buf));
-	if (len < 0)
-		die_errno("index-stream: reading fast-import mark");
-	if (close(tmpfd) < 0)
-		die_errno("index-stream: closing fast-import mark");
-	if (unlink(tmpfile))
-		die_errno("index-stream: unlinking fast-import mark");
-	if (len != 44 ||
-	    memcmp(":1 ", buf, 3) ||
-	    get_sha1_hex(buf + 3, sha1))
-		die_errno("index-stream: unexpected fast-import mark: <%s>", buf);
-	return 0;
+	return index_bulk_checkin(sha1, fd, size, type, path, flags);
 }
 
 int index_fd(unsigned char *sha1, int fd, struct stat *st,
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index deba111..29d6024 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -7,21 +7,97 @@ test_description='adding and checking out large blobs'
 
 test_expect_success setup '
 	git config core.bigfilethreshold 200k &&
-	echo X | dd of=large bs=1k seek=2000
+	echo X | dd of=large1 bs=1k seek=2000 &&
+	echo X | dd of=large2 bs=1k seek=2000 &&
+	echo X | dd of=large3 bs=1k seek=2000 &&
+	echo Y | dd of=huge bs=1k seek=2500
 '
 
-test_expect_success 'add a large file' '
-	git add large &&
-	# make sure we got a packfile and no loose objects
-	test -f .git/objects/pack/pack-*.pack &&
-	test ! -f .git/objects/??/??????????????????????????????????????
+test_expect_success 'add a large file or two' '
+	git add large1 huge large2 &&
+	# make sure we got a single packfile and no loose objects
+	bad= count=0 idx= &&
+	for p in .git/objects/pack/pack-*.pack
+	do
+		count=$(( $count + 1 ))
+		if test -f "$p" && idx=${p%.pack}.idx && test -f "$idx"
+		then
+			continue
+		fi
+		bad=t
+	done &&
+	test -z "$bad" &&
+	test $count = 1 &&
+	cnt=$(git show-index <"$idx" | wc -l) &&
+	test $cnt = 2 &&
+	for l in .git/objects/??/??????????????????????????????????????
+	do
+		test -f "$l" || continue
+		bad=t
+	done &&
+	test -z "$bad" &&
+
+	# attempt to add another copy of the same
+	git add large3 &&
+	bad= count=0 &&
+	for p in .git/objects/pack/pack-*.pack
+	do
+		count=$(( $count + 1 ))
+		if test -f "$p" && idx=${p%.pack}.idx && test -f "$idx"
+		then
+			continue
+		fi
+		bad=t
+	done &&
+	test -z "$bad" &&
+	test $count = 1
 '
 
 test_expect_success 'checkout a large file' '
-	large=$(git rev-parse :large) &&
-	git update-index --add --cacheinfo 100644 $large another &&
+	large1=$(git rev-parse :large1) &&
+	git update-index --add --cacheinfo 100644 $large1 another &&
 	git checkout another &&
-	cmp large another ;# this must not be test_cmp
+	cmp large1 another ;# this must not be test_cmp
+'
+
+test_expect_success 'packsize limit' '
+	test_create_repo mid &&
+	(
+		cd mid &&
+		git config core.bigfilethreshold 64k &&
+		git config pack.packsizelimit 256k &&
+
+		# mid1 and mid2 will fit within 256k limit but
+		# appending mid3 will bust the limit and will
+		# result in a separate packfile.
+		test-genrandom "a" $(( 66 * 1024 )) >mid1 &&
+		test-genrandom "b" $(( 80 * 1024 )) >mid2 &&
+		test-genrandom "c" $(( 128 * 1024 )) >mid3 &&
+		git add mid1 mid2 mid3 &&
+
+		count=0
+		for pi in .git/objects/pack/pack-*.idx
+		do
+			test -f "$pi" && count=$(( $count + 1 ))
+		done &&
+		test $count = 2 &&
+
+		(
+			git hash-object --stdin <mid1
+			git hash-object --stdin <mid2
+			git hash-object --stdin <mid3
+		) |
+		sort >expect &&
+
+		for pi in .git/objects/pack/pack-*.idx
+		do
+			git show-index <"$pi"
+		done |
+		sed -e "s/^[0-9]* \([0-9a-f]*\) .*/\1/" |
+		sort >actual &&
+
+		test_cmp expect actual
+	)
 '
 
 test_done
diff --git a/zlib.c b/zlib.c
index 3c63d48..2b2c0c7 100644
--- a/zlib.c
+++ b/zlib.c
@@ -188,13 +188,20 @@ void git_deflate_init_gzip(git_zstream *strm, int level)
 	    strm->z.msg ? strm->z.msg : "no message");
 }
 
-void git_deflate_end(git_zstream *strm)
+int git_deflate_abort(git_zstream *strm)
 {
 	int status;
 
 	zlib_pre_call(strm);
 	status = deflateEnd(&strm->z);
 	zlib_post_call(strm);
+	return status;
+}
+
+void git_deflate_end(git_zstream *strm)
+{
+	int status = git_deflate_abort(strm);
+
 	if (status == Z_OK)
 		return;
 	error("deflateEnd: %s (%s)", zerr_to_string(status),
-- 
1.7.8.rc4.177.g4d64
