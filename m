Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0751E1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 17:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440059AbfJXRzv (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 13:55:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:57258 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2436672AbfJXRzv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 13:55:51 -0400
Received: (qmail 17410 invoked by uid 109); 24 Oct 2019 17:55:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Oct 2019 17:55:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3361 invoked by uid 111); 24 Oct 2019 17:58:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Oct 2019 13:58:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Oct 2019 13:55:49 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-progress: fix test failures on big-endian systems
Message-ID: <20191024175549.GA12892@sigill.intra.peff.net>
References: <b0bec82e-ad0a-32f6-e2e6-e1f0e6920639@physik.fu-berlin.de>
 <20190731071755.GF4545@pobox.com>
 <f1ce445e-6954-8e7b-2dca-3a566ce689a5@physik.fu-berlin.de>
 <20191019233706.GM29845@szeder.dev>
 <xmqq36fmor7o.fsf@gitster-ct.c.googlers.com>
 <20191024172442.GM4348@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191024172442.GM4348@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 24, 2019 at 07:24:42PM +0200, SZEDER Gábor wrote:

> On Mon, Oct 21, 2019 at 09:52:11AM +0900, Junio C Hamano wrote:
> > I can sympathize, but I do not think it is worth inventing OPT_U64()
> > or adding "int total_i" whose value is assigned to "u64 total" after
> > parsing a command line arg with OPT_INTEGER() into the former.
> 
> I agree, we should wait for the first real use case where specifying a
> larger-than-32bit integer actually makes sense in practice.

Anybody who wants to refer to a file or memory size would want that. We
have a few cases in pack-objects already, but they use OPT_MAGNITUDE()
instead. Which makes sense. Anything we expect to be that gigantic would
want to have the shorthand to say "4G" or whatever.

(As a side note, I notice that OPT_MAGNITUDE uses "unsigned long", which
probably needs to be adjusted for Windows. Dealing with all of the
void-pointer type-punning fallout from that will be fun. :) ).

> It's output looks like this when applied to an older version without
> the big-endian fix upthread:
> 
>   potential error at apply.c:4982:26:
>     passing variable 'state -> p_context' of type 'unsigned int' to OPT_INTEGER
>     OPT_INTEGER expects an int

Looks like this found a lot of the same issues my "intp" conversion
found. My recollection is that mine found more, but it might just have
been that the compiler's warning output is rather verbose. TBH, I didn't
carefully catalog them; as soon as I saw the problem, I went to bed in
disgust. ;)

> diff --git a/contrib/coccinelle/parse-options.cocci b/contrib/coccinelle/parse-options.cocci
> new file mode 100644
> index 0000000000..e0cddef421
> --- /dev/null
> +++ b/contrib/coccinelle/parse-options.cocci
> @@ -0,0 +1,18 @@
> +@ optint @
> +identifier opts;
> +type T;
> +T var;
> +expression SHORT, LONG, HELP;
> +position p;
> +@@
> +struct option opts[] = { ..., OPT_INTEGER(SHORT, LONG, &var@p, HELP), ...};
> +
> +@ script:python @
> +p << optint.p;
> +var << optint.var;
> +vartype << optint.T;
> +@@

I avoided relying on the python interpreter for previous cocci patches,
since some builds don't have it (IIRC, the one in Debian experimental
doesn't, but that one has not graduated even to "unstable" after several
years, so maybe it's not worth worrying about).

If we do start using python, we might want to revisit 4d168e742a
(coccinelle: use <...> for function exclusion, 2018-08-28), which
describes a faster python alternative in the commit message.

-Peff
