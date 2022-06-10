Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4596CC433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 14:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345016AbiFJOr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 10:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349163AbiFJOrK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 10:47:10 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62EA1CE7AE
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 07:47:08 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id c14so24934965pgu.13
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0CKVrz/E6OLPTIKkPoamXnUuECqDmAbXpeEX4yt+Uv4=;
        b=kDHa7FEoFksflaS4uLtdcqq7t6TSeU1hggduPrrMLZE6Fc1lKIFkbhs8tvQIUrF7gf
         YMT7b00AmU4dNRHzqcmC/G3B41UnmZWAofV1bl7KSA5B0KGY7sDOWTnQ1ILrwTfRilES
         6PPQyAxHfUQT4mFUGKvaaP/G2Y7HMo2e+lsAGrm6QHt4PzQKtBcqokwgKF+SWp6680WG
         J2mzwZVYgBW+glfN2NsCNj19+gaovWoINj01GkQoyxGuyM084351ac92DtK/AafcDTyF
         IbaZaoPNgCtEfTwzaelHRMfXMXXseM6gM6gxrtPIEZ8NCjWyXvH8Dk/kl0Q4xQyBvh0M
         5Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0CKVrz/E6OLPTIKkPoamXnUuECqDmAbXpeEX4yt+Uv4=;
        b=KD6gtwVBBc5wP/wnfJTm2a+sJD2HD71rHYFr1ZTWD8JWS3gdKlPRLQqfXOLy9e69eA
         DNTpSPFLWwlLKxg7/XqcfZ5foljQ22/MoxHTIRZvCLb+bvO5VAKfB9QEzhE7efnYlIoc
         pnQupVHhDlWHNOFZ3l3AqeKYfXk7BjufQ6gqsBX/WvuaBpB8iIFk5Nw+dwVPx0ncGuqG
         yB2HgdF+kR/qGp/0ZeJt7vwTUUaN+iTAAnzYWKwNzYHWwYQbpJQj3FqAyefVOsBIQpki
         2uIgjuK2WssyqSrT5/X+YaVJyBdihIHF9YqSLsNAE2SvyPKS0BSjD2CQr2GGhIrRLDp8
         5OkA==
X-Gm-Message-State: AOAM531D9kTVA2LigeppXrMYup1Ym1XoayokdPHkIgKfClr0flIC709l
        e6QTciY9c12FeH8bPqzJSbI=
X-Google-Smtp-Source: ABdhPJwP2VaZNEdmzz1thMqBpDn5l46DrpCr/pRjFrJJ/aCbsZEVOgv5k/82HC9rnPSQxQ6xWN5SDw==
X-Received: by 2002:a63:dd17:0:b0:3fd:695e:8728 with SMTP id t23-20020a63dd17000000b003fd695e8728mr28096287pgg.70.1654872427982;
        Fri, 10 Jun 2022 07:47:07 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id lx9-20020a17090b4b0900b001e292e30129sm1840434pjb.22.2022.06.10.07.47.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jun 2022 07:47:07 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     avarab@gmail.com
Cc:     Han Xin <chiyutianyi@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, l.s.r@web.de, neerajsi@microsoft.com,
        newren@gmail.com, philipoakley@iee.email, stolee@gmail.com,
        worldhello.net@gmail.com, Neeraj Singh <nksingh85@gmail.com>
Subject: [PATCH v14 0/7] unpack-objects: support streaming blobs to disk
Date:   Fri, 10 Jun 2022 22:46:00 +0800
Message-Id: <cover.1654871915.git.chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
References: <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes "unpack-objects" capable of streaming large objects
to disk.

As 7/7 shows streaming e.g. a 100MB blob now uses ~5MB of memory
instead of ~105MB. This streaming method is slower if you've got
memory to handle the blobs in-core, but if you don't it allows you to
unpack objects at all, as you might otherwise OOM.

Changes since v13:

* Make the error checking in the loop of get_data() the same way as
  we do in the non dry-run mode.

* Add batched disk flushes for stream_loose_object(). This is pointed
  out by Neeraj Singh[1].

