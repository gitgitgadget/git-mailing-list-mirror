Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C50F2202D7
	for <e@80x24.org>; Mon,  6 Mar 2017 03:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbdCFDwz (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Mar 2017 22:52:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:38935 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752545AbdCFDv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2017 22:51:56 -0500
Received: (qmail 1551 invoked by uid 109); 6 Mar 2017 03:51:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Mar 2017 03:51:56 +0000
Received: (qmail 13639 invoked by uid 111); 6 Mar 2017 03:52:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Mar 2017 22:52:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Mar 2017 22:51:52 -0500
Date:   Sun, 5 Mar 2017 22:51:52 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?QW5kcsOp?= Laszlo <andre@laszlo.nu>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pull: do not segfault when HEAD refers to missing object
 file
Message-ID: <20170306035152.c7bh5jiqrfncyudl@sigill.intra.peff.net>
References: <20170305234222.4590-1-andre@laszlo.nu>
 <20170305235222.vxia7jw2n5uj2h2e@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170305235222.vxia7jw2n5uj2h2e@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 05, 2017 at 11:52:22PM +0000, brian m. carlson wrote:

> On Mon, Mar 06, 2017 at 12:42:22AM +0100, André Laszlo wrote:
> > +test_expect_success 'git pull --rebase with corrupt HEAD does not segfault' '
> > +	mkdir corrupted &&
> > +	(cd corrupted &&
> > +	git init &&
> > +	echo one >file && git add file &&
> > +	git commit -m one &&
> > +	REV=$(git rev-parse HEAD) &&
> > +	rm -f .git/objects/${REV:0:2}/${REV:2} &&
> 
> I think this is a bashism.  On dash, I get the following:
> 
>   genre ok % dash -c 'foo=abcdefg; echo ${foo:0:2}; echo ${foo:2}'
>   dash: 1: Bad substitution

Yeah, it is. You can do it easily with 'sed', of course, but if you want
to avoid the extra process and do it in pure shell, it's more like:

  last38=${REV#??}
  first2=${REV%$last38}
  rm -f .git/objects/$first2/$last38

-Peff
