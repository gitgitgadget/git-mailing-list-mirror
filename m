Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EDFC6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 01:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiITB4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 21:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiITB4B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 21:56:01 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A1C56BAA
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 18:55:58 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x18so729774qkn.6
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 18:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Pmk84Sa59g777kyuV6/3MQA45TzTQibzWFSagH/LNI0=;
        b=U02JAuHyCNNKilEe3TKdjCOtsxjz48I9pCI+1l9a4SXqef7QDa/KFmEBgzJubSvGiw
         6Y8vqLA2GH9VdSNEykYa8RNd5ZUpOalg9JL4CjacaWCLGFNWIEHks9yC/Rc5MuTYaArK
         sKhcIoRcDTyuSmY/je73XE0gOnACV4WP1kgbIdTO4f8o4jSRjteRvhtVFzrW0/HgipD0
         DY7C2YRukigMDS68lNa3dCaFN2KW0Mo5yCHnCYRSnbWrRjdx3zZ2F8t7fY08VLpa/UuI
         QffB0EAbEX9KoxPkOiFZM0h5WeoF43J0g6Y1DTviUk9tYs75c45Lfm0ygOM+mvehIWmG
         FqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Pmk84Sa59g777kyuV6/3MQA45TzTQibzWFSagH/LNI0=;
        b=2Agg6R7vDWy8O3zG5MbixQcRfJOxtYvJviC2u21P1a156wjs2RFELdp3NjizeZo+mf
         o3oNCnEJe+umW3wfJesgrbHhjJwSVfwmC80Cnf3x2fsHsFMBlus+E9pnZA02SNKmfgP0
         xFgn3lgGLDsUbSstOyQtgergNPllrzB7pLul9Mgpr+wY05j8SLXuGcVT3lbh9S3NN3sw
         0zIDSac3psMOLwmHAW1L9ZHrd8sVra1QWw6yCBBn3rZ3biiMPGSTw8jyqeQNZ8tAw3ey
         v8rtkSOkcYToxMecKnvt7PsKsYROaIiBeRO3jszdY0DyY3T2HjRetw9WF4Vqrg/wein7
         lCBg==
X-Gm-Message-State: ACrzQf0ln3jkpcVkWpewwG4TuP6XqGhDK0AEJurSeEkM6qtKc3hzd3aS
        MIuFlFGxzGVx3D9NFTD0kiKilFHpAiogUg==
X-Google-Smtp-Source: AMsMyM7LPV84Ie2eGZSJRyv7ib4KZVduvAugc6JQ2h+8+JFwdlm9eVGD1vVi/eSkpPOObbTehwXCKQ==
X-Received: by 2002:a37:aa13:0:b0:6ce:9be8:fea2 with SMTP id t19-20020a37aa13000000b006ce9be8fea2mr15316756qke.414.1663638957236;
        Mon, 19 Sep 2022 18:55:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w23-20020a05620a0e9700b006ce1bfbd603sm42343qkm.124.2022.09.19.18.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 18:55:57 -0700 (PDT)
Date:   Mon, 19 Sep 2022 21:55:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com,
        gregory.szorc@gmail.com
Subject: [PATCH 7/7] midx.c: avoid cruft packs with non-zero `repack
 --batch-size`
Message-ID: <5f06a2e244a4efb166267cd3a7c975d5f04c07d5.1663638929.git.me@ttaylorr.com>
References: <cover.1663638929.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1663638929.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply similar treatment with respect to cruft packs as in a few commits
ago to `repack` with a non-zero `--batch-size`.

Since the case of a non-zero `--batch-size` is handled separately (in
`fill_included_packs_batch()` instead of `fill_included_packs_all()`), a
separate fix must be applied for this case.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c                      |  2 ++
 t/t5319-multi-pack-index.sh | 41 +++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/midx.c b/midx.c
index 273704caed..3a8dcfe98e 100644
--- a/midx.c
+++ b/midx.c
@@ -1946,6 +1946,8 @@ static int fill_included_packs_batch(struct repository *r,
 			continue;
 		if (!pack_kept_objects && p->pack_keep)
 			continue;
+		if (p->is_cruft)
+			continue;
 		if (open_pack_index(p) || !p->num_objects)
 			continue;
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index d967d92c20..b5f9b10922 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -807,6 +807,47 @@ test_expect_success 'repack (all) ignores cruft pack' '
 	)
 '
 
+test_expect_success 'repack (--batch-size) ignores cruft pack' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit_bulk 5 &&
+		test_commit --no-tag unreachable &&
+
+		git reset --hard HEAD^ &&
+		git reflog expire --all --expire=all &&
+		git repack --cruft -d &&
+
+		test_commit four &&
+
+		find $objdir/pack -type f -name "*.pack" | sort >before &&
+		git repack -d &&
+		find $objdir/pack -type f -name "*.pack" | sort >after &&
+
+		pack="$(comm -13 before after)" &&
+		test_file_size "$pack" >sz &&
+		# Set --batch-size to twice the size of the pack created
+		# in the previous step, since this is enough to
+		# accommodate it and the cruft pack.
+		#
+		# This means that the MIDX machinery *could* combine the
+		# new and cruft packs together.
+		#
+		# We ensure that it does not below.
+		batch="$((($(cat sz) * 2)))" &&
+
+		git multi-pack-index write &&
+
+		find $objdir/pack | sort >before &&
+		git multi-pack-index repack --batch-size=$batch &&
+		find $objdir/pack | sort >after &&
+
+		test_cmp before after
+	)
+'
+
 test_expect_success 'expire removes repacked packs' '
 	(
 		cd dup &&
-- 
2.37.0.1.g1379af2e9d
