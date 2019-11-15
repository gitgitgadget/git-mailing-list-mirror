Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 499BB1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 04:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKOEMQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 23:12:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:48040 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726533AbfKOEMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 23:12:16 -0500
Received: (qmail 25428 invoked by uid 109); 15 Nov 2019 04:12:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Nov 2019 04:12:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10105 invoked by uid 111); 15 Nov 2019 04:15:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Nov 2019 23:15:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Nov 2019 23:12:15 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     matheus.bernardino@usp.br, git@vger.kernel.org,
        christian.couder@gmail.com, olyatelezhnaya@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        stefanbeller@gmail.com
Subject: Re: [PATCH v2 05/11] object-store: allow threaded access to object
 reading
Message-ID: <20191115041215.GB21654@sigill.intra.peff.net>
References: <20191114060134.GB10643@sigill.intra.peff.net>
 <20191114181552.137071-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191114181552.137071-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 14, 2019 at 10:15:52AM -0800, Jonathan Tan wrote:

> > > > A pthread_rwlock would work, but it would be the first use in Git. I
> > > > think we'd need to find an equivalent for compat/win32/pthread.h.
> > > 
> > > These[1][2] seems to be the equivalent options on Windows. I'll have
> > > to read these docs more carefully, but [2] seems to be more
> > > interesting in terms of speed. Also, the extra features of [1] are not
> > > really needed for our use case here.
> > > 
> > > [1]: https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/reader-writer-spin-locks
> > > [2]: https://docs.microsoft.com/en-us/windows/win32/sync/slim-reader-writer--srw--locks
> > 
> > Yeah, looks like it, but I don't have any expertise there (nor a Windows
> > system to test on).
> 
> One thing to note is that that if we do this, we'll be having one rwlock
> per pack window. I couldn't find out what the Windows limits were, but
> it seems that pthreads does not mandate having no limit [1]:

Yeah, interesting point. We shouldn't _usually_ have too many windows at
once, but I think this would be the first place where we allocate a
non-constant number of thread mechanisms. And there are degenerate cases
where you might have tens of thousands of packs.

I suspect it's a non-issue in practice, though. Any limits there are
likely related to kernel resources like descriptors. And those
degenerate cases already run into issues there (did you know that Linux
systems limit the number of mmaps a single process can have? I didn't
until I tried repacking a repo with 35,000 packs).

-Peff
