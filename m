Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0194259C
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 02:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718935506; cv=none; b=YOBDayDkGts65467C8vsFTXcDB0CRz4avIOB1aIWdic8MVk+ZzXuw100qWIVdHcipbf/q1auliweWSOTRvPj9a+9KkRHBEaj6Xa4CJsfuXb874HnCbciVxv2cWRyHwSI3C2q/p1c0xVkUT4zDI6V4Z0+JFId/Nuaq3Ovgv4EaIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718935506; c=relaxed/simple;
	bh=cKntde42JeC61K+Sz+NabHr5MkSBtcCVXCt0UQShUqU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SMq48WxRZVMT1yLlxVhmtFNGk+Z6PDzYGQXn1TVKTi7mFc884TQGCl+LUCSYa8m+OHV7Wnh66FIglnA4iuwtUx2XNO9zNX3iEDeWJCSbSY63pN9n2jyVl979w5DQHNaIMdsR1ph15+NCrtcXxfKnlcMwyx9Wthwtco8Ur8AggWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=oNY48i0T; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="oNY48i0T"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8065D482F
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 02:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1718935497;
	bh=cKntde42JeC61K+Sz+NabHr5MkSBtcCVXCt0UQShUqU=;
	h=From:To:Subject:Date:From;
	b=oNY48i0TNKasltSPO9MU27ncGh4eYer/W5vjm4LYF8gL6q4uLaDIUQ0Q6xFJIl4+s
	 bnj+/XqfAM2DM6F7MOFAKofu6GNN+TibgBAzMDymDvSnYkQ6ZrHZoBzA9J7EC1X01b
	 qcJPlgJJ/1z7QtnfO6D2N7mOzyWNWLDsy9hVhNhw=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Subject: [PATCH] cat-file: reduce write calls for unfiltered blobs
Date: Fri, 21 Jun 2024 02:04:57 +0000
Message-ID: <20240621020457.1081233-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the --buffer switch is useful for non-interactive batch use,
buffering doesn't work with processes using request-response loops since
idle times are unpredictable between requests.

For unfiltered blobs, our streaming interface now appends the initial
blob data directly into the scratch buffer used for object info.
Furthermore, the final blob chunk can hold the output delimiter before
making the final write(2).

While the same syscall reduction can be done with stdio buffering by
adding fflush(3) after writing the output delimiter, stdio use requires
additional memory copies for the blob contents since it's not possible
for our streaming interface to write directly to stdio internal buffers.

For the reader process, this reduces read(2) syscalls by up to 67% in
the best case for small blobs.  Unfortunately my real-world tests on
normal data only showed only a ~20% reduction in read(2) syscalls on the
reader side due to larger blobs and scheduler unpredictability.  Time
improvements only came out to roughly 0.5% on my laptop, but this may be
more noticeable on systems where syscalls are more expensive.

writev(2) was also considered, but it is not portable and detrimental
given the way our streaming API works.  writev(2) might make more sense
for filtered outputs or reading non-blob data.

Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/cat-file.c | 36 +++++++++++++++++++++------------
 streaming.c        | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 streaming.h        |  1 +
 3 files changed, 74 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 43a1d7ac49..23db5c6a7a 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -87,9 +87,10 @@ static int filter_object(const char *path, unsigned mode,
 	return 0;
 }
 
-static int stream_blob(const struct object_id *oid)
+static int stream_blob(struct strbuf *scratch, const struct object_id *oid)
 {
-	if (stream_blob_to_fd(1, oid, NULL, 0))
+	if (scratch ? stream_blob_to_strbuf_fd(1, scratch, oid) :
+			stream_blob_to_fd(1, oid, NULL, 0))
 		die("unable to stream %s to stdout", oid_to_hex(oid));
 	return 0;
 }
