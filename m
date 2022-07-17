Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FB4C433EF
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 22:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiGQWLh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jul 2022 18:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGQWLf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jul 2022 18:11:35 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61FE11441
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 15:11:32 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9CCE13E34E;
        Sun, 17 Jul 2022 18:11:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oW+sFnO5iJ3cwrGdBbdhw0GhAKaYrTzCNPZrTn
        3O610=; b=V7iAoaX2HqiSBfkidGA7QHvCxqa79/21G+KdzB7Waxta0yuB2woDys
        0RvSaOZLRuxhQadAfNx8ngIOrozGWgkNsWc3gkFe2UX7MENzVQjOupCOMag0tAsJ
        3gDvIEw3Ewh8mev0alIcfld8HKwm8ZcU9gdNy9pS6iunkr4s901NM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E03F713E34C;
        Sun, 17 Jul 2022 18:11:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 52CA213E34B;
        Sun, 17 Jul 2022 18:11:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        congdanhqx@gmail.com, christian.couder@gmail.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com
Subject: Re: [PATCH v5 1/4] revision: improve commit_rewrite_person()
References: <20220712160634.213956-1-siddharthasthana31@gmail.com>
        <20220716074055.1786231-1-siddharthasthana31@gmail.com>
        <20220716074055.1786231-2-siddharthasthana31@gmail.com>
Date:   Sun, 17 Jul 2022 15:11:30 -0700
In-Reply-To: <20220716074055.1786231-2-siddharthasthana31@gmail.com>
        (Siddharth Asthana's message of "Sat, 16 Jul 2022 13:10:52 +0530")
Message-ID: <xmqqo7xnv17x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6995894C-061D-11ED-889F-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> +/*
> + * Returns the difference between the new and old length of the ident line.
> + */
> +static ssize_t rewrite_ident_line(const char *person, struct strbuf *buf,
> +								  struct string_list *mailmap)

Line-folding is a good idea, but why do we use such a deep
indentation?  In this project, tab-width is 8.

> +static void commit_rewrite_person(struct strbuf *buf, const char **header,
> +								  struct string_list *mailmap)

Likewise.

> +{
> +	size_t buf_offset = 0;
> +
> +	if (!mailmap)
> +		return;
> +
> +	for (;;) {
> +		const char *person, *line;
> +		size_t i;
> +
> +		line = buf->buf + buf_offset;
> +		if (!*line || *line == '\n')
> +			return; /* End of header */
> +
> +		for (i = 0; header[i]; i++)
> +			if (skip_prefix(line, header[i], &person)) {
> +				rewrite_ident_line(person, buf, mailmap);

If the return value of rewrite_ident_line() is never used, perhaps
stop computing the return value in that function and make it return
"void".  I personally thought it was clever to return "how much does
the ident part grew/shrunk?" from the helper and use it to adjust,
but I do not mind to scrap the clever-ness if some folks may find it
harder to understand.

> +				break;
> +			}
> +
> +		buf_offset = strchrnul(buf->buf + buf_offset, '\n') - buf->buf;

And this is a "easier-to-understand but need to scan the buffer once
again, only to figure out what we ought to already know" version.

> +		if (buf->buf[buf_offset] == '\n')
> +			++buf_offset;

Prefer post-increment when there is no reason to favor pre-increment
over post-increment, i.e. write this as "buf_offset++".

> +	}
> +}
> +
>  static int commit_match(struct commit *commit, struct rev_info *opt)
>  {
>  	int retval;
> @@ -3832,11 +3862,12 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
>  		strbuf_addstr(&buf, message);
>  
>  	if (opt->grep_filter.header_list && opt->mailmap) {
> +		const char *commit_headers[] = { "author ", "committer ", NULL };
> +
>  		if (!buf.len)
>  			strbuf_addstr(&buf, message);
>  
> -		commit_rewrite_person(&buf, "\nauthor ", opt->mailmap);
> -		commit_rewrite_person(&buf, "\ncommitter ", opt->mailmap);
> +		commit_rewrite_person(&buf, commit_headers, opt->mailmap);
>  	}
>  
>  	/* Append "fake" message parts as needed */
