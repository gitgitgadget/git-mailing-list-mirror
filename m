Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E8DD1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 21:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753156AbcJKVsH (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 17:48:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:56107 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752814AbcJKVsG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 17:48:06 -0400
Received: (qmail 10613 invoked by uid 109); 11 Oct 2016 21:47:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 21:47:15 +0000
Received: (qmail 13619 invoked by uid 111); 11 Oct 2016 21:47:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 17:47:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Oct 2016 17:47:14 -0400
Date:   Tue, 11 Oct 2016 17:47:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Support `git reset --stdin`
Message-ID: <20161011214713.y2fpjkrx6sspks4a@sigill.intra.peff.net>
References: <cover.1476202100.git.johannes.schindelin@gmx.de>
 <20161011183448.yasglfjelo4kgrq4@sigill.intra.peff.net>
 <xmqqshs28z52.fsf@gitster.mtv.corp.google.com>
 <20161011212644.zzqidtcgatu3qsei@sigill.intra.peff.net>
 <xmqqoa2q7elc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqoa2q7elc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 02:36:31PM -0700, Junio C Hamano wrote:

> > True. I'd have done something more like:
> >
> >   git ls-tree -r $paths | git update-index --index-info
> >
> > but there are some corner cases around deleting paths from the index.
> 
> Ah, I would think read-tree has the exact same issue, even if we
> added pathspec support, around removal.
> 
> So it is more like
> 
> 	(
> 		printf "0 0000000000000000000000000000000000000000\t%s\n" $paths
> 		git --literal-pathspecs ls-tree -r --ignore-missing $paths
> 	) | git update-index --index-info
> 
> which does not look too bad, even though this
> 
> 	printf "%s\n" $paths | git reset --stdin
> 
> does look shorter.

Of course neither of ours solutions works when "$paths" is coming on
stdin, rather than in a variable, which I suspect was Dscho's original
motivation. :)

One reason not to do the unconditional $z40 in yours is that without it,
I would hope that update-index is smart enough not to discard the stat
information for entries which are unchanged.

I suspect the best answer is more like:

  git diff-index --cached HEAD | git update-index --index-info

except that you have to munge the data in between, because update-index
does not know how to pick the correct data out of the --raw diff output.
But that's probably closer to what git-reset does internally.

Anyway, the existence of this discussion is probably a good argument in
favor of Dscho's patch. I was mostly curious how close our plumbing
tools could come.

-Peff
