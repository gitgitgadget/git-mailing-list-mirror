Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE31DC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 00:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B14611CE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 00:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbhI1AFP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:05:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57509 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhI1AFP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 20:05:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BA86D9608;
        Mon, 27 Sep 2021 20:03:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=G/rGekkdB6pyf0JSUSoIyvf0tjppAp55DzZoYu2A4BQ=; b=Z7d8
        TQJpi5ccCi+Z7aC8nW+5qZrMEzxujJH6Uf1as7RUQTMUindjfNW7sl2J95RdbzSq
        XR+VOh52eziqHJKUNe+Mu/H1Y7L7Ls80nvlWLqqh10qhEO3mJy8gVOTTfzb7hSFp
        OtTpzG8N7icikbQPH4+1P69fbGdTG/eIiS/f8lA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13482D9607;
        Mon, 27 Sep 2021 20:03:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E09FD9606;
        Mon, 27 Sep 2021 20:03:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v8 2/2] pretty: colorize pattern matches in commit messages
References: <20210924155000.1259649-1-someguy@effective-light.com>
        <20210924155000.1259649-2-someguy@effective-light.com>
Date:   Mon, 27 Sep 2021 17:03:34 -0700
Message-ID: <xmqqilylmuqx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8678660C-1FEF-11EC-A631-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hamza Mahfooz <someguy@effective-light.com> writes:

> +static void append_line_with_color(struct strbuf *sb, struct grep_opt *opt,
> +				   const char *line, size_t linelen,
> +				   int color, enum grep_context ctx,
> +				   enum grep_header_field field)
> +{
> +	const char *buf, *eol, *line_color, *match_color;
> +	regmatch_t match;
> +	int eflags = 0;
> +
> +	buf = line;
> +	eol = buf + linelen;
> +
> +	if (!opt || !want_color(color) || opt->invert)
> +		goto end;
> +
> +	line_color = opt->colors[GREP_COLOR_SELECTED];
> +	match_color = opt->colors[GREP_COLOR_MATCH_SELECTED];
> +
> +	while (grep_next_match(opt, buf, eol, ctx, &match, field, eflags)) {

So, this expects <buf, eol> to be only payload without "author " or
timestamp, ...

>  	} else {
> -		strbuf_addf(sb, "%s: %.*s%.*s <%.*s>\n", what,
> -			    (pp->fmt == CMIT_FMT_FULLER) ? 4 : 0, "    ",
> -			    (int)namelen, namebuf, (int)maillen, mailbuf);
> +		struct strbuf id = STRBUF_INIT;
> +		enum grep_header_field field = GREP_HEADER_FIELD_MAX;
> +		struct grep_opt *opt = pp->rev ? &pp->rev->grep_filter : NULL;
> +
> +		if (!strcmp(what, "Author"))
> +			field = GREP_HEADER_AUTHOR;
> +		else if (!strcmp(what, "Commit"))
> +			field = GREP_HEADER_COMMITTER;
> +
> +		strbuf_addf(sb, "%s: ", what);
> +		if (pp->fmt == CMIT_FMT_FULLER)
> +			strbuf_addchars(sb, ' ', 4);
> +
> +		strbuf_addf(&id, "%.*s <%.*s>", (int)namelen, namebuf,
> +			    (int)maillen, mailbuf);
> +
> +		append_line_with_color(sb, opt, id.buf, id.len, pp->color,
> +				       GREP_CONTEXT_HEAD, field);

... which is exactly what this caller is doing.

Very nice.
