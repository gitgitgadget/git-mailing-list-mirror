Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E35C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 00:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E26E2063A
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 00:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgAaATJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 19:19:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:49216 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727380AbgAaATJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 19:19:09 -0500
Received: (qmail 9918 invoked by uid 109); 31 Jan 2020 00:19:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Jan 2020 00:19:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28558 invoked by uid 111); 31 Jan 2020 00:26:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jan 2020 19:26:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jan 2020 19:19:07 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] C: use skip-prefix to avoid hardcoded string length
Message-ID: <20200131001907.GD2394563@coredump.intra.peff.net>
References: <xmqqv9owa6cw.fsf@gitster-ct.c.googlers.com>
 <20200127232004.GE19360@coredump.intra.peff.net>
 <xmqq36c09zo0.fsf@gitster-ct.c.googlers.com>
 <xmqqa764d9f1.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa764d9f1.fsf_-_@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 11:35:46AM -0800, Junio C Hamano wrote:

>  * v2 uses a simpler conversion that has a side effect of changing
>    the error message from "git reflog expire" in a better way.

Thanks, this all looks good to me.

> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 4d3430900d..81dfd563c0 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -560,15 +560,16 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  
>  	for (i = 1; i < argc; i++) {
>  		const char *arg = argv[i];
> +
>  		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
>  			flags |= EXPIRE_REFLOGS_DRY_RUN;
> -		else if (starts_with(arg, "--expire=")) {
> -			if (parse_expiry_date(arg + 9, &cb.cmd.expire_total))
> +		else if (skip_prefix(arg, "--expire=", &arg)) {
> +			if (parse_expiry_date(arg, &cb.cmd.expire_total))
>  				die(_("'%s' is not a valid timestamp"), arg);
>  			explicit_expiry |= EXPIRE_TOTAL;
>  		}

I'm not sure if you meant to leave the blank-line addition, or if it was
a leftover from when there was a variable added there in v1. I think the
result is more readable, though, so I certainly don't mind it. ;)

-Peff
