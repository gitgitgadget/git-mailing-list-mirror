Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38512C433FE
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 11:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbhLULyd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 06:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237320AbhLULyc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 06:54:32 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2E3C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 03:54:31 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id a23so12126507pgm.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 03:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L4iN/fUSOIzfCbZx26NYnzqWE8xvQjRvnk3kusvsTq4=;
        b=VO8/AnISlXw35/KuBTYm5/kBuL/f1ZCMp6Du45joxz/z1a1MBhoV69LP3xbMRmfwCg
         TIvEsYVbxTcJh9295Le64EqcUtjlrfMG4R2jAYSuHVrhX4PQVipSTivQTdOChfjXaZQC
         ZdXcQKwVynh0PEC6TcbJDjfrEKBq9eZrSTgfX5yX4OR0iBU/iwjNCvoSpDFNcH54v93P
         eoJXostqoTn2MNwmeTMexL6MSeC870igTP21fy4HEEIXH188/1Ocy5fpgBHKKggF7jDu
         Iosf11fSW2lkULUDxZompHhx+PZQSURbKswZ661X8MeMaUoFxSENO7vDPMCBkNkf81/C
         AK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L4iN/fUSOIzfCbZx26NYnzqWE8xvQjRvnk3kusvsTq4=;
        b=ndUaPSNaC8kznsG6ICugINl+D/aOKtvhdvzBIzFmNh0i+RDC4UNUflHRi5W5HIgYFE
         2doRnwxdbYQpk6Tcs0agDLSSPHLbWEBgsNg3SlQE2OvURHwciJT7WogOIwYc1leDN0q3
         1OAW1KNKx0BeJ+47lLYYH8KiOQNioOA3NnNoGzxBy+dScBYKVBUulyu3XIwx7bTPFN+N
         eICznZipTTgSr3ICDMVwGgjGOZSOHuzbiZYEtaod11gVuyU7tX3uag94lhmXKT+XK4ZQ
         hICcNqLZ2+hFkm3+S4d5j1GLW3F8ZyCNXno1PPi9iDmob358BJOkFRPNBK70PbJ36nHo
         24aw==
X-Gm-Message-State: AOAM530ARsUt7z4V9IyfLlNqSofuVTRpy2QeUk+ovkEpHp6P/wjfk6LM
        MHpbrr8j3d3FCWiEIjmWlLc=
X-Google-Smtp-Source: ABdhPJyx5Pv+Ixqr+dyZ/aEQkm+0d/YtPZ6QBSWuhP/6ORG8OcAY0eC42KrOFSHFibA00nI0P78oxg==
X-Received: by 2002:a63:f80f:: with SMTP id n15mr2601381pgh.394.1640087671404;
        Tue, 21 Dec 2021 03:54:31 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id s30sm20513742pfw.57.2021.12.21.03.54.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Dec 2021 03:54:30 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v7 5/5] unpack-objects: unpack_non_delta_entry() read data in a stream
Date:   Tue, 21 Dec 2021 19:52:01 +0800
Message-Id: <20211221115201.12120-6-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.g80008efde6.agit.6.5.6
In-Reply-To: <20211217112629.12334-1-chiyutianyi@gmail.com>
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
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

However, unpack non-delta objects from a stream instead of from an
entrie buffer will have 10% performance penalty. Therefore, only unpack
object larger than the "core.BigFileStreamingThreshold" in zstream. See
the following benchmarks:

    hyperfine \
      --setup \
      'if ! test -d scalar.git; then git clone --bare https://github.com/microsoft/scalar.git; cp scalar.git/objects/pack/*.pack small.pack; fi' \
      --prepare 'rm -rf dest.git && git init --bare dest.git'

    Summary
      './git -C dest.git -c core.bigfilethreshold=512m unpack-objects <small.pack' in 'origin/master'
        1.01 ± 0.04 times faster than './git -C dest.git -c core.bigfilethreshold=512m unpack-objects <small.pack' in 'HEAD~1'
        1.01 ± 0.04 times faster than './git -C dest.git -c core.bigfilethreshold=512m unpack-objects <small.pack' in 'HEAD~0'
        1.03 ± 0.10 times faster than './git -C dest.git -c core.bigfilethreshold=16k unpack-objects <small.pack' in 'origin/master'
        1.02 ± 0.07 times faster than './git -C dest.git -c core.bigfilethreshold=16k unpack-objects <small.pack' in 'HEAD~0'
        1.10 ± 0.04 times faster than './git -C dest.git -c core.bigfilethreshold=16k unpack-objects <small.pack' in 'HEAD~1'

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 Documentation/config/core.txt       | 11 +++++
 builtin/unpack-objects.c            | 73 ++++++++++++++++++++++++++++-
 cache.h                             |  1 +
 config.c                            |  5 ++
 environment.c                       |  1 +
 t/t5590-unpack-non-delta-objects.sh | 36 +++++++++++++-
 6 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a..601b7a2418 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -424,6 +424,17 @@ be delta compressed, but larger binary media files won't be.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
