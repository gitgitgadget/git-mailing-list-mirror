Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358D5C433EF
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 08:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D9E760F8F
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 08:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhJIIXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 04:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJIIXH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 04:23:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CBDC061570
        for <git@vger.kernel.org>; Sat,  9 Oct 2021 01:21:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso10487620pjb.4
        for <git@vger.kernel.org>; Sat, 09 Oct 2021 01:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pEz22nQ/Tj3oPWHtjnsLy25KBD+x056U4Pr2DkzNlmU=;
        b=ZRz5fONuy0a6IZIX+aiKS1YHWRBSWuSZ7YCPlNndw9D7LLk2Sey8E23VEqhkepSZ1T
         xv/84UMuenS+BQD2uf10RdC9u3/HWFUxp6cum9s7u5BrA2yMXT24TWCz+RD7NtHnKhRj
         5jU47GaoDg8qp9NQ4J5NrKoPvC8+cqEG2B+pl///LVDVhrfHHY6fntXVCqYQN3FgNhoM
         htilp8MwEqTJmYjG/6qgClxQipon42/ORH07OEJ4zax0JYgEyO1LEtxGAeDnvkBEAfCE
         /rEnkodaPU3zXlcqTcaITKVNIF17RQAKaFY8xskATRAb5Uc9XttHu+xf+oeXGkioZzHg
         gbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pEz22nQ/Tj3oPWHtjnsLy25KBD+x056U4Pr2DkzNlmU=;
        b=7w+I+YfLqNBVKtymLLRmfWJ7YsCrj27wIP/FWWbBtSqwf1Ie6vhgJeroTW1rK5mMa5
         Au21Y71QN8sHdqzve2/u/DxQFZTNdgJPBD95hjfVVt65p5uDEamQD97mx+9/kzVBYwYB
         JV0lYokWIyEeHj8aH9N9Mi1b+pC+EviNDWDwF2SPy5qaqvuEMU7nn6Dmg0DXncz7qfPT
         nl39DB9Ho6AxLIj5W1VIIOAgvDaL6ldbjDDOXpjd99pPwEysEG7ise9yFu+8ErjpWTXw
         G+GrA32Vy562MbTzg4YDDMMMQmXbGf1vAqNgShrFdy3opeSc74/P9ObVq/PpLvCsSXQo
         J3TA==
X-Gm-Message-State: AOAM530iMMs3tdKSSMqO3Ccvz3PbvA7j2hr2QtVT6jaks1tXVb7ABNog
        0YfMlJr3LB1eHLmZ4liJs/E=
X-Google-Smtp-Source: ABdhPJyvmztzFWDJgHMKWtlx5bjx5OTJ7s7NavEr5UjXS68aduDryyxGzkwu5z0Hf05FZC1UFi00zg==
X-Received: by 2002:a17:90a:1f4a:: with SMTP id y10mr16483409pjy.225.1633767669086;
        Sat, 09 Oct 2021 01:21:09 -0700 (PDT)
Received: from localhost.localdomain ([58.100.47.145])
        by smtp.gmail.com with ESMTPSA id f20sm1710551pga.12.2021.10.09.01.21.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Oct 2021 01:21:08 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH] unpack-objects: unpack large object in stream
Date:   Sat,  9 Oct 2021 16:20:58 +0800
Message-Id: <20211009082058.41138-1-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.33.0.1.g09a6bb964f.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

When calling "unpack_non_delta_entry()", will allocate full memory for
the whole size of the unpacked object and write the buffer to loose file
on disk. This may lead to OOM for the git-unpack-objects process when
unpacking a very large object.

In function "unpack_delta_entry()", will also allocate full memory to
buffer the whole delta, but since there will be no delta for an object
larger than "core.bigFileThreshold", this issue is moderate.

To resolve the OOM issue in "git-unpack-objects", we can unpack large
object to file in stream, and use the setting of "core.bigFileThreshold" as
the threshold for large object.

