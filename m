Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19D5020986
	for <e@80x24.org>; Tue,  4 Oct 2016 17:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbcJDRjh (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 13:39:37 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:55454 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbcJDRjg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 13:39:36 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1brTgc-0002oM-00; Tue, 04 Oct 2016 17:39:26 +0000
Date:   Tue, 4 Oct 2016 13:39:26 -0400
From:   Rich Felker <dalias@libc.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        musl@lists.openwall.com
Subject: Re: [musl] Re: Regression: git no longer works with musl libc's
 regex impl
Message-ID: <20161004173926.GA19318@brightrain.aerifal.cx>
References: <20161004150848.GA7949@brightrain.aerifal.cx>
 <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
 <20161004154045.GT19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610041802310.35196@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610041802310.35196@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 06:08:33PM +0200, Johannes Schindelin wrote:
> Hi Rich,
> 
> On Tue, 4 Oct 2016, Rich Felker wrote:
> 
> > On Tue, Oct 04, 2016 at 11:27:22AM -0400, Jeff King wrote:
> > > On Tue, Oct 04, 2016 at 11:08:48AM -0400, Rich Felker wrote:
> > > 
> > > > 1. is nonzero mod page size, it just works; the remainder of the last
> > > >    page reads as zero bytes when mmapped.
> > > 
> > > Is that a portable assumption?
> > 
> > Yes.
> 
> No, it is not. You quote POSIX, but the matter of the fact is that we use
> a subset of POSIX in order to be able to keep things running on Windows.
> 
> And quite honestly, there are lots of reasons to keep things running on
> Windows, and even to favor Windows support over musl support. Over four
> million reasons: the Git for Windows users.
> 
> So rather than getting into an ideological discussion about "broken"
> systems, it would be good to keep things practical, realizing that those
> users make up a very real chunk of all of Git's users.
> 
> As to making NO_REGEX conditional on REG_STARTEND: you are talking about
> apples and oranges here. NO_REGEX is a Makefile flag, while REG_STARTEND
> is a C preprocessor macro.

It seems like you could just always compile the source file, and just
have it all inside #if defined(NO_REGEX) || !defined(REG_STARTEND) or
similar.

> And lastly, the best alternative would be to teach musl about
> REG_STARTEND, as it is rather useful a feature.

Maybe, but it seems fundamentally costly to support -- it's extra
state in the inner loops that imposes costly spill/reload on archs
with too few registers (x86). I'll look at doing this when we
overhaul/replace the regex implementation, and I'm happy to do some
performance-regression tests for adding it now if someone has a simple
patch (as was mentioned on the musl list).

Rich
