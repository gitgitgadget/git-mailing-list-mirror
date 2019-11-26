Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E18C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 16:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DD6206BF
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 16:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfKZQHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:07:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:32964 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727964AbfKZQHj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 11:07:39 -0500
Received: (qmail 2563 invoked by uid 109); 26 Nov 2019 16:07:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Nov 2019 16:07:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3138 invoked by uid 111); 26 Nov 2019 16:11:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Nov 2019 11:11:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Nov 2019 11:07:37 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] name-rev: use skip_prefix() instead of starts_with()
Message-ID: <20191126160737.GC25729@sigill.intra.peff.net>
References: <23925fba-9413-0596-b21a-f49aac922f88@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23925fba-9413-0596-b21a-f49aac922f88@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 26, 2019 at 04:23:31PM +0100, René Scharfe wrote:

> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index b0f0776947..c261d661d7 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -161,10 +161,8 @@ static const char *name_ref_abbrev(const char *refname, int shorten_unambiguous)
>  {
>  	if (shorten_unambiguous)
>  		refname = shorten_unambiguous_ref(refname, 0);
> -	else if (starts_with(refname, "refs/heads/"))
> -		refname = refname + 11;
> -	else if (starts_with(refname, "refs/"))
> -		refname = refname + 5;
> +	else if (!skip_prefix(refname, "refs/heads/", &refname))
> +		skip_prefix(refname, "refs/", &refname);
>  	return refname;

And this one is correct because we were already mutating the pointer.
Good.

Collapsing the conditional makes sense. IMHO it might be a little easier
to follow if we keep else-if non-negated, like:

  if (shorten_unambiguous)
         refname = shorten_unambiguous(refname, 0);
  else if (skip_prefix(refname, "refs/heads/", &refname))
         ; /* refname already advanced */
  else
         skip_prefix(refname, "refs/", &refname);

but I'm fine with it either way.

Also, I think we are leaking the result of shorten_unambiguous_refename
here (the caller won't free it, as we return a const; but anyway we
sometimes return a pointer into the existing const string so it wouldn't
be safe). That's all outside your patch, obviously.

-Peff
