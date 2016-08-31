Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AACC20229
	for <e@80x24.org>; Wed, 31 Aug 2016 05:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbcHaFmG (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 01:42:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:35749 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750708AbcHaFmG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 01:42:06 -0400
Received: (qmail 7343 invoked by uid 109); 31 Aug 2016 05:42:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 Aug 2016 05:42:05 +0000
Received: (qmail 3461 invoked by uid 111); 31 Aug 2016 05:42:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 Aug 2016 01:42:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Aug 2016 01:42:01 -0400
Date:   Wed, 31 Aug 2016 01:42:01 -0400
From:   Jeff King <peff@peff.net>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
Subject: Re: git blame <directory> [was: Reducing CPU load on git server]
Message-ID: <20160831054201.ldlwptlmcndjmfwu@sigill.intra.peff.net>
References: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
 <20160829054725.r6pqf3xlusxi7ibq@sigill.intra.peff.net>
 <CAFMAO9yUMY5dqw-oWpKG1H-xska1AtDyt31_WaeJDyTieQLChw@mail.gmail.com>
 <20160829213101.3ulrw5hrh5pytjii@sigill.intra.peff.net>
 <9fe5aa9b-5ba8-2b9a-7feb-58e115be3902@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fe5aa9b-5ba8-2b9a-7feb-58e115be3902@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 30, 2016 at 12:46:20PM +0200, Jakub Narębski wrote:

> W dniu 29.08.2016 o 23:31, Jeff King pisze:
> 
> > Blame-tree is a GitHub-specific command (it feeds the main repository
> > view page), and is a known CPU hog. There's more clever caching for that
> > coming down the pipe, but it's not shipped yet.
> 
> I wonder if having support for 'git blame <directory>' in Git core would
> be something interesting to Git users.  I once tried to implement it,
> but it went nowhere.  Would it be hard to implement?

I think there's some interest; I have received a few off-list emails
over the years about it. There was some preliminary discussion long ago:

  http://public-inbox.org/git/20110302164031.GA18233@sigill.intra.peff.net/

The code that runs on GitHub is available in my fork of git. I haven't
submitted it upstream because there are some lingering issues. I
mentioned them on-list in the first few items of:

  http://public-inbox.org/git/20130318121243.GC14789@sigill.intra.peff.net/

That code is in the jk/blame-tree branch of https://github.com/peff/git
if you are interested in addressing them (note that I haven't touched
that code in a few years except for rebasing it forward, so it may have
bitrotted a little).

Here's a snippet from an off-list conversation I had with Dennis (cc'd)
in 2014 (I think he uses that blame-tree code as part of a custom git
web interface):

> The things I think it needs are:
> 
>   1. The max-depth patches need to be reconciled with Duy's pathspec
>      work upstream. The current implementation works only for tree
>      diffs, and is not really part of the pathspec at all.
> 
>   2. Docs/output formats for blame-tree need to be friendlier, as you
>      noticed.
> 
>   3. Blame-tree does not use revision pathspecs at all. This makes it
>      take way longer than it could, because it does not prune away side
>      branches deep in history that affect only paths whose blame we have
>      already found. But the current pathspec code is so slow that using
>      it outweighs the pruning benefit.
> 
>      I have a series, which I just pushed up to jk/faster-blame-tree,
>      which tries to improve this.  But it's got a lot of new, untested
>      code itself (we are not even running it at GitHub yet). It's also
>      based on v1.9.4; I think there are going to be a lot of conflicts
>      with the combine-tree work done in v2.0.
> 
> [...]
> 
> I also think it would probably make sense for blame-tree to support the
> same output formats as git-blame (e.g., to have an identical --porcelain
> mode, to have a reasonable human-readable format by default, etc).

That's all I could dig out of my archives. I'd be happy if somebody
wanted to pick it up and run with it. Polishing for upstream has been on
my list for several years now, but there's usually something more
important (or interesting) to work on at any given moment.

You might also look at how GitLab does it. I've never talked to them
about it, and as far as I know they do not use blame-tree.

-Peff
