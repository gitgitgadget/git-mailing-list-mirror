Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3EF1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 13:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbcJENQN (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 09:16:13 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:55542 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753007AbcJENQM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 09:16:12 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1brm3D-0005l9-00; Wed, 05 Oct 2016 13:15:59 +0000
Date:   Wed, 5 Oct 2016 09:15:59 -0400
From:   Rich Felker <dalias@libc.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        musl@lists.openwall.com
Subject: Re: [musl] Re: Regression: git no longer works with musl libc's
 regex impl
Message-ID: <20161005131559.GG19318@brightrain.aerifal.cx>
References: <20161004150848.GA7949@brightrain.aerifal.cx>
 <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
 <20161004154045.GT19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610041802310.35196@virtualbox>
 <20161004173926.GA19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610051250080.35196@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610051250080.35196@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 05, 2016 at 01:17:49PM +0200, Johannes Schindelin wrote:
> Hi Rich,
> 
> On Tue, 4 Oct 2016, Rich Felker wrote:
> 
> > On Tue, Oct 04, 2016 at 06:08:33PM +0200, Johannes Schindelin wrote:
> >
> > > And lastly, the best alternative would be to teach musl about
> > > REG_STARTEND, as it is rather useful a feature.
> > 
> > Maybe, but it seems fundamentally costly to support -- it's extra
> > state in the inner loops that imposes costly spill/reload on archs
> > with too few registers (x86).
> 
> It is true that it could cause that.
> 
> I had a brief look at the source code (you use backtracking...

Where did you get that idea? Backtracking is the most utterly
incompetent way to implement regex -- it throws away the whole
property that makes regex useful, being regular. Unfortunately, POSIX
BRE is not regular, as it contains backreferences, so any
implementation of regcomp/regexec requires at least a minimal
backtracking code path for BREs that contain backreferences.

> hopefully
> nobody uses musl to parse regular expressions from untrusted, or

On the contrary, musl's is the only system reccomp/regexec I'm aware
of that actually attempts to be safe with untrusted input -- when
using REG_EXTENDED (ERE). Other implementations provide backreferences
in ERE as an extension, making ERE unsafe just like BRE. musl
intentionally disallows them as a feature.

At least until recently, glibc also crashed on malloc failures in
regcomp, making it unsafe on untrusted input for that reason too.

Rich
