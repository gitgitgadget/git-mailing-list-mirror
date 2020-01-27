Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7D0C33CB7
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 23:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF922467B
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 23:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgA0XUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:20:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:45826 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725955AbgA0XUF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 18:20:05 -0500
Received: (qmail 4748 invoked by uid 109); 27 Jan 2020 23:20:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Jan 2020 23:20:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2104 invoked by uid 111); 27 Jan 2020 23:27:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Jan 2020 18:27:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Jan 2020 18:20:04 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] C: use skip-prefix to avoid hardcoded string length
Message-ID: <20200127232004.GE19360@coredump.intra.peff.net>
References: <xmqqv9owa6cw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9owa6cw.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 02:21:03PM -0800, Junio C Hamano wrote:

> We often skip an optional prefix in a string with a hardcoded
> constant, e.g.
> 
> 	if (starts_with(string, "prefix"))
> 		string += 6;
> 
> which is less error prone when written
> 
> 	skip_prefix(string, "prefix", &string);

All of these look obviously correct, because you've introduced new
temporary variables to replace the computed values. But...

> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 4d3430900d..51ffd74945 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -560,15 +560,17 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  
>  	for (i = 1; i < argc; i++) {
>  		const char *arg = argv[i];
> +		const char *valptr;
> +
>  		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
>  			flags |= EXPIRE_REFLOGS_DRY_RUN;
> -		else if (starts_with(arg, "--expire=")) {
> -			if (parse_expiry_date(arg + 9, &cb.cmd.expire_total))
> +		else if (skip_prefix(arg, "--expire=", &valptr)) {
> +			if (parse_expiry_date(valptr, &cb.cmd.expire_total))
>  				die(_("'%s' is not a valid timestamp"), arg);
>  			explicit_expiry |= EXPIRE_TOTAL;
>  		}

In this case, I think the die message in the context could be improved
to show "valptr". At which point you might as well do:

  else if (skip_prefix(arg, "--expire=", &arg)) {

> -		else if (starts_with(arg, "--expire-unreachable=")) {
> -			if (parse_expiry_date(arg + 21, &cb.cmd.expire_unreachable))
> +		else if (skip_prefix(arg, "--expire-unreachable=", &valptr)) {
> +			if (parse_expiry_date(valptr, &cb.cmd.expire_unreachable))
>  				die(_("'%s' is not a valid timestamp"), arg);
>  			explicit_expiry |= EXPIRE_UNREACH;
>  		}

Ditto here.

-Peff
