Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976CDC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 09:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351402AbhLCJja (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 04:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbhLCJj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 04:39:29 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01967C06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 01:36:06 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id o14so1705768plg.5
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 01:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLfcp4oo97FlrFuefuc0uBZv2WKFfx19R1W+y2Yj73Y=;
        b=LZuKb8Y6KirPwyqPEjtC2HCDrDXYPmPliR6TqVDcreF1Sd4p+Zhs81ulFdijjOEBVc
         guezam9gaIYYvhU38hkxELTgWiSru+4muhttx5NJE2XxdnNoKA8LhK3g+DEe6dFIzGVb
         hvo0EStNJnw95wzP+AWAa1hJ5p43oU2VrGjFmgE1jawdd6MZTsir05YgwRm3S6KwwaCI
         7G+BFmf3rB5Vw3Z45YNfgk0LNA7EGnPdslTbOOyvl9uPwSiqHNlqn6HrJ0LW5F6Bt976
         qJd5qf54e0YvPBrYec8xpQIGtYTeZll5KVageU3LbNK5f3Q/kzOXnR+StpZHY6KrvWxW
         bZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLfcp4oo97FlrFuefuc0uBZv2WKFfx19R1W+y2Yj73Y=;
        b=ZvNJ1kBH8WVM/GuqB57m/NaGUeyLAi3+wZ/cmmJQPFo4Vhjebew1Yci0dVQ7Dn/JzM
         Ghbl9S/bn/d5odoO8pgDTmc7CM/9jtEiRPvsi8lYoWhSoGz3l5ad0lCwE6H5tZe6oxJJ
         FNae6BFh6boMUVUsZJmyi8oymA5RKyv1M+LLodhQPSnLopqj9I+zycg++y40xOEVtQHw
         ny/6RAlkXe3XQrfB/Vlv9qeXXc75bQ9Cx+dhbYlwIUXamofcmZ6EWokbFJ3hxW6EuUHy
         kn8lXeCV9oiUXKZ4MBPZkzkFBJ06DQfeNUkorZFL0DNg1htfRapLmoqA/EeCeyNsKlSh
         NKkQ==
X-Gm-Message-State: AOAM533QLgKuEp/ww70nxPfMm64YdGuegrt7MaJ87YbMDdg+lvSYebO6
        lpOXY/kCPsZQLuiCbzxAW7M=
X-Google-Smtp-Source: ABdhPJwkljFIA2FrlU2n7VYjUAKDqkhyGHF03fOdvNhzInTRyhjthVIeDpZDhGKAPVyoeYyQz3xG0Q==
X-Received: by 2002:a17:90b:341:: with SMTP id fh1mr12752130pjb.90.1638524165352;
        Fri, 03 Dec 2021 01:36:05 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id g9sm2708142pfj.160.2021.12.03.01.36.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Dec 2021 01:36:04 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v4 0/5] unpack large objects in stream
Date:   Fri,  3 Dec 2021 17:35:25 +0800
Message-Id: <20211203093530.93589-1-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122033220.32883-1-chiyutianyi@gmail.com>
References: <20211122033220.32883-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

Changes since v3:
* Add "size" to "struct input_stream" which used by following commits.

* Increase the buffer size of "struct input_zstream_data" from 4096 to
  8192, which is consistent with the "fixed_buf" in the "index-pack.c".

* Refactor "read stream in a loop in write_loose_object()" which
  introduced a performance problem reported by Derrick Stolee[1].

* Rewrite benchmarks in "unpack-objects: unpack_non_delta_entry() read
  data in a stream" with sugguestions by Derrick Stolee[1] and
  Ævar Arnfjörð Bjarmason[2]. 
  Now use "scalar.git" to benchmark, which contains more than 28000
  objects and 96 objects larger than 16kB.

1. https://lore.kernel.org/git/8ff89e50-1b80-7932-f0e2-af401ee04bb1@gmail.com/
2. https://lore.kernel.org/git/211201.86r1aw9gbd.gmgdl@evledraar.gmail.com/

Han Xin (5):
  object-file: refactor write_loose_object() to read buffer from stream
  object-file.c: handle undetermined oid in write_loose_object()
  object-file.c: read stream in a loop in write_loose_object()
  unpack-objects.c: add dry_run mode for get_data()
  unpack-objects: unpack_non_delta_entry() read data in a stream

 builtin/unpack-objects.c            |  93 +++++++++++++++++++++++--
 object-file.c                       | 102 ++++++++++++++++++++++++----
 object-store.h                      |  10 +++
 t/t5590-unpack-non-delta-objects.sh |  76 +++++++++++++++++++++
 4 files changed, 262 insertions(+), 19 deletions(-)
 create mode 100755 t/t5590-unpack-non-delta-objects.sh

