Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A22CC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 19:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbiHVTuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 15:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbiHVTuf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 15:50:35 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF933CBCD
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:50:34 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id cr9so8749681qtb.13
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=nZ4LwTwuNjIxq/I6FM2nNIZ0mIOMCp6EDYqdGvsUI7o=;
        b=PWkiLJEkq0Ibe+uyvtXT3uD4EyvuA07eORTACbosOmrddo8R2BXrCPeFZYx8Qye0yy
         aOYiY0OCo8ur9Kuyn2FRFPU+y4Enzvh183vLYS8VYmfvscUZRQzDikKeIrqBq/z8Nxz4
         29jly2oQvWCcoXWVOuiVf39iog7buSJmxPEgSXdNI66q3lYam2A+DU71PrVvWiMHNh54
         dGGVEI5Yn6yotlAXwEWv3JIue8Mb3jLOdbnHBHLdhDDWYnsUwmndjP/WCYmUmtbcNdHk
         vSAtIofOfFGuPc9FOc+EgkKKt0LrrztM3p3a3ZeKsnw16/gQZM1Of+wF4BmLaO8R6sI+
         qK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=nZ4LwTwuNjIxq/I6FM2nNIZ0mIOMCp6EDYqdGvsUI7o=;
        b=46zz4WrpF8vYW7Fe/ofL+sOV/8H2zCsPTAqOIhsB/ELfRph1B4ebNaVS61B07cClfi
         RmdLHH3bLfeKNM1+QgiNFC4C5d/ZBIXsIYS6ehlVBSS+Aahx5aCk3CmPaM+QY4m48Ci8
         IfMp0p7fNBZ4sA13LP9G3yU0eo4z1DvDGoaYxSJT9N+7gdcXatO0pAOFDa2buDiQlhjQ
         BrS3OAevyGEfePH2hYkidaz/3yPqX0H3R/34j47giiUZCIKhmUGvje3HdYsiJUxuSh4W
         BRXo/PDVb6yWhrgQRWTqLNPnw2U8bTKeym3emrvxwXmoFnoz0jWqVI8axQZQpArnpiNy
         FhIA==
X-Gm-Message-State: ACgBeo0vUGQN3rWGxGnWRXl52YcPsPg5HAqHrpQ+BkUpJIPUg5Tq0jhP
        S5GYpcw8iSO3FnfBvmoeIZ5aPiAU9LPoY/Ru
X-Google-Smtp-Source: AA6agR5not16ABYfBmvCxeVqy7L0VekhOJ/j3fotf8s8tSVM6JdWiA8+W+4tUF9A0ypq+f6EFIbqZg==
X-Received: by 2002:ac8:7f53:0:b0:343:652:ce62 with SMTP id g19-20020ac87f53000000b003430652ce62mr16123511qtk.514.1661197833830;
        Mon, 22 Aug 2022 12:50:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m9-20020a05620a24c900b006af0ce13499sm12226402qkn.115.2022.08.22.12.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:50:33 -0700 (PDT)
Date:   Mon, 22 Aug 2022 15:50:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, derrickstolee@github.com,
        jonathantanmy@google.com, kaartic.sivaraam@gmail.com
Subject: [PATCH v2 1/7] t5326: demonstrate potential bitmap corruption
Message-ID: <6b38bfcd2c2bced350cea198f7d576ffb81f3481.1661197803.git.me@ttaylorr.com>
References: <cover.1660944574.git.me@ttaylorr.com>
 <cover.1661197803.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1661197803.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to generate a corrupt MIDX bitmap when certain conditions
are met. This happens when the preferred pack "P" changes to one (say,
"Q") that:

  - "Q" has objects included in an existing MIDX,
  - but "Q" is different than "P",
  - and "Q" and "P" have some objects in common

When this is the case, not all objects from "Q" will be selected from
"Q" (ie., the generated MIDX will represent them as coming from a
different pack), despite "Q" being preferred.

This is an invariant violation, since all objects contained in the
MIDX's preferred pack are supposed to originate from the preferred pack.
In other words, all duplicate objects are resolved in favor of the copy
that comes from the MIDX's preferred pack, if any.

This violation results in a corrupt object order, which cannot be
interpreted by the pack-bitmap code, leading to broken clones and other
defects.

This test demonstrates the above problem by constructing a minimal
reproduction, and showing that the final `git clone` invocation fails.

The reproduction is mostly straightforward, except that the new pack
generated between MIDX writes (which is necessary in order to prevent
that operation from being a noop) must sort ahead of all existing packs
in order to prevent a different pack (neither "P" nor "Q") from
appearing as preferred (meaning all its objects appear in order at the
beginning of the pseudo-pack order).

Subsequent commits will first refactor the midx.c::get_sorted_entries()
function, and then fix this bug.

Reported-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5326-multi-pack-bitmaps.sh | 47 +++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 4fe57414c1..c364677ae8 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -307,4 +307,51 @@ test_expect_success 'graceful fallback when missing reverse index' '
 	)
 '
 
+test_expect_success 'preferred pack change with existing MIDX bitmap' '
+	git init preferred-pack-with-existing &&
+	(
+		cd preferred-pack-with-existing &&
+
+		test_commit base &&
+		test_commit other &&
+
+		git rev-list --objects --no-object-names base >p1.objects &&
+		git rev-list --objects --no-object-names other >p2.objects &&
+
+		p1="$(git pack-objects "$objdir/pack/pack" \
+			--delta-base-offset <p1.objects)" &&
+		p2="$(git pack-objects "$objdir/pack/pack" \
+			--delta-base-offset <p2.objects)" &&
+
+		# Generate a MIDX containing the first two packs,
+		# marking p1 as preferred, and ensure that it can be
+		# successfully cloned.
+		git multi-pack-index write --bitmap \
+			--preferred-pack="pack-$p1.pack" &&
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+		git clone --no-local . clone1 &&
+
+		# Then generate a new pack which sorts ahead of any
+		# existing pack (by tweaking the pack prefix).
+		test_commit foo &&
+		git pack-objects --all --unpacked $objdir/pack/pack0 &&
+
+		# Generate a new MIDX which changes the preferred pack
+		# to a pack contained in the existing MIDX, such that
+		# not all objects from p2 that appear in the MIDX had
+		# their copy selected from p2.
+		git multi-pack-index write --bitmap \
+			--preferred-pack="pack-$p2.pack" &&
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+
+		# When the above circumstances are met, an existing bug
+		# in the MIDX machinery will cause the reverse index to
+		# be read incorrectly, resulting in failed clones (among
+		# other things).
+		test_must_fail git clone --no-local . clone2
+	)
+'
+
 test_done
-- 
2.37.0.1.g1379af2e9d

