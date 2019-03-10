Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AFDF202BB
	for <e@80x24.org>; Sun, 10 Mar 2019 23:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfCJXj7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 19:39:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:45256 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727063AbfCJXj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 19:39:59 -0400
Received: (qmail 12345 invoked by uid 109); 10 Mar 2019 23:39:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 10 Mar 2019 23:39:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18601 invoked by uid 111); 10 Mar 2019 23:40:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 10 Mar 2019 19:40:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Mar 2019 19:39:57 -0400
Date:   Sun, 10 Mar 2019 19:39:57 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: bitmaps by default? [was: prune: use bitmaps for reachability
 traversal]
Message-ID: <20190310233956.GB3059@sigill.intra.peff.net>
References: <20190214043127.GA19019@sigill.intra.peff.net>
 <20190214043743.GB19183@sigill.intra.peff.net>
 <20190309024944.zcbwgvn52jsw2a2e@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190309024944.zcbwgvn52jsw2a2e@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 09, 2019 at 02:49:44AM +0000, Eric Wong wrote:

> Jeff King <peff@peff.net> wrote:
> > Pruning generally has to traverse the whole commit graph in order to
> > see which objects are reachable. This is the exact problem that
> > reachability bitmaps were meant to solve, so let's use them (if they're
> > available, of course).
> 
> Perhaps this is good impetus for doing bitmaps by default?

I'm actually not sure it is, because the prune costs less than making
the bitmaps. Here are some timings on linux.git. This full-graph
traversal is roughly the same cost as the reachability walk that prune
would do internally:

	$ time git rev-list --objects --all >/dev/null
	real	0m47.714s
	user	0m47.113s
	sys	0m0.600s

Here's a normal noop repack as a baseline.

	$ time git repack -ad
	real	1m26.922s
	user	1m20.029s
	sys	0m7.878s

And here's another immediately after with bitmap generation. Generating
the bitmaps takes about 100s, compared to the 47s it would save us on
the prune.

	$ time git repack -adb
	real	3m5.915s
	user	2m59.377s
	sys	0m7.718s

Things are a little rosier if you generate the bitmaps a second time:

	$ time git repack -adb
	real	1m43.571s
	user	1m37.403s
	sys	0m8.179s

We can reuse some of the old bitmaps and it only takes 20 extra seconds,
making it a net win. But I'm not sure how realistic that is. There were
literally no new objects introduced between those two command. If this
were a "real" repack occurring after we'd accumulated a week or two
worth of objects, how long would it take?

A few other random observations:

  - I do suspect there are some real inefficiencies in the way we
    generate bitmaps. It _should_ be about as expensive as the graph
    traversal, but clearly it's not. I think this is because of the way
    the current bitmap code picks commits to bitmap, and then walks
    somewhat haphazardly over the history, trying to accumulate the set
    of objects for each commit. IOW, I believe it may sometimes
    traverse over some sequences of history more than once. So if we
    could make that faster, then the balance would shift in its favor.

  - This is comparing the cost of generating the bitmaps to the time
    saved for _one_ operation. On a repo serving many fetches, the cost
    to generate it is amortized over many requests. But for a normal
    end-user, that's not true (they'd presumably push out their work,
    but that usually only needs to walk a small bit of history anyway).

    The balance would change if we had more operations that used bitmaps
    (e.g., --contains can use them, as can ahead/behind checks). We
    don't do those things yet, but we could. However, those algorithms
    are also using other commit-graph optimizations, and we've discussed
    revamping the bitmap format as part of that work (one problem in
    particular is that to use the current bitmaps you have to parse the
    whole .bitmap file, making it sometimes a net negative to use the
    bitmaps). So I'd consider holding off any decision like "let's make
    this the default" until we see where that work goes.

> It would make life easier for people new to hosting git servers
> (and hopefully reduce centralization :)

I do think they're a net win for people hosting git servers. But if
that's the goal, I think at most you'd want to make bitmaps the default
for bare repos. They're really not much help for normal end-user repos
at this point.

> I started working on it, but t0410-partial-clone.sh fails with
> "Failed to write bitmap index. Packfile doesn't have full
> closure"; so more work needs to be done w.r.t. default behavior
> on partial clones...

Yeah, you can't use bitmaps at all in an incomplete clone. Shallow
clones would probably have the same issue (though in general we just
disable bitmaps entirely in shallow situations, so that might kick in).

-Peff