+core.bigFileStreamingThreshold::
+	Files larger than this will be streamed out to a temporary
+	object file while being hashed, which will when be renamed
+	in-place to a loose object, particularly if the
+	`core.bigFileThreshold' setting dictates that they're always
+	written out as loose objects.
++
+Default is 128 MiB on all platforms.
++
+Common unit suffixes of 'k', 'm', or 'g' are supported.
+
 core.excludesFile::
 	Specifies the pathname to the file that contains patterns to
 	describe paths that are not meant to be tracked, in addition
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 9104eb48da..72d8616e00 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -331,11 +331,82 @@ static void added_object(unsigned nr, enum object_type type,
 	}
 }
 
+struct input_zstream_data {
+	git_zstream *zstream;
+	unsigned char buf[8192];
+	int status;
+};
+
+static const void *feed_input_zstream(struct input_stream *in_stream,
+				      unsigned long *readlen)
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
+static void write_stream_blob(unsigned nr, size_t size)
+{
+	git_zstream zstream;
+	struct input_zstream_data data;
+	struct input_stream in_stream = {
+		.read = feed_input_zstream,
+		.data = &data,
+	};
+
+	memset(&zstream, 0, sizeof(zstream));
+	memset(&data, 0, sizeof(data));
+	data.zstream = &zstream;
+	git_inflate_init(&zstream);
+
+	if (write_stream_object_file(&in_stream, size, OBJ_BLOB, 0, 0,
+				     &obj_list[nr].oid))
+		die(_("failed to write object in stream"));
+
+	if (zstream.total_out != size || data.status != Z_STREAM_END)
+		die(_("inflate returned %d"), data.status);
+	git_inflate_end(&zstream);
+
+	if (strict) {
+		struct blob *blob =
+			lookup_blob(the_repository, &obj_list[nr].oid);
+		if (blob)
+			blob->object.flags |= FLAG_WRITTEN;
+		else
+			die(_("invalid blob object from stream"));
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
+	if (!dry_run && type == OBJ_BLOB &&
+	    size > big_file_streaming_threshold) {
+		write_stream_blob(nr, size);
+		return;
+	}
 
+	buf = get_data(size, dry_run);
 	if (!dry_run && buf)
 		write_object(nr, type, buf, size);
 	else
diff --git a/cache.h b/cache.h
index 64071a8d80..8c9123cb5d 100644
--- a/cache.h
+++ b/cache.h
@@ -974,6 +974,7 @@ extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
+extern unsigned long big_file_streaming_threshold;
 extern unsigned long pack_size_limit_cfg;
 
 /*
diff --git a/config.c b/config.c
index c5873f3a70..7b122a142a 100644
--- a/config.c
+++ b/config.c
@@ -1408,6 +1408,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.bigfilestreamingthreshold")) {
+		big_file_streaming_threshold = git_config_ulong(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.packedgitlimit")) {
 		packed_git_limit = git_config_ulong(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 0d06a31024..04bba593de 100644
--- a/environment.c
+++ b/environment.c
@@ -47,6 +47,7 @@ size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
+unsigned long big_file_streaming_threshold = 128 * 1024 * 1024;
 int pager_use_color = 1;
 const char *editor_program;
 const char *askpass_program;
diff --git a/t/t5590-unpack-non-delta-objects.sh b/t/t5590-unpack-non-delta-objects.sh
index 48c4fb1ba3..8436cbf8db 100755
--- a/t/t5590-unpack-non-delta-objects.sh
+++ b/t/t5590-unpack-non-delta-objects.sh
@@ -13,6 +13,11 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 prepare_dest () {
 	test_when_finished "rm -rf dest.git" &&
 	git init --bare dest.git
+	if test -n "$1"
+	then
+		git -C dest.git config core.bigFileStreamingThreshold $1
+		git -C dest.git config core.bigFileThreshold $1
+	fi
 }
 
 test_expect_success "setup repo with big blobs (1.5 MB)" '
@@ -33,7 +38,7 @@ test_expect_success 'setup env: GIT_ALLOC_LIMIT to 1MB' '
 '
 
 test_expect_success 'fail to unpack-objects: cannot allocate' '
-	prepare_dest &&
+	prepare_dest 2m &&
 	test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>err &&
 	grep "fatal: attempting to allocate" err &&
 	(
@@ -44,6 +49,35 @@ test_expect_success 'fail to unpack-objects: cannot allocate' '
 	! test_cmp expect actual
 '
 
+test_expect_success 'unpack big object in stream' '
+	prepare_dest 1m &&
+	mkdir -p dest.git/objects/05 &&
+	git -C dest.git unpack-objects <test-$PACK.pack &&
+	git -C dest.git fsck &&
+	(
+		cd dest.git &&
+		find objects/?? -type f | sort
+	) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'unpack big object in stream with existing oids' '
+	prepare_dest 1m &&
+	git -C dest.git index-pack --stdin <test-$PACK.pack &&
+	(
+		cd dest.git &&
+		find objects/?? -type f | sort
+	) >actual &&
+	test_must_be_empty actual &&
+	git -C dest.git unpack-objects <test-$PACK.pack &&
+	git -C dest.git fsck &&
+	(
+		cd dest.git &&
+		find objects/?? -type f | sort
+	) >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'unpack-objects dry-run' '
 	prepare_dest &&
 	git -C dest.git unpack-objects -n <test-$PACK.pack &&
-- 
2.34.1.52.g80008efde6.agit.6.5.6

