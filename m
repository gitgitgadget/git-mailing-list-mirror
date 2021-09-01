Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9668C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 23:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993C56102A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 23:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbhIAX1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 19:27:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58580 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhIAX1g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 19:27:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4AEA8D940B;
        Wed,  1 Sep 2021 19:26:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/J04LxmaN0iQtLmK0It38SXzN5sqLzQqNq6g3y
        5C6RY=; b=FTHsOkSq2io43fdA0dSuPRgsyoMSoAlpua38BS6e4waLCcnD43kt3z
        zPDM9cJpcL3ir4nObeVFxf9S/hABUK98ionLveOV0p5jM0wY0p8/N3ywtJK+EpnJ
        ipL6NABqZPiaOPDVYQ5KLeYRNjO1+R3CwMvAmHE4JO8Tkf+PyxnFs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41A5DD940A;
        Wed,  1 Sep 2021 19:26:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C78F9D9409;
        Wed,  1 Sep 2021 19:26:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pretty: colorize pattern matches in commit messages
References: <20210901121616.2109658-1-someguy@effective-light.com>
Date:   Wed, 01 Sep 2021 16:26:37 -0700
In-Reply-To: <20210901121616.2109658-1-someguy@effective-light.com> (Hamza
        Mahfooz's message of "Wed, 1 Sep 2021 08:16:16 -0400")
Message-ID: <xmqqwnnznahe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DE0A290-0B7C-11EC-BBBB-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hamza Mahfooz <someguy@effective-light.com> writes:

> Currently, for example when
>
>   git log --grep=pattern
>
> is executed, the outputted commits that are matched by the pattern do not
> have the relevant substring matches highlighted.

A proposed log message that stops after a description of the current
status alone invites a "so what?" response.  While it may be so
obvious to you why the current state is undesirable (after all, it
motivated you enough to write a patch to improve the situation), the
job of the proposed message is to explain and convince others to
agree what is wrong in the current state and what is a reasonable
design to improve it.  Among these three ingredients, the latter two
are missing from the above.

Because it is our convention to talk about the current status in
present tense first, you do not have to start the description with
"Currently,".

Taking the above two paragraphs together, perhaps:

    The "git log" command limits its output to the commits that
    contain strings that matched the "--grep=<pattern>" option, but
    unlike output from "git grep -e <pattern>", the matches are not
    highlighted, making them harder to spot.

    Teach the pretty-printer code to highlight matches from the
    "--grep=<pattern>", "--author=<pattern>" and
    "--committer=<pattern>" options (to view the last one, you may
    have to ask for --pretty=fuller).

Or something like that.

>  pretty.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 98 insertions(+), 11 deletions(-)

This new feature deserves to be tested.  I am surprised that we do
not have "git log --grep" tests whose expected output we need to
adjust for this change.  Perhaps it is becuase we are not otherwise
showing colors at all in "git log" tests?

It also needs a documentation update, if only to tell readers how to
customize the color used to paint the hits.

> +static void append_matched_line(struct grep_opt *opt, const char *line,
> +				size_t linelen, enum grep_pat_token token,
> +				int field, struct strbuf *sb)
> +{
> +	struct grep_pat *pat;
> +	struct strbuf tmp_sb;
> +	regmatch_t tmp_match, match;
> +	char *buf, *eol, *color;
> +	int cflags = 0;
> +
> +	strbuf_init(&tmp_sb, linelen + 1);
> +	strbuf_add(&tmp_sb, line, linelen);
> +	buf = tmp_sb.buf;
> +	eol = buf + linelen;

This copy of the whole line is wasted when ...

> +	if (!opt || !want_color(opt->color))
> +		goto skip;

... we are not doing any coloring.  Can we avoid it?

> +	color = opt->colors[GREP_COLOR_MATCH_CONTEXT];

Why is the context (as opposed to selected) color used here?  

In general, when you allow the foreground color to be customized,
you must also make the background color customizable, so that the
end user can avoid low contrast combinations.  If we look at how
opt->color is handled in grep.c::show_line(), we can tell how both
match_color (foregroud) and line_color (background) are taken from
the palette that the end user can customize.  We should do the same
here, without assuming that 'color' here will have a good contrast
against the COLOR_RESET backdrop.

> +	for (;;) {
> +		match.rm_so = match.rm_eo = -1;
> +
> +		for (pat = (token == GREP_PATTERN_HEAD ?
> +			    opt->header_list : opt->pattern_list);
> +		     pat; pat = pat->next) {
> +			if (pat->token == token &&
> +			    (field == -1 || pat->field == field) &&
> +			    !regexec(&pat->regexp, buf, 1, &tmp_match,
> +				     cflags)) {
> +
> +				if ((match.rm_so >= 0 && match.rm_eo >= 0) &&
> +				    (tmp_match.rm_so > match.rm_so ||
> +				     (tmp_match.rm_so == match.rm_so &&
> +				      tmp_match.rm_eo < match.rm_eo)))
> +					continue;
> +
> +				match.rm_so = tmp_match.rm_so;
> +				match.rm_eo = tmp_match.rm_eo;
> +			}
> +		}

For the current commit to come this far, "git log --grep=<pattern>"
must have done the above exact regexec() to decide if we need to
call this function in the first place, right?

We must be redoing the same computation here, which is unfortunate
for two reasons.  Performance and maintainability.

How much extra cycles are we looking at with this additional code?
Depending on how inefficient this code makes, we may need to make it
an optional feature, turned off by default.

Worse yet, this can easily become a source of future bugs, since the
above matching logic must be kept in sync with the existing matching
code elsewhere.  I would not be surprised if the above logic is
already broken when various options that affects how pattern
matching works with "log --grep" (e.g. "--invert-grep", "-E", "-i")
are in use.

Also, this function is misnamed.  It is not a function that appends
matched line.  From the caller's point of view, it is used to append
each and every line it wants to add to sb [*], and they do not even
need or want to know how the callee decides which parts of the line
to paint in different colors.  Perhaps append_line_with_color() or
something?

	Side note.  By the way, why is the sb the last parameter to
	this function?  Usually functions that operate on a strbuf
	take it as the first argument.

> +		if (match.rm_so == match.rm_eo)
> +			break;
> +
> +		strbuf_grow(sb, strlen(color) + strlen(GIT_COLOR_RESET));
> +		strbuf_add(sb, buf, match.rm_so);
> +		strbuf_add(sb, color, strlen(color));
> +		strbuf_add(sb, buf + match.rm_so,
> +			   match.rm_eo - match.rm_so);
> +		strbuf_add(sb, GIT_COLOR_RESET,
> +			   strlen(GIT_COLOR_RESET));
> +		buf += match.rm_eo;
> +		cflags = REG_NOTBOL;
> +	}
> +
> +skip:
> +	strbuf_add(sb, buf, eol - buf);
> +
> +	strbuf_release(&tmp_sb);
> +}
> +

I like what the new feature wants to do, but I am not sure if this
is the best execution of the idea (yet).

Thanks.
