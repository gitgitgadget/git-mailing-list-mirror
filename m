Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62AE320282
	for <e@80x24.org>; Thu, 15 Jun 2017 05:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbdFOF45 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 01:56:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:40426 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751623AbdFOF44 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 01:56:56 -0400
Received: (qmail 25863 invoked by uid 109); 15 Jun 2017 05:56:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 05:56:56 +0000
Received: (qmail 19686 invoked by uid 111); 15 Jun 2017 05:56:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 01:56:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jun 2017 01:56:54 -0400
Date:   Thu, 15 Jun 2017 01:56:54 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [BUG] add_again() off-by-one error in custom format
Message-ID: <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
References: <CACi5S_1j46SbP7cQMdUnULmgGD7xBkSUrS2PKbzq8ZydybHE=w@mail.gmail.com>
 <xmqqd1a8n7o8.fsf@gitster.mtv.corp.google.com>
 <d229403a-d078-87b4-f3e8-89058fa4b548@web.de>
 <xmqqtw3j68rc.fsf@gitster.mtv.corp.google.com>
 <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
 <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
 <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2017 at 08:24:25PM +0200, René Scharfe wrote:

> > I think the real question is how likely people use more than one
> > occurrence of the same thing in their custom format, and how deeply
> > they care that --format='%h %h' costs more than --format='%h'.  The
> > cost won't of course be double (because the main traversal costs
> > without any output), but it would be rather unreasonable to expect
> > that --format='%h %h %h %h %h' to cost the same as --format='%h';
> > after all, Git is doing more for them ;-)
> 
> The answer to the first half is obviously "very likely" -- otherwise
> this bug wouldn't have been found, right? :)
> 
> Regarding the question of how bad a 50% slowdown for a second %h
> would be: No idea.  If ran interactively it may not even be noticeable
> because the user can read the first few lines in less while the rest
> is prepared in the background.  We don't have a perf test for formats
> with duplicate short hashes, so we don't promise anything, right? :)

One interesting thing is that the cost of finding short hashes very much
depends on your loose object setup. I timed:

  git log --format=%H >/dev/null

versus

  git log --format=%h >/dev/null

on git.git. It went from about 400ms to about 800ms. But then I noticed
I had a lot of loose object directories, and ran "git gc --prune=now".
Afterwards, my timings were more like 380ms and 460ms.

The difference is that in the "before" case, we actually opened each
directory and ran getdents(). But after gc, the directories are gone
totally and open() fails. We also have to do a linear walk through the
objects in each directory, since the contents are sorted.

So I wonder if it is worth trying to optimize the short-sha1 computation
in the first place. Double-%h aside, that would make _everything_
faster, including --oneline.

I'm not really sure how, though, short of caching the directory
contents. That opens up questions of whether and when to invalidate the
cache. If the cache were _just_ about short hashes, it might be OK to
just assume that it remains valid through the length of the program (so
worst case, a simultaneous write might mean that we generate a sha1
which just became ambiguous, but that's generally going to be racy
anyway).

The other downside of course is that we'd spend RAM on it. We could
bound the size of the cache, I suppose.

-Peff
