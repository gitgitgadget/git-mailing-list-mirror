Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1C9C43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 08:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiGFIwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 04:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiGFIwY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 04:52:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECA824970
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 01:52:22 -0700 (PDT)
Received: (qmail 2732 invoked by uid 109); 6 Jul 2022 08:52:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Jul 2022 08:52:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18402 invoked by uid 111); 6 Jul 2022 08:52:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Jul 2022 04:52:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Jul 2022 04:52:21 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Will Chandler <wfc@wfchandler.org>, derrickstolee@github.com,
        git@vger.kernel.org, ps@pks.im
Subject: Re: commit-graph overflow generation chicken and egg
Message-ID: <YsVNRXPFFdjlvMy9@coredump.intra.peff.net>
References: <a154e109-3f4c-c500-3365-d47879abf30d@github.com>
 <DD88D523-0ECA-4474-9AA5-1D4A431E532A@wfchandler.org>
 <YsS7H4i5DqUZVQ5i@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsS7H4i5DqUZVQ5i@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 05, 2022 at 06:28:47PM -0400, Taylor Blau wrote:

> > This re-writes the commit data to:
> >
> >   {
> >     graph_pos = 0,
> >     generation = 17631
> >   }
> 
> Nicely explained. To me, it seems like the problem is that we're reusing
> the same slab to:
> 
>   - store data that we're going to write as a part of commit-graph
>     generation, and
>   - store auxiliary data about commits that we have *read* from a
>     commit-graph
> 
> A complete fix might be to use a separate slab to store data that we
> read from data that we are about to write, to avoid polluting the latter
> with the former.

Yeah, that was my first instinct, too. But from a skim of the code, I
think that may be complicated, as the two uses don't seem to be
differentiated well. Or at least it resisted some basic hacky efforts I
made (e.g., splitting commit_graph_data_at() from the more limited
readers). I'm not that familiar with the commit-graph writing code; I
suspect Stolee might have something intelligent to say.

> In the meantime, a more minimal fix would be to avoid reading and
> overwriting the generation data where we can avoid it. AFAICT, this is
> the only spot that would need to be changed. The following patch does
> the trick for me:

Yeah, it fixes it for me, too, but it leaves me with many questions. ;)
Specifically:

  - if it's so easy to get the position, why do we have the position in
    the slab in the first place? Or is it for the cases where we're
    writing (though then the question is: why do we fill it for the read
    case, then)?

  - if I understand correctly, the real sin here was calling
    commit_graph_position() during the write. How can we find
    other potential problem spots? From my (again, admittedly not well
    developed) view of the code, it seems like an intentional choice
    that you could intermingle computed and from-disk results.

At any rate, thanks to both you and Will for moving this forward.

-Peff
