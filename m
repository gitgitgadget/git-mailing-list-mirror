Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7910C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 22:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3F961263
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 22:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFWWbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 18:31:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:58814 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229688AbhFWWbN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 18:31:13 -0400
Received: (qmail 7891 invoked by uid 109); 23 Jun 2021 22:27:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Jun 2021 22:27:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7294 invoked by uid 111); 23 Jun 2021 22:28:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Jun 2021 18:28:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Jun 2021 18:28:55 -0400
From:   Jeff King <peff@peff.net>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] RFC: implement new zdiff3 conflict style
Message-ID: <YNO1p93gHN4RPZaV@coredump.intra.peff.net>
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
 <YMh2M8Ek/RUVjKkL@coredump.intra.peff.net>
 <CABPp-BE7-E03+x38EK-=AE5mwwdST+d50hiiud2eY2Nsf3rM5g@mail.gmail.com>
 <255df678-9a31-bba2-f023-c7d98e5ffc15@gmail.com>
 <YMnS+2DFYiswc75z@coredump.intra.peff.net>
 <f76c79d6-f280-3011-d88d-6de146977626@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f76c79d6-f280-3011-d88d-6de146977626@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 10:53:25AM +0100, Phillip Wood wrote:

> > Thanks for figuring that out. I agree that the output after the patch
> > you showed is correct, in the sense that the common lines show up in the
> > base now. It does feel like it's working against the point of zdiff3,
> > though, which is to reduce the number of common lines shown in the
> > "ours" and "theirs" hunks.
> 
> I agree - the output is longer rather than shorter. As we only want to trim
> the common prefix and suffix from the conflicts I wonder if it would be
> better to special case zdiff3 rather than piggy backing on the existing
> XDL_MERGE_ZEALOUS implementation. We can trim the common lines by looping
> over the begging and end of the hunk comparing the lines with xdl_recmatch()
> without going to the trouble of diffing them as XDL_MERGE_ZEALOUS does. I
> don't think we need to worry about coalescing adjacent conflicts for zdiff3.
> It makes sense to coalesce in the XDL_MERGE_ZEALOUS case as it can
> potentially split a  N line conflict hunk into N/2 single line conflict
> hunks but zdiff3 does not split conflict hunks.

That matches my intuition of a reasonable path forward (but I confess to
not being too well-versed in the details of the XDL_MERGE internals).

> Yes, I think the heuristic for coalescing conflict hunks could be improved.
> It would be fairly simple to only join two hunks if the conflicts are longer
> that the context between them and the existing XDL_MERGE_ZEALOUS_ALNUM logic
> allows conflicts with more context between them to be coalesced if the
> context lines are uninteresting. I think XDL_MERGE_ZEALOUS_ALNUM is only
> used by `git merge-file` at the moment, with everything else going through
> ll_merge() which uses XDL_MERGE_ZEALOUS

I don't recall much discussion around using ALNUM versus not, nor could
I find much in the archive. It looks like merge-file was converted to
show off ALNUM when it was added in ee95ec5d58 (xdl_merge(): introduce
XDL_MERGE_ZEALOUS_ALNUM, 2008-02-17), and it never really progressed
from there.

It might be an interesting exercise to re-run a bunch of merges and see
if ALNUM produces better (or worse) results on the whole.

-Peff
