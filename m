Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D029CC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 03:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbhKVDid (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 22:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbhKVDib (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 22:38:31 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA48C061759
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 19:35:25 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 200so14120807pga.1
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 19:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1p68IFUVfnUrT06HkmD/8yADTxYi1d3dtj2beA2VWnc=;
        b=F9/NP0LTi9kYKUV2lfZHLKuVECHSXvFBRc6+o6RDGzEVOuEla40c46oXz3QcL01F9+
         r/AYO7OpsY2Qlg+Lx599eINOGFffBaY1e3gZQu2mwfzJh8yrYgP9vZ26hbJ75jRvKBps
         ti9iHZvb3SLbWYwOdizulWcvck/MitISIVnRJKM+n18YGBurMqDvPh0Gc+NKTWfEImAM
         JKCEqfF+PLjGF4abrHKwA4n3YAmfAeKsm+s8Z4p88UTKHj99n2Y+XMmtYTzcF8iKkz7R
         t2x0/LPFn9KqHf53HWMlRT1fav/eJ/HL1M6/wtWnkc0unbesQne35q1HjP4sQjA6Si9v
         63ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1p68IFUVfnUrT06HkmD/8yADTxYi1d3dtj2beA2VWnc=;
        b=IzGQ3HeTscn2uQ9s27opt9NMJqiuRAgMqK7L4b3gNMjN24ANw2sTxoWt6Xtq7u/wHY
         qeZzjZH2DxbjqhdpjjjMNjaqpzoU714BaTgL7E+xD86uvGtSeAavQ7UiSAL8pojxlyJO
         mpKvUgKnMNP84A9kJ3rRPCRZQbyYd5v5x5HV5re8JUV8ZFP6V1YMMN1ptI1CTYlSzU5w
         ykFiL5vOSeoetY0hbWhSmkbZnIkGVesABm2Npz6sEfRPJurzK6XGXaRFXWBy1FP2ZsR3
         orlINgAWcDyiD7jDtTV/bYtftfsn9eOy448m+R77aDhYvRdat8ilZUet465kg38SgjqR
         zdMQ==
X-Gm-Message-State: AOAM532PZHEvQd2/eSL1cykHX8M5Vr1503SyU1Iq6Db1ydrooEMrLEf2
        kGMF4uP9yeWZ574GiwfGDJg=
X-Google-Smtp-Source: ABdhPJxhZUPjZS+PEHYdJxGS/Z9KcjLJtZt/jOVvfdpgMiFWPFLjeEzJ69eHJcX3xrCrQRGLy96MEw==
X-Received: by 2002:aa7:9a04:0:b0:4a2:ebcd:89a with SMTP id w4-20020aa79a04000000b004a2ebcd089amr46351048pfj.60.1637552125482;
        Sun, 21 Nov 2021 19:35:25 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id q11sm1235714pgt.54.2021.11.21.19.35.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Nov 2021 19:35:25 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v3 5/5] unpack-objects: unpack_non_delta_entry() read data in a stream
Date:   Mon, 22 Nov 2021 11:32:20 +0800
Message-Id: <20211122033220.32883-6-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0.6.g676eedc724
In-Reply-To: <20211009082058.41138-1-chiyutianyi@gmail.com>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

We used to call "get_data()" in "unpack_non_delta_entry()" to read the
entire contents of a blob object, no matter how big it is. This
implementation may consume all the memory and cause OOM.

By implementing a zstream version of input_stream interface, we can use
a small fixed buffer for "unpack_non_delta_entry()".

However, unpack non-delta objects from a stream instead of from an entrie
buffer will have 10% performance penalty. Therefore, only unpack object
larger than the "big_file_threshold" in zstream. See the following
benchmarks:

    $ hyperfine \
    --prepare 'rm -rf dest.git && git init --bare dest.git' \
    'git -C dest.git unpack-objects <binary_320M.pack'
    Benchmark 1: git -C dest.git unpack-objects <binary_320M.pack
      Time (mean ± σ):     10.029 s ±  0.270 s    [User: 8.265 s, System: 1.522 s]
      Range (min … max):    9.786 s … 10.603 s    10 runs

    $ hyperfine \
    --prepare 'rm -rf dest.git && git init --bare dest.git' \
    'git -c core.bigFileThreshold=2m -C dest.git unpack-objects <binary_320M.pack'
    Benchmark 1: git -c core.bigFileThreshold=2m -C dest.git unpack-objects <binary_320M.pack
      Time (mean ± σ):     10.859 s ±  0.774 s    [User: 8.813 s, System: 1.898 s]
      Range (min … max):    9.884 s … 12.192 s    10 runs

    $ hyperfine \
    --prepare 'rm -rf dest.git && git init --bare dest.git' \
    'git -C dest.git unpack-objects <binary_96M.pack'
    Benchmark 1: git -C dest.git unpack-objects <binary_96M.pack
      Time (mean ± σ):      2.678 s ±  0.037 s    [User: 2.205 s, System: 0.450 s]
      Range (min … max):    2.639 s …  2.743 s    10 runs

    $ hyperfine \
    --prepare 'rm -rf dest.git && git init --bare dest.git' \
    'git -c core.bigFileThreshold=2m -C dest.git unpack-objects <binary_96M.pack'
    Benchmark 1: git -c core.bigFileThreshold=2m -C dest.git unpack-objects <binary_96M.pack
      Time (mean ± σ):      2.819 s ±  0.124 s    [User: 2.216 s, System: 0.564 s]
      Range (min … max):    2.679 s …  3.125 s    10 runs

Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 builtin/unpack-objects.c            | 76 ++++++++++++++++++++++++++++-
 object-file.c                       |  6 +--
 object-store.h                      |  4 ++
 t/t5590-unpack-non-delta-objects.sh | 76 +++++++++++++++++++++++++++++
 4 files changed, 158 insertions(+), 4 deletions(-)
 create mode 100755 t/t5590-unpack-non-delta-objects.sh

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 8d68acd662..bfc254a236 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -326,11 +326,85 @@ static void added_object(unsigned nr, enum object_type type,
 	}
 }
 
