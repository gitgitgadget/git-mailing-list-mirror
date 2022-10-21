Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F48C4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 05:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJUFvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJUFvA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 01:51:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C37E1A0450
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 22:50:59 -0700 (PDT)
Received: (qmail 10565 invoked by uid 109); 21 Oct 2022 05:50:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 05:50:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1933 invoked by uid 111); 21 Oct 2022 05:51:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 01:51:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 01:50:58 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 5/6] shortlog: implement `--group=author` in terms of
 `--group=<format>`
Message-ID: <Y1IzQprA+QQFQXGz@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666320509.git.me@ttaylorr.com>
 <f0044682be70f876f6f92455f1fa46dd2e8aa09f.1666320509.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0044682be70f876f6f92455f1fa46dd2e8aa09f.1666320509.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 11:11:41PM -0400, Taylor Blau wrote:

> Instead of handling SHORTLOG_GROUP_AUTHOR separately, reimplement it as
> a special case of the new `--group=<format>` mode, where the author mode
> is a shorthand for `--group='%aN <%aE>'.
> 
> Note that we still need to keep the SHORTLOG_GROUP_AUTHOR enum since it
> has a different meaning in `read_from_stdin()`, where it is still used
> for a different purpose.

Yep, makes sense. The implementation all looks correct to me, although:

> diff --git a/builtin/log.c b/builtin/log.c
> index ee19dc5d45..b4d5420217 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1334,6 +1334,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  	log.in2 = 4;
>  	log.file = rev->diffopt.file;
>  	log.groups = SHORTLOG_GROUP_AUTHOR;
> +	shortlog_finish_setup(&log);
>  	for (i = 0; i < nr; i++)
>  		shortlog_add_commit(&log, list[i]);

I'd probably have pulled out this "finish_setup()" stuff into its own
patch. I can live with it either way, though. The advantage of having it
here is that it becomes obvious why this caller needs it (whereas if
done as a preparatory patch, it would just do the trailer sorting, which
make_cover_letter() obviously does not need).

-Peff
