Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 252541FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 07:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751843AbdFJHZK (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 03:25:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:37500 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751797AbdFJHZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 03:25:09 -0400
Received: (qmail 32084 invoked by uid 109); 10 Jun 2017 07:25:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 07:25:08 +0000
Received: (qmail 29335 invoked by uid 111); 10 Jun 2017 07:25:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 03:25:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 03:25:06 -0400
Date:   Sat, 10 Jun 2017 03:25:06 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 1/2] git-compat-util: add a FREEZ() wrapper around
 free(ptr); ptr = NULL
Message-ID: <20170610072506.embaavscstmjnv6v@sigill.intra.peff.net>
References: <20170609085346.19974-1-avarab@gmail.com>
 <20170609220420.4910-2-avarab@gmail.com>
 <20170609222738.GF21733@aiede.mtv.corp.google.com>
 <20170609233701.GA7195@whir>
 <xmqq60g462nd.fsf@gitster.mtv.corp.google.com>
 <20170610032143.GA7880@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170610032143.GA7880@starla>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 10, 2017 at 03:21:43AM +0000, Eric Wong wrote:

> > So make Jonathan's freez_impl a public API and rename it to
> > free_and_null(), perhaps?
> 
> Perhaps...  I think it needs to take "void *" to avoid warnings:
> 
> 	static inline void free_and_null(void *ptrptr)
> 	{
> 		void **tmp = ptrptr;
> 
> 		free(*tmp);
> 		*tmp = NULL;
> 	}

That unfortunately makes it very easy to get it wrong in the callers.
Both:

  free_and_null(&p);

and

  free_and_null(p);

would be accepted by the compiler, but one of them causes undefined
behavior.

Unfortunately using "void **" in the declaration doesn't work, because
C's implicit casting rules don't apply to pointer-to-pointer types.

-Peff
