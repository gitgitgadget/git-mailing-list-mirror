Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97268C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 20:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiITUkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiITUkR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 16:40:17 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FA23F1C0
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:40:16 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id s13so2934163qvq.10
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=HawmbIJnpTtD1o1tDb0MiBKhTOuCrJ2NMJfbasN6AKE=;
        b=dmk7gjWr7R9Ktsc9fsyRad1Jzqj/DNjw3bnH3n9MlOFcMuPU+NL5Ikwg3KPlOeNaqw
         U2nlq/9JEf9boBwByQGGRn7NIv3sfm1+yLo6w0MUSSEmBn1EIPDzGPa6URPGdiIxqOvd
         oCmoT6Ch2lhtv2Ko7a2rcH5MdD2r2m+xH22+gmCLgFeu149bs/SlU/c08S3b+ih5aVZz
         d240r7oeIHH11ZsgfHgXRq3BKZm1MRYjAvbBOMtbDjd7tUlJpdPqGnjnT3p5X9c9Gbx/
         oDndhcOAuPUtYDi01Q2pos8TQo613diTGt+zmbHiDgA+z9uF86q4T/XZorlZi2eml/Rw
         oVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=HawmbIJnpTtD1o1tDb0MiBKhTOuCrJ2NMJfbasN6AKE=;
        b=QbYFBjgald38AvDF1wYOtskL9zRUM8eYa2vtLrnxzl5cKjuijGSdcfsJaOd3MW1oMK
         7n/iRwzGcRZ8IMhElwbQ1SJBPZ2zL1LFBOqqiJ5nKqUSWyEGO9IsC/y3t4d41pxtya9u
         RLUuBbgz4UyhkeDrENqsRFZxTGWpbeN/hlkxHY0cIhGn7wLPRo2REvjm+Gtd2zJDdhey
         A+eNXZUM8v/HQ90HCZ9yaRRyYXO3TmRvQsisMeJB5Ghjud2fnym+etxQX0OAJqhloBBd
         rMypq8m9xR8jhAxk/zDfLmDoParIRx9KWRDNBkmKH5e5GIHkbg40lAHRCqpSLjcYeHed
         m7uw==
X-Gm-Message-State: ACrzQf32ewc74WVKkX3X1+laSdoiwGFvYgVFqIyPkCq6uykDAZkhYnvD
        K5jS9i15ba7D8JMXipsPmQlOW1r58VVKGw==
X-Google-Smtp-Source: AMsMyM6sqG/hroo9DZnM514kb1AkoN2AAP0CGbkSCLSgxLRhEmGmEbvjve0RFBl8FexjKPBAXxTM/A==
X-Received: by 2002:ad4:596c:0:b0:4ad:5b16:3789 with SMTP id eq12-20020ad4596c000000b004ad5b163789mr4505464qvb.84.1663706415542;
        Tue, 20 Sep 2022 13:40:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g16-20020a05620a40d000b006a6ab259261sm539507qko.29.2022.09.20.13.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:40:15 -0700 (PDT)
Date:   Tue, 20 Sep 2022 16:40:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com, peff@peff.net
Subject: [PATCH v2 0/3] midx: use `--stdin-packs` to implement `repack`
Message-ID: <cover.1663706401.git.me@ttaylorr.com>
References: <YyokIf%2FSd7SYztKQ@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YyokIf%2FSd7SYztKQ@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a few patches that replace the existing "feed each OID
one-by-one" approach to implement the `repack` sub-command of the
`multi-pack-index` builtin with one that uses `pack-objects`'s
`--stdin-packs` option.

There is an additional patch at the beginning of this series in order to
extract the mtime-sorted list of packs to rollup from their home in
`fill_included_packs_batch()`. There's also one more on the end to unify
the `include_pack` array into the `repack_info` struct(s) themselves.

The second patch is the substantive one. Thanks for all of the review so
far! :-)

Taylor Blau (3):
  midx.c: compute pack_info array outside of fill_included_packs_batch()
  midx.c: use `pack-objects --stdin-packs` when repacking
  midx.c: unify `include_pack` array into `pack_info` struct

 midx.c | 76 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  a501776f6e midx.c: compute pack_info array outside of fill_included_packs_batch()
1:  7e987eb9d7 ! 2:  4218d9e08a midx.c: use `pack-objects --stdin-packs` when repacking
    @@ midx.c: int midx_repack(struct repository *r, const char *object_dir, size_t bat
      	struct strbuf base_name = STRBUF_INIT;
     +	struct strbuf scratch = STRBUF_INIT;
      	struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
    + 	struct repack_info *pack_info = NULL;
      
    - 	/*
     @@ midx.c: int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
      	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
      	repo_config_get_bool(r, "repack.usedeltaislands", &use_delta_islands);
    @@ midx.c: int midx_repack(struct repository *r, const char *object_dir, size_t bat
     -		struct object_id oid;
     -		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
     +	for (i = 0; i < m->num_packs; i++) {
    -+		strbuf_reset(&scratch);
    ++		struct repack_info *info = &pack_info[i];
      
     -		if (!include_pack[pack_int_id])
     -			continue;
    -+		strbuf_addstr(&scratch, m->pack_names[i]);
    -+		strbuf_strip_suffix(&scratch, ".idx");
    -+		strbuf_addstr(&scratch, ".pack");
    ++		strbuf_reset(&scratch);
      
     -		nth_midxed_object_oid(&oid, m, i);
     -		fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
    -+		fprintf(cmd_in, "%s%s\n", include_pack[i] ? "" : "^", scratch.buf);
    ++		strbuf_addstr(&scratch, m->pack_names[info->pack_int_id]);
    ++		strbuf_strip_suffix(&scratch, ".idx");
    ++		strbuf_addstr(&scratch, ".pack");
    ++
    ++		fprintf(cmd_in, "%s%s\n", include_pack[info->pack_int_id] ? "" : "^", scratch.buf);
      	}
      	fclose(cmd_in);
     +	strbuf_release(&scratch);
-:  ---------- > 3:  81e9ccc323 midx.c: unify `include_pack` array into `pack_info` struct
-- 
2.37.0.1.g1379af2e9d
