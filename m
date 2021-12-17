Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E47CC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 11:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhLQL2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 06:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhLQL2i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 06:28:38 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D11BC061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 03:28:38 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id v13so2021122pfi.3
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 03:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WgTMR8jDbJwpoGoBy1u6adK3mBlEaisV7zmAyr4teSQ=;
        b=NIn9sgTAoTdxv6oACIztfHlaqle9fRKUIhJc+IbwCnDl7PAE3lfDvzkc3oYQDXoNqg
         xDLroDpXKRKo+MUj/7G8aIwEwdwncV8CwL7Ev6Ums6TkhEt/Vz40z8NYK001dQD9YqMk
         N/BR0N+fQS9HSiSbD7rPt+mi1DU1zTwudBZIcK766ZMQLoHZkMqS1st8QhtUeIH/qBvY
         Qn0u/eBN+IaG1kJY77dkGmzhqOtd/7N9Th/GBU5PkypkRfhciALPRcCzqlFV6N17fO2A
         CiUWLT05tZv6ngGUOLyXOQathmTLDiC9KU9A4nA23PAMc1cezeIo3UWwkuDBlGgvlH55
         OieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WgTMR8jDbJwpoGoBy1u6adK3mBlEaisV7zmAyr4teSQ=;
        b=qKEs34puXyMT4odmj3heUwPLiZWir7iiZXafxnFwfsbdG46S5zgefh014DtYiqFnB1
         Tcx56RvJpz3g0USd0jyYCig1N2+GajP7PVe1QlGXyHNMVfDau/liN2l2I092AYa+s42M
         TwwbLAW/0BhNPwNaOqlod+R086N91AjCYIFFQYJTtWXfgpLAVf/Bb3nlDuhZbktwDTlH
         4kiOskhpa4Na9qstfeFWJbckbKifJlxYVMxBL18K/0PHZiaATayv1IGUFe4iAa3VLXUv
         276tlOOT9JFJZ5x6Zj020qB882TXxUhJGrEMLk7O8dFmh/GHN08FkEXOs7AMk77i544+
         7l/g==
X-Gm-Message-State: AOAM531xq9mq555Yo/nKsQb0wAovNRxmR6p1dOOvc4Snl4Sd500qhHN5
        2v443P+XU0zTyqFoCzs4PasZ7MSlENiGIDez
X-Google-Smtp-Source: ABdhPJw8/W57qHReRCEhYK1XztfCt+oN8a7C2N9JPOjorqjah7NVqhgAfgFnsCaymedxawTzzui7pA==
X-Received: by 2002:aa7:9007:0:b0:4b1:40b9:7046 with SMTP id m7-20020aa79007000000b004b140b97046mr2767176pfo.48.1639740517605;
        Fri, 17 Dec 2021 03:28:37 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.97])
        by smtp.gmail.com with ESMTPSA id f10sm5194673pge.33.2021.12.17.03.28.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Dec 2021 03:28:36 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v5 0/6] unpack large blobs in stream
Date:   Fri, 17 Dec 2021 19:26:23 +0800
Message-Id: <20211217112629.12334-1-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.gfcc2252aea.agit.6.5.6
In-Reply-To: <20211210103435.83656-1-chiyutianyi@gmail.com>
References: <20211210103435.83656-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

Changes since v5:
* Refactor write_loose_object() to reuse in stream version sugguest by
  Ævar Arnfjörð Bjarmason [1].

* Add a new testcase into t5590-unpack-non-delta-objects to cover the case of
  unpacking existing objects.

* Fix code formatting in unpack-objects.c sugguest by
  Ævar Arnfjörð Bjarmason [2].

1. https://lore.kernel.org/git/211213.86bl1l9bfz.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/211213.867dc8ansq.gmgdl@evledraar.gmail.com/

Han Xin (6):
  object-file.c: release strbuf in write_loose_object()
  object-file.c: refactor object header generation into a function
  object-file.c: refactor write_loose_object() to reuse in stream
    version
  object-file.c: make "write_object_file_flags()" to support read in
    stream
  unpack-objects.c: add dry_run mode for get_data()
  unpack-objects: unpack_non_delta_entry() read data in a stream

 Documentation/config/core.txt       |  11 ++
 builtin/unpack-objects.c            |  94 ++++++++++++-
 cache.h                             |   2 +
 config.c                            |   5 +
 environment.c                       |   1 +
 object-file.c                       | 207 +++++++++++++++++++++++-----
 object-store.h                      |   5 +
 t/t5590-unpack-non-delta-objects.sh |  87 ++++++++++++
 8 files changed, 370 insertions(+), 42 deletions(-)
 create mode 100755 t/t5590-unpack-non-delta-objects.sh

