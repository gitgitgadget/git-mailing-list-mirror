Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14A5C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 18:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbiADSPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 13:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbiADSPk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 13:15:40 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE602C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 10:15:40 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id p12so10977331qvj.6
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 10:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MOp4FIeCpL8SCGFtf1dTBAbHQHj7ACy3trS6H4rSEnk=;
        b=avjaiPnAhiGB909ztToL8lQlZzXLYJkpLQPa5g4SbMPxPB4xC22kJIxruySlWD4tZp
         mcXF6h+HDb6Hhod2VX3LyN39EdO1qT56eBrWl8TIQt5etS3NuLVu1N3HffA/0Op8xdAD
         zjAOwaif6hEBdVuOY+Xnwjh1A8mkzaDgMf4zAjXQLpq7cK3j3WJ/URExH2H/v2sjUgFK
         yr8bvorCmTSt+8F1hRnpqgvX22WrByVMzg8uww/P58U8/dpqgirbO5cEyYwfNOSjyzbK
         CxjUekZe394ZKXKy0VX9Kn5vu9LKcCDSiT3uvymnlFnPKSZdwXuAAwHx2WRabEeP4ena
         2tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MOp4FIeCpL8SCGFtf1dTBAbHQHj7ACy3trS6H4rSEnk=;
        b=fEhqmuCBd13ln8tVCA2LoJJTuIYDkLw8zStuNR/0Q46KUEffn+TOojvpG8JQo0i49E
         AW1Ywgisn3tzHrOmKd9i19J1nLMtRgzx+yEVfkplUvf9jdftmFARnBqf0gHVSLVFO11n
         Ev/oGqQWLE1Z8mCBzSSGc0gL1CpCdXDUgFRXwiNw9vLQwuwJOJE3J6WCmYB8AF56aC7M
         iH/loRfdZmcayw61/tyFnxs8UyC44eU1tiXKEhSCkZ3Ei8VRrNZ/P0cr5U3VEiYtle7d
         74kPLzipNkxzCdK+BbqZcyQtK5710PMnRDqDfLzYzx5UFQ8biN1TtGnnRfovOJ27nNSE
         bnDg==
X-Gm-Message-State: AOAM530DJ+Sukv7ROO0Pi6WLuXhuK7BclLYPFbF9X/ee7hsrJjwnDKlb
        t/XUdH6DVEoF7YlMFXZ6F+XKXwMbe8oE3/fg
X-Google-Smtp-Source: ABdhPJxtJACERiTbt9NU9MRJo3vJtQKpoOo1YbI4qH//Je5lIPE9P4MQxM/AuIrlpa+najhPOgXwEg==
X-Received: by 2002:a05:6214:29cf:: with SMTP id gh15mr47094626qvb.4.1641320139584;
        Tue, 04 Jan 2022 10:15:39 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l9sm28585669qkj.37.2022.01.04.10.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:15:39 -0800 (PST)
Date:   Tue, 4 Jan 2022 13:15:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com
Subject: [PATCH v3 0/9] midx: prevent bitmap corruption when permuting pack
 order
Message-ID: <cover.1641320129.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638991570.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a small reroll of my series which fixes a serious problem with MIDX
bitmaps by which they can become corrupt when permuting their pack order.

This reroll cleans up some of the tests by removing a couple of places where we
explicitly set GIT_TRACE2_EVENT_NESTING in the environment, which is no longer
needed after 62329d336f (Merge branch 'ds/trace2-regions-in-tests', 2021-12-15).

It also adds one new patch on top, which ensure that we gracefully fall back
when MIDX bitmaps cannot be read in certain cases.

It is prepared on the tip of master (which is dcc0cd074f at the time of
writing).

Taylor Blau (9):
  t5326: demonstrate bitmap corruption after permutation
  midx.c: make changing the preferred pack safe
  pack-revindex.c: instrument loading on-disk reverse index
  t5326: drop unnecessary setup
  t5326: extract `test_rev_exists`
  t5326: move tests to t/lib-bitmap.sh
  t/lib-bitmap.sh: parameterize tests over reverse index source
  midx: read `RIDX` chunk when present
  pack-bitmap.c: gracefully fallback after opening pack/MIDX

 Documentation/technical/multi-pack-index.txt |   1 +
 Documentation/technical/pack-format.txt      |  13 +-
 midx.c                                       |  31 +++-
 midx.h                                       |   1 +
 pack-bitmap.c                                |   4 +
 pack-revindex.c                              |  20 ++
 t/lib-bitmap.sh                              | 185 +++++++++++++++++++
 t/t5310-pack-bitmaps.sh                      |  28 +++
 t/t5326-multi-pack-bitmaps.sh                | 164 +++-------------
 t/t5327-multi-pack-bitmaps-rev.sh            |  23 +++
 t/t7700-repack.sh                            |   4 -
 11 files changed, 322 insertions(+), 152 deletions(-)
 create mode 100755 t/t5327-multi-pack-bitmaps-rev.sh

