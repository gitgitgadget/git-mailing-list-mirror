Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7019C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 05:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJUFcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJUFcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 01:32:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D58228CC8
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 22:32:08 -0700 (PDT)
Received: (qmail 10491 invoked by uid 109); 21 Oct 2022 05:32:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 05:32:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1634 invoked by uid 111); 21 Oct 2022 05:32:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 01:32:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 01:32:07 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 1/6] shortlog: accept `--date`-related options
Message-ID: <Y1Iu1x6dR6GwiA2Y@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666320509.git.me@ttaylorr.com>
 <58baccbaa8612adae55f776ce10806809861270c.1666320509.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58baccbaa8612adae55f776ce10806809861270c.1666320509.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 11:11:29PM -0400, Taylor Blau wrote:

> diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> index f64e77047b..311c041c06 100644
> --- a/Documentation/git-shortlog.txt
> +++ b/Documentation/git-shortlog.txt
> @@ -47,6 +47,11 @@ OPTIONS
>  
>  	Each pretty-printed commit will be rewrapped before it is shown.
>  
> +--date=<format>::
> +	With a `--group=format:<format>`, show dates formatted
> +	according to the given date string. (See the `--date` options
> +	in the "COMMIT FORMATTING" section of linkgit:git-log[1].)

I like this much better than including the whole date-formats section.
Two nits:

  - s/options/option/ ? I guess you could say there are "options" for
    formatting the date, but with "--date" it seems like you'd mean the
    singular option.

  - Because "Commit Formatting" is a subsection in git-log(1), the
    manual will format it with title caps, not all-caps.

> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index 7a1e1fe7c0..53c379a51d 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -211,7 +211,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
>  	ctx.fmt = CMIT_FMT_USERFORMAT;
>  	ctx.abbrev = log->abbrev;
>  	ctx.print_email_subject = 1;
> -	ctx.date_mode.type = DATE_NORMAL;
> +	ctx.date_mode = log->date_mode;
>  	ctx.output_encoding = get_log_output_encoding();
>  
>  	if (!log->summary) {

After the discussion in the last round of whether that funky caller in
make_cover_letter() properly initialized the "struct shortlog", I
wondered briefly if this would do the right thing for that caller. And
it does, because DATE_NORMAL is intentionally set to "0" to allow for
zero-initializing (which is what shortlog_init does).

Not that it matters in practice, because that caller will not group by
nor format using a date, but I was curious if I had inadvertently
introduced a gotcha for future callers. But it is good.

> diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> index 3095b1b2ff..7547da539d 100755
> --- a/t/t4201-shortlog.sh
> +++ b/t/t4201-shortlog.sh
> @@ -83,6 +83,13 @@ test_expect_success 'pretty format' '
>  	test_cmp expect log.predictable
>  '
>  
> +test_expect_success 'pretty format (with --date)' '
> +	sed "s/SUBJECT/2005-04-07 OBJECT_NAME/" expect.template >expect &&
> +	git shortlog --format="%ad %H" --date=short HEAD >log &&
> +	fuzz log >log.predictable &&
> +	test_cmp expect log.predictable
> +'

And this looks sensible. If you dropped "%H" then you wouldn't need to
fuzz, and are still testing the interesting part. But just following the
whole template/fuzz thing of the surrounding tests is reasonable.

-Peff
