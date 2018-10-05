Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730971F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 19:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeJFCmg (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 22:42:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:43654 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728381AbeJFCmg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 22:42:36 -0400
Received: (qmail 25726 invoked by uid 109); 5 Oct 2018 19:42:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Oct 2018 19:42:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15381 invoked by uid 111); 5 Oct 2018 19:41:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Oct 2018 15:41:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2018 15:42:23 -0400
Date:   Fri, 5 Oct 2018 15:42:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
Message-ID: <20181005194223.GA19428@sigill.intra.peff.net>
References: <pull.10.git.gitgitgadget@gmail.com>
 <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
 <d1b58614-989f-5998-6c53-c19eee409a2f@web.de>
 <dd798e76-922f-a113-4408-e3892bee3b44@gmail.com>
 <223b14f7-213f-4d22-4776-22dcfd1806c2@web.de>
 <7b95417a-c8fb-4f1e-cb09-c36804a3a4d0@web.de>
 <20181005165157.GC11254@sigill.intra.peff.net>
 <dca35e44-a763-bcf0-f457-b8dab53815cf@web.de>
 <20181005190847.GC17482@sigill.intra.peff.net>
 <c05f192b-4e89-48b0-1c23-b43ec6fdb74b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c05f192b-4e89-48b0-1c23-b43ec6fdb74b@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 09:36:28PM +0200, René Scharfe wrote:

> Am 05.10.2018 um 21:08 schrieb Jeff King:
> > On Fri, Oct 05, 2018 at 08:48:27PM +0200, René Scharfe wrote:
> >> +#define DEFINE_SORT(name, type, compare)				\
> >> +static int compare##_void(const void *one, const void *two)		\
> >> +{									\
> >> +	return compare(one, two);					\
> >> +}									\
> >> +static void name(type base, size_t nmemb)				\
> >> +{									\
> >> +	const type dummy = NULL;					\
> >> +	if (nmemb > 1)							\
> >> +		qsort(base, nmemb, sizeof(base[0]), compare##_void);	\
> >> +	else if (0)							\
> >> +		compare(dummy, dummy);					\
> >> +}
> > 
> > I do like that this removes the need to have the code block aspart of
> > the macro.
> > 
> > Did you measure to see if there is any runtime impact?
> 
> No, but I wouldn't expect any -- the generated code should be the same
> in most cases.
> 
> Here's an example: https://godbolt.org/z/gwXENy.

OK, that's good enough for me.

> The typed comparison function can be inlined into the one with the void
> pointers, though.

Right, that makes sense. I suspect it depends on the comparison function
being static, but in a DEFINE_SORT() world, they generally could be.

So I like this approach.

-Peff
