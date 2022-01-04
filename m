Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C0FC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 01:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiADB4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 20:56:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55874 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiADB4r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 20:56:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 848BF17058E;
        Mon,  3 Jan 2022 20:56:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=kogCGnXN40ypsjacQkfVlcs92QO2AhgegbTCtLQCNeQ=; b=Cw/X
        rLN0iENGk611LzFhxicPqKFnw61ltwDBmfCOVkLYW2w8emYIQsUa/DE82t3KscRN
        X1GJWi8K2+nwIkSDe+yPG+C3ffNblWJ62bYs+jShIVnO5mZ01rsbC9QU3Is945yi
        NIHnyJhXQStqWdpfp+RNHyG9dT2scklkyMfYzW4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CC0F17058D;
        Mon,  3 Jan 2022 20:56:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D533917058B;
        Mon,  3 Jan 2022 20:56:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3] receive-pack.c: consolidate find header logic
References: <pull.1125.v2.git.git.1640758765723.gitgitgadget@gmail.com>
        <pull.1125.v3.git.git.1640931460758.gitgitgadget@gmail.com>
Date:   Mon, 03 Jan 2022 17:56:42 -0800
Message-ID: <xmqq35m4gt5x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9120AB8C-6D01-11EC-BB28-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	size_t out_len;
> +	const char *val = find_header_mem(msg, len, key, &out_len);
> +
> +	if (val == NULL)

Style:

	if (!val)

> +		return NULL;
> +
> +	if (next_line)
> +		*next_line = val + out_len + 1;
> +
> +	return xmemdupz(val, out_len);
>  }
>  
>  /*
> diff --git a/commit.c b/commit.c
> index a348f085b2b..8ac32a4d7b5 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1631,12 +1631,13 @@ struct commit_list **commit_list_append(struct commit *commit,
>  	return &new_commit->next;
>  }
>  
> -const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
> +const char *find_header_mem(const char *msg, size_t len,
> +			const char *key, size_t *out_len)
>  {
>  	int key_len = strlen(key);
>  	const char *line = msg;
>  
> +	while (line && line < msg + len) {
>  		const char *eol = strchrnul(line, '\n');

Between line[0] and msg[len], there may not be a LF nor NUL at all,
and strchrnul() will scan beyond the range we were given (which is
msg[0]..msg[len]).

But that is something we share with the find_header() if I am not
mistaken, so I am OK to leave the code as posted and leave it
outside the scope of this series to clean it up to make it safer.

The reason why it is probably safe for the current set of callers
(and presumably any reasonable new callers we may add later) is that
they computed "len" by scanning the block of memory starting at (or
before) "msg" before calling us, and we know that the block of
memory is properly NUL-terminated.  find_header() is called by
check_nonce() and check_cert_push_options(), both of which tell
us to scan in a strbuf, which is designed to be scannable for NUL
safely by having an extra NUL at the end beyond the end.