Reviewed-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 builtin/unpack-objects.c          |  41 +++++++-
 object-file.c                     | 149 +++++++++++++++++++++++++++---
 object-store.h                    |   9 ++
 t/t5590-receive-unpack-objects.sh |  92 ++++++++++++++++++
 4 files changed, 279 insertions(+), 12 deletions(-)
 create mode 100755 t/t5590-receive-unpack-objects.sh

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4a9466295b..8ac77e60a8 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -320,11 +320,50 @@ static void added_object(unsigned nr, enum object_type type,
 	}
 }
 
+static void fill_stream(struct git_zstream *stream)
+{
+	stream->next_in = fill(1);
+	stream->avail_in = len;
+}
+
+static void use_stream(struct git_zstream *stream)
+{
+	use(len - stream->avail_in);
+}
+
+static void write_stream_blob(unsigned nr, unsigned long size)
+{
+	struct git_zstream_reader reader;
+	struct object_id *oid = &obj_list[nr].oid;
+
+	reader.fill = &fill_stream;
+	reader.use = &use_stream;
+
+	if (write_stream_object_file(&reader, size, type_name(OBJ_BLOB),
+				     oid, dry_run))
+		die("failed to write object in stream");
+	if (strict && !dry_run) {
+		struct blob *blob = lookup_blob(the_repository, oid);
+		if (blob)
+			blob->object.flags |= FLAG_WRITTEN;
+		else
+			die("invalid blob object from stream");
+	}
+	obj_list[nr].obj = NULL;
+}
+
 static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 				   unsigned nr)
 {
-	void *buf = get_data(size);
+	void *buf;
+
+	/* Write large blob in stream without allocating full buffer. */
+	if (type == OBJ_BLOB && size > big_file_threshold) {
+		write_stream_blob(nr, size);
+		return;
+	}
 
+	buf = get_data(size);
 	if (!dry_run && buf)
 		write_object(nr, type, buf, size);
 	else
diff --git a/object-file.c b/object-file.c
index a8be899481..06c1693675 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1913,6 +1913,28 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 	return fd;
 }
 
+static int write_object_buffer(struct git_zstream *stream, git_hash_ctx *c,
+			       int fd, unsigned char *compressed,
+			       int compressed_len, const void *buf,
+			       size_t len, int flush)
+{
+	int ret;
+
+	stream->next_in = (void *)buf;
+	stream->avail_in = len;
+	do {
+		unsigned char *in0 = stream->next_in;
+		ret = git_deflate(stream, flush);
+		the_hash_algo->update_fn(c, in0, stream->next_in - in0);
+		if (write_buffer(fd, compressed, stream->next_out - compressed) < 0)
+			die(_("unable to write loose object file"));
+		stream->next_out = compressed;
+		stream->avail_out = compressed_len;
+	} while (ret == Z_OK);
+
+	return ret;
+}
+
 static int write_loose_object(const struct object_id *oid, char *hdr,
 			      int hdrlen, const void *buf, unsigned long len,
 			      time_t mtime)
@@ -1949,17 +1971,9 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	the_hash_algo->update_fn(&c, hdr, hdrlen);
 
 	/* Then the data itself.. */
-	stream.next_in = (void *)buf;
-	stream.avail_in = len;
-	do {
-		unsigned char *in0 = stream.next_in;
-		ret = git_deflate(&stream, Z_FINISH);
-		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
-		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
-			die(_("unable to write loose object file"));
-		stream.next_out = compressed;
-		stream.avail_out = sizeof(compressed);
-	} while (ret == Z_OK);
+	ret = write_object_buffer(&stream, &c, fd, compressed,
+				  sizeof(compressed), buf, len,
+				  Z_FINISH);
 
 	if (ret != Z_STREAM_END)
 		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
@@ -2020,6 +2034,119 @@ int write_object_file(const void *buf, unsigned long len, const char *type,
 	return write_loose_object(oid, hdr, hdrlen, buf, len, 0);
 }
 
