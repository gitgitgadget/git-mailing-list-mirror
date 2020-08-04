Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBC4C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 19:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28DEB20842
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 19:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgHDT6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:58:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:48060 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbgHDT6b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 15:58:31 -0400
Received: (qmail 5564 invoked by uid 109); 4 Aug 2020 19:58:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Aug 2020 19:58:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15050 invoked by uid 111); 4 Aug 2020 19:58:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Aug 2020 15:58:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Aug 2020 15:58:30 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
Message-ID: <20200804195830.GA2014743@coredump.intra.peff.net>
References: <20200728163617.GA2649887@coredump.intra.peff.net>
 <20200729201002.GA2989059@coredump.intra.peff.net>
 <871rku3soc.fsf@osv.gnss.ru>
 <20200731230858.GA1461090@coredump.intra.peff.net>
 <87mu3drynx.fsf@osv.gnss.ru>
 <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
 <87o8nrybnb.fsf@osv.gnss.ru>
 <20200803180824.GA2711830@coredump.intra.peff.net>
 <874kpi47xj.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874kpi47xj.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 04, 2020 at 08:50:16PM +0300, Sergey Organov wrote:

> Attached is rather minimal incompatible change to --diff-merges that'd
> allow extensions in the future, to get out of urge for the discussed
> changes. I'm going to follow-up with actual improvements and I'm aware
> it lacks documentation changes.

Thanks, I like the direction here. Definitely it would need
documentation, but also tests (probably in t4013 alongside the ones my
series added; in fact you'd probably need to adjust my tests for the
non-optional argument).

> diff --git a/revision.c b/revision.c
> index 669bc856694f..dcdff59bc36a 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2323,10 +2323,31 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		revs->diff = 1;
>  		revs->diffopt.flags.recursive = 1;
>  		revs->diffopt.flags.tree_in_recursive = 1;
> -	} else if (!strcmp(arg, "-m") || !strcmp(arg, "--diff-merges")) {
> +	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
>  		revs->ignore_merges = 0;
> +		if (!strcmp(optarg, "off")) {
> +			revs->ignore_merges = 1;
> +		} else if (!strcmp(optarg, "all")) {
> +			revs->diff = 0;

Should this be revs->ignore_merges = 0?

> +		} else if (!strcmp(optarg, "c")) {
> +			revs->diff = 1;
> +			revs->dense_combined_merges = 0;
> +			revs->combine_merges = 1;
> +		} else if (!strcmp(optarg, "cc")) {
> +			revs->diff = 1;
> +			revs->dense_combined_merges = 1;
> +			revs->combine_merges = 1;
> +		} else if (!strcmp(optarg, "combined-all-paths")) {
> +			revs->diff = 1;
> +			revs->combined_all_paths = 1;

I think Junio's suggestion to push these out to a separate patch is a
good one.

It's unfortunate that we have to duplicate all of the various options
that get set (from the "--cc", etc, blocks). But I think the boilerplate
for pushing it into a helper would make it even harder to read.

> +		} else {
> +			die("--diff-merges: unknown value '%s'.", optarg);
> +		}

A few nits:

  - we usually don't have a period at the end of our error messages

  - this should probably be marked for translation, i.e.,
    die(_("translated message"), optarg)

  - I think other similar messages are more like:

      unknown value for --diff-merges: %s

> +		return argcount;
>  	} else if (!strcmp(arg, "--no-diff-merges")) {
>  		revs->ignore_merges = 1;

I thought at first that the --no- form would be handled by
parse_long_opt() via the parseopt code, but it is not using parseopt at
all. :) So it is correct to keep this.

-Peff