Range-diff against v3:
1:  8640b04f6d ! 1:  af707ef304 object-file: refactor write_loose_object() to read buffer from stream
    @@ object-file.c: int write_object_file_flags(const void *buf, unsigned long len,
     +			.buf = buf,
     +			.len = len,
     +		},
    ++		.size = len,
     +	};
      
      	/* Normally if we have it in the pack then we do not bother writing
    @@ object-file.c: int hash_object_file_literally(const void *buf, unsigned long len
     +			.buf = buf,
     +			.len = len,
     +		},
    ++		.size = len,
     +	};
      
      	/* type string, SP, %lu of the length plus NUL must fit this */
    @@ object-file.c: int force_object_loose(const struct object_id *oid, time_t mtime)
      	if (has_loose_object(oid))
      		return 0;
      	buf = read_object(the_repository, oid, &type, &len);
    ++	in_stream.size = len;
      	if (!buf)
      		return error(_("cannot read object for %s"), oid_to_hex(oid));
     +	data.buf = buf;
    @@ object-store.h: struct object_directory {
     +struct input_stream {
     +	const void *(*read)(struct input_stream *, unsigned long *len);
     +	void *data;
    ++	size_t size;
     +};
     +
      KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
2:  d4a2caf2bd = 2:  321ad90d8e object-file.c: handle undetermined oid in write_loose_object()
3:  2575900449 ! 3:  1992ac39af object-file.c: read stream in a loop in write_loose_object()
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
     -		ret = git_deflate(&stream, Z_FINISH);
     +		if (!stream.avail_in) {
     +			buf = in_stream->read(in_stream, &stream.avail_in);
    -+			if (buf) {
    -+				stream.next_in = (void *)buf;
    -+				in0 = (unsigned char *)buf;
    -+			} else {
    ++			stream.next_in = (void *)buf;
    ++			in0 = (unsigned char *)buf;
    ++			/* All data has been read. */
    ++			if (in_stream->size + hdrlen == stream.total_in + stream.avail_in)
     +				flush = Z_FINISH;
    -+			}
     +		}
     +		ret = git_deflate(&stream, flush);
      		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
      		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
      			die(_("unable to write loose object file"));
    + 		stream.next_out = compressed;
    + 		stream.avail_out = sizeof(compressed);
    +-	} while (ret == Z_OK);
    ++	} while (ret == Z_OK || ret == Z_BUF_ERROR);
    + 
    + 	if (ret != Z_STREAM_END)
    + 		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
4:  ca93ecc780 = 4:  c41eb06533 unpack-objects.c: add dry_run mode for get_data()
5:  39a072ee2a ! 5:  9427775bdc unpack-objects: unpack_non_delta_entry() read data in a stream
    @@ Commit message
         larger than the "big_file_threshold" in zstream. See the following
         benchmarks:
     
    -        $ hyperfine \
    -        --prepare 'rm -rf dest.git && git init --bare dest.git' \
    -        'git -C dest.git unpack-objects <binary_320M.pack'
    -        Benchmark 1: git -C dest.git unpack-objects <binary_320M.pack
    -          Time (mean ± σ):     10.029 s ±  0.270 s    [User: 8.265 s, System: 1.522 s]
    -          Range (min … max):    9.786 s … 10.603 s    10 runs
    +        hyperfine \
    +          --setup \
    +          'if ! test -d scalar.git; then git clone --bare https://github.com/microsoft/scalar.git; cp scalar.git/objects/pack/*.pack small.pack; fi' \
    +          --prepare 'rm -rf dest.git && git init --bare dest.git' \
    +          -n 'old' 'git -C dest.git unpack-objects <small.pack' \
    +          -n 'new' 'new/git -C dest.git unpack-objects <small.pack' \
    +          -n 'new (small threshold)' \
    +          'new/git -c core.bigfilethreshold=16k -C dest.git unpack-objects <small.pack'
    +        Benchmark 1: old
    +          Time (mean ± σ):      6.075 s ±  0.069 s    [User: 5.047 s, System: 0.991 s]
    +          Range (min … max):    6.018 s …  6.189 s    10 runs
     
    -        $ hyperfine \
    -        --prepare 'rm -rf dest.git && git init --bare dest.git' \
    -        'git -c core.bigFileThreshold=2m -C dest.git unpack-objects <binary_320M.pack'
    -        Benchmark 1: git -c core.bigFileThreshold=2m -C dest.git unpack-objects <binary_320M.pack
    -          Time (mean ± σ):     10.859 s ±  0.774 s    [User: 8.813 s, System: 1.898 s]
    -          Range (min … max):    9.884 s … 12.192 s    10 runs
    +        Benchmark 2: new
    +          Time (mean ± σ):      6.090 s ±  0.033 s    [User: 5.075 s, System: 0.976 s]
    +          Range (min … max):    6.030 s …  6.142 s    10 runs
     
    -        $ hyperfine \
    -        --prepare 'rm -rf dest.git && git init --bare dest.git' \
    -        'git -C dest.git unpack-objects <binary_96M.pack'
    -        Benchmark 1: git -C dest.git unpack-objects <binary_96M.pack
    -          Time (mean ± σ):      2.678 s ±  0.037 s    [User: 2.205 s, System: 0.450 s]
    -          Range (min … max):    2.639 s …  2.743 s    10 runs
    +        Benchmark 3: new (small threshold)
    +          Time (mean ± σ):      6.755 s ±  0.029 s    [User: 5.150 s, System: 1.560 s]
    +          Range (min … max):    6.711 s …  6.809 s    10 runs
     
    -        $ hyperfine \
    -        --prepare 'rm -rf dest.git && git init --bare dest.git' \
    -        'git -c core.bigFileThreshold=2m -C dest.git unpack-objects <binary_96M.pack'
    -        Benchmark 1: git -c core.bigFileThreshold=2m -C dest.git unpack-objects <binary_96M.pack
    -          Time (mean ± σ):      2.819 s ±  0.124 s    [User: 2.216 s, System: 0.564 s]
    -          Range (min … max):    2.679 s …  3.125 s    10 runs
    +        Summary
    +          'old' ran
    +            1.00 ± 0.01 times faster than 'new'
    +            1.11 ± 0.01 times faster than 'new (small threshold)'
     
    +    Helped-by: Derrick Stolee <stolee@gmail.com>
         Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
     
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
      
     +struct input_zstream_data {
     +	git_zstream *zstream;
    -+	unsigned char buf[4096];
    ++	unsigned char buf[8192];
     +	int status;
     +};
     +
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
     +	struct input_stream in_stream = {
     +		.read = feed_input_zstream,
     +		.data = &data,
    ++		.size = size,
     +	};
     +	struct object_id *oid = &obj_list[nr].oid;
     +	int ret;
-- 
2.34.0

