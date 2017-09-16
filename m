Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCD4420286
	for <e@80x24.org>; Sat, 16 Sep 2017 16:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751248AbdIPQYI (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 12:24:08 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:36616 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbdIPQYH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 12:24:07 -0400
X-Greylist: delayed 638 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Sep 2017 12:24:07 EDT
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1dtFic-0007Mg-00; Sat, 16 Sep 2017 16:13:22 +0000
Date:   Sat, 16 Sep 2017 12:13:22 -0400
From:   Rich Felker <dalias@libc.org>
To:     "A. Wilcox" <awilfox@adelielinux.org>
Cc:     Jeff King <peff@peff.net>, Kevin Daudt <me@ikke.info>,
        git@vger.kernel.org, musl@lists.openwall.com
Subject: Re: [musl] Re: Git 2.14.1: t6500: error during test on musl libc
Message-ID: <20170916161322.GX1627@brightrain.aerifal.cx>
References: <59BB3E40.7020804@adelielinux.org>
 <20170915063740.GB21499@alpha.vpn.ikke.info>
 <20170915113011.emko6q5utb7x4bvu@sigill.intra.peff.net>
 <59BCAF81.3090206@adelielinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59BCAF81.3090206@adelielinux.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2017 at 11:58:41PM -0500, A. Wilcox wrote:
> On 15/09/17 06:30, Jeff King wrote:
> > On Fri, Sep 15, 2017 at 08:37:40AM +0200, Kevin Daudt wrote:
> > 
> >> On Thu, Sep 14, 2017 at 09:43:12PM -0500, A. Wilcox wrote:
> >>> -----BEGIN PGP SIGNED MESSAGE-----
> >>> Hash: SHA256
> >>>
> >>> Hi there,
> >>>
> >>> While bumping Git's version for our Linux distribution to 2.14.1, I've
> >>> run in to a new test failure in t6500-gc.sh.  This is the output of
> >>> the failing test with debug=t verbose=t:
> >>
> >> This is a new test introduced by c45af94db 
> >> (gc: run pre-detach operations under lock, 2017-07-11) which was
> >> included in v2.14.0.
> >>
> >> So it might be that this was already a problem for a longer time, only
> >> just recently uncovered.
> > 
> > The code change there is not all that big. Mostly we're just checking
> > that the lock is actually respected. The lock code doesn't exercise libc
> > all that much. It does use fscanf, which I guess is a little exotic for
> > us. It's also possible that hostname() doesn't behave quite as we
> > expect.
> > 
> > If you instrument gc like the patch below, what does it report when you
> > run:
> > 
> >   GIT_TRACE=1 ./t6500-gc.sh --verbose-only=8
> > 
> > I get:
> > 
> >   [...]
> >   trace: built-in: git 'gc' '--auto'
> >   Auto packing the repository in background for optimum performance.
> >   See "git help gc" for manual housekeeping.
> >   debug: gc lock already held by $my_hostname
> >   [...]
> > 
> > If you get "acquired gc lock", then the problem is in
> > lock_repo_for_gc(), and I'd suspect some problem with fscanf or
> > hostname.
> > 
> > -Peff
> 
> 
> Hey there Peff,
> 
> What a corner-y corner case we have here.  I believe the actual error is
> in the POSIX standard itself[1], as it is not clear what happens when
> there are not enough characters to 'fill' the width specified with %c in
> fscanf:

ISO C specifies very clearly what happens, in 7.21.6.2 The fscanf
function, paragraph 12: 

	c
		Matches a sequence of characters of exactly the number
		specified by the field width...

Note the word "exactly". Thus a read of fewer characters is not a
match.

There is an open glibc bug for this with classic Drepper behavior
until his departure, followed by acknowledgement of the bug, but no
further action I'm aware of:

https://sourceware.org/bugzilla/show_bug.cgi?id=12701

Any applications depending on the buggy glibc behavior should be
fixed.

Rich
