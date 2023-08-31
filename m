Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C12C83F37
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 17:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243060AbjHaRuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 13:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjHaRuW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 13:50:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BEACF3
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 10:50:19 -0700 (PDT)
Received: (qmail 25369 invoked by uid 109); 31 Aug 2023 17:50:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 17:50:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9349 invoked by uid 111); 31 Aug 2023 17:50:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 13:50:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 13:50:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 4/8] parse-options: mark unused "opt" parameter in
 callbacks
Message-ID: <20230831175018.GB3208283@coredump.intra.peff.net>
References: <20230831070935.GA3197495@coredump.intra.peff.net>
 <20230831071820.GB3197751@coredump.intra.peff.net>
 <xmqqil8vxjcd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqil8vxjcd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 31, 2023 at 09:33:22AM -0700, Junio C Hamano wrote:

> > -static int option_parse_stage(const struct option *opt,
> > +static int option_parse_stage(const struct option *opt UNUSED,
> >  			      const char *arg, int unset)
> >  {
> >  	BUG_ON_OPT_NEG(unset);
> 
> I suspect that the original is buggy; when given
> 
>   $ git checkout-index --stage=all --stage=1 path
> 
> the first option turns --temp on, but the second one does not turn
> it off.  For now I think being bug-to-bug compatible and annotating
> the opt as UNUSED is good, but as a follow-up, we could make the
> caller:
> 
>  (1) point &checkout_stage with opt->value;
> 
>  (2) make to_tempfile to tristate <unspecified, false, true> by
>      initializing it to -1;
> 
>  (3) adjust to_tempfile that is still <unspecified> after
>      parse_options() returns, according to the value in
>      checkout_stage.
> 
> and then this can follow the "opt->value points at the variable that
> is affected" pattern.

Yeah, I think that would work, with one extra bit:

  (4) complain when (!to_tempfile && checkout_stage == CHECKOUT_ALL)

I do think it would be better to fix separately, but maybe if I'm
re-rolling I can do it as an early patch in the series (it is not much
different than the "xopts" fix in scope).

> > -static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
> > +static int parse_refmap_arg(const struct option *opt UNUSED,
> > +			    const char *arg, int unset)
> >  {
> >  	BUG_ON_OPT_NEG(unset);
> 
> Can't this just point opt->value at the global &refmap?  Obviously
> not a huge deal, as we could have taken the "annotate as UNUSED"
> approach for all the functions in [3/8].

Hmm, yeah. I think I looked at the abstract refspec_append() here and
assumed that it might be touching other variables. But it's not. It's
operating purely on the &refspec we pass it (and even though it uses
ALLOC_GROW, the "nr" and "alloc" are both contained in the struct). So
yeah, it really should have been converted in patch 3.

I think that is probably worth a re-roll.

-Peff
