Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A0FC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF53C610D1
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhDIPt0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:49:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:46326 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhDIPtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 11:49:25 -0400
Received: (qmail 31810 invoked by uid 109); 9 Apr 2021 15:49:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 15:49:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12530 invoked by uid 111); 9 Apr 2021 15:49:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 11:49:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 11:49:11 -0400
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
Subject: Re: There should have be git gc --repack-arguments
Message-ID: <YHB3d31eTACBd6pY@coredump.intra.peff.net>
References: <b35a68a1-e693-5502-7a28-a1dd8222d3a0@gmail.com>
 <YG4J7vtTRVpGGLoo@coredump.intra.peff.net>
 <xmqq8s5tzv4f.fsf@gitster.g>
 <YG4mImcQyTC1/S8X@coredump.intra.peff.net>
 <xmqqa6q9yc8c.fsf@gitster.g>
 <YG4ws7PiKKKjPUff@coredump.intra.peff.net>
 <1edb799b-5e17-264d-e525-5355c52af36a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1edb799b-5e17-264d-e525-5355c52af36a@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 04:58:32PM +0700, Bagas Sanjaya wrote:

> On 08/04/21 05.22, Jeff King wrote:
> > If you are sneaker-netting, you are probably better off to just split
> > the pack at byte boundaries with an external tool anyway, for two
> > reasons:
> > 
> >    - our max-pack-size is just a guideline. It only splits at object
> >      boundaries so if you have an object bigger than the max, we'll
> >      exceed it.
> > 
> >    - dedicated splitting tools often have useful extra features, like
> >      k-of-n error correction.
> > 
> What external tools are for splitting packs? Can splitted packs
> by such tools still be usable by Git?

No, but you can reassemble the parts at the destination before feeding
them to Git. On a system with normal posix tools, you can split like:

  git pack-objects --stdout --all </dev/null |
  split -b 1m - split-pack-

and then after transferring split-pack-* (which are individual 1
megabyte files) to the destination, you can do:

  cat split-pack-* |
  git index-pack -v --stdin

(There's no error correction in split; tools like rar will do that, and
probably others, but it has been ages since I've had to split a file to
meet transfer requirements).

-Peff
