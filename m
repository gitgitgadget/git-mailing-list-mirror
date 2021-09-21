Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60020C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 14:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0A561165
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 14:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhIUOvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 10:51:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:51746 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233644AbhIUOvH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 10:51:07 -0400
Received: (qmail 5773 invoked by uid 109); 21 Sep 2021 14:49:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 14:49:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1126 invoked by uid 111); 21 Sep 2021 14:49:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Sep 2021 10:49:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Sep 2021 10:49:37 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH 0/5] const-correctness in grep.c
Message-ID: <YUnxAawpNjyb0z3o@coredump.intra.peff.net>
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
 <87czp29l2c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87czp29l2c.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 02:07:08PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This whole thing looks good to me. I only found a small whitespace nit
> in one of the patches. Did you consider following-up by having this code
> take const char*/const size_t pairs. E.g. starting with something like
> the below.

I do generally find ptr/len pairs to be easier to read, but they also
make it really easy to introduce subtle bugs. E.g., if you consume part
of a buffer, you have to tweak both the ptr and the len. So the current:

	while (word_char(bol[-1]) && bol < eol)
		bol++;

has to become:

	while (word_char(bol[-1] && len > 0) {
		bol++;
		len--;
	}

So I'd be hesitant to churn battle-tested code in such a way for what I
consider to be a pretty minor benefit.

I did notice the ugly use of "unsigned long" here in a few places
(rather than size_t). I do think it is worth fixing, but it seemed a
little too far to try to cram into this series (it's obviously touching
the same lines, but it's quite orthogonal semantically).

The other hesitation I had is that the source of this "unsigned long"
pattern is almost certainly the object code (which is much more
important to convert, as it blocks people from having >4GB objects on
Windows). So we might want to just wait for a larger conversion there.
OTOH, I don't think there is any downside to a partial conversion here
in the meantime (because size_t will always be at least as long as
"unsigned long" in practice).

> -static int pcre2match(struct grep_pat *p, const char *line, const char *eol,
> +static int pcre2match(struct grep_pat *p, const char *line, const size_t len,
>  		regmatch_t *match, int eflags)
>  {
>  	int ret, flags = 0;
> @@ -448,11 +448,11 @@ static int pcre2match(struct grep_pat *p, const char *line, const char *eol,
>  
>  	if (p->pcre2_jit_on)
>  		ret = pcre2_jit_match(p->pcre2_pattern, (unsigned char *)line,
> -				      eol - line, 0, flags, p->pcre2_match_data,
> +				      len, 0, flags, p->pcre2_match_data,
>  				      NULL);
>  	else
>  		ret = pcre2_match(p->pcre2_pattern, (unsigned char *)line,
> -				  eol - line, 0, flags, p->pcre2_match_data,
> +				  len, 0, flags, p->pcre2_match_data,
>  				  NULL);

Not related to your point, but these casts are funny now. They are meant
to cast to "unsigned char" pointers to match pcre's signature, but now
they are casting away const-ness, too. That might be worth fixing as
part of this series.

Though should they really be casting to PCRE2_SPTR? The types are opaque
in their API because of the weird multi-width thing, though I find it
hard to imagine us ever using the wider versions of the library.

-Peff
