Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E31F1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 23:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362AbcHAX6Q (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 19:58:16 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54684 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755393AbcHAX6P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 19:58:15 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 851551F855;
	Mon,  1 Aug 2016 23:56:51 +0000 (UTC)
Date:	Mon, 1 Aug 2016 23:56:51 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 1/1 v2] pager: move pager-specific setup into the build
Message-ID: <20160801235651.GA7140@starla>
References: <20160801214937.4752-1-e@80x24.org>
 <20160801214937.4752-2-e@80x24.org>
 <xmqq1t28gkhf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1t28gkhf.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> > Allowing PAGER_ENV to be set at build-time allows us to move
> > pager-specific knowledge out of our build.  Currently, this
> > allows us to set a better default for FreeBSD where more(1)
> > is the same binary as less(1).
> 
> Thanks for resurrecting, but I am not sure what "a better default"
> is from the above description and with the patch.  Even though a
> naive reading of the above (i.e. "less" and "more" are the same)
> makes me expect that the patch will give the same set of default
> environment settings to those on FreeBSD, you give LESS=FRX and
> MORE=-R, i.e. they are configured differently.

Perhaps s/better/platform-appropriate/ ?

I just copied your original patch in setting MORE=-R
(but removed 'S' from LESS).

So v3 will be MORE=FRX, as less was added:

    commit 98170c0c3ba86eb1cc975e7848d075bf2abc1ed0
    Author: ps <ps@FreeBSD.org>
    Date:   Mon May 22 10:00:00 2000 +0000

	bmake glue for less.

and more was nuked:

    commit cde9059fa3e4dc7e259c3864d7536252a5c580a0
    Author: ps <ps@FreeBSD.org>
    Date:   Mon May 29 13:31:51 2000 +0000

	Nuke more from the repository.

And "git branch -r --contains" on both of those commits says
they showed up in the 5.0 release.  However, further
investigation says more was even gone by the 4.1.0 release

  git show origin/release/4.1.0:usr.bin/more # non-existent tree
  git show origin/release/4.0.0:usr.bin/more # tree still exists

But, "git show origin/release/4.0.0:usr.bin/more/option.c"
reveals more from those days wouldn't handle -R anyways,
and hopefully nobody is still running 4.0.0...

ref: git://github.com/freebsd/freebsd.git

> > This also prepares us for introducing a run-time config knob to
> > override the build-time environment in the next commit.
> 
> This is now gone, judging from 1/1 on the subject line being not
> 1/2, right?

Oops, yes :x

> > Originally-from:
> >  https://public-inbox.org/git/xmqq61piw4yf.fsf@gitster.dls.corp.google.com/
