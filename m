Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3106FC433F5
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 22:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhL0Wdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 17:33:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50707 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhL0Wdd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 17:33:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD02D169591;
        Mon, 27 Dec 2021 17:33:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dEVHkHahInSyudsXy0FwdIEdE25NH9uOLItZaF
        6WL3I=; b=j6cb0XRfIsgYaQtvKSvlIkTGBM3C/mNL49glqRjmWkRHIn3zwtNxlU
        I6cixEHawj6tBgsOZMVmSSIF/z/k+5Z/f8MCk7uWwnzGOJ19KLdtq3PZytDsPJHb
        vYp2LezYZ30SEDApZm53aurT7Jy0vaekZpTT9kailuiZOkNPU4L9M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B64AE169590;
        Mon, 27 Dec 2021 17:33:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4046716958E;
        Mon, 27 Dec 2021 17:33:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/2] receive-pack.c: consolidate find header logic
References: <pull.1125.git.git.1640629598.gitgitgadget@gmail.com>
        <9465c20d4bd398dacbd7df2c068513c9ec484dd8.1640629598.git.gitgitgadget@gmail.com>
Date:   Mon, 27 Dec 2021 14:33:25 -0800
In-Reply-To: <9465c20d4bd398dacbd7df2c068513c9ec484dd8.1640629598.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Mon, 27 Dec 2021 18:26:37
        +0000")
Message-ID: <xmqqtuetvft6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 027D8626-6765-11EC-B30E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> There are two functions that have very similar logic of finding a header
> value. find_commit_header, and find_header. We can conslidate the logic

"consolidate".

> by using find_commit_header and replacing the logic in find_header.
> This helps clean up the code, as the logic for finding header values can
> stay in one place.

It does make sense to split the renaming and this change into two
separate steps like this series does.  The renaming done in 2/2
however makes readers wonder if our existing code paths that handle
tag objects becomes cleaner by using the function (and if not, if
the perceived benefit of making it into a more generic name is a
mere mirage), though.

> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  builtin/receive-pack.c | 48 ++++++++++++++++++------------------------
>  commit.c               |  3 ++-
>  2 files changed, 23 insertions(+), 28 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 4f92e6f059d..939d4b28b7c 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -581,32 +581,26 @@ static char *prepare_push_cert_nonce(const char *path, timestamp_t stamp)
>  	return strbuf_detach(&buf, NULL);
>  }
>  
> -/*
> - * NEEDSWORK: reuse find_commit_header() from jk/commit-author-parsing
> - * after dropping "_commit" from its name and possibly moving it out
> - * of commit.c
> - */
> -static char *find_header(const char *msg, size_t len, const char *key,
> -			 const char **next_line)
> +static char *find_header_value(const char *msg, const char *key, const char **next_line)

I do not think this change is quite right.  &msg[len] in the
original may not be the end of a NUL-terminated string, i.e. the
caller does not want this helper to scan through to the end of the
buffer but wants it to stop much earlier at the "len" the caller
specifies.

>  {
> -	int key_len = strlen(key);
> -	const char *line = msg;
> -
> -	while (line && line < msg + len) {
> -		const char *eol = strchrnul(line, '\n');
> -
> -		if ((msg + len <= eol) || line == eol)
> -			return NULL;
> -		if (line + key_len < eol &&
> -		    !memcmp(line, key, key_len) && line[key_len] == ' ') {
> -			int offset = key_len + 1;
> -			if (next_line)
> -				*next_line = *eol ? eol + 1 : eol;
> -			return xmemdupz(line + offset, (eol - line) - offset);
> -		}
> -		line = *eol ? eol + 1 : NULL;
> +	size_t out_len;
> +	const char *eol;
> +	char *ret;
> +
> +	const char *val = find_commit_header(msg, key, &out_len);
> +	if (val == NULL)
> +		return NULL;
> +
> +	eol = strchrnul(val, '\n');
> +	if (next_line) {
> +		*next_line = *eol ? eol + 1: eol;

Also, find_commit_header() has already figured out what the next
line should be.  If it is not just telling us, we are forced to
recompute it with an extra strchrnul(), but is that really the case?

HOWEVER.

Doesn't out_len have enough information to let us compute next_line
without scanning the line again?

> -	return NULL;
> +
> +	ret = xmalloc(out_len+1);
> +	memcpy(ret, val, out_len);
> +	ret[out_len] = '\0';

In any case, it is not necessary to open code xmemdupz() into these
three lines, no?
