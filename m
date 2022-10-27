Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DA8FA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 20:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbiJ0U2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 16:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbiJ0U2U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 16:28:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55578FD76
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 13:28:18 -0700 (PDT)
Received: (qmail 18026 invoked by uid 109); 27 Oct 2022 20:28:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Oct 2022 20:28:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24462 invoked by uid 111); 27 Oct 2022 20:28:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Oct 2022 16:28:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Oct 2022 16:28:17 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] midx.c: clear auxiliary MIDX files first
Message-ID: <Y1rp4d4CXrtnxP9R@coredump.intra.peff.net>
References: <bf36093cd6d7ac83b16241b0199b3a8c904e6774.1666722316.git.me@ttaylorr.com>
 <Y1jIo1dPl0M2TSHo@coredump.intra.peff.net>
 <143a588a-c98b-733b-2b23-34a87ca89431@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <143a588a-c98b-733b-2b23-34a87ca89431@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2022 at 09:31:28AM -0400, Derrick Stolee wrote:

> This was always possible before, too: the midx could be read by a
> reader process before the repack process deletes that file. However,
> if the reader does not also gain a handle on the corresponding
> .bitmap before the repack process deletes that file, too, then the
> reader is also left thinking that no .bitmap exists.

Good point. Neither the writer _nor_ the reader is atomic. :)

> I think the old code is more correct, here. The window is slightly
> smaller, and the new code creates a window where the filesystem
> doesn't need to change for readers to get an imperfect view of
> things.

Yeah, I agree that the old code is nicer in that the window is a little
smaller.

Do we want to do something about the warning, though? Falling back to a
slow path sucks, of course, but racily generating user-visible warnings
for something that is not actually a problem is also not great.

> Aside: in these cases where a .bitmap file is not found for a midx,
> do we fall back to trying to find a .bitmap file for a pack-file?
> That would assuage most of the concerns here about what happens in
> this window where the repack has a new .pack/.bitmap pair but the
> old midx still exists (without a .bitmap, depending on timing).

Yes, we should. Code paths generally go through open_bitmap(), which
tries the midx first, then looks for pack bitmaps.

And in that sense, the race after this patch is fairly harmless. We fail
to see the midx bitmap, but we'll see the pack one (which must have been
created before we deleted the midx one, assuming this is a "git repack
-adb" or equivalent).

Is that also true of the race before this patch? I'm not sure which
warning is being generated, but if it's in open_midx_bitmap_1(), then
the same logic would apply.

-Peff
