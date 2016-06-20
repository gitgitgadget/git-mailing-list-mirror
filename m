Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B9B20179
	for <e@80x24.org>; Mon, 20 Jun 2016 10:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbcFTKKv (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 06:10:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:57194 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751701AbcFTKKu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 06:10:50 -0400
Received: (qmail 13244 invoked by uid 102); 20 Jun 2016 10:03:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 06:03:00 -0400
Received: (qmail 13291 invoked by uid 107); 20 Jun 2016 10:03:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 06:03:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2016 06:02:57 -0400
Date:	Mon, 20 Jun 2016 06:02:57 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Vadim Eisenberg <VADIME@il.ibm.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG REPORT] git 2.9.0 clone --recursive fails on cloning a
 submodule
Message-ID: <20160620100256.GA14058@sigill.intra.peff.net>
References: <OFC76C15DC.FC882C57-ONC2257FD7.00261552-C2257FD7.002660FC@LocalDomain>
 <OFE09D48F2.D1D14F49-ONC2257FD7.00280736-C2257FD7.0028245A@notes.na.collabserv.com>
 <20160619100051.GA14584@sigill.intra.peff.net>
 <xmqq7fdkx5oz.fsf@gitster.mtv.corp.google.com>
 <20160620001332.GA10101@sigill.intra.peff.net>
 <CAGZ79kZ9NF57EyEZ4PgOhJw50ujt=QmHs+w1ZNFeDO4zitksVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ9NF57EyEZ4PgOhJw50ujt=QmHs+w1ZNFeDO4zitksVQ@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 19, 2016 at 06:09:28PM -0700, Stefan Beller wrote:

> > I hadn't paid much attention to this topic originally, but was surprised
> > that "--depth 10" in the clone implies "--depth 1" in the submodule.
> > This is not really related to your patch (in fact, your patch makes the
> > logic go away). But maybe something to consider if it's ever resurrected
> > (or possibly if somebody runs "--shallow-submodules --depth 5" we should
> > pass --depth=1; I dunno).
> 
> How often do we see a depth != 1 in practice?
> I have the impression (and no data to back up my claim) that a binary
> switch for nonshallow or depth 1 would serve us just as good, which is why
> I did not want to ad complexity to the submodule depth.
> (What if you want submodule A with depth 2 and B with 5? In that
> case get them all shallow and deepen as appropriate, would be my answer)

To be honest, I don't know why people use anything except --depth=1, but
it's clear from my experience that they do. This example has --depth=10,
and on the server side at GitHub I have seen similar numbers from clients,
especially CI services.

(I take special note of such cases because --shallow quite often causes
performance problems on the server side, though generally --depth=10 is
not any worse than --depth=1. The worst case is really
"--no-single-branch --depth=1", which wants a ton of objects but has to
throw away all of the on-disk deltas).

> > We are not really testing "does not imply" here, but "passing
> > --shallow-submodules works". The "does not imply" test would be cloning
> > without the option and checking that the resulting submodules are not
> > shallow.
> 
> In case we want to be sure that it works for 2.9.1, i.e. we treat it
> as a regression,
> we need to test the "does not imply" a bit more I would think. I can send that
> test on top tomorrow if you'd like to.

I think it's worth doing (and testing both: the default behavior, and
that the --shallow-submodules feature works). Thanks.

-Peff
