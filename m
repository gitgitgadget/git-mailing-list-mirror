Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51506C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A43461090
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242454AbhIWR1F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:27:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51620 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbhIWR1E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 13:27:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7776D14993B;
        Thu, 23 Sep 2021 13:25:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6Yt1Xi10s+HQCpM9CORN38OP15FQAseJEBZnpQ
        gCzGU=; b=w+DI2JEfvHl07RjVDzci0cE5hu+38ZzksE4Tamp1anPSmanYFzBgNt
        owoRGzCYl610BqsZJvQaD+Yt5z9ErrUqSrdIMPAr09llZealjZosYtq1e2aBxbOf
        WHiYY1W9RyMa6HUMNFVzCqTpD1Q7kFBgCuUp7h2gfkAJe02TcYjWY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FBEB14993A;
        Thu, 23 Sep 2021 13:25:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D465C149939;
        Thu, 23 Sep 2021 13:25:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 1/2] grep: refactor next_match() and
 match_one_pattern() for external use
References: <20210921211324.1426938-1-someguy@effective-light.com>
Date:   Thu, 23 Sep 2021 10:25:28 -0700
In-Reply-To: <20210921211324.1426938-1-someguy@effective-light.com> (Hamza
        Mahfooz's message of "Tue, 21 Sep 2021 17:13:23 -0400")
Message-ID: <xmqq8rzn2ohj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FDC37F0-1C93-11EC-80FF-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hamza Mahfooz <someguy@effective-light.com> writes:

> These changes are made in preparation of, the colorization support for the
> "git log" subcommands that, rely on regex functionality (i.e. "--author",
> "--committer" and "--grep"). These changes are necessary primarily because
> match_one_pattern() expects header lines to be prefixed, however, in
> pretty, the prefixes are stripped from the lines because the name-email
> pairs needs to go through additional parsing, before they can be printed
> and because next_match() doesn't handle the case of
> "ctx == GREP_CONTEXT_HEAD" at all. So, teach next_match() how to handle the
> new case, move header_field[] so it can be used by pretty to reappend
> relevant prefixes and teach match_one_pattern() how to handle subsequent
> header line match attempts.
>
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> ---
> v5: separate grep changes from pretty changes.
>
> v6: rescope some variables.
>
> v7: export header_field[] and allow for subsequent matches on header lines
>     in match_one_pattern().
> ---
>  grep.c | 53 ++++++++++++++++++++++++++++-------------------------
>  grep.h | 13 +++++++++++++
>  2 files changed, 41 insertions(+), 25 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 14fe8a0fd2..f4126011c5 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -935,15 +935,6 @@ static void strip_timestamp(const char *bol, const char **eol_p)
>  	}
>  }
>  
> -static struct {
> -	const char *field;
> -	size_t len;
> -} header_field[] = {
> -	{ "author ", 7 },
> -	{ "committer ", 10 },
> -	{ "reflog ", 7 },
> -};
> -
>  static int match_one_pattern(struct grep_pat *p,
>  			     const char *bol, const char *eol,
>  			     enum grep_context ctx,
> @@ -953,18 +944,23 @@ static int match_one_pattern(struct grep_pat *p,
>  	const char *start = bol;
>  
>  	if ((p->token != GREP_PATTERN) &&
> -	    ((p->token == GREP_PATTERN_HEAD) != (ctx == GREP_CONTEXT_HEAD)))
> +	    ((p->token == GREP_PATTERN_HEAD) != (ctx == GREP_CONTEXT_HEAD)) &&
> +	    ((p->token == GREP_PATTERN_BODY) != (ctx == GREP_CONTEXT_BODY)))
>  		return 0;
>  
>  	if (p->token == GREP_PATTERN_HEAD) {
> -		const char *field;
> -		size_t len;
> -		assert(p->field < ARRAY_SIZE(header_field));
> -		field = header_field[p->field].field;
> -		len = header_field[p->field].len;
> -		if (strncmp(bol, field, len))
> -			return 0;
> -		bol += len;
> +		if (!(eflags & REG_NOTBOL)) {
> +			const char *field;
> +			size_t len;
> +
> +			assert(p->field < ARRAY_SIZE(grep_header_fields));
> +			field = grep_header_fields[p->field].field;
> +			len = grep_header_fields[p->field].len;
> +			if (strncmp(bol, field, len))
> +				return 0;
> +			bol += len;
> +		}
> +
>  		switch (p->field) {
>  		case GREP_HEADER_AUTHOR:
>  		case GREP_HEADER_COMMITTER:
>			saved_ch = strip_timestamp(bol, &eol);

Let's first see if we correctly understand how the original was
designed to be used.  It is called once per line, with "bol" set
to the true beginning of the line.

For a line in the header (e.g. "author A U Thor <au@th.or> 12345678
+0000"), therefore, we ensure we are looking at the right type of
the header (e.g. when looking for an "author" line, the line must
begin with "author "), or we return 0 (i.e. does not match).  And
then, for "author" and "committer" line, we adjust the eol to
exclude the timestamp part from pattern the matching by calling
strip_timetamp().

Both of these special case used to be unconditional because we _knew_
that the caller would call this function with "bol" pointing at the
true beginning of the line.

The patch adds a new !(eflags & REG_NOTBOL) guard, presumably
because new callers will start calling this function with "bol" set
to point in the middle of a line?  So we only do the "check the kind
of header and skip a line that records the commiter when we are
looking for an author" part when the guard passes, i.e. we know that
the caller called us with the true beginning of the line in bol.

But how would the new caller that points "bol" at middle of a line
make sure that we are looking at the right kind of header?  If the
pattern p is set to match only for an author line, the first call
with "bol" set to the true beginning of the line will correctly
reject a "committer" header, but because you lost the sanity check
above, the second and subsequent one will go ahead and scan for the
pattern p on the line, even if p->field asks for author line and the
line records the committer.  You'd end up finding a commit object
that is committed by (but not authored by) the person when you are
looking for a commit that was authored by somebody, no?  

If you ask for commits by somebody (e.g. "--author=Hazma") with an
output format that shows both the author and the committer
(e.g. "log --pretty=fuller"), wouldn't your "hit coloring" code
show Hazma on the committer name as a grep hit, too?

Also, because the function is designed to be called with bol and eol
set to true beginning and the end of the line, the strip_timestamp()
side of the logic should also be done only once, but that is not
what is happening in the patch.  Chomping the line immediately after
the last occurrence of '>' is idempotent, so it is OK to have the
logic outside the new !(eflags & REG_NOTBOL) guard, but discarding
the updated eol from the first call and not reusing the result of
the strip_timestamp() in the second and subsequent call smells like
a waste.

I am having a feeling that you'd need to make the caller of this
function (either the direct callers, or you may want to introduce
another layer between the current direct callers and this function)
perform these massaging for the prefix and trailing parts of the
line for GREP_PATTERN_HEAD patterns, so that this function, if you
were to change it to be callable many times starting at a middle of
the line, only needs to care about matching the pattern in the
portion between (bol, eol) and nothing else.

