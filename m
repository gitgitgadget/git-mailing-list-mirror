Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A92F1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 08:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeJ0Qzt (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 12:55:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:57130 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726610AbeJ0Qzt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 12:55:49 -0400
Received: (qmail 27678 invoked by uid 109); 27 Oct 2018 08:15:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 27 Oct 2018 08:15:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4889 invoked by uid 111); 27 Oct 2018 08:14:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 27 Oct 2018 04:14:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Oct 2018 04:15:39 -0400
Date:   Sat, 27 Oct 2018 04:15:39 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 01/10] thread-utils: macros to unconditionally compile
 pthreads API
Message-ID: <20181027081538.GG26685@sigill.intra.peff.net>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027071003.1347-2-pclouds@gmail.com>
 <20181027073125.GB26685@sigill.intra.peff.net>
 <CACsJy8AA8ABmV5myBEETWP0uSNNFjvUP5mE705OV9=JtyHgTkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AA8ABmV5myBEETWP0uSNNFjvUP5mE705OV9=JtyHgTkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 09:40:13AM +0200, Duy Nguyen wrote:

> > We expect to be able to store a void pointer here and get it back, which
> > should work even for a single thread. Do we need something like:
> >
> >   extern void *pthread_specific_data;
> >
> >   #define pthread_setspecific(key, data) do { \
> >         pthread_specific_data = data; \
> >   } while(0)
> >
> >   void pthread_getspecific(key) pthread_specific_data
> 
> The data is per key though so a correct implementation may involve a
> hashmap or a list.

Ah, yeah, you're right, I was mixing up the thread id and the key in my
head. I think it would just be an array of void pointers, with
pthread_key_create() returning an static index.

> It does simplify index-pack which has to fall back to nothread_data
> when pthreads is not available. But with index-pack being the only
> call site that can take advantage of this (run-command.c probably will
> use real pthreads library anyway), I'm not sure if it's worth really
> implementing these functions.

Yeah, you might be right.

-Peff
