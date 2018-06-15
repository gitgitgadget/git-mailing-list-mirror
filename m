Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E24301F403
	for <e@80x24.org>; Fri, 15 Jun 2018 17:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936306AbeFORb6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 13:31:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:45974 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S936136AbeFORb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 13:31:57 -0400
Received: (qmail 22322 invoked by uid 109); 15 Jun 2018 17:31:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Jun 2018 17:31:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23190 invoked by uid 111); 15 Jun 2018 17:32:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Jun 2018 13:32:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2018 13:31:55 -0400
Date:   Fri, 15 Jun 2018 13:31:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Luat Nguyen <root@l4w.io>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/3] ewah: adjust callers of ewah_read_mmap()
Message-ID: <20180615173155.GC3067@sigill.intra.peff.net>
References: <2067D731-C415-4D19-8CDA-90D7DC638397@l4w.io>
 <20180615032850.GA23241@sigill.intra.peff.net>
 <20180615034442.GA14422@sigill.intra.peff.net>
 <f6931351-df79-cb76-ee29-c57472a6a201@gmail.com>
 <xmqq1sd82e9h.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1sd82e9h.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 15, 2018 at 09:41:46AM -0700, Junio C Hamano wrote:

> Derrick Stolee <stolee@gmail.com> writes:
> 
> > On 6/14/2018 11:44 PM, Jeff King wrote:
> >> The return value of ewah_read_mmap() is now an ssize_t,
> >> since we could (in theory) process up to 32GB of data. This
> >> would never happen in practice, but a corrupt or malicious
> >> .bitmap or index file could convince us to do so.
> >
> > Aside: Why a 32GB limit? Usually I see 32-bit issues limiting by 2
> > (signed) or 4 GB (unsigned). Is there something specifically in the
> > bitmap format that stops at this size?
> 
> The proposed log message for 1/3 has this bit
> 
>   - check the size for integer overflow (this should be
>     impossible on 64-bit, as the size is given as a 32-bit
>     count of 8-byte words, but is possible on a 32-bit
>     system)
> 
> 4 Giga 8-byte words makes 32 Giga bytes, I'd guess.

Yes, exactly. It's definitely an odd size. I think using the same
varints we use in the packfile would be more efficient (and they're
already variable-length records), though we tend to have few enough of
these that it probably doesn't matter.

I think a more useful change for the bitmap format would be some kind of
index. IIRC, right now readers have to linearly scan the whole file in
order to use a single bitmap.

With Stolee's commit-metadata files, we could potentially move to
storing reachability bitmaps as a data element there. But there are two
complications:

 - the bitmaps themselves are dependent on having an ordered list of
   objects (one per bit) to talk about. And that's why they're
   integrated with packfiles, since that provides a constrained universe
   with a set ordering.

 - the existing storage isn't entirely independent between bitmaps. Some
   of them are basically "deltas" off of nearby bitmaps.

-Peff
