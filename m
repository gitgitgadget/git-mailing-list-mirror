Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518A7C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28CD86101C
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhHTR5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:57:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:53426 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235201AbhHTR47 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 13:56:59 -0400
Received: (qmail 23378 invoked by uid 109); 20 Aug 2021 17:56:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Aug 2021 17:56:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6942 invoked by uid 111); 20 Aug 2021 17:56:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Aug 2021 13:56:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Aug 2021 13:56:20 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Fix leak in credential_apply_config
Message-ID: <YR/sxISzR0RebVMZ@coredump.intra.peff.net>
References: <20210820084413.1503711-1-mh@glandium.org>
 <ffa1786e-f69f-3d76-98dc-7fa5cdbd31c0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ffa1786e-f69f-3d76-98dc-7fa5cdbd31c0@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 20, 2021 at 10:58:56AM -0400, Derrick Stolee wrote:

> On 8/20/2021 4:44 AM, Mike Hommey wrote:
> >  	normalized_url = url_normalize(url.buf, &config.url);
> >  
> >  	git_config(urlmatch_config_entry, &config);
> > +	string_list_clear(&config.vars, 1);
> >  	free(normalized_url);
> >  	strbuf_release(&url);
> 
> A good find! This is obviously correct and a valuable change
> to make. If you are interested in doing a little extra work,
> then I think there is something more we could do here.
> 
> I took a look at the rest of "struct urlmatch_config" to see
> if anything else needed to be cleared, and it turns out that
> config.url.url is an allocated string, but happens to be
> equal to normalized_url, which is freed here.
> 
> Perhaps the optimal organization would be to have a
> clear_urlmatch_config() method that clears all allocated data
> within the config, and change things like url_normalize()
> return a 'const char *' to make it clear that the url should
> be freed somewhere else.

Yeah, I had the same thought; it feels like we're peeking into details
of how url_config works (especially the knowledge that we we should be
passing free_util).

> It would help unify the handling of code that is somewhat
> duplicated (but slightly different each time) across
> credential_apply_config(), http_init(), get_urlmatch(),
> and cmd__urlmatch_normalization().

Agreed. It looks like http_init() has the same leak that is fixed here.

-Peff
