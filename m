Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2F4C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8477261019
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbhIVUW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 16:22:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:52916 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237538AbhIVUW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 16:22:26 -0400
Received: (qmail 11058 invoked by uid 109); 22 Sep 2021 20:20:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Sep 2021 20:20:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17960 invoked by uid 111); 22 Sep 2021 20:20:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Sep 2021 16:20:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Sep 2021 16:20:53 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH 1/5] grep: stop modifying buffer in strip_timestamp
Message-ID: <YUuQJUSl/jrnQR7n@coredump.intra.peff.net>
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
 <YUlVsLkFGRfRqpKG@coredump.intra.peff.net>
 <CAPUEsphSyZB-vtubjYhN_5Gy3Zv0HQ=fH=+G8kMYzJyrOLXPxQ@mail.gmail.com>
 <CAPig+cQnC1LLPtuC0qVX7EQ_ki4pev6scRox3utA45XeLHfGig@mail.gmail.com>
 <YUlw6V7AL8l6mbSh@coredump.intra.peff.net>
 <YUl+w8Tn3jqfLqt2@carlos-mbp.lan>
 <7d791c04-d122-1eb9-a84c-939294817395@web.de>
 <YUnrI10DXLElenKZ@coredump.intra.peff.net>
 <87v92t8wlp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v92t8wlp.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 11:02:31PM +0200, Ævar Arnfjörð Bjarmason wrote:

> 
> On Tue, Sep 21 2021, Jeff King wrote:
> 
> > On Tue, Sep 21, 2021 at 09:37:23AM +0200, René Scharfe wrote:
> >
> >> > @@ -965,9 +953,12 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
> >> >  		bol += len;
> >> >  		switch (p->field) {
> >> >  		case GREP_HEADER_AUTHOR:
> >> > -		case GREP_HEADER_COMMITTER:
> >> > -			strip_timestamp(bol, &eol);
> >> > +		case GREP_HEADER_COMMITTER: {
> >> > +			char *em = memrchr(bol, '>', eol - bol);
> >> > +			if (em)
> >> > +				eol = em + 1;
> >> 
> >> The old code documents the intent via the function name.  The new one
> >> goes into the nitty-gritty without further explanation, which I find
> >> harder to read.
> >
> > Agreed. I do think the conversion is functionally correct, but it
> > doesn't strike me as worth the change.
> 
> As far as some general improvement in thish area it seems to me that
> this whole subthread is losing the forest for the trees.

I'd definitely agree with that. :)

> It probably makes sense to split up that commit.c code into something
> that can give you structured output, i.e. headers with types and
> start/end points for interesting data, then in grep.c we won't need a
> strip_anything(), or strrchr() or memrchr() or whatever.

I don't disagree with any of this, either, but I think it's a separate
(and much more complicated) topic than what this series is dealing with.
So my preference would be to take this as an immediate improvement, and
let anything like that get built on top.

> It would also be a lot faster for grepping if we could offload more of
> this work to the regex engine, particularly if we've got a more capable
> engine like PCREv2.
> 
> In many cases we're splitting lines ourselves, when we could have the
> engine work in a multi-line mode, or translate the user's --author match
> into something that can match the raw commit header. So have an implicit
> /^author /m anchor if we're matching author headers, instead of having
> grep.c string-twiddle that around one line at a time.

Ditto here. Multi-line matching may make things a lot more efficient,
but I think is out of scope for this series. That seems like an
interesting area for future work.

-Peff
