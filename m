Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B90C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 21:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbiGNVCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 17:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiGNVCz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 17:02:55 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB366C109
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:02:53 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A8A5144B60;
        Thu, 14 Jul 2022 17:02:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KfhFoiohsxVtMVvx7g0DT8xVPcL08lftg8fCWa
        pQE/w=; b=UmnL0/XG3HnmfyFdG4DgSC7QTQvXxIobi5ke4TB2aCg4ka8Fd1Dccx
        9imI50Q3+SuYVVPvupT/3fdhnIAc45NjH0rQwn6+giGREyvvO6dbhaHLUhtor5A8
        L/SAvzofY9D4jGkj5xI7P9+7mUlpMvPt+YMiMWD9S9PvAuP0+jfrQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90255144B5F;
        Thu, 14 Jul 2022 17:02:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DACE4144B5D;
        Thu, 14 Jul 2022 17:02:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        congdanhqx@gmail.com, christian.couder@gmail.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com
Subject: Re: [PATCH v4 1/4] revision: improve commit_rewrite_person()
References: <20220709154149.165524-1-siddharthasthana31@gmail.com>
        <20220712160634.213956-1-siddharthasthana31@gmail.com>
        <20220712160634.213956-2-siddharthasthana31@gmail.com>
Date:   Thu, 14 Jul 2022 14:02:50 -0700
In-Reply-To: <20220712160634.213956-2-siddharthasthana31@gmail.com> (Siddharth
        Asthana's message of "Tue, 12 Jul 2022 21:36:31 +0530")
Message-ID: <xmqq8rov4dc5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52F7AE8E-03B8-11ED-86A2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> +/*
> + * Returns the difference between the new and old length of the ident line.
> + */
> +static ssize_t rewrite_ident_line(const char* person, struct strbuf *buf, struct string_list *mailmap)

"const char *person".  Asterisk sticks to the variable, not to the
type.

Wrap such an overly long line.

> +static void commit_rewrite_person(struct strbuf *buf, const char **headers, struct string_list *mailmap)

Likewise.

The second parameter should be called "header", not "headers",
because the way this array is used is primarily to access its
individual members, i.e. header[i] and it is more grammatical
to say that header[0] is the zero-th header, not headers[0].

> +{
> +	size_t buf_offset = 0;
> +
> +	if (!mailmap)
> +		return;
> +
> +	for (;;) {
> +		const char *person, *line;
> +		size_t i, linelen;
> +
> +		line = buf->buf + buf_offset;

buf_offset is initialized to 0.  The idea is to keep track of the
position of the current line in buf->buf as the byte offset from the
beginning.  This makes it safe to let rewrite_ident_line()
reallocate buf->buf in the loop.  So "line" points at the beginning
of the current line.

> +		linelen = strchrnul(line, '\n') - line + 1;

This "linelen" counts the LF (or NUL) termination.  Hence ...

> +		if (linelen <= 1)
> +			/* End of header */
> +			return;

... linelen==0 means we are at an empty line.

> +		buf_offset += linelen;

And by adding linelen to buf_offset, we prepare buf_offset to point
at the beginning of the next line.

BUT.

What happens when the buffer has only headers, no body, without an
empty line after the header?  buf_offset will be pointing at the
byte past the final NUL at the end of the buffer.  The next round of
the loop will point line at an invalid piece of memory.

I _think_ that the current generation of high-level tools like "git
commit" and "git tag" may leave an blank line at the end even when
they are told to create a message with no body, but this code should
not depend on that.  An object with no body and without a blank line
after the header is a valid object (cf. fsck.c::verify_headers()).

> +		for (i = 0; headers[i]; i++)
> +			if (skip_prefix(line, headers[i], &person))
> +				buf_offset += rewrite_ident_line(person, buf, mailmap);
> +	}

As the commit_headers[] array the caller gives us does not have
duplicates, as soon as we find a match, we should break out of the
loop, i.e.

		for (i = 0; header[i]; i++) {
			if (skip_prefix(line, header[i], &person))
				buf_offset += rewrite_ident_line(person, buf, maimap);
			break;
		}

> +}
> +
>  static int commit_match(struct commit *commit, struct rev_info *opt)
>  {
>  	int retval;
> @@ -3832,11 +3859,12 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
>  		strbuf_addstr(&buf, message);
>  
>  	if (opt->grep_filter.header_list && opt->mailmap) {
> +		const char *commit_headers[] = { "author ", "committer ", NULL };

It is OK to call the array "commit_headers", because the way we use
the identifier is only to refer to the collection of headers as a
whole.

>  		if (!buf.len)
>  			strbuf_addstr(&buf, message);
>  
> -		commit_rewrite_person(&buf, "\nauthor ", opt->mailmap);
> -		commit_rewrite_person(&buf, "\ncommitter ", opt->mailmap);
> +		commit_rewrite_person(&buf, commit_headers, opt->mailmap);
>  	}
>  
>  	/* Append "fake" message parts as needed */

Thanks.
