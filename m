Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA71C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 23:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbhL3XBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 18:01:18 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56685 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhL3XBR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 18:01:17 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 773C118118B;
        Thu, 30 Dec 2021 18:01:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PTHI+qtP+wOr68rcVUFZAN9g7Pq3ht0i52LmqJ
        Q75Ag=; b=FeVD7p8SQlK5F7PTHXyXykOlQ/4yNwI8GWIf9/GovGsoN1B4CDy6kb
        1jPQSPcZCqJJZauNBWlgB1yug6zR/G0mBBFZe3gbMoJMLHLidi1Uv8Rn1vYXzsHu
        BDQSPcoOTpDf2I1nGysR08Hnkg67rKSuxR7ZrAl5Htn70+y3uxi58=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 55F9618118A;
        Thu, 30 Dec 2021 18:01:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9147D181187;
        Thu, 30 Dec 2021 18:01:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2] receive-pack.c: consolidate find header logic
References: <pull.1125.git.git.1640629598.gitgitgadget@gmail.com>
        <pull.1125.v2.git.git.1640758765723.gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 15:01:12 -0800
In-Reply-To: <pull.1125.v2.git.git.1640758765723.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Wed, 29 Dec 2021 06:19:25 +0000")
Message-ID: <xmqq1r1tofyf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62F11A52-69C4-11EC-8173-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> There are two functions that have very similar logic of finding a header
> value. find_commit_header, and find_header. We can conslidate the logic
> by using find_commit_header and replacing the logic in find_header.
>
> Introduce a new function find_header_max, which is equivalent to
> find_commit_header except it takes a len parameter that determines how
> many bytes to read. find_commit_header can then call find_header_max
> with 0 as the len.

find_header_max() is not the name of the function that finds the
largest header?  That is misleading.

<git-compat-util.h> defines a few helper functions that take a
counted string, and they are named with _mem() suffix after the name
of their NUL-terminated counterparts (if exists).  skip_prefix() has
skip_prefix_mem(), strip_suffix() has strip_suffix_mem().

find_header_mem() or something along that line, perhaps?

> diff --git a/commit.c b/commit.c
> index a348f085b2b..2ed115e04a0 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1631,12 +1631,14 @@ struct commit_list **commit_list_append(struct commit *commit,
>  	return &new_commit->next;
>  }
>  
> -const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
> +const char *find_header_max(const char *msg, const char *key,
> +			size_t len,
> +			size_t *out_len)

If <len> is meant to be the length part of <ptr,len> pair, we should
have it immediately after the <ptr> parameter.

	find_header_mem(const char *msg, size_t len,
        		const char *key, size_t *out_len)

That makes it clear to the readers that <msg, len> are close friends.

Also, I have a feeling that ...

>  {
>  	int key_len = strlen(key);
>  	const char *line = msg;
>  
> -	while (line) {
> +	while (line && (len == 0 || line < msg + len)) {

... we do not want this special casing of "if !len".  By making the
caller responsible to _always_ supply the length of msg, we can lose
the conditional.

>  		const char *eol = strchrnul(line, '\n');
>  
>  		if (line == eol)
> @@ -1653,6 +1655,10 @@ const char *find_commit_header(const char *msg, const char *key, size_t *out_len
>  	return NULL;
>  }
>  
> +const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
> +{
> +	return find_header_max(msg, key, 0, out_len);

I.e. find_header_mem(msg, strlen(msg), key, out_len);

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 9f4a0b816cf..b69ead8dcda 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -581,32 +581,19 @@ static char *prepare_push_cert_nonce(const char *path, timestamp_t stamp)
>  	return strbuf_detach(&buf, NULL);
>  }
>  
> -/*
> - * NEEDSWORK: reuse find_commit_header() from jk/commit-author-parsing
> - * after dropping "_commit" from its name and possibly moving it out
> - * of commit.c
> - */
>  static char *find_header(const char *msg, size_t len, const char *key,
>  			 const char **next_line)
>  {
> +	size_t out_len;
> +	const char *val = find_header_max(msg, key, len, &out_len);
> +
> +	if (val == NULL)
> +		return NULL;
> +
> +	if (next_line)
> +		*next_line = val + out_len + 1;
> +
> +	return xmemdupz(val, out_len);
>  }

Yup, something along that line.  Note that find_header() does make
it clear that the <msg, len> parameters form a pair.  We want to do
the same for the new helper.