@@ -195,7 +196,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		}
 
 		if (type == OBJ_BLOB) {
-			ret = stream_blob(&oid);
+			ret = stream_blob(NULL, &oid);
 			goto cleanup;
 		}
 		buf = repo_read_object_file(the_repository, &oid, &type,
@@ -237,7 +238,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 				oidcpy(&blob_oid, &oid);
 
 			if (oid_object_info(the_repository, &blob_oid, NULL) == OBJ_BLOB) {
-				ret = stream_blob(&blob_oid);
+				ret = stream_blob(NULL, &blob_oid);
 				goto cleanup;
 			}
 			/*
@@ -376,7 +377,15 @@ static void batch_write(struct batch_options *opt, const void *data, int len)
 		write_or_die(1, data, len);
 }
 
-static void print_object_or_die(struct batch_options *opt, struct expand_data *data)
+static void flush_scratch(struct batch_options *opt, struct strbuf *scratch)
+{
+	batch_write(opt, scratch->buf, scratch->len);
+	strbuf_reset(scratch);
+}
+
+static void print_object_or_die(struct strbuf *scratch,
+				struct batch_options *opt,
+				struct expand_data *data)
 {
 	const struct object_id *oid = &data->oid;
 
@@ -389,6 +398,8 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 			char *contents;
 			unsigned long size;
 
+			flush_scratch(opt, scratch);
+
 			if (!data->rest)
 				die("missing path for '%s'", oid_to_hex(oid));
 
@@ -414,7 +425,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 			batch_write(opt, contents, size);
 			free(contents);
 		} else {
-			stream_blob(oid);
+			stream_blob(scratch, oid);
 		}
 	}
 	else {
@@ -422,6 +433,8 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 		unsigned long size;
 		void *contents;
 
+		flush_scratch(opt, scratch);
+
 		contents = repo_read_object_file(the_repository, oid, &type,
 						 &size);
 		if (!contents)
@@ -498,8 +511,6 @@ static void batch_object_write(const char *obj_name,
 		}
 	}
 
-	strbuf_reset(scratch);
-
 	if (!opt->format) {
 		print_default_format(scratch, data, opt);
 	} else {
@@ -507,12 +518,11 @@ static void batch_object_write(const char *obj_name,
 		strbuf_addch(scratch, opt->output_delim);
 	}
 
-	batch_write(opt, scratch->buf, scratch->len);
-
 	if (opt->batch_mode == BATCH_MODE_CONTENTS) {
-		print_object_or_die(opt, data);
-		batch_write(opt, &opt->output_delim, 1);
+		print_object_or_die(scratch, opt, data);
+		strbuf_addch(scratch, opt->output_delim);
 	}
+	flush_scratch(opt, scratch);
 }
 
 static void batch_one_object(const char *obj_name,
@@ -787,7 +797,7 @@ static int batch_objects(struct batch_options *opt)
 		      opt->format ? opt->format : DEFAULT_FORMAT,
 		      &data);
 	data.mark_query = 0;
-	strbuf_release(&output);
+	strbuf_reset(&output);
 	if (opt->transform_mode)
 		data.split_on_whitespace = 1;
 
diff --git a/streaming.c b/streaming.c
index 10adf625b2..9787449c50 100644
--- a/streaming.c
+++ b/streaming.c
@@ -10,6 +10,8 @@
 #include "object-store-ll.h"
 #include "replace-object.h"
 #include "packfile.h"
+#include "strbuf.h"
+#include "hex.h"
 
 typedef int (*open_istream_fn)(struct git_istream *,
 			       struct repository *,
@@ -546,3 +548,51 @@ int stream_blob_to_fd(int fd, const struct object_id *oid, struct stream_filter
 	close_istream(st);
 	return result;
 }
+
+/*
+ * stdio buffering requires extra data copies, using strbuf
+ * allows us to read_istream directly into a scratch buffer
+ */
+int stream_blob_to_strbuf_fd(int fd, struct strbuf *sb,
+				const struct object_id *oid)
+{
+	size_t bufsz = 16 * 1024;
+	struct git_istream *st;
+	enum object_type type;
+	unsigned long sz;
+	int result = -1;
+
+	st = open_istream(the_repository, oid, &type, &sz, NULL);
+	if (!st)
+		return result;
+	if (type != OBJ_BLOB)
+		goto close_and_exit;
+	if (bufsz > sz)
+		bufsz = sz;
+	strbuf_grow(sb, bufsz + 1); /* extra byte for output_delim */
+	while (sz) {
+		ssize_t readlen = read_istream(st, sb->buf + sb->len, bufsz);
+
+		if (readlen < 0)
+			goto close_and_exit;
+		if (readlen == 0)
+			die("unexpected EOF from %s\n", oid_to_hex(oid));
+		sz -= readlen;
+		if (!sz) {
+			/*
+			 * done, keep the last bit buffered for caller to
+			 * append output_delim
+			 */
+			strbuf_setlen(sb, sb->len + readlen);
+			break;
+		}
+		if (write_in_full(fd, sb->buf, sb->len + readlen) < 0)
+			goto close_and_exit;
+		strbuf_reset(sb);
+	}
+	result = 0;
+
+ close_and_exit:
+	close_istream(st);
+	return result;
+}
diff --git a/streaming.h b/streaming.h
index bd27f59e57..3cba4fe016 100644
--- a/streaming.h
+++ b/streaming.h
@@ -17,5 +17,6 @@ int close_istream(struct git_istream *);
 ssize_t read_istream(struct git_istream *, void *, size_t);
 
 int stream_blob_to_fd(int fd, const struct object_id *, struct stream_filter *, int can_seek);
+int stream_blob_to_strbuf_fd(int fd, struct strbuf *, const struct object_id *);
 
 #endif /* STREAMING_H */