+int write_stream_object_file(struct git_zstream_reader *reader,
+			     unsigned long len, const char *type,
+			     struct object_id *oid,
+			     int dry_run)
+{
+	git_zstream istream, ostream;
+	unsigned char buf[8192], compressed[4096];
+	char hdr[MAX_HEADER_LEN];
+	int istatus, ostatus, fd = 0, hdrlen, dirlen, flush = 0;
+	int ret = 0;
+	git_hash_ctx c;
+	struct strbuf tmp_file = STRBUF_INIT;
+	struct strbuf filename = STRBUF_INIT;
+
+	/* Write tmpfile in objects dir, because oid is unknown */
+	if (!dry_run) {
+		strbuf_addstr(&filename, the_repository->objects->odb->path);
+		strbuf_addch(&filename, '/');
+		fd = create_tmpfile(&tmp_file, filename.buf);
+		if (fd < 0) {
+			if (errno == EACCES)
+				ret = error(_("insufficient permission for adding an object to repository database %s"),
+					get_object_directory());
+			else
+				ret = error_errno(_("unable to create temporary file"));
+			goto cleanup;
+		}
+	}
+
+	memset(&istream, 0, sizeof(istream));
+	istream.next_out = buf;
+	istream.avail_out = sizeof(buf);
+	git_inflate_init(&istream);
+
+	if (!dry_run) {
+		/* Set it up */
+		git_deflate_init(&ostream, zlib_compression_level);
+		ostream.next_out = compressed;
+		ostream.avail_out = sizeof(compressed);
+		the_hash_algo->init_fn(&c);
+
+		/* First header */
+		hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %" PRIuMAX, type,
+				(uintmax_t)len) + 1;
+		ostream.next_in = (unsigned char *)hdr;
+		ostream.avail_in = hdrlen;
+		while (git_deflate(&ostream, 0) == Z_OK)
+			; /* nothing */
+		the_hash_algo->update_fn(&c, hdr, hdrlen);
+	}
+
+	/* Then the data itself */
+	do {
+		unsigned char *last_out = istream.next_out;
+		reader->fill(&istream);
+		istatus = git_inflate(&istream, 0);
+		if (istatus == Z_STREAM_END)
+			flush = Z_FINISH;
+		reader->use(&istream);
+		if (!dry_run)
+			ostatus = write_object_buffer(&ostream, &c, fd, compressed,
+						      sizeof(compressed), last_out,
+						      istream.next_out - last_out,
+						      flush);
+		istream.next_out = buf;
+		istream.avail_out = sizeof(buf);
+	} while (istatus == Z_OK);
+
+	if (istream.total_out != len || istatus != Z_STREAM_END)
+		die( _("inflate returned %d"), istatus);
+	git_inflate_end(&istream);
+
+	if (dry_run)
+		goto cleanup;
+
+	if (ostatus != Z_STREAM_END)
+		die(_("unable to deflate new object (%d)"), ostatus);
+	ostatus = git_deflate_end_gently(&ostream);
+	if (ostatus != Z_OK)
+		die(_("deflateEnd on object failed (%d)"), ostatus);
+	the_hash_algo->final_fn(oid->hash, &c);
+	close_loose_object(fd);
+
+	/* We get the oid now */
+	loose_object_path(the_repository, &filename, oid);
+
+	dirlen = directory_size(filename.buf);
+	if (dirlen) {
+		struct strbuf dir = STRBUF_INIT;
+		/*
+		 * Make sure the directory exists; note that the contents
+		 * of the buffer are undefined after mkstemp returns an
+		 * error, so we have to rewrite the whole buffer from
+		 * scratch.
+		 */
+		strbuf_add(&dir, filename.buf, dirlen - 1);
+		if (mkdir(dir.buf, 0777) && errno != EEXIST) {
+			unlink_or_warn(tmp_file.buf);
+			strbuf_release(&dir);
+			ret = -1;
+			goto cleanup;
+		}
+		strbuf_release(&dir);
+	}
+
+	ret = finalize_object_file(tmp_file.buf, filename.buf);
+
+cleanup:
+	strbuf_release(&tmp_file);
+	strbuf_release(&filename);
+	return ret;
+}
+
 int hash_object_file_literally(const void *buf, unsigned long len,
 			       const char *type, struct object_id *oid,
 			       unsigned flags)
