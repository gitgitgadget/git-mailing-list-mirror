Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43620C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 10:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbhLJKif (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbhLJKie (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 05:38:34 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4DEC061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:34:59 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y7so6037626plp.0
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9JjsBx/nfj3aqsSdqhCj7COe9H3C04uCKQ2Kzw8r7RY=;
        b=VGwwsQE2SoxZ1P+ulYzVcSrp/zu+rbx+XfUsAZUx96k+a9/Mf+r45qqXdJrENKIXs4
         j5LMlBXGsi2vY/MDR2rbZSzCDxHrwqKV5uMdv1hPzAke2gJ4JGOLv07qYKdOJhrQphVd
         ReBjLvam1RGcxoevbxk0++Umc5W5+DtIjvO2VjS3Z3K3p6nvqR6LEbZrw8dj4NqKm66a
         DxkBoaNqvdAk2hAcmytEV4A7kKW7IwZPdBC12mcr2NKiwA4zmmY07To7F0z87ETSi7zT
         4lVoHUDJ2n6LIPioFNL8sGUoct1gOaNjqzIwiMS+jTlU0f8G1mYgovVvzjlxOBd4gjfK
         ExlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9JjsBx/nfj3aqsSdqhCj7COe9H3C04uCKQ2Kzw8r7RY=;
        b=ZBFUOKRXBB0Kq3GNVoMe6QvZl/bIjm/bSK12AeRhs1IrXcOZrJFd+4b1JavtkfnygX
         zmU6RZsmBCOnO2eEvZCSDCCgHBl1dgAq7vd1MKxIoR9dW4ER7ggMUy/Bkl+P6R9vhAM5
         aOEa/J117xZCn61OmgVtJ9cMpjivYITC0zOUBnMdLmmBBxmNDz/JUMgGipHxjGSXSMl7
         wcJqkKvP/C+T1AuPg4OmflW5JI4AsjaY2SyItwsBm1oWAWoeITbTnH57dlbMwP0ds8t3
         lzS0Y54EuAnlBAD6TQtU+MINqUlqhQ/xv46sYW5/cjF5GOrkDka1yB1ffR7NyE9DDQdG
         STfQ==
X-Gm-Message-State: AOAM531lE1b0EZugAaV71PAHExdLgIdio49j6tVU/LW8NsiMSZxJoTbP
        OiSkoStxdFYvZwOU2Q+jyuIr99vztCMBJw==
X-Google-Smtp-Source: ABdhPJxqvf/TKhZhx8rtmoQ1aPEsl8xEagUxfgfo+T1x9zxbGHnVJ7xVMs978DBfL1jGBGcKsGa/Fg==
X-Received: by 2002:a17:90a:df8d:: with SMTP id p13mr22676787pjv.197.1639132499324;
        Fri, 10 Dec 2021 02:34:59 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id 204sm2396250pgb.63.2021.12.10.02.34.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 02:34:58 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v5 0/6] unpack large blobs in stream
Date:   Fri, 10 Dec 2021 18:34:29 +0800
Message-Id: <20211210103435.83656-1-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211203093530.93589-1-chiyutianyi@gmail.com>
References: <20211203093530.93589-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

Changes since v4:
* Refactor to "struct input_stream" implementations so that we can
  reduce the changes to "write_loose_object()" sugguest by
  Ævar Arnfjörð Bjarmason.

* Add a new flag called "HASH_STREAM" to support this feature.

* Add a new config "core.bigFileStreamingThreshold" instread of
  "core.bigFileThreshold" sugguest by Ævar Arnfjörð Bjarmason[1].

* Roll destination repository preparement into a function in 
  "t5590-unpack-non-delta-objects.sh", so that we can run testcases
  with --run=setup,3,4.

1. https://lore.kernel.org/git/211203.86zgphsu5a.gmgdl@evledraar.gmail.com/

Han Xin (6):
  object-file: refactor write_loose_object() to support read from stream
  object-file.c: handle undetermined oid in write_loose_object()
  object-file.c: read stream in a loop in write_loose_object()
  unpack-objects.c: add dry_run mode for get_data()
  object-file.c: make "write_object_file_flags()" to support "HASH_STREAM"
  unpack-objects: unpack_non_delta_entry() read data in a stream

 Documentation/config/core.txt       | 11 ++++
 builtin/unpack-objects.c            | 86 +++++++++++++++++++++++++++--
 cache.h                             |  2 +
 config.c                            |  5 ++
 environment.c                       |  1 +
 object-file.c                       | 73 +++++++++++++++++++-----
 object-store.h                      |  5 ++
 t/t5590-unpack-non-delta-objects.sh | 70 +++++++++++++++++++++++
 8 files changed, 234 insertions(+), 19 deletions(-)
 create mode 100755 t/t5590-unpack-non-delta-objects.sh

Range-diff against v4:
1:  af707ef304 < -:  ---------- object-file: refactor write_loose_object() to read buffer from stream
2:  321ad90d8e < -:  ---------- object-file.c: handle undetermined oid in write_loose_object()
3:  1992ac39af < -:  ---------- object-file.c: read stream in a loop in write_loose_object()
-:  ---------- > 1:  f3595e68cc object-file: refactor write_loose_object() to support read from stream
-:  ---------- > 2:  c25fdd1fe5 object-file.c: handle undetermined oid in write_loose_object()
-:  ---------- > 3:  ed226f2f9f object-file.c: read stream in a loop in write_loose_object()
4:  c41eb06533 ! 4:  2f91e540f6 unpack-objects.c: add dry_run mode for get_data()
    @@ builtin/unpack-objects.c: static void use(int bytes)
      {
      	git_zstream stream;
     -	void *buf = xmallocz(size);
    -+	unsigned long bufsize = dry_run ? 4096 : size;
    ++	unsigned long bufsize = dry_run ? 8192 : size;
     +	void *buf = xmallocz(bufsize);
      
      	memset(&stream, 0, sizeof(stream));
-:  ---------- > 5:  7698938eac object-file.c: make "write_object_file_flags()" to support "HASH_STREAM"
5:  9427775bdc ! 6:  103bb1db06 unpack-objects: unpack_non_delta_entry() read data in a stream
    @@ Commit message
     
         However, unpack non-delta objects from a stream instead of from an entrie
         buffer will have 10% performance penalty. Therefore, only unpack object
    -    larger than the "big_file_threshold" in zstream. See the following
    +    larger than the "core.BigFileStreamingThreshold" in zstream. See the following
         benchmarks:
     
             hyperfine \
               --setup \
               'if ! test -d scalar.git; then git clone --bare https://github.com/microsoft/scalar.git; cp scalar.git/objects/pack/*.pack small.pack; fi' \
    -          --prepare 'rm -rf dest.git && git init --bare dest.git' \
    -          -n 'old' 'git -C dest.git unpack-objects <small.pack' \
    -          -n 'new' 'new/git -C dest.git unpack-objects <small.pack' \
    -          -n 'new (small threshold)' \
    -          'new/git -c core.bigfilethreshold=16k -C dest.git unpack-objects <small.pack'
    -        Benchmark 1: old
    -          Time (mean ± σ):      6.075 s ±  0.069 s    [User: 5.047 s, System: 0.991 s]
    -          Range (min … max):    6.018 s …  6.189 s    10 runs
    -
    -        Benchmark 2: new
    -          Time (mean ± σ):      6.090 s ±  0.033 s    [User: 5.075 s, System: 0.976 s]
    -          Range (min … max):    6.030 s …  6.142 s    10 runs
    -
    -        Benchmark 3: new (small threshold)
    -          Time (mean ± σ):      6.755 s ±  0.029 s    [User: 5.150 s, System: 1.560 s]
    -          Range (min … max):    6.711 s …  6.809 s    10 runs
    +          --prepare 'rm -rf dest.git && git init --bare dest.git'
     
             Summary
    -          'old' ran
    -            1.00 ± 0.01 times faster than 'new'
    -            1.11 ± 0.01 times faster than 'new (small threshold)'
    +          './git -C dest.git -c core.bigfilethreshold=512m unpack-objects <small.pack' in 'origin/master'
    +            1.01 ± 0.04 times faster than './git -C dest.git -c core.bigfilethreshold=512m unpack-objects <small.pack' in 'HEAD~1'
    +            1.01 ± 0.04 times faster than './git -C dest.git -c core.bigfilethreshold=512m unpack-objects <small.pack' in 'HEAD~0'
    +            1.03 ± 0.10 times faster than './git -C dest.git -c core.bigfilethreshold=16k unpack-objects <small.pack' in 'origin/master'
    +            1.02 ± 0.07 times faster than './git -C dest.git -c core.bigfilethreshold=16k unpack-objects <small.pack' in 'HEAD~0'
    +            1.10 ± 0.04 times faster than './git -C dest.git -c core.bigfilethreshold=16k unpack-objects <small.pack' in 'HEAD~1'
     
    +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Helped-by: Derrick Stolee <stolee@gmail.com>
         Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
     
    + ## Documentation/config/core.txt ##
    +@@ Documentation/config/core.txt: be delta compressed, but larger binary media files won't be.
    + +
    + Common unit suffixes of 'k', 'm', or 'g' are supported.
    + 
    ++core.bigFileStreamingThreshold::
    ++	Files larger than this will be streamed out to a temporary
    ++	object file while being hashed, which will when be renamed
    ++	in-place to a loose object, particularly if the
    ++	`core.bigFileThreshold' setting dictates that they're always
    ++	written out as loose objects.
    +++
    ++Default is 128 MiB on all platforms.
    +++
    ++Common unit suffixes of 'k', 'm', or 'g' are supported.
    ++
    + core.excludesFile::
    + 	Specifies the pathname to the file that contains patterns to
    + 	describe paths that are not meant to be tracked, in addition
    +
      ## builtin/unpack-objects.c ##
     @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type type,
      	}
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
     +
     +static void write_stream_blob(unsigned nr, unsigned long size)
     +{
    -+	char hdr[32];
    -+	int hdrlen;
     +	git_zstream zstream;
     +	struct input_zstream_data data;
     +	struct input_stream in_stream = {
     +		.read = feed_input_zstream,
     +		.data = &data,
    -+		.size = size,
     +	};
    -+	struct object_id *oid = &obj_list[nr].oid;
     +	int ret;
     +
     +	memset(&zstream, 0, sizeof(zstream));
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
     +	data.zstream = &zstream;
     +	git_inflate_init(&zstream);
     +
    -+	/* Generate the header */
    -+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX, type_name(OBJ_BLOB), (uintmax_t)size) + 1;
    -+
    -+	if ((ret = write_loose_object(oid, hdr, hdrlen, &in_stream, 0, 0)))
    ++	if ((ret = write_object_file_flags(&in_stream, size, type_name(OBJ_BLOB) ,&obj_list[nr].oid, HASH_STREAM)))
     +		die(_("failed to write object in stream %d"), ret);
     +
     +	if (zstream.total_out != size || data.status != Z_STREAM_END)
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
     +	git_inflate_end(&zstream);
     +
     +	if (strict && !dry_run) {
    -+		struct blob *blob = lookup_blob(the_repository, oid);
    ++		struct blob *blob = lookup_blob(the_repository, &obj_list[nr].oid);
     +		if (blob)
     +			blob->object.flags |= FLAG_WRITTEN;
     +		else
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
     +	void *buf;
     +
     +	/* Write large blob in stream without allocating full buffer. */
    -+	if (!dry_run && type == OBJ_BLOB && size > big_file_threshold) {
    ++	if (!dry_run && type == OBJ_BLOB && size > big_file_streaming_threshold) {
     +		write_stream_blob(nr, size);
     +		return;
     +	}
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
      		write_object(nr, type, buf, size);
      	else
     
    - ## object-file.c ##
    -@@ object-file.c: static const void *feed_simple_input_stream(struct input_stream *in_stream, unsi
    - 	return data->buf;
    - }
    + ## cache.h ##
    +@@ cache.h: extern size_t packed_git_window_size;
    + extern size_t packed_git_limit;
    + extern size_t delta_base_cache_limit;
    + extern unsigned long big_file_threshold;
    ++extern unsigned long big_file_streaming_threshold;
    + extern unsigned long pack_size_limit_cfg;
      
    --static int write_loose_object(const struct object_id *oid, char *hdr,
    --			      int hdrlen, struct input_stream *in_stream,
    --			      time_t mtime, unsigned flags)
    -+int write_loose_object(const struct object_id *oid, char *hdr,
    -+		       int hdrlen, struct input_stream *in_stream,
    -+		       time_t mtime, unsigned flags)
    - {
    - 	int fd, ret;
    - 	unsigned char compressed[4096];
    + /*
     
    - ## object-store.h ##
    -@@ object-store.h: int hash_object_file(const struct git_hash_algo *algo, const void *buf,
    - 		     unsigned long len, const char *type,
    - 		     struct object_id *oid);
    + ## config.c ##
    +@@ config.c: static int git_default_core_config(const char *var, const char *value, void *cb)
    + 		return 0;
    + 	}
      
    -+int write_loose_object(const struct object_id *oid, char *hdr,
    -+		       int hdrlen, struct input_stream *in_stream,
    -+		       time_t mtime, unsigned flags);
    ++	if (!strcmp(var, "core.bigfilestreamingthreshold")) {
    ++		big_file_streaming_threshold = git_config_ulong(var, value);
    ++		return 0;
    ++	}
     +
    - int write_object_file_flags(const void *buf, unsigned long len,
    - 			    const char *type, struct object_id *oid,
    - 			    unsigned flags);
    + 	if (!strcmp(var, "core.packedgitlimit")) {
    + 		packed_git_limit = git_config_ulong(var, value);
    + 		return 0;
    +
    + ## environment.c ##
    +@@ environment.c: size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
    + size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
    + size_t delta_base_cache_limit = 96 * 1024 * 1024;
    + unsigned long big_file_threshold = 512 * 1024 * 1024;
    ++unsigned long big_file_streaming_threshold = 128 * 1024 * 1024;
    + int pager_use_color = 1;
    + const char *editor_program;
    + const char *askpass_program;
     
      ## t/t5590-unpack-non-delta-objects.sh (new) ##
     @@
    @@ t/t5590-unpack-non-delta-objects.sh (new)
     +
     +. ./test-lib.sh
     +
    -+test_expect_success "create commit with big blobs (1.5 MB)" '
    ++prepare_dest () {
    ++	test_when_finished "rm -rf dest.git" &&
    ++	git init --bare dest.git &&
    ++	git -C dest.git config core.bigFileStreamingThreshold $1
    ++	git -C dest.git config core.bigFileThreshold $1
    ++}
    ++
    ++test_expect_success "setup repo with big blobs (1.5 MB)" '
     +	test-tool genrandom foo 1500000 >big-blob &&
     +	test_commit --append foo big-blob &&
     +	test-tool genrandom bar 1500000 >big-blob &&
    @@ t/t5590-unpack-non-delta-objects.sh (new)
     +		cd .git &&
     +		find objects/?? -type f | sort
     +	) >expect &&
    -+	PACK=$(echo main | git pack-objects --progress --revs test)
    ++	PACK=$(echo main | git pack-objects --revs test)
     +'
     +
    -+test_expect_success 'setup GIT_ALLOC_LIMIT to 1MB' '
    ++test_expect_success 'setup env: GIT_ALLOC_LIMIT to 1MB' '
     +	GIT_ALLOC_LIMIT=1m &&
     +	export GIT_ALLOC_LIMIT
     +'
     +
    -+test_expect_success 'prepare dest repository' '
    -+	git init --bare dest.git &&
    -+	git -C dest.git config core.bigFileThreshold 2m &&
    -+	git -C dest.git config receive.unpacklimit 100
    -+'
    -+
     +test_expect_success 'fail to unpack-objects: cannot allocate' '
    ++	prepare_dest 2m &&
     +	test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>err &&
    -+	test_i18ngrep "fatal: attempting to allocate" err &&
    ++	grep "fatal: attempting to allocate" err &&
     +	(
     +		cd dest.git &&
     +		find objects/?? -type f | sort
     +	) >actual &&
    ++	test_file_not_empty actual &&
     +	! test_cmp expect actual
     +'
     +
    -+test_expect_success 'set a lower bigfile threshold' '
    -+	git -C dest.git config core.bigFileThreshold 1m
    -+'
    -+
     +test_expect_success 'unpack big object in stream' '
    ++	prepare_dest 1m &&
     +	git -C dest.git unpack-objects <test-$PACK.pack &&
     +	git -C dest.git fsck &&
     +	(
    @@ t/t5590-unpack-non-delta-objects.sh (new)
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'setup for unpack-objects dry-run test' '
    -+	git init --bare unpack-test.git
    -+'
    -+
     +test_expect_success 'unpack-objects dry-run' '
    ++	prepare_dest 1m &&
    ++	git -C dest.git unpack-objects -n <test-$PACK.pack &&
     +	(
    -+		cd unpack-test.git &&
    -+		git unpack-objects -n <../test-$PACK.pack
    -+	) &&
    -+	(
    -+		cd unpack-test.git &&
    ++		cd dest.git &&
     +		find objects/ -type f
     +	) >actual &&
     +	test_must_be_empty actual
-- 
2.34.0