* Minor typo/grammar/comment etc. fixes throughout.

1. https://lore.kernel.org/git/7ba4858a-d1cc-a4eb-b6d6-4c04a5dd6ce7@gmail.com/

Han Xin (4):
  unpack-objects: low memory footprint for get_data() in dry_run mode
  object-file.c: refactor write_loose_object() to several steps
  object-file.c: add "stream_loose_object()" to handle large object
  unpack-objects: use stream_loose_object() to unpack large objects

Ævar Arnfjörð Bjarmason (3):
  object-file.c: do fsync() and close() before post-write die()
  object-file.c: factor out deflate part of write_loose_object()
  core doc: modernize core.bigFileThreshold documentation

 Documentation/config/core.txt   |  33 +++--
 builtin/unpack-objects.c        | 106 ++++++++++++--
 object-file.c                   | 240 +++++++++++++++++++++++++++-----
 object-store.h                  |   8 ++
 t/t5351-unpack-large-objects.sh |  76 ++++++++++
 5 files changed, 408 insertions(+), 55 deletions(-)
 create mode 100755 t/t5351-unpack-large-objects.sh

Range-diff against v13:
1:  6703df6350 ! 1:  bf600a2fa8 unpack-objects: low memory footprint for get_data() in dry_run mode
    @@ Commit message
     
         Because in dry_run mode, "get_data()" is only used to check the
         integrity of data, and the returned buffer is not used at all, we can
    -    allocate a smaller buffer and reuse it as zstream output. Therefore,
    -    in dry_run mode, "get_data()" will release the allocated buffer and
    -    return NULL instead of returning garbage data.
    +    allocate a smaller buffer and use it as zstream output. Make the function
    +    return NULL in the dry-run mode, as no callers use the returned buffer.
     
         The "find [...]objects/?? -type f | wc -l" test idiom being used here
         is adapted from the same "find" use added to another test in
    @@ builtin/unpack-objects.c: static void use(int bytes)
      }
      
     +/*
    -+ * Decompress zstream from stdin and return specific size of data.
    ++ * Decompress zstream from the standard input into a newly
    ++ * allocated buffer of specified size and return the buffer.
     + * The caller is responsible to free the returned buffer.
     + *
     + * But for dry_run mode, "get_data()" is only used to check the
    @@ builtin/unpack-objects.c: static void *get_data(unsigned long size)
     +		if (dry_run) {
     +			/* reuse the buffer in dry_run mode */
     +			stream.next_out = buf;
    -+			stream.avail_out = bufsize;
    ++			stream.avail_out = bufsize > size - stream.total_out ?
    ++						   size - stream.total_out :
    ++						   bufsize;
     +		}
      	}
      	git_inflate_end(&stream);
