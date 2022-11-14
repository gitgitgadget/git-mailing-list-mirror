Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD0CC433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 22:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbiKNWYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 17:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKNWYA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 17:24:00 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B36EF59B
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:24:00 -0800 (PST)
Received: (qmail 15482 invoked by uid 109); 14 Nov 2022 22:23:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 14 Nov 2022 22:23:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14540 invoked by uid 111); 14 Nov 2022 22:23:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 14 Nov 2022 17:23:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 14 Nov 2022 17:23:58 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Teng Long <dyroneteng@gmail.com>, avarab@gmail.com,
        derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 0/2] pack-bitmap.c: avoid exposing absolute paths
Message-ID: <Y3K//kO3fxD7Pl3/@coredump.intra.peff.net>
References: <cover.1667470481.git.dyroneteng@gmail.com>
 <cover.1668063122.git.dyroneteng@gmail.com>
 <Y27MH2LtfVzKEM65@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y27MH2LtfVzKEM65@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2022 at 05:26:39PM -0500, Taylor Blau wrote:

> On Thu, Nov 10, 2022 at 03:10:10PM +0800, Teng Long wrote:
> > From: Teng Long <dyroneteng@gmail.com>
> >
> > Diff since v2:
> >
> > * remove unnecessary comments.
> > * use "GIT_TRACE2_EVENT" instead of "GIT_TRACE_PERF".
> > * improve commit message of [1/2].
> 
> Thanks, this version looks great. I'm very satisfied with where it ended
> up, and I'm feeling comfortable with merging it down.

Me too. If we wanted to go further, there are two obvious next steps.

One, we can break out of the bitmap loop early if we're not tracing:

diff --git a/pack-bitmap.c b/pack-bitmap.c
index aaa2d9a104..3b6c2f804a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -527,8 +527,15 @@ static int open_pack_bitmap(struct repository *r,
 	assert(!bitmap_git->map);
 
 	for (p = get_all_packs(r); p; p = p->next) {
-		if (open_pack_bitmap_1(bitmap_git, p) == 0)
+		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
 			ret = 0;
+			/*
+			 * The only reason to keep looking is to report
+			 * duplicates.
+			 */
+			if (!trace2_is_enabled())
+				break;
+		}
 	}
 
 	return ret;

I doubt this buys us much in practice. After patch 2, looking for extra
bitmaps is much cheaper. It's one open() call per pack (which will
return ENOENT normally) looking for a bitmap. And while it's only 2
lines of code, it does increase coupling of assumptions between the two
functions. So maybe not worth doing. I dunno.

And two, we could complain when there is both a midx and a pack bitmap,
like so:

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3b6c2f804a..44a80ed8f2 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -524,8 +524,6 @@ static int open_pack_bitmap(struct repository *r,
 	struct packed_git *p;
 	int ret = -1;
 
-	assert(!bitmap_git->map);
-
 	for (p = get_all_packs(r); p; p = p->next) {
 		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
 			ret = 0;
@@ -559,11 +557,20 @@ static int open_midx_bitmap(struct repository *r,
 static int open_bitmap(struct repository *r,
 		       struct bitmap_index *bitmap_git)
 {
+	int found = 0;
+
 	assert(!bitmap_git->map);
 
-	if (!open_midx_bitmap(r, bitmap_git))
-		return 0;
-	return open_pack_bitmap(r, bitmap_git);
+	found = !open_midx_bitmap(r, bitmap_git);
+
+	/*
+	 * these will all be skipped if we opened a midx bitmap; but run it
+	 * anyway if tracing is enabled to report the duplicates
+	 */
+	if (!found || trace2_is_enabled())
+		found |= !open_pack_bitmap(r, bitmap_git);
+
+	return found ? 0 : -1;
 }
 
 struct bitmap_index *prepare_bitmap_git(struct repository *r)

But I'm not sure if that is even something we want. I know we retained
pack bitmaps as a quick recovery mechanism while test-deploying midx
bitmaps. OTOH, now that the feature is stable, I doubt anybody else
would ever do that.

It also suffers from the same coupling issues as the other.

So I don't know that either is worth pursuing (hence this message and
not fully prepared patches), but these are just the two leftover things
I noticed from the series, so I wanted to record them for posterity.

-Peff
