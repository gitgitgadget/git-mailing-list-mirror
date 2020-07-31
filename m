Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD939C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 21:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F92208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 21:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgGaVBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:01:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:44386 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729062AbgGaVBP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 17:01:15 -0400
Received: (qmail 24761 invoked by uid 109); 31 Jul 2020 21:01:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 21:01:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31765 invoked by uid 111); 31 Jul 2020 21:01:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jul 2020 17:01:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jul 2020 17:01:14 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 4/4] upload-pack.c: introduce
 'uploadpackfilter.tree.maxDepth'
Message-ID: <20200731210114.GC1440890@coredump.intra.peff.net>
References: <cover.1595468657.git.me@ttaylorr.com>
 <cover.1596227003.git.me@ttaylorr.com>
 <c9d71809f49dc1b600b75769e0b6aae17382bf4e.1596227003.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9d71809f49dc1b600b75769e0b6aae17382bf4e.1596227003.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 04:26:39PM -0400, Taylor Blau wrote:

> +test_expect_success 'upload-pack limits tree depth filters' '
> +	test_config -C srv.bare uploadpackfilter.allow false &&
> +	test_config -C srv.bare uploadpackfilter.tree.allow true &&
> +	test_config -C srv.bare uploadpackfilter.tree.maxDepth 0 &&
> +	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
> +		"file://$(pwd)/srv.bare" pc3 2>err &&
> +	test_i18ngrep "filter '\''tree'\'' not supported (maximum depth: 0, but got: 1)" err
> +'

Same i18ngrep comment as in the earlier patch (i.e., we can use grep
here).

> @@ -1029,6 +1040,11 @@ static void die_if_using_banned_filter(struct upload_pack_data *data)
>  
>  	strbuf_addf(&buf, "git upload-pack: filter '%s' not supported",
>  		    list_object_filter_config_name(banned->choice));
> +	if (banned->choice == LOFC_TREE_DEPTH &&
> +	    data->tree_filter_max_depth != ULONG_MAX)
> +		strbuf_addf(&buf, _(" (maximum depth: %lu, but got: %lu)"),
> +			    data->tree_filter_max_depth,
> +			    banned->tree_exclude_depth);

Hmm. So I see now why you wanted to go with the strbuf in the earlier
patch. This does still feel awkward, though. You check "is it allowed"
in an earlier function, we get "nope, it's not allowed", and now we have
to reimplement the check here. That seems like a maintenance burden.

I think a more natural flow would be either:

  - the "is it allowed" functions calls immediately into the function
    that sends the error and dies (this might need a conditional if
    there's a caller who doesn't want to die; I didn't check)

or

  - on failure it populates an error buffer itself, which the caller can
    then pass along as it sees fit

-Peff
