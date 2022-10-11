Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A726C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 01:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJKBfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiJKBeq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 21:34:46 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434A09588
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 18:34:43 -0700 (PDT)
Received: (qmail 29962 invoked by uid 109); 11 Oct 2022 01:34:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 01:34:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16222 invoked by uid 111); 11 Oct 2022 01:34:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 21:34:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 21:34:42 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 5/7] shortlog: implement `--group=author` in terms of
 `--group=<format>`
Message-ID: <Y0TIMlrrifYKuBnR@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <55a6ef7bc0082818fa51a0915c43002ede5c449f.1665448437.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55a6ef7bc0082818fa51a0915c43002ede5c449f.1665448437.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 08:34:15PM -0400, Taylor Blau wrote:

> Instead of handling SHORTLOG_GROUP_AUTHOR separately, reimplement it as
> a special case of the new `--group=<format>` mode, where the author mode
> is a shorthand for `--group='%aN <%aE>'.

OK, this should be a nice cleanup.

> diff --git a/builtin/log.c b/builtin/log.c
> index ee19dc5d45..6b77e520b5 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1334,6 +1334,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  	log.in2 = 4;
>  	log.file = rev->diffopt.file;
>  	log.groups = SHORTLOG_GROUP_AUTHOR;
> +	shortlog_init_group(&log);
>  	for (i = 0; i < nr; i++)
>  		shortlog_add_commit(&log, list[i]);

In another caller you drop the assignment of log.groups, since
shortlog_init_group() already does so if log.groups is 0 (which it will
be, since shortlog_init() will zero-initialize).

Should we do the same here? Or maybe leaving it is more obvious. It
would be more obvious still if we made the helper take the type, like:

  shortlog_init_group(&log, SHORTLOG_GROUP_AUTHOR);

But I guess that is not accurate, as we'd eventually use this in
shortlog.c to turn _any_ bits we've accumulated in log.group into their
correct formats.

I think the name of the helper function puzzled me a bit. It is really
"finish up any setup for the shortlog struct". We could lazily do it in
shortlog_add_commit(), but that's pretty subtle. But could we maybe call
it:

  shortlog_finish_setup();

or something? I dunno. I might be nit-picking, but I actually had to
scratch my head quite a bit to understand what was going on here.

> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index f708d96558..aac8c7afa4 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -245,15 +245,6 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
>  	}
>  	oneline_str = oneline.len ? oneline.buf : "<none>";
>  
> -	if (log->groups & SHORTLOG_GROUP_AUTHOR) {
> -		strbuf_reset(&ident);
> -		format_commit_message(commit,
> -				      log->email ? "%aN <%aE>" : "%aN",
> -				      &ident, &ctx);
> -		if (!HAS_MULTI_BITS(log->groups) ||
> -		    strset_add(&dups, ident.buf))
> -			insert_one_record(log, ident.buf, oneline_str);
> -	}

This loses the HAS_MULTI_BITS() optimization. The idea there is that if
you have a single group-by that can't produce multiple outputs, then
there's no need to do duplicate detection.

The equivalent in an all-formats world is something like:

  log.format.nr > 1 && !log.trailers.nr

(because trailers are special in that one trailer key can produce
multiple idents for a single commit).

> +void shortlog_init_group(struct shortlog *log)
> +{
> +	if (!log->groups)
> +		log->groups = SHORTLOG_GROUP_AUTHOR;
> +
> +	if (log->groups & SHORTLOG_GROUP_AUTHOR)
> +		string_list_append(&log->format,
> +				   log->email ? "%aN <%aE>" : "%aN");
> +}

Regardless of the naming suggestion I made, I think things would be more
obvious if this top conditional remained in cmd_shortlog(). And then the
explicit assignment of "log.group" in make_cover_letter() would remain.

> @@ -439,8 +440,8 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
>  	log.file = rev.diffopt.file;
>  	log.date_mode = rev.date_mode;
>  
> -	if (!log.groups)
> -		log.groups = SHORTLOG_GROUP_AUTHOR;
> +	shortlog_init_group(&log);
> +
>  	string_list_sort(&log.trailers);

Now that we have a "finish the shortlog init" function, probably this
trailer sort should go into it, too. The current caller doesn't need it,
but it removes on more gotcha from using the shortlog API.

-Peff
