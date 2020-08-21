Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F1BC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2166020714
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgHUS75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:59:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:37448 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgHUS75 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 14:59:57 -0400
Received: (qmail 19680 invoked by uid 109); 21 Aug 2020 18:59:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 18:59:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31108 invoked by uid 111); 21 Aug 2020 18:59:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 14:59:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 14:59:55 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [RFC 3/3] refspec: add support for negative refspecs
Message-ID: <20200821185955.GA1165@coredump.intra.peff.net>
References: <20200815002509.2467645-1-jacob.e.keller@intel.com>
 <20200815002509.2467645-3-jacob.e.keller@intel.com>
 <xmqq5z9gzvmb.fsf@gitster.c.googlers.com>
 <CA+P7+xpcm51cLPDDW+F1J-XZ2VvwNDWjnZqm54f3DKXxDfBF5Q@mail.gmail.com>
 <20200818174116.GA2473110@coredump.intra.peff.net>
 <CA+P7+xrPep7caJm2uN+hAqOqZU3b2njpW95JQCzYJdKgbakp8A@mail.gmail.com>
 <CA+P7+xq4+RJF5f8v6ZG6mfXKg29Sh4CcFB72tKDPTx5vQLsS1A@mail.gmail.com>
 <CA+P7+xo8KqGnKRmF7dGhWYV9tQ7dwzjoyezGMEbh4mxKHQJUbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xo8KqGnKRmF7dGhWYV9tQ7dwzjoyezGMEbh4mxKHQJUbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 11:21:19AM -0700, Jacob Keller wrote:

> > I also tried adding a test for fetch --prune, but that ultimately
> > calls query_refspecs_multiple and query_refspecs. I need to figure out
> > how negative refspecs need to interact with that function still.
> 
> So there's an interesting problem here... query_refspecs_multiple
> takes only the destination name, which makes the "get_stale_heads" not
> work properly, since for fetch we want to apply the refspec to the
> remote sides "source".

Hmm. So if I understand it, that function is asking about _local_ refs,
and wondering "if we were to fetch using these refspecs, would we write
to this ref". We know that negative refspecs can't impact the mapping of
remote to local.

But I guess the case you are about is:

  git fetch --prune refs/heads/*:refs/remotes/origin/* ^refs/heads/foo

where we need to realize that the local refs/remotes/origin/foo needs to
be saved. I think that should be possible by reverse-applying the
transformations from any positive refspecs, and then seeing if they
match any negative ones. I don't know how much support the existing code
will give you for that, though.

-Peff
