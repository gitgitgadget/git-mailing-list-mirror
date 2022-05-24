Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A064C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 18:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbiEXSyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 14:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240491AbiEXSy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 14:54:27 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D06E5A168
        for <git@vger.kernel.org>; Tue, 24 May 2022 11:54:26 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-f17f1acffeso23381884fac.4
        for <git@vger.kernel.org>; Tue, 24 May 2022 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mQp8NliBj5JpIDXrjp5fkKh0Z7L6r2JU92UGn9OVt6s=;
        b=ydmyN3x3ORauPTvQ9WbOd9si5JrFwWwPXdWvVJgojRW9pJZIGXAMWBUUIKbaDDYsSD
         diisAWkxojLBKEfyCIAkICy3GEACdACR7OqUpMiGoIZqTaJKiFqEcBtlP4CEeWhFq94a
         2Wlzn7h/8ASwgw5qkKIY1cQNnf9OjVkep+nCe4KqR8Y3X8QhmnB3QScvA+qNBf1Q6sgP
         yDTPwUffqTldkLa9bpmAA31vaPIP/otfCh5OAYRoLaKieQRl5QEHVbTu8cS14GbDj2qg
         MhF2DUTFAO09LVgCqOYN8BEgsRhknZLuk3yFjACtHdBmXAs20VkXLsHj2YZ95pdIYorB
         UJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mQp8NliBj5JpIDXrjp5fkKh0Z7L6r2JU92UGn9OVt6s=;
        b=TF5u0AiECkX0VNnl2yHelx35Xx3s7Al5XYsgpnaa2vHsQA3Yg53Z5dIhZQpxprKuW/
         BljsMpRro7S2iMuZ25RE2p3xQmB4JVwCbCf8YCNMNLZQfdF0z1YwRCF8HeUpFedaG3DZ
         EVVYCAx9Nixmtx34uSLEuK186gXXh57Fu9I9un8mKhLaDljiykORaYVBKG6IREcsQemY
         kDsHo5Jw77fWp1as1fRXejTfoA/+jE+HZDPmsHmg3svkEzfLGuUy3FnaPP+DASo0LjiW
         dVXd9njLeY6Vmlg8e07e6SbFBXxNXU5dc7IZXdE14OWza4SxuCFl/VeaNzjPNieTFNVI
         mDTA==
X-Gm-Message-State: AOAM530mHUxgDpdZ+IPXTSgbtUpc/za2eYDEC9BNflMl0nQz+32qGcJh
        6EsRVB0eQo6N8vY7znrbp+3A1TTypUWvhw==
X-Google-Smtp-Source: ABdhPJzryHNzWBuMS5hAx1Gs56Bec1rTNKulJAB+uQ+MbAfHyu9xpT4EOrBoRkIMP4fuqDfwOL78RA==
X-Received: by 2002:a05:6870:b14a:b0:f2:3221:be57 with SMTP id a10-20020a056870b14a00b000f23221be57mr3343092oal.10.1653418465394;
        Tue, 24 May 2022 11:54:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s7-20020a05687087c700b000f2911d1987sm1396028oam.39.2022.05.24.11.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 11:54:24 -0700 (PDT)
Date:   Tue, 24 May 2022 14:54:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v2 1/4] pack-bitmap.c: check preferred pack validity when
 opening MIDX bitmap
Message-ID: <618e8a6166473d238e62ce6243d9a0b2b72ee2f0.1653418457.git.me@ttaylorr.com>
References: <cover.1652458395.git.me@ttaylorr.com>
 <cover.1653418457.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653418457.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When pack-objects adds an entry to its packing list, it marks the
packfile and offset containing the object, which we may later use during
verbatim reuse (c.f., `write_reused_pack_verbatim()`).

If the packfile in question is deleted in the background (e.g., due to a
concurrent `git repack`), we'll die() as a result of calling use_pack(),
unless we have an open file descriptor on the pack itself. 4c08018204
(pack-objects: protect against disappearing packs, 2011-10-14) worked
around this by opening the pack ahead of time before recording it as a
valid source for reuse.

4c08018204's treatment meant that we could tolerate disappearing packs,
since it ensures we always have an open file descriptor on any pack that
we mark as a valid source for reuse. This tightens the race to only
happen when we need to close an open pack's file descriptor (c.f., the
caller of `packfile.c::get_max_fd_limit()`) _and_ that pack was deleted,
in which case we'll complain that a pack could not be accessed and
die().

The pack bitmap code does this, too, since prior to dc1daacdcc
(pack-bitmap: check pack validity when opening bitmap, 2021-07-23) it
was vulnerable to the same race.

The MIDX bitmap code does not do this, and is vulnerable to the same
race. Apply the same treatment as dc1daacdcc to the routine responsible
for opening the multi-pack bitmap's preferred pack to close this race.

This patch handles the "preferred" pack (c.f., the section
"multi-pack-index reverse indexes" in
Documentation/technical/pack-format.txt) specially, since pack-objects
depends on reusing exact chunks of that pack verbatim in
reuse_partial_packfile_from_bitmap(). So if that pack cannot be loaded,
the utility of a bitmap is significantly diminished.

Similar to dc1daacdcc, we could technically just add this check in
reuse_partial_packfile_from_bitmap(), since it's possible to use a MIDX
.bitmap without needing to open any of its packs. But it's simpler to do
the check as early as possible, covering all direct uses of the
preferred pack. Note that doing this check early requires us to call
prepare_midx_pack() early, too, so move the relevant part of that loop
from load_reverse_index() into open_midx_bitmap_1().

Subsequent patches handle the non-preferred packs in a slightly
different fashion.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 97909d48da..d607918407 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -315,6 +315,8 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	struct stat st;
 	char *idx_name = midx_bitmap_filename(midx);
 	int fd = git_open(idx_name);
+	uint32_t i;
+	struct packed_git *preferred;
 
 	free(idx_name);
 
@@ -353,6 +355,20 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		warning(_("multi-pack bitmap is missing required reverse index"));
 		goto cleanup;
 	}
+
+	for (i = 0; i < bitmap_git->midx->num_packs; i++) {
+		if (prepare_midx_pack(the_repository, bitmap_git->midx, i))
+			die(_("could not open pack %s"),
+			    bitmap_git->midx->pack_names[i]);
+	}
+
+	preferred = bitmap_git->midx->packs[midx_preferred_pack(bitmap_git)];
+	if (!is_pack_valid(preferred)) {
+		warning(_("preferred pack (%s) is invalid"),
+			preferred->pack_name);
+		goto cleanup;
+	}
+
 	return 0;
 
 cleanup:
@@ -429,8 +445,6 @@ static int load_reverse_index(struct bitmap_index *bitmap_git)
 		 * since we will need to make use of them in pack-objects.
 		 */
 		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
-			if (prepare_midx_pack(the_repository, bitmap_git->midx, i))
-				die(_("load_reverse_index: could not open pack"));
 			ret = load_pack_revindex(bitmap_git->midx->packs[i]);
 			if (ret)
 				return ret;
-- 
2.36.1.94.gb0d54bedca

