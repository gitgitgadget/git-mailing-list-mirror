Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BF6C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 14:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90BD660F9E
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 14:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhIUO0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 10:26:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:51718 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhIUO0E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 10:26:04 -0400
Received: (qmail 5672 invoked by uid 109); 21 Sep 2021 14:24:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 14:24:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 899 invoked by uid 111); 21 Sep 2021 14:24:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Sep 2021 10:24:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Sep 2021 10:24:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH 1/5] grep: stop modifying buffer in strip_timestamp
Message-ID: <YUnrI10DXLElenKZ@coredump.intra.peff.net>
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
 <YUlVsLkFGRfRqpKG@coredump.intra.peff.net>
 <CAPUEsphSyZB-vtubjYhN_5Gy3Zv0HQ=fH=+G8kMYzJyrOLXPxQ@mail.gmail.com>
 <CAPig+cQnC1LLPtuC0qVX7EQ_ki4pev6scRox3utA45XeLHfGig@mail.gmail.com>
 <YUlw6V7AL8l6mbSh@coredump.intra.peff.net>
 <YUl+w8Tn3jqfLqt2@carlos-mbp.lan>
 <7d791c04-d122-1eb9-a84c-939294817395@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d791c04-d122-1eb9-a84c-939294817395@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 09:37:23AM +0200, René Scharfe wrote:

> > @@ -965,9 +953,12 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
> >  		bol += len;
> >  		switch (p->field) {
> >  		case GREP_HEADER_AUTHOR:
> > -		case GREP_HEADER_COMMITTER:
> > -			strip_timestamp(bol, &eol);
> > +		case GREP_HEADER_COMMITTER: {
> > +			char *em = memrchr(bol, '>', eol - bol);
> > +			if (em)
> > +				eol = em + 1;
> 
> The old code documents the intent via the function name.  The new one
> goes into the nitty-gritty without further explanation, which I find
> harder to read.

Agreed. I do think the conversion is functionally correct, but it
doesn't strike me as worth the change.

-Peff
