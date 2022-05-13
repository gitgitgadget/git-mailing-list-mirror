Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B005C433EF
	for <git@archiver.kernel.org>; Fri, 13 May 2022 16:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382361AbiEMQX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 12:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358037AbiEMQXU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 12:23:20 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290A235248
        for <git@vger.kernel.org>; Fri, 13 May 2022 09:23:19 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id s6so1259633ilp.9
        for <git@vger.kernel.org>; Fri, 13 May 2022 09:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pn/WrrMKqTOpjFtRQE1FWdL5QeafcBhrR9gmnxszgeo=;
        b=AcYTxsOUX6pZNAA+11luSXFd+Ul8A3rFGcm/ipHkuGlvebknPGrSgC5CvLiGA2YMRI
         AKUBy/xYf6RsRaD7UUZXL54MBwRasVlEGnvsbcTRn7rSe1nMDV2MWvpbrkucgUel0Dij
         j8vqhPN8bbmlDy9w2cHVNFnE1wkx97q9gVuH00BBl51wTrk3zJ/4bcPMhEa0tS6DkBVg
         dJ9fZ5Q7bhzz1+bLHEdLrNKuVZyw0ZieudQppCvx0rxvD3V5fFCoCGobLzSCqwuYSHhw
         vZJYiwH4lX83/oAR24hN6jvbGfywbgQKFxKLYvawPbYyPt9R7rna9T05nb/E7zIlmS57
         kycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pn/WrrMKqTOpjFtRQE1FWdL5QeafcBhrR9gmnxszgeo=;
        b=cF6yj0C2w2cQ1mR3CeK2aojDIIEvaSP3B+fq4OzZeMD+lCNShHM8PZeN0BWUHHqjs9
         kJvrm3jpVIwaVgGwQqCipUvm8fREFkeA6EuxPKmjFo64EOgpzk1NayiZ//BMctEowZrc
         VSbO66KAIE+5PJpkeKWyxq18+RWQmNR6vriH9xGn20+Uxz0XddJn3B2VCE7zvls9BNdN
         ZiXKBm2NwywKX/x2s36mgwG2EXJo4QDI8NdgdNnaEDW40sNBre7u+Bhfzh0MB8kRfDM/
         J4hRuZFm/AJUvTO5KNRUvXhC8buXAgbKN5epaMIFkUT+7+x7B3ug1yy2HHL1AwernpKH
         c9rA==
X-Gm-Message-State: AOAM532G6GLurCHmJgKJKs5b+pJRpNXp1MRf6UcVzSGywL4m31XNArzg
        xmVOT+BVXU4lkU6VWjdd1BGNuFmBjy1FS2s2
X-Google-Smtp-Source: ABdhPJwckv2BVNfJMeAM8Pft+X2uKzempxoSHX/ykT2JHP59XM9jhXzZGCq9nj9AIrgi3YJ7jUoM8Q==
X-Received: by 2002:a05:6e02:1aa3:b0:2cf:74b1:8404 with SMTP id l3-20020a056e021aa300b002cf74b18404mr3066271ilv.101.1652458998450;
        Fri, 13 May 2022 09:23:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f2-20020a056638118200b0032b3a7817b6sm764213jas.122.2022.05.13.09.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 09:23:18 -0700 (PDT)
Date:   Fri, 13 May 2022 12:23:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH 1/2] pack-bitmap: check preferred pack validity when opening
 MIDX bitmap
Message-ID: <06eca1fba9d2597906ec342c51ba2bb5c4fde0e4.1652458395.git.me@ttaylorr.com>
References: <cover.1652458395.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1652458395.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When pack-objects adds an entry to its packing list, it marks the
packfile and offset containing the object, which we may later use during
verbatim reuse (c.f., `write_reused_pack_verbatim()`).

If the packfile in question is deleted in the background (e.g., due to a
concurrent `git repack`), we'll die() as a result of calling use_pack().
4c08018204 (pack-objects: protect against disappearing packs,
2011-10-14) worked around this by opening the pack ahead of time before
recording it as a valid source for reuse.

4c08018204's treatment meant that we could tolerate disappearing packs,
since it ensures we always have an open file descriptor any pack that we
mark as a valid source for reuse. This tightens the race to only happen
when we need to close an open pack's file descriptor (c.f., the caller
of `packfile.c::get_max_fd_limit()`) _and_ that pack was deleted, in
which case we'll complain that a pack could not be accessed and die().

The pack bitmap code does this, too, since prior to bab919bd44
(pack-bitmap: check pack validity when opening bitmap, 2015-03-26) it
was vulnerable to the same race.

The MIDX bitmap code does not do this, and is vulnerable to the same
race. Apply the same treatment as bab919bd44 to the routine responsible
for opening multi-pack bitmaps to close this race.

Similar to bab919bd44, we could technically just add this check in
reuse_partial_packfile_from_bitmap(), since it's technically possible to
use a MIDX .bitmap without needing to open any of its packs. But it's
simpler to do the check as early as possible, covering all direct uses
of the preferred pack. Note that doing this check early requires us to
call prepare_midx_pack() early, too, so move the relevant part of that
loop from load_reverse_index() into open_midx_bitmap_1().

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 97909d48da..6b1a43d99c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -315,6 +315,8 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	struct stat st;
 	char *idx_name = midx_bitmap_filename(midx);
 	int fd = git_open(idx_name);
+	uint32_t i;
+	struct packed_git *preferred;
 
 	free(idx_name);
 
@@ -353,6 +355,21 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
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
+		close(fd);
+		warning(_("preferred pack (%s) is invalid"),
+			preferred->pack_name);
+		goto cleanup;
+	}
+
 	return 0;
 
 cleanup:
@@ -429,8 +446,6 @@ static int load_reverse_index(struct bitmap_index *bitmap_git)
 		 * since we will need to make use of them in pack-objects.
 		 */
 		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
-			if (prepare_midx_pack(the_repository, bitmap_git->midx, i))
-				die(_("load_reverse_index: could not open pack"));
 			ret = load_pack_revindex(bitmap_git->midx->packs[i]);
 			if (ret)
 				return ret;
-- 
2.36.1.76.g80c0bcd80e

