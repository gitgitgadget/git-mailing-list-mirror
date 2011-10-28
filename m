From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] Bulk check-in
Date: Fri, 28 Oct 2011 16:54:11 -0700
Message-ID: <1319846051-462-5-git-send-email-gitster@pobox.com>
References: <1319846051-462-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 29 01:54:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJwFn-0002Xd-31
	for gcvg-git-2@lo.gmane.org; Sat, 29 Oct 2011 01:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933889Ab1J1XyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 19:54:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57678 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933880Ab1J1XyW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 19:54:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A34C06AE4
	for <git@vger.kernel.org>; Fri, 28 Oct 2011 19:54:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Y5wD
	Z/r3xOElLqMhPkDffNJF1LQ=; b=YUs2bAKNsdP4mfCfCsbmHIsQhE4C5LIbtZ2u
	TvpZLfnYl63S8KgiVDIudhiDyKRTVXmCYRPlKYje+ZxaSPorjAegn9ZR75YivtBt
	eVA5X13PhLWKtkT06AIhVyfWpQdssv2n8MSuNcQZt213TN5IkXibe5V0Q0vt387a
	X10n6IM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vhQLjz
	vdCR4N/qZa7NGUIajPUwUMdxPwUXd12bZOXWxjUT471u4bWM+zE8h4qAQ+Y4EUaV
	dZYNn8dxiECAw/oqROkWtDEBLe0ayAqCPOZ80fA8IkXYXfE5rUyBFRprpbGlR/lj
	745A9Fje7HLjE1lWvdPnMtewBu3c5JeUa6Ths=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AABB6AE3
	for <git@vger.kernel.org>; Fri, 28 Oct 2011 19:54:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C606B6AE2 for
 <git@vger.kernel.org>; Fri, 28 Oct 2011 19:54:20 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.1.573.ga40d2
In-Reply-To: <1319846051-462-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 27A39E88-01C0-11E1-A64F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184443>

This extends the earlier approach to stream a large file directly from the
filesystem to its own packfile, and allows "git add" to send large files
directly into a single pack. Older code used to spawn fast-import, but
the new bulk_checkin API replaces it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile         |    2 +
 builtin/add.c    |    5 ++
 bulk-checkin.c   |  159 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 bulk-checkin.h   |   16 ++++++
 sha1_file.c      |   67 ++---------------------
 t/t1050-large.sh |   26 +++++++--
 6 files changed, 206 insertions(+), 69 deletions(-)
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
diff --git a/bulk-checkin.c b/bulk-checkin.c
new file mode 100644
index 0000000..cad7a0b
--- /dev/null
+++ b/bulk-checkin.c
@@ -0,0 +1,159 @@
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
+	if (state->nr_written == 1) {
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
+	free(state->written);
+	memset(state, 0, sizeof(*state));
+
+	/* Make objects we just wrote available to ourselves */
+	reprepare_packed_git();
+}
+
+static void deflate_to_pack(struct bulk_checkin_state *state,
+			    unsigned char sha1[],
+			    int fd, size_t size, enum object_type type,
+			    const char *path, unsigned flags)
+{
+	unsigned char obuf[16384];
+	unsigned hdrlen;
+	git_zstream s;
+	git_SHA_CTX ctx;
+	int write_object = (flags & HASH_WRITE_OBJECT);
+	int status = Z_OK;
+	struct pack_idx_entry *idx = NULL;
+
+	hdrlen = sprintf((char *)obuf, "%s %" PRIuMAX, typename(type), size) + 1;
+	git_SHA1_Init(&ctx);
+	git_SHA1_Update(&ctx, obuf, hdrlen);
+
+	if (write_object) {
+		idx = xcalloc(1, sizeof(*idx));
+		idx->offset = state->offset;
+		crc32_begin(state->f);
+	}
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
+			git_SHA1_Update(&ctx, ibuf, rsize);
+			s.next_in = ibuf;
+			s.avail_in = rsize;
+			size -= rsize;
+		}
+
+		status = git_deflate(&s, size ? 0 : Z_FINISH);
+
+		if (!s.avail_out || status == Z_STREAM_END) {
+			size_t written = s.next_out - obuf;
+			if (write_object) {
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
+	git_SHA1_Final(sha1, &ctx);
+	if (write_object) {
+		idx->crc32 = crc32_end(state->f);
+		hashcpy(idx->sha1, sha1);
+		ALLOC_GROW(state->written,
+			   state->nr_written + 1, state->alloc_written);
+		state->written[state->nr_written++] = idx;
+	}
+}
+
+int index_bulk_checkin(unsigned char *sha1,
+		       int fd, size_t size, enum object_type type,
+		       const char *path, unsigned flags)
+{
+	if (!state.f && (flags & HASH_WRITE_OBJECT)) {
+		state.f = create_tmp_packfile(&state.pack_tmp_name);
+		reset_pack_idx_option(&state.pack_idx_opts);
+		/* Pretend we are going to write only one object */
+		state.offset = write_pack_header(state.f, 1);
+		if (!state.offset)
+			die_errno("unable to write pack header");
+	}
+
+	deflate_to_pack(&state, sha1, fd, size, type, path, flags);
+	if (!state.plugged)
+		finish_bulk_checkin(&state);
+	return 0;
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
index deba111..36def25 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -7,14 +7,28 @@ test_description='adding and checking out large blobs'
 
 test_expect_success setup '
 	git config core.bigfilethreshold 200k &&
-	echo X | dd of=large bs=1k seek=2000
+	echo X | dd of=large bs=1k seek=2000 &&
+	echo Y | dd of=huge bs=1k seek=2500
 '
 
-test_expect_success 'add a large file' '
-	git add large &&
-	# make sure we got a packfile and no loose objects
-	test -f .git/objects/pack/pack-*.pack &&
-	test ! -f .git/objects/??/??????????????????????????????????????
+test_expect_success 'add a large file or two' '
+	git add large huge &&
+	# make sure we got a single packfile and no loose objects
+	bad= count=0 &&
+	for p in .git/objects/pack/pack-*.pack
+	do
+		count=$(( $count + 1 ))
+		test -f "$p" && continue
+		bad=t
+	done &&
+	test -z "$bad" &&
+	test $count = 1 &&
+	for l in .git/objects/??/??????????????????????????????????????
+	do
+		test -f "$l" || continue
+		bad=t
+	done &&
+	test -z "$bad"
 '
 
 test_expect_success 'checkout a large file' '
-- 
1.7.7.1.573.ga40d2
