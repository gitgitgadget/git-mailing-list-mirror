Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31CC31F453
	for <e@80x24.org>; Wed,  1 May 2019 20:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfEAUqe (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 16:46:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:46308 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726139AbfEAUqd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 16:46:33 -0400
Received: (qmail 24800 invoked by uid 109); 1 May 2019 20:46:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 May 2019 20:46:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22544 invoked by uid 111); 1 May 2019 20:47:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 01 May 2019 16:47:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2019 16:46:31 -0400
Date:   Wed, 1 May 2019 16:46:31 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@i10z.com>,
        =?utf-8?B?xLBzbWFpbCBEw7ZubWV6?= via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mingw: enable DEP and ASLR
Message-ID: <20190501204631.GB13372@sigill.intra.peff.net>
References: <pull.134.git.gitgitgadget@gmail.com>
 <e142c1396ec3541486317819e885cf42be24af34.1556575015.git.gitgitgadget@gmail.com>
 <8e59dbf6-a339-74f3-4e60-e56b3817aea5@kdbg.org>
 <nycvar.QRO.7.76.6.1904301838400.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1904301838400.45@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 30, 2019 at 06:41:29PM -0400, Johannes Schindelin wrote:

> > I'm a bit concerned that this breaks my debug sessions where I use -O0.
> > But I'll test without -O0 before I really complain.
> 
> Weird. Jameson Miller also mentioned this very concern in an internal
> review.
> 
> I guess I'll do something like
> 
> 	ifneq (,$(findstring -O,$(filter-out -O0,$(CFLAGS))))
> 
> Does that work for you?

I wonder if this points to this patch touching the wrong level. These
compiler flags are a thing that _some_ builds want (i.e., production
builds where people care most about security and not about debugging),
but not necessarily all.

I'd have expected this to be tweakable by a Makefile knob (either a
specific knob, or just the caller setting the right CFLAGS etc), and
then for the builds of Git for Windows to turn those knobs when making a
package to distribute.

Our internal package builds at GitHub all have this in their config.mak
(for Linux, of course):

  CFLAGS += -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
  CFLAGS += -fstack-protector-strong

  CFLAGS += -fpie
  LDFLAGS += -z relro -z now
  LDFLAGS += -pie

and I wouldn't be surprised if other binary distributors (like the
Debian package) do something similar.

-Peff
