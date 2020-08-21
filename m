Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EA5C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 19:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA44820738
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 19:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgHUTOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:14:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:37484 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgHUTOR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 15:14:17 -0400
Received: (qmail 19836 invoked by uid 109); 21 Aug 2020 19:14:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 19:14:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31316 invoked by uid 111); 21 Aug 2020 19:14:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 15:14:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 15:14:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] index-pack threading defaults
Message-ID: <20200821191416.GB1165@coredump.intra.peff.net>
References: <20200821175153.GA3263018@coredump.intra.peff.net>
 <20200821184459.GB3263614@coredump.intra.peff.net>
 <xmqqmu2n964x.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmu2n964x.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 11:59:58AM -0700, Junio C Hamano wrote:

> > After writing a response elsewhere in the thread, it occurred to me that
> > a good candidate for explaining this may be that our modern sha1dc
> > implementation is way slower than what we were using in 2012 (which
> > would have been either block-sha1, or the even-faster openssl
> > implementation). And since a good chunk of index-pack's time is going to
> > computing sha1 hashes on the resulting objects, that means that since
> > 2012, we're spending relatively more time in the hash computation (which
> > parallelizes per-object) and less time in the other parts that happen
> > under a lock.
> 
> Believable conjecture that is.  You could benchmark again with
> block-sha1 on today's hardware, but because the performance profile
> with sha1dc is what matters in the real world anyway...

Yeah, I agree on the "real world" part, but I'm the curious sort, so
here are numbers compiled against openssl (which is generally even
faster than block-sha1, and would thus emphasize the results of our
hypothesis):

  5302.3: index-pack 0 threads                   108.78(106.39+2.31)
  5302.4: index-pack 1 threads                   110.65(108.08+2.49)
  5302.5: index-pack 2 threads                   67.57(110.83+2.75) 
  5302.6: index-pack 4 threads                   48.18(123.82+3.02) 
  5302.7: index-pack 8 threads                   39.07(153.45+4.13) 
  5302.8: index-pack 16 threads                  38.38(265.78+7.71) 
  5302.9: index-pack default number of threads   54.64(117.35+2.73)

So it's actually pretty similar. Things continue getting faster as we go
past 3 threads. Though our total improvement is less (29% better with 8
threads compared to 3, versus 42% better when using sha1dc). So I think
it's _part_ of the reason, but not all of it.

-Peff
