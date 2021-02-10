Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0B7C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 09:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB3764E35
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 09:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhBJJl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 04:41:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:56048 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230125AbhBJJjj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 04:39:39 -0500
Received: (qmail 30903 invoked by uid 109); 10 Feb 2021 09:38:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Feb 2021 09:38:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16460 invoked by uid 111); 10 Feb 2021 09:38:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Feb 2021 04:38:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Feb 2021 04:38:51 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Kyle Meyer <kyle@kyleam.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] rev-list --disk-usage
Message-ID: <YCOpq5fDYp+YEzEu@coredump.intra.peff.net>
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
 <YCJpbPIlSpCAKSBF@coredump.intra.peff.net>
 <YCJtbmaguIW+YeAs@coredump.intra.peff.net>
 <xmqq8s7x0wra.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8s7x0wra.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 09, 2021 at 01:14:17PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't know that it's really worth digging into that much, though it's
> > quite possible there may be some easy wins by optimizing those memcpy
> > calls. E.g., I'm not sure if the compiler ends up inlining them or not.
> > If it doesn't realize that the_hash_algo->rawsz is only ever "20" or
> > "32", we could perhaps help it along with specialized versions of
> > hashcpy(). If somebody does want to play with it, this patch may make a
> > good testbed. :)
> 
> Yuck.  That reminds me of the adventure Shawn he made in the Java
> land benchmarking which one among int[5], int a,b,c,d,e, char[40] is
> the most efficient way (both storage-wise and performance-wise) to
> store SHA-1 hash.  I wish we didn't have to go there.
> 
> It indeed is an interesting, despite a bit sad, observation that
> even with a good precomputed information, an overly heavy interface
> can kill potential performance benefit.

Agreed. But I'm hoping we can continue to mostly ignore it. I suspect
this finding means we are wasting a few hundred milliseconds copying
oids around during a clone of torvalds/linux. But overall that is a
pretty heavy-weight operation, and I doubt anybody really notices. And
for something as lightweight as --disk-usage, it was easy enough to
optimize around it.

It probably does have a more measurable impact in something like:

  git rev-list --use-bitmap-index --objects HEAD >/dev/null

where we really do need those oids, and the extra copying might add up.
I guess if somebody is interested in micro-optimizing, that is probably
a good command to look at.

-Peff
