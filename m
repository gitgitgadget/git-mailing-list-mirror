Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE93EB64DA
	for <git@archiver.kernel.org>; Sun,  2 Jul 2023 13:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjGBNLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jul 2023 09:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGBNLT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2023 09:11:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CA9135
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 06:11:18 -0700 (PDT)
Received: (qmail 12278 invoked by uid 109); 2 Jul 2023 13:11:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 02 Jul 2023 13:11:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12297 invoked by uid 111); 2 Jul 2023 13:11:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 02 Jul 2023 09:11:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 2 Jul 2023 09:11:17 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] repack: only repack .packs that exist
Message-ID: <20230702131117.GB1036686@coredump.intra.peff.net>
References: <pull.1546.git.1687287782439.gitgitgadget@gmail.com>
 <20230627075427.GE1226768@coredump.intra.peff.net>
 <ZJ1N2I6sDfxhrJo8@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJ1N2I6sDfxhrJo8@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 29, 2023 at 05:24:40AM -0400, Taylor Blau wrote:

> > I also kind of wonder if this repack code should simply be loading and
> > iterating the packed_git list, but that is a much bigger change.
> 
> I have wanted to do this for a while ;-). The minimal patch is less
> invasive than I had thought:

Yeah, I agree it's not too bad. If we want to go that route, though, I
think we should do it on top of Stolee's patch, though (which makes it a
pure cleanup once the behaviors are aligned).

I'm also not sure if you'd need to do anything tricky with alternate
object dirs (it looks like the existing code ignores them entirely, so I
guess we'd want to skip entries without pack_local set).

> [...]
> I think you could probably go further than this, since having to store
> the suffix-less pack names in the fname_kept and fname_nonkept lists is
> kind of weird.
> 
> It would be nice if we could store pointers to the actual packed_git
> structs themselves in place of those lists instead, but I'm not
> immediately sure how feasible it would be to do since we re-prepare the
> object store between enumerating and then removing these packs.

I think that would work, because we do not ever drop packed_git entries
from the list (even if the files were deleted between prepare/reprepare).
But it also creates a subtle memory ownership dependency/assumption
between the two bits of code. It seems clearer to me to just copy the
names out to our own lists here (i.e., the patch you showed).

-Peff
