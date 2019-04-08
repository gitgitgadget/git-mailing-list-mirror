Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3783B20248
	for <e@80x24.org>; Mon,  8 Apr 2019 20:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfDHUcy (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 16:32:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:51348 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726930AbfDHUcy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 16:32:54 -0400
Received: (qmail 11144 invoked by uid 109); 8 Apr 2019 20:32:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 08 Apr 2019 20:32:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22685 invoked by uid 111); 8 Apr 2019 20:33:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 08 Apr 2019 16:33:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Apr 2019 16:32:52 -0400
Date:   Mon, 8 Apr 2019 16:32:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 01/13] packfile.h: drop extern from function
 declarations
Message-ID: <20190408203252.GA5696@sigill.intra.peff.net>
References: <20190405180306.GA21113@sigill.intra.peff.net>
 <20190405180340.GA32243@sigill.intra.peff.net>
 <c21b923f-54aa-defa-ecfd-11ecd6f8a664@ramsayjones.plus.com>
 <20190405192534.GA4496@sigill.intra.peff.net>
 <xmqqzhp19j0y.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhp19j0y.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 08, 2019 at 02:13:17PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Apr 05, 2019 at 08:19:30PM +0100, Ramsay Jones wrote:
> >
> >> >  /* global flag to enable extra checks when accessing packed objects */
> >> > -extern int do_check_packed_object_crc;
> >> > +int do_check_packed_object_crc;
> >> 
> >> ... removing this 'extern' on an int variable sends 'sparse'
> >> into a frenzy of warnings! :-D
> >> 
> >> [You didn't use a global s/extern// by any chance?]
> >
> > Oh my. I did look at each one, but probably via replace-and-confirm in
> > vim. I don't know how I managed to botch that one so badly.
> 
> Perhaps we should keep 'extern' even when declaring (not defining) a
> public function in the header file to avoid a gotcha like this?
> 
> What was the reasoning behind the insn in CodingGuidelines?  "As it
> is already the default" does qualify as a reasonable justification
> for telling "extern is not needed for functions" to our readers, but
> not quite enough for "extern should not be used for functions".

I think the reasoning is just that it's useless noise, so it makes the
resulting lines longer (which are often already too-long) and harder to
read.

For this particular patch, I don't care that much about the existing
functions, which I'm not touching, but rather was adding a new one. And
my options were:

  - use "extern" there to match; even if we don't want to go through the
    code churn of cleaning up existing cases, I think we shouldn't be
    encouraging it in new ones. Even more crazy to me would actually
    be review telling somebody to add an extern.

  - intermingle it with the existing extern ones. Low risk, but leaves
    people wondering why some have extern and some do not.

  - clean up the existing cases first

I dunno. Like all code churn, these kinds of clean-ups have the
possibility of accidentally screwing something up. But they are at least
a one-time pain, as long as we do not keep changing our mind back and
forth.

-Peff
