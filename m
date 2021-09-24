Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75750C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 19:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E8BD610CB
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 19:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346463AbhIXTZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 15:25:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64872 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344513AbhIXTZM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 15:25:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E90A11534FD;
        Fri, 24 Sep 2021 15:23:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=817p7rJqNTH5UjQoXniKCjQLaVesGG3HfQNv9fuWmHg=; b=Pfdk
        BwnkL0Z7lheUjO0/zej3MH7rloG5BK0N4mNbgQlmE/Wwr8nane6SosjgEVOz3cTY
        vC3+1DxzJVu8uSh9ABwkBmxpLyVMxHRNoVqWP6C3T4lF8fzomY/Y+ZEMOqbsa/gG
        YiNu4sKEj0sjpWv7CJdoYrEWf774Dqims89PhBw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E18AB1534FA;
        Fri, 24 Sep 2021 15:23:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 581AD1534F9;
        Fri, 24 Sep 2021 15:23:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v8 1/2] grep: refactor next_match() and
 match_one_pattern() for external use
References: <20210924155000.1259649-1-someguy@effective-light.com>
Date:   Fri, 24 Sep 2021 12:23:35 -0700
Message-ID: <xmqqilypu6a0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA2755C6-1D6C-11EC-AE81-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hamza Mahfooz <someguy@effective-light.com> writes:

> These changes are made in preparation of, the colorization support for the
> "git log" subcommands that, rely on regex functionality (i.e. "--author",
> "--committer" and "--grep"). These changes are necessary primarily because
> match_one_pattern() expects header lines to be prefixed, however, in
> pretty, the prefixes are stripped from the lines because the name-email
> pairs need to go through additional parsing, before they can be printed and
> because next_match() doesn't handle the case of
> "ctx == GREP_CONTEXT_HEAD" at all. So, teach next_match() how to handle the
> new case and move match_one_pattern()'s core logic to
> headless_match_one_pattern() while preserving match_one_pattern()'s uses
> that depend on the additional processing.
>
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> ---
> v5: separate grep changes from pretty changes.
>
> v6: rescope some variables.
>
> v7: export header_field[] and allow for subsequent matches on header lines
>     in match_one_pattern().
>
> v8: add headless_match_one_pattern() and move header_field[] back.

This looks a lot more sensible split compared to the previous round.

> ---
>  grep.c | 83 ++++++++++++++++++++++++++++++++++++----------------------
>  grep.h |  4 +++
>  2 files changed, 55 insertions(+), 32 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 14fe8a0fd2..e46b046638 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -944,37 +944,19 @@ static struct {
>  	{ "reflog ", 7 },
>  };
>  
> -static int match_one_pattern(struct grep_pat *p,
> -			     const char *bol, const char *eol,
> -			     enum grep_context ctx,
> -			     regmatch_t *pmatch, int eflags)
> +static int headerless_match_one_pattern(struct grep_pat *p,
> +					const char *bol, const char *eol,
> +					enum grep_context ctx,
> +					regmatch_t *pmatch, int eflags)
>  {
>  	int hit = 0;
>  	const char *start = bol;
>  
>  	if ((p->token != GREP_PATTERN) &&
> -	    ((p->token == GREP_PATTERN_HEAD) != (ctx == GREP_CONTEXT_HEAD)))
> +	    ((p->token == GREP_PATTERN_HEAD) != (ctx == GREP_CONTEXT_HEAD)) &&
> +	    ((p->token == GREP_PATTERN_BODY) != (ctx == GREP_CONTEXT_BODY)))

I _think_ it makes sense to have this additional "if looking for
something in the body, do not bother if we are not in body", but I
wonder if that is a bugfix that has nothing to do with this topic.

In other words, even if for whatever reason we decide that it is not
worth painting the hits in "git log --grep=<pattern> --author=<who>"
output, would the addition to this single condition to the original
code, with or without the refactoring, fix some existing bug?

If so, perhaps that can be a separate patch with a test that
demonstrates the bug fixed.  With this change mixed in, it is
unclear if this step is pure refactoring that does not break the
existing callers of the code path.

If it is not a bugfix, we need to explain the reason why this
additional condition is necessary in the proposed log message (I am
assuming that this change is needed to get the end result working).