Range-diff against v5:
1:  f3595e68cc < -:  ---------- object-file: refactor write_loose_object() to support read from stream
2:  c25fdd1fe5 < -:  ---------- object-file.c: handle undetermined oid in write_loose_object()
3:  ed226f2f9f < -:  ---------- object-file.c: read stream in a loop in write_loose_object()
-:  ---------- > 1:  59d35dac5f object-file.c: release strbuf in write_loose_object()
-:  ---------- > 2:  2174a6cbad object-file.c: refactor object header generation into a function
-:  ---------- > 3:  8a704ecc59 object-file.c: refactor write_loose_object() to reuse in stream version
-:  ---------- > 4:  96f05632a2 object-file.c: make "write_object_file_flags()" to support read in stream
4:  2f91e540f6 ! 5:  1acbb6e849 unpack-objects.c: add dry_run mode for get_data()
    @@ builtin/unpack-objects.c: static void use(int bytes)
      {
      	git_zstream stream;
     -	void *buf = xmallocz(size);
    -+	unsigned long bufsize = dry_run ? 8192 : size;
    -+	void *buf = xmallocz(bufsize);
    ++	unsigned long bufsize;
    ++	void *buf;
      
      	memset(&stream, 0, sizeof(stream));
    ++	if (dry_run && size > 8192)
    ++		bufsize = 8192;
    ++	else
    ++		bufsize = size;
    ++	buf = xmallocz(bufsize);
      
      	stream.next_out = buf;
     -	stream.avail_out = size;
5:  7698938eac < -:  ---------- object-file.c: make "write_object_file_flags()" to support "HASH_STREAM"
6:  92d69cb84a ! 6:  476aaba527 unpack-objects: unpack_non_delta_entry() read data in a stream
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
     +	int status;
     +};
     +
    -+static const void *feed_input_zstream(struct input_stream *in_stream, unsigned long *readlen)
    ++static const void *feed_input_zstream(const struct input_stream *in_stream,
    ++				      unsigned long *readlen)
     +{
     +	struct input_zstream_data *data = in_stream->data;
     +	git_zstream *zstream = data->zstream;
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
     +		.read = feed_input_zstream,
     +		.data = &data,
     +	};
    -+	int ret;
     +
     +	memset(&zstream, 0, sizeof(zstream));
     +	memset(&data, 0, sizeof(data));
     +	data.zstream = &zstream;
     +	git_inflate_init(&zstream);
     +
    -+	if ((ret = write_object_file_flags(&in_stream, size, type_name(OBJ_BLOB) ,&obj_list[nr].oid, HASH_STREAM)))
    -+		die(_("failed to write object in stream %d"), ret);
    ++	if (write_object_file_flags(&in_stream, size,
    ++				    type_name(OBJ_BLOB),
    ++				    &obj_list[nr].oid,
    ++				    HASH_STREAM))
    ++		die(_("failed to write object in stream"));
     +
     +	if (zstream.total_out != size || data.status != Z_STREAM_END)
     +		die(_("inflate returned %d"), data.status);
     +	git_inflate_end(&zstream);
     +
    -+	if (strict && !dry_run) {
    ++	if (strict) {
     +		struct blob *blob = lookup_blob(the_repository, &obj_list[nr].oid);
     +		if (blob)
     +			blob->object.flags |= FLAG_WRITTEN;
     +		else
    -+			die("invalid blob object from stream");
    ++			die(_("invalid blob object from stream"));
     +	}
     +	obj_list[nr].obj = NULL;
     +}
    @@ t/t5590-unpack-non-delta-objects.sh (new)
     +prepare_dest () {
     +	test_when_finished "rm -rf dest.git" &&
     +	git init --bare dest.git &&
    -+	git -C dest.git config core.bigFileStreamingThreshold $1
    ++	git -C dest.git config core.bigFileStreamingThreshold $1 &&
     +	git -C dest.git config core.bigFileThreshold $1
     +}
     +
    @@ t/t5590-unpack-non-delta-objects.sh (new)
     +	test_cmp expect actual
     +'
     +
    ++test_expect_success 'unpack big object in stream with existing oids' '
    ++	prepare_dest 1m &&
    ++	git -C dest.git index-pack --stdin <test-$PACK.pack &&
    ++	(
    ++		cd dest.git &&
    ++		find objects/?? -type f | sort
    ++	) >actual &&
    ++	test_must_be_empty actual &&
    ++	git -C dest.git unpack-objects <test-$PACK.pack &&
    ++	git -C dest.git fsck &&
    ++	(
    ++		cd dest.git &&
    ++		find objects/?? -type f | sort
    ++	) >actual &&
    ++	test_must_be_empty actual
    ++'
    ++
     +test_expect_success 'unpack-objects dry-run' '
     +	prepare_dest 1m &&
     +	git -C dest.git unpack-objects -n <test-$PACK.pack &&
-- 
2.34.1.52.gfcc2252aea.agit.6.5.6