diff --git a/object-store.h b/object-store.h
index d24915ced1..12b113ef93 100644
--- a/object-store.h
+++ b/object-store.h
@@ -33,6 +33,11 @@ struct object_directory {
 	char *path;
 };
 
+struct git_zstream_reader {
+	void (*fill)(struct git_zstream *);
+	void (*use)(struct git_zstream *);
+};
+
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
 	struct object_directory *, 1, fspathhash, fspatheq)
 
@@ -225,6 +230,10 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 int write_object_file(const void *buf, unsigned long len,
 		      const char *type, struct object_id *oid);
 
+int write_stream_object_file(struct git_zstream_reader *reader,
+			     unsigned long len, const char *type,
+			     struct object_id *oid, int dry_run);
+
 int hash_object_file_literally(const void *buf, unsigned long len,
 			       const char *type, struct object_id *oid,
 			       unsigned flags);
diff --git a/t/t5590-receive-unpack-objects.sh b/t/t5590-receive-unpack-objects.sh
new file mode 100755
index 0000000000..7e63dfc0db
--- /dev/null
+++ b/t/t5590-receive-unpack-objects.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+#
+# Copyright (c) 2021 Han Xin
+#
+
+test_description='Test unpack-objects when receive pack'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success "create commit with big blobs (1.5 MB)" '
+	test-tool genrandom foo 1500000 >big-blob &&
+	test_commit --append foo big-blob &&
+	test-tool genrandom bar 1500000 >big-blob &&
+	test_commit --append bar big-blob &&
+	(
+		cd .git &&
+		find objects/?? -type f | sort
+	) >expect &&
+	git repack -ad
+'
+
+test_expect_success 'setup GIT_ALLOC_LIMIT to 1MB' '
+	GIT_ALLOC_LIMIT=1m &&
+	export GIT_ALLOC_LIMIT
+'
+
+test_expect_success 'prepare dest repository' '
+	git init --bare dest.git &&
+	git -C dest.git config core.bigFileThreshold 2m &&
+	git -C dest.git config receive.unpacklimit 100
+'
+
+test_expect_success 'fail to push: cannot allocate' '
+	test_must_fail git push dest.git HEAD 2>err &&
+	test_i18ngrep "remote: fatal: attempting to allocate" err &&
+	(
+		cd dest.git &&
+		find objects/?? -type f | sort
+	) >actual &&
+	! test_cmp expect actual
+'
+
+test_expect_success 'set a lower bigfile threshold' '
+	git -C dest.git config core.bigFileThreshold 1m
+'
+
+test_expect_success 'unpack big object in stream' '
+	git push dest.git HEAD &&
+	git -C dest.git fsck &&
+	(
+		cd dest.git &&
+		find objects/?? -type f | sort
+	) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for unpack-objects dry-run test' '
+	PACK=$(echo main | git pack-objects --progress --revs test) &&
+	unset GIT_ALLOC_LIMIT &&
+	git init --bare unpack-test.git
+'
+
+test_expect_success 'unpack-objects dry-run with large threshold' '
+	(
+		cd unpack-test.git &&
+		git config core.bigFileThreshold 2m &&
+		git unpack-objects -n <../test-$PACK.pack
+	) &&
+	(
+		cd unpack-test.git &&
+		find objects/ -type f
+	) >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'unpack-objects dry-run with small threshold' '
+	(
+		cd unpack-test.git &&
+		git config core.bigFileThreshold 1m &&
+		git unpack-objects -n <../test-$PACK.pack
+	) &&
+	(
+		cd unpack-test.git &&
+		find objects/ -type f
+	) >actual &&
+	test_must_be_empty actual
+'
+
+test_done
-- 
2.33.0.1.g09a6bb964f.dirty