> +static int match_one_pattern(struct grep_pat *p,
> +			     const char *bol, const char *eol,
> +			     enum grep_context ctx, regmatch_t *pmatch,
> +			     int eflags)
> +{
> +	const char *field;
> +	size_t len;
> +
> +	if (p->token == GREP_PATTERN_HEAD) {
> +		assert(p->field < ARRAY_SIZE(header_field));
> +		field = header_field[p->field].field;
> +		len = header_field[p->field].len;
> +		if (strncmp(bol, field, len))
> +			return 0;
> +		bol += len;
> +
> +		switch (p->field) {
> +		case GREP_HEADER_AUTHOR:
> +		case GREP_HEADER_COMMITTER:
> +			strip_timestamp(bol, &eol);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return headerless_match_one_pattern(p, bol, eol, ctx, pmatch, eflags);
> +}

So, match_one_pattern() after all the above changes behaves almost
identically for existing callers, except that it has the "pattern
for body should only apply to the body text" condition added, which
may affect the behaviour.

> @@ -1143,7 +1155,7 @@ static int match_next_pattern(struct grep_pat *p,
>  {
>  	regmatch_t match;
>  
> -	if (!match_one_pattern(p, bol, eol, ctx, &match, eflags))
> +	if (!headerless_match_one_pattern(p, bol, eol, ctx, &match, eflags))
>  		return 0;
>  	if (match.rm_so < 0 || match.rm_eo < 0)
>  		return 0;

Since this "next" thing is designed to be repeatedly called, we use
the new helper that is meant for <bol, eol> after we preprocessed
the header and the trailing timestamp away, which makes sense, I
guess.  But the caller needs to do the preprocessing before it makes
the first call to match_next_pattern() on any given line to adjust
bol and eol.

> @@ -1158,22 +1170,28 @@ static int match_next_pattern(struct grep_pat *p,
>  	return 1;
>  }
>  
> -static int next_match(struct grep_opt *opt,
> -		      const char *bol, const char *eol,
> -		      enum grep_context ctx, regmatch_t *pmatch, int eflags)
> +int grep_next_match(struct grep_opt *opt,
> +		    const char *bol, const char *eol,
> +		    enum grep_context ctx, regmatch_t *pmatch,
> +		    enum grep_header_field field, int eflags)
>  {
>  	struct grep_pat *p;
>  	int hit = 0;
>  
>  	pmatch->rm_so = pmatch->rm_eo = -1;
>  	if (bol < eol) {
> -		for (p = opt->pattern_list; p; p = p->next) {
> +		for (p = ((ctx == GREP_CONTEXT_HEAD)
> +			   ? opt->header_list : opt->pattern_list);
> +			  p; p = p->next) {
>  			switch (p->token) {
>  			case GREP_PATTERN: /* atom */
>  			case GREP_PATTERN_HEAD:
>  			case GREP_PATTERN_BODY:
> -				hit |= match_next_pattern(p, bol, eol, ctx,
> -							  pmatch, eflags);
> +				if ((field == GREP_HEADER_FIELD_MAX) ||
> +				    (p->field == field))
> +					hit |= match_next_pattern(p, bol, eol,
> +								  ctx, pmatch,
> +								  eflags);

... and this caller apparently does not.  It is made the
responsibility of the callers of grep_next_match() to adjust bol and
eol before calling it.

>  				break;
>  			default:
>  				break;
> @@ -1261,7 +1279,8 @@ static void show_line(struct grep_opt *opt,
>  			else if (sign == '=')
>  				line_color = opt->colors[GREP_COLOR_FUNCTION];
>  		}
> -		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
> +		while (grep_next_match(opt, bol, eol, ctx, &match,
> +				       GREP_HEADER_FIELD_MAX, eflags)) {

... which is this caller, show_line(), which is the only caller of
grep_next_match().

But this function is not taught to strip headers and timestamp from
<bol, eol>, either, so it is the responsibility of the callers of
show_line().

I _think_ all the current callers of show_line() handle the blob
contents found by "git grep" and not "git log --grep/--author", and
there is no GREP_PATTERN_HEAD/GREP_PATTERN_BODY given, but I may be
mistaken.  With the current set of callers, do we ever call
next_match() with a pattern with p->token set to GREP_PATTERN_HEAD
or _BODY?  I am wondering why we even have those cases covered in
the switch statement in the previous hunk.

match_one_pattern() of course must be prepared to see the HEAD and
BODY requests because match_expr_eval() is evantually called via
grep_buffer() interface to implement "git log --grep/--author", but
I do not think next_match() would be called in that code path.  The
handling of GREP_PATTERN_HEAD and GREP_PATTERN_BODY in next_match(),
which I am wondering about, came from 7e8f59d5 (grep: color patterns
in output, 2009-03-07).

Anyway, let's read on.

> diff --git a/grep.h b/grep.h
> index 3cb8a83ae8..521068308e 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -190,6 +190,10 @@ void append_header_grep_pattern(struct grep_opt *, enum grep_header_field, const
>  void compile_grep_patterns(struct grep_opt *opt);
>  void free_grep_patterns(struct grep_opt *opt);
>  int grep_buffer(struct grep_opt *opt, const char *buf, unsigned long size);
> +int grep_next_match(struct grep_opt *opt,
> +		    const char *bol, const char *eol,
> +		    enum grep_context ctx, regmatch_t *pmatch,
> +		    enum grep_header_field field, int eflags);

As this is made external, it at least needs a comment on the
(somewhat strange) field parameter, especially the fact that "no,
this is not grepping in the header lines in a commit object" is
signalled by a special GREP_HEADER_FIELD_MAX value.

>  
>  struct grep_source {
>  	char *name;

Other than that, looks much cleaner than the previous round.

Thanks.
