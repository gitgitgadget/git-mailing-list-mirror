Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E3452035B
	for <e@80x24.org>; Mon, 10 Jul 2017 09:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbdGJJm5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 05:42:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49922 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752276AbdGJJm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 05:42:56 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 8AAB0202AC;
        Mon, 10 Jul 2017 09:42:55 +0000 (UTC)
Date:   Mon, 10 Jul 2017 09:42:55 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 6/6] reflog-walk: stop using fake parents
Message-ID: <20170710094255.GA8170@untitled>
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
 <20170705080904.idlpm6ecslzfbm75@sigill.intra.peff.net>
 <20170707003239.GA13431@untitled>
 <20170707030224.4iubuzsz2qwdhgiw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170707030224.4iubuzsz2qwdhgiw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Fri, Jul 07, 2017 at 12:32:39AM +0000, Eric Wong wrote:
> 
> > I'm not sure why, but this is causing t1414.8 failures on 32-bit
> > x86 with the latest pu with Debian jessie (oldstable).
> > 
> > Reverting this (beafb2c62947a6d4a97b9c3baf99fe62ec8e830f) in pu
> > seems to fix the test for me.
> > 
> > +Cc: Ramsay since he also had a 32-bit environment.
> 
> Thanks, I was able to reproduce with CFLAGS=-m32.

No problem and thanks for the quick response!  Latest pu is
fine for me.

To notice similar errors sooner, I wonder if we should have a
test target for 64-bit users to test with -m32 enabled, somehow.

Fwiw, I started having a cronjob which runs "make test-pu" on my
32-bit machine, where config.mak has this:

==> config.mak <==
DEVELOPER := 1
pulog := /tmp/git-test-pu.log

cur_head = $(shell git rev-parse HEAD^0)
cur_pu = $(shell git rev-parse refs/remotes/origin/pu^0)

test-pu:
	git fetch -q origin
	test x"$(cur_pu)" = x"$(cur_head)" || { \
		$(MAKE) clean && \
		git reset --hard origin/pu && \
		{ $(MAKE) -k test >$(pulog) 2>&1 || \
		 mutt -s 'pufail' e@80x24.org <$(pulog); }; }
-- 
EW