+struct input_zstream_data {
+	git_zstream *zstream;
+	unsigned char buf[4096];
+	int status;
+};
+
+static const void *feed_input_zstream(struct input_stream *in_stream, unsigned long *readlen)
+{
+	struct input_zstream_data *data = in_stream->data;
+	git_zstream *zstream = data->zstream;
+	void *in = fill(1);
+
+	if (!len || data->status == Z_STREAM_END) {
+		*readlen = 0;
+		return NULL;
+	}
+
+	zstream->next_out = data->buf;
+	zstream->avail_out = sizeof(data->buf);
+	zstream->next_in = in;
+	zstream->avail_in = len;
+
+	data->status = git_inflate(zstream, 0);
+	use(len - zstream->avail_in);
+	*readlen = sizeof(data->buf) - zstream->avail_out;
+
+	return data->buf;
+}
+
+static void write_stream_blob(unsigned nr, unsigned long size)
+{
+	char hdr[32];
+	int hdrlen;
+	git_zstream zstream;
+	struct input_zstream_data data;
+	struct input_stream in_stream = {
+		.read = feed_input_zstream,
+		.data = &data,
+	};
+	struct object_id *oid = &obj_list[nr].oid;
+	int ret;
+
+	memset(&zstream, 0, sizeof(zstream));
+	memset(&data, 0, sizeof(data));
+	data.zstream = &zstream;
+	git_inflate_init(&zstream);
+
+	/* Generate the header */
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX, type_name(OBJ_BLOB), (uintmax_t)size) + 1;
+
+	if ((ret = write_loose_object(oid, hdr, hdrlen, &in_stream, 0, 0)))
+		die(_("failed to write object in stream %d"), ret);
+
+	if (zstream.total_out != size || data.status != Z_STREAM_END)
+		die(_("inflate returned %d"), data.status);
+	git_inflate_end(&zstream);
+
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
-	void *buf = get_data(size, dry_run);
+	void *buf;
+
+	/* Write large blob in stream without allocating full buffer. */
+	if (!dry_run && type == OBJ_BLOB && size > big_file_threshold) {
+		write_stream_blob(nr, size);
+		return;
+	}
 
+	buf = get_data(size, dry_run);
 	if (!dry_run && buf)
 		write_object(nr, type, buf, size);
 	else
diff --git a/object-file.c b/object-file.c
index 93bcfaca50..bd7631f7ef 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1878,9 +1878,9 @@ static const void *feed_simple_input_stream(struct input_stream *in_stream, unsi
 	return data->buf;
 }
 
-static int write_loose_object(const struct object_id *oid, char *hdr,
-			      int hdrlen, struct input_stream *in_stream,
-			      time_t mtime, unsigned flags)
+int write_loose_object(const struct object_id *oid, char *hdr,
+		       int hdrlen, struct input_stream *in_stream,
+		       time_t mtime, unsigned flags)
 {
 	int fd, ret;
 	unsigned char compressed[4096];
diff --git a/object-store.h b/object-store.h
index ccc1fc9c1a..cbd95c47e2 100644
--- a/object-store.h
+++ b/object-store.h
@@ -228,6 +228,10 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 		     unsigned long len, const char *type,
 		     struct object_id *oid);
 
+int write_loose_object(const struct object_id *oid, char *hdr,
+		       int hdrlen, struct input_stream *in_stream,
+		       time_t mtime, unsigned flags);
+
 int write_object_file_flags(const void *buf, unsigned long len,
 			    const char *type, struct object_id *oid,
 			    unsigned flags);
diff --git a/t/t5590-unpack-non-delta-objects.sh b/t/t5590-unpack-non-delta-objects.sh
new file mode 100755
index 0000000000..01d950d119
--- /dev/null
+++ b/t/t5590-unpack-non-delta-objects.sh
@@ -0,0 +1,76 @@
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
+	PACK=$(echo main | git pack-objects --progress --revs test)
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
+test_expect_success 'fail to unpack-objects: cannot allocate' '
+	test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>err &&
+	test_i18ngrep "fatal: attempting to allocate" err &&
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
+	git -C dest.git unpack-objects <test-$PACK.pack &&
+	git -C dest.git fsck &&
+	(
+		cd dest.git &&
+		find objects/?? -type f | sort
+	) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for unpack-objects dry-run test' '
+	git init --bare unpack-test.git
+'
+
+test_expect_success 'unpack-objects dry-run' '
+	(
+		cd unpack-test.git &&
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
2.34.0.6.g676eedc724