Range-diff against v2:
 1:  dfbac4bc60 =  1:  babce7d29a t5326: demonstrate bitmap corruption after permutation
 2:  4ea52e66dd !  2:  7d20c13f8b midx.c: make changing the preferred pack safe
    @@ Commit message
     
      ## Documentation/technical/multi-pack-index.txt ##
     @@ Documentation/technical/multi-pack-index.txt: and their offsets into multiple packfiles. It contains:
    -   - An offset within the jth packfile for the object.
    - - If large offsets are required, we use another list of large
    + ** An offset within the jth packfile for the object.
    + * If large offsets are required, we use another list of large
        offsets similar to version 2 pack-indexes.
     +- An optional list of objects in pseudo-pack order (used with MIDX bitmaps).
      
 3:  b630fea149 =  3:  3279e2eb9b pack-revindex.c: instrument loading on-disk reverse index
 4:  f430b6f2e9 =  4:  5818621ea8 t5326: drop unnecessary setup
 5:  73faab9f42 !  5:  33502d6a17 t5326: extract `test_rev_exists`
    @@ t/t5326-multi-pack-bitmaps.sh: midx_pack_source () {
     +	commit="$1"
     +
     +	test_expect_success 'reverse index exists' '
    -+		GIT_TRACE2_EVENT_NESTING=10 \
     +		GIT_TRACE2_EVENT=$(pwd)/event.trace \
     +			git rev-list --test-bitmap "$commit" &&
     +
 6:  bf42b116e1 !  6:  76e23cae0f t5326: move tests to t/lib-bitmap.sh
    @@ t/lib-bitmap.sh: have_delta () {
     +	commit="$1"
     +
     +	test_expect_success 'reverse index exists' '
    -+		GIT_TRACE2_EVENT_NESTING=10 \
     +		GIT_TRACE2_EVENT=$(pwd)/event.trace \
     +			git rev-list --test-bitmap "$commit" &&
     +
    @@ t/t5326-multi-pack-bitmaps.sh: test_description='exercise basic multi-pack bitma
     -	commit="$1"
     -
     -	test_expect_success 'reverse index exists' '
    --		GIT_TRACE2_EVENT_NESTING=10 \
     -		GIT_TRACE2_EVENT=$(pwd)/event.trace \
     -			git rev-list --test-bitmap "$commit" &&
     -
 7:  fa91631024 !  7:  7ce3dc60f9 t/lib-bitmap.sh: parameterize tests over reverse index source
    @@ t/lib-bitmap.sh: midx_pack_source () {
     +	kind="$2"
      
      	test_expect_success 'reverse index exists' '
    - 		GIT_TRACE2_EVENT_NESTING=10 \
      		GIT_TRACE2_EVENT=$(pwd)/event.trace \
      			git rev-list --test-bitmap "$commit" &&
      
 8:  993bfa8dd8 !  8:  55aa69de12 midx: read `RIDX` chunk when present
    @@ t/t5326-multi-pack-bitmaps.sh: test_description='exercise basic multi-pack bitma
      GIT_TEST_MULTI_PACK_INDEX=0
      GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
      
    -+GIT_TEST_MIDX_WRITE_REV=0
    -+GIT_TEST_MIDX_READ_RIDX=1
    -+export GIT_TEST_MIDX_WRITE_REV
    -+export GIT_TEST_MIDX_READ_RIDX
    ++# This test exercise multi-pack bitmap functionality where the object order is
    ++# stored and read from a special chunk within the MIDX, so use the default
    ++# behavior here.
    ++sane_unset GIT_TEST_MIDX_WRITE_REV
    ++sane_unset GIT_TEST_MIDX_READ_RIDX
     +
      midx_bitmap_core
      
 -:  ---------- >  9:  9707d5ea44 pack-bitmap.c: gracefully fallback after opening pack/MIDX
-- 
2.34.1.25.gb3157a20e6
