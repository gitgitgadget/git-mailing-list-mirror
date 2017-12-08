Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9271FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 21:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbdLHViZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 16:38:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:52924 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752172AbdLHViY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 16:38:24 -0500
Received: (qmail 30851 invoked by uid 109); 8 Dec 2017 21:38:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 21:38:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6279 invoked by uid 111); 8 Dec 2017 21:38:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 16:38:46 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 16:38:22 -0500
Date:   Fri, 8 Dec 2017 16:38:22 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] diffcore: add a filter to find a specific blob
Message-ID: <20171208213822.GD7355@sigill.intra.peff.net>
References: <20171208002447.20261-1-sbeller@google.com>
 <20171208002447.20261-2-sbeller@google.com>
 <20171208093434.GD26199@sigill.intra.peff.net>
 <643e1afd-43e2-7fcc-452b-8b9ceac6868c@ramsayjones.plus.com>
 <20171208201957.GA456@sigill.intra.peff.net>
 <CAGZ79kaos7cmQe3bmR5gCVXbUjBBQdSYYOE11egnDEMaX-7xSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaos7cmQe3bmR5gCVXbUjBBQdSYYOE11egnDEMaX-7xSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 08, 2017 at 12:39:55PM -0800, Stefan Beller wrote:

> > If you add --raw, you can see that both commits introduce that blob, and
> > it never "goes away". That's because that happened in a merge, which we
> > don't diff in a default log invocation.
> 
> We should when --raw is given.
> --raw is documented as  "For each commit, show a summary of changes
> using the raw diff format." and I would argue that 'each commit' includes
> merges. Though I guess this may have implications for long time users.

And "--patch" is documented as "generate patch", but it also does
nothing for merges by default. I think it has little to do with "--raw".
It is simply that the default for "log" is none of "-c", "--cc", or
"-m".

We _could_ change that default ("--cc" is already the default for
git-show), but I would not be surprised if that has fallouts (certainly
it makes git-log much slower).

> > So I think this one is tricky because of the revert. In the same way
> > that pathspec-limiting is often tricky in the face of a revert, because
> > the merges "hide" interesting things happening.
> 
> yup, hidden merges are unfortunate. Is there an easy way to find out
> about merges? (Junio hints at having tests around merges, which I'll do
> next)

If you find such an easy way, let me know. :)

One of the few really manual types of query I remember having done in
recent years is trying to pinpoint a bad merge. I.e., somebody during
merge resolution accidentally does "git checkout --ours foo.c", blowing
away changes which they didn't mean to. And then later you want to
figure out which merge did it.

If you use "-c" or "--cc", that isn't an "interesting" change, because
it resolves to one side of the merge. If you use "-m", you get way too
many changes and have to comb through them manually. I've resorted to
"-m --first-parent", but then you frequently have to dig down several
layers (e.g., the bad merge is a merge from "master" onto a topic
branch, and your first "--first-parent" attempt will just find the bad
topic being merged back into master).

I think the most promising tool I've seen there is to redo the merge and
show the diff between the auto-merge (including conflicts) and the
committed tree. It's just another definition of "is this hunk
interesting" that's different from "--cc".

I'm not sure how that would interact with something like "--blobfind",
though. For that matter, I'm not quite sure how your patch would
interact with "--cc". I think you may need to special-case it.

-Peff
