Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2674C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 22:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJEW1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 18:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJEW1B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 18:27:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0204C61B
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 15:26:59 -0700 (PDT)
Received: (qmail 9309 invoked by uid 109); 5 Oct 2022 22:26:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Oct 2022 22:26:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18778 invoked by uid 111); 5 Oct 2022 22:26:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Oct 2022 18:26:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Oct 2022 18:26:57 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Stopak <jacob@initialcommit.io>, git@vger.kernel.org,
        martin.agren@gmail.com
Subject: Re: [RFC PATCH v2] shortlog: add group-by options for year and month
Message-ID: <Yz4EsT8noIoygk9b@coredump.intra.peff.net>
References: <20220922061824.16988-1-jacob@initialcommit.io>
 <20220922232536.40807-1-jacob@initialcommit.io>
 <xmqqillevzeh.fsf@gitster.g>
 <Yy4sIAHdvp6yRql+@coredump.intra.peff.net>
 <Yz36eFeGyQ3ha1pw@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz36eFeGyQ3ha1pw@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 05, 2022 at 05:43:20PM -0400, Taylor Blau wrote:

> > Heh, I was about to make the exact same suggestion. The existing
> > "--group=author" could really just be "--group='%an <%ae>'" (or variants
> > depending on the "-e" flag).
> 
> This caught my attention, so I wanted to see how hard it would be to
> implement. It actually is quite straightforward, and gets us most of the
> way to being able to get the same functionality as in Jacob's patch
> (minus being able to do the for-each-ref-style sub-selectors, like
> `%(authordate:format=%Y-%m)`).

Yeah, your patch is about what I'd expect.

The date thing I think can be done with --date; I just sent a sketch in
another part of the thread.

> +static void insert_record_from_pretty(struct shortlog *log,
> +				      struct strset *dups,
> +				      struct commit *commit,
> +				      struct pretty_print_context *ctx,
> +				      const char *oneline)
> +{
> +	struct strbuf ident = STRBUF_INIT;
> +	size_t i;
> +
> +	for (i = 0; i < log->pretty.nr; i++) {
> +		if (i)
> +			strbuf_addch(&ident, ' ');
> +
> +		format_commit_message(commit, log->pretty.items[i].string,
> +				      &ident, ctx);
> +	}

So here you're allowing multiple pretty options. But really, once we
allow the user an arbitrary format, is there any reason for them to do:

  git shortlog --group=%an --group=%ad

versus just:

  git shortlog --group='%an %ad'

?

>  void shortlog_add_commit(struct shortlog *log, struct commit *commit)
>  {
>  	struct strbuf ident = STRBUF_INIT;
> @@ -243,6 +266,8 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
>  	if (log->groups & SHORTLOG_GROUP_TRAILER) {
>  		insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
>  	}
> +	if (log->groups & SHORTLOG_GROUP_PRETTY)
> +		insert_record_from_pretty(log, &dups, commit, &ctx, oneline_str);

I was puzzled at first that this was a bitwise check. But I forgot that
we added support for --group options already, in 63d24fa0b0 (shortlog:
allow multiple groups to be specified, 2020-09-27).

So a plan like:

  git shortlog --group=author --group=date

(as in the original patch in this thread) doesn't quite work, I think.
Because the semantics for multiple --group lines are that the commit is
credited individually to each ident. That's what lets you do:

  git shortlog -ns --group=author --group=trailer:co-authored-by

and credit authors and co-authors equally. So likewise, I think multiple
group-format options don't really make sense (or at least, do not make
sense to concatenate; you'd put each key in its own single format).

> @@ -321,8 +346,10 @@ static int parse_group_option(const struct option *opt, const char *arg, int uns
>  	else if (skip_prefix(arg, "trailer:", &field)) {
>  		log->groups |= SHORTLOG_GROUP_TRAILER;
>  		string_list_append(&log->trailers, field);
> -	} else
> -		return error(_("unknown group type: %s"), arg);
> +	} else {
> +		log->groups |= SHORTLOG_GROUP_PRETTY;
> +		string_list_append(&log->pretty, arg);
> +	}

We probably want to insist that the format contains a "%" sign, and/or
git it a keyword like "format:". Otherwise a typo like:

  git shortlog --format=autor

stops being an error we detect, and just returns nonsense results
(every commit has the same ident).

I think you'd want to detect SHORTLOG_GROUP_PRETTY in the
read_from_stdin() path, too. And probably just die() with "not
supported", like we do for trailers.

> I think you could also do some cleanup on top, like replacing the
> SHORTLOG_GROUP_AUTHOR mode with adding either "%aN <%aE>" (or "%aN",
> without --email) as an entry in the `pretty` string_list.

Yeah, that would be a nice cleanup. I think might even be a good idea to
explain the various options to the users in terms of "--author is
equivalent to %aN <%aE>". It may help them understand how the tool
works.

-Peff