2:  6e289d25c1 = 2:  a327f484f7 object-file.c: do fsync() and close() before post-write die()
3:  46f9def06c ! 3:  9bc8002282 object-file.c: refactor write_loose_object() to several steps
    @@ object-file.c: static int create_tmpfile(struct strbuf *tmp, const char *filenam
     + *
     + * - End the compression of zlib stream.
     + * - Get the calculated oid to "oid".
    -+ * - fsync() and close() the "fd"
     + */
     +static int end_loose_object_common(git_hash_ctx *c, git_zstream *stream,
     +				   struct object_id *oid)
4:  5a95ebede6 = 4:  7c73815f18 object-file.c: factor out deflate part of write_loose_object()
5:  26847541aa ! 5:  28a9588f9c object-file.c: add "stream_loose_object()" to handle large object
    @@ Commit message
         path.
     
         "freshen_packed_object()" or "freshen_loose_object()" will be called
    -    inside "stream_loose_object()" after obtaining the "oid".
    +    inside "stream_loose_object()" after obtaining the "oid". After the
    +    temporary file is written, we wants to mark the object to recent and we
    +    may find that where indeed is already the object. We should remove the
    +    temporary and do not leave a new copy of the object.
     
         Helped-by: René Scharfe <l.s.r@web.de>
         Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ object-file.c: static int freshen_packed_object(const struct object_id *oid)
     +	char hdr[MAX_HEADER_LEN];
     +	int hdrlen;
     +
    ++	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
    ++		prepare_loose_object_bulk_checkin();
    ++
     +	/* Since oid is not determined, save tmp file to odb path. */
     +	strbuf_addf(&filename, "%s/", get_object_directory());
     +	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
    @@ object-file.c: static int freshen_packed_object(const struct object_id *oid)
     +		die(_("write stream object %ld != %"PRIuMAX), stream.total_in,
     +		    (uintmax_t)len + hdrlen);
     +
    -+	/* Common steps for write_loose_object and stream_loose_object to
    ++	/*
    ++	 * Common steps for write_loose_object and stream_loose_object to
     +	 * end writing loose oject:
     +	 *
     +	 *  - End the compression of zlib stream.
6:  eb962b60b9 ! 6:  dea5c4172b core doc: modernize core.bigFileThreshold documentation
    @@ Documentation/config/core.txt: You probably do not need to adjust this value.
     +Files above the configured limit will be:
      +
     -Common unit suffixes of 'k', 'm', or 'g' are supported.
    -+* Stored deflated, without attempting delta compression.
    ++* Stored deflated in packfiles, without attempting delta compression.
     ++
     +The default limit is primarily set with this use-case in mind. With it
     +most projects will have their source code and other text files delta
    @@ Documentation/config/core.txt: You probably do not need to adjust this value.
     +usage, at the slight expense of increased disk usage.
     ++
     +* Will be treated as if though they were labeled "binary" (see
    -+  linkgit:gitattributes[5]). This means that e.g. linkgit:git-log[1]
    -+  and linkgit:git-diff[1] will not diffs for files above this limit.
    ++  linkgit:gitattributes[5]). e.g. linkgit:git-log[1] and
    ++  linkgit:git-diff[1] will not diffs for files above this limit.
     ++
     +* Will be generally be streamed when written, which avoids excessive
     +memory usage, at the cost of some fixed overhead. Commands that make
7:  88a2754fcb ! 7:  d236230a4c unpack-objects: use stream_loose_object() to unpack large objects
    @@ t/t5351-unpack-large-objects.sh: test_description='git unpack-objects with large
      }
      
      test_expect_success "create large objects (1.5 MB) and PACK" '
    +@@ t/t5351-unpack-large-objects.sh: test_expect_success "create large objects (1.5 MB) and PACK" '
    + 	test_commit --append foo big-blob &&
    + 	test-tool genrandom bar 1500000 >big-blob &&
    + 	test_commit --append bar big-blob &&
    +-	PACK=$(echo HEAD | git pack-objects --revs pack)
    ++	PACK=$(echo HEAD | git pack-objects --revs pack) &&
    ++	git verify-pack -v pack-$PACK.pack >out &&
    ++	sed -n -e "s/^\([0-9a-f][0-9a-f]*\).*\(commit\|tree\|blob\).*/\1/p" \
    ++		<out >obj-list
    + '
    + 
    + test_expect_success 'set memory limitation to 1MB' '
     @@ t/t5351-unpack-large-objects.sh: test_expect_success 'set memory limitation to 1MB' '
      '
      
    @@ t/t5351-unpack-large-objects.sh: test_expect_success 'set memory limitation to 1
     +	test_dir_is_empty dest.git/objects/pack
     +'
     +
    ++BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
    ++
    ++test_expect_success 'unpack big object in stream (core.fsyncmethod=batch)' '
    ++	prepare_dest 1m &&
    ++	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
    ++		git -C dest.git $BATCH_CONFIGURATION unpack-objects <pack-$PACK.pack &&
    ++	grep fsync/hardware-flush trace2.txt &&
    ++	test_dir_is_empty dest.git/objects/pack &&
    ++	git -C dest.git cat-file --batch-check="%(objectname)" <obj-list >current &&
    ++	cmp obj-list current
    ++'
    ++
     +test_expect_success 'do not unpack existing large objects' '
     +	prepare_dest 1m &&
     +	git -C dest.git index-pack --stdin <pack-$PACK.pack &&
-- 
2.36.1

