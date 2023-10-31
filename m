Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E65DCA7C
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 05:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pNpYQiMw"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFB0B7
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 22:19:35 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 67ABB2162C;
	Tue, 31 Oct 2023 01:19:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=O1ImjWHVhCWN19RFIG+z7Z1zAualMyL1cie2kk
	kUC2Q=; b=pNpYQiMwbRhYWmlQUF1ug0RybZLO4PttjbACmqAlt2JfwahURXV7SA
	yZjaXyhI/8SYjzv0t0LvD08oeNTNnKVzrqMqUcuarKyjzO8RW9lq3z6MsDAWHp2d
	U2LckMrFcjYtzfzsWenW5Wz6gBFNf4fHsA1mRz3cH//e1siw3gY7c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 608C92162B;
	Tue, 31 Oct 2023 01:19:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7FD952162A;
	Tue, 31 Oct 2023 01:19:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Dragan
 Simic <dsimic@manjaro.org>
Subject: Re: [RFC PATCH 2/3] strbuf_commented_addf(): drop the
 comment_line_char parameter
In-Reply-To: <bb01336233b30d46960d6eb15f036e6346a9cd2b.1698696798.git.jonathantanmy@google.com>
	(Jonathan Tan's message of "Mon, 30 Oct 2023 13:22:47 -0700")
References: <db6702ba-11a7-44c1-af2a-95b080aaeb77@gmail.com>
	<cover.1698696798.git.jonathantanmy@google.com>
	<bb01336233b30d46960d6eb15f036e6346a9cd2b.1698696798.git.jonathantanmy@google.com>
Date: Tue, 31 Oct 2023 14:19:31 +0900
Message-ID: <xmqqh6m74bdo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 12E96C1E-77AD-11EE-8475-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jonathan Tan <jonathantanmy@google.com> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> All the callers of this function supply the global variable
> comment_line_char as an argument to its second parameter.  Remove
> the parameter to allow us in the future to change the reference to
> the global variable with something else, like a function call.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---

> diff --git a/environment.c b/environment.c
> index bb3c2a96a3..d9f64cffa0 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -416,3 +416,21 @@ int print_sha1_ellipsis(void)
>  	}
>  	return cached_result;
>  }
> +
> +void strbuf_commented_addf(struct strbuf *sb,
> +			   const char *fmt, ...)
> +{
> +	va_list params;
> +	struct strbuf buf = STRBUF_INIT;
> +	int incomplete_line = sb->len && sb->buf[sb->len - 1] != '\n';
> +
> +	va_start(params, fmt);
> +	strbuf_vaddf(&buf, fmt, params);
> +	va_end(params);
> +
> +	strbuf_add_commented_lines(sb, buf.buf, buf.len, comment_line_char);
> +	if (incomplete_line)
> +		sb->buf[--sb->len] = '\0';
> +
> +	strbuf_release(&buf);
> +}

This moving of the helper function does not belong to the "fix
commented_addf() not to take the comment_line_char" step.

The series should be restructured to have the two patches from me
first, and then your moving some stuff to environment.c, probably.
