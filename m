Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8AFC433F5
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 23:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359474AbhK1Xb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 18:31:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65332 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359483AbhK1X33 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 18:29:29 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51BB71062A9;
        Sun, 28 Nov 2021 18:26:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JIwft7SNgiqkFtt2KmT127RjXZluvMsA/NLAIe
        PvDE4=; b=FdgQdx0RfxV+zUk/2Y3bxBvRgMb2xQFhEHGI4AagxXG1UJlBntQZDD
        W7y/GEjpiBbK4eBH8LmXl2VhJ8I0QudW3h2wBp7QmxUxX57XD/gG8kUmUzKBx4Kt
        y3U27UhQ5gZ6O5t51gsHLo/aLsNtimT09pOUHStZjQUKWSBfWtHXs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 482E41062A8;
        Sun, 28 Nov 2021 18:26:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B3D681062A7;
        Sun, 28 Nov 2021 18:26:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Subject: Re: git diff -I<regex> does not work with empty +/- lines
References: <20211128091521.7ysocurtt4qlgcf6@gmail.com>
Date:   Sun, 28 Nov 2021 15:26:10 -0800
In-Reply-To: <20211128091521.7ysocurtt4qlgcf6@gmail.com> (Johannes
        Altmanninger's message of "Sun, 28 Nov 2021 10:15:21 +0100")
Message-ID: <xmqqtufv50bx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92AF4CCC-50A2-11EC-86B3-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

> diff -I<regex> suppresses hunks where all +/- lines match <regex>.
> it is useful to filter away boilerplate changes.
>
> Unfortunately, it doesn't help if a hunk has a blank line, because the one
> obvious way to filter out blank lines (^$) match *every* line, surprisingly.
> This is because for a line "01\n"
> we have a zero-width match here ^$ (offset 3).
>
> IOW, while we succesfully ignore deleted blank lines
>
> 	printf '\n' | git diff --no-index - /dev/null -I'^$'
> 	diff --git a/- b/-
> 	deleted file mode 100644
>
> we also ignore non-blank lines (very surprising)
>
> 	printf 'non-blank-line\n' | git diff --no-index - /dev/null -I'^$'
> 	diff --git a/- b/-
> 	deleted file mode 100644
>
> unless they don't end in a newline (special case)
>
> 	printf 'line without ending newline' | git diff --no-index - /dev/null -I'^$'
> 	diff --git a/- b/-
> 	deleted file mode 100644
> 	--- a/-
> 	+++ /dev/null
> 	@@ -1 +0,0 @@
> 	-line without ending newline
> 	\ No newline at end of file
>
> This patch fixes the second example. Is this the right direction?

I do not know where in the code the breakage in the first example
comes from.  It sounds like a bug if a pattern is not matched
honoring the anchor, whether the beginning-of-line "^" or the
end-of-line "$" one.

> Do we want to honor core.eol, so we preserve the \r when we have Unix endings?

Absolutely.  I think the code paths that work on blob data (i.e. Git
internal, before the smudge operation is applied to externalize it
to a working tree file) should only consider LF as the end of line
(and any existing code that doesn't is a bug).

> In any case -I<regex> won't be able to discern between "line\n" and "line"
> but that's not important to me.
>
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index a4542c05b6..23325022b9 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -1016,10 +1016,17 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
>  static int record_matches_regex(xrecord_t *rec, xpparam_t const *xpp) {
>  	regmatch_t regmatch;
>  	int i;
> +	const char *end = rec->ptr + rec->size;
> +
> +	if (rec->size >= 2 && end[-2] == '\r' && end[-1] == '\n') {
> +		end -= 2;
> +	} else if (rec->size && end[-1] == '\n') {
> +		end -= 1;
> +	}
>  
>  	for (i = 0; i < xpp->ignore_regex_nr; i++)
> -		if (!regexec_buf(xpp->ignore_regex[i], rec->ptr, rec->size, 1,
> -				 &regmatch, 0))
> +		if (!regexec_buf(xpp->ignore_regex[i], rec->ptr,
> +				 end - rec->ptr, 1, &regmatch, 0))
>  			return 1;
>  
>  	return 0;
