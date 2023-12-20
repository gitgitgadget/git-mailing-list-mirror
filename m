Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283634879E
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i7bKoJK1"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 57BFB2F75A;
	Wed, 20 Dec 2023 15:07:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TdRE0btRIu6L7/gVTLv7gqrpTNzBMsVLEzPCxl
	urOtE=; b=i7bKoJK1hhiaYS7pTLPz62NKkSaz2T49cHjgjvCX5KjYSIpu4CWrSk
	sOjXwpwBxwborEEUOOTArJ77GTeHG+4N12rOpdJFdJJ8efCc03l2b1scBZ/W427E
	iPnMW7ckCk+hKlzMkhwpG++6oMJrf6YfpwYmfdKTHjVRKDWQRwl8Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3B0132F759;
	Wed, 20 Dec 2023 15:07:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D62422F758;
	Wed, 20 Dec 2023 15:07:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Joanna Wang <jojwang@google.com>,  sunshine@sunshineco.com,  tboegi@web.de
Subject: Re: [PATCH 1/1] attr: add builtin objectmode values support
In-Reply-To: <xmqqedfrovsb.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	12 Dec 2023 15:17:40 -0800")
References: <xmqqttpmtnn5.fsf@gitster.g>
	<20231116054437.2343549-1-jojwang@google.com>
	<xmqqsf56ql14.fsf@gitster.g> <xmqqil62qfvr.fsf@gitster.g>
	<CAMmZTi-U_ufzoBLCDWKbrf=3GZzGszxnM1_Pu6ufBeoYjj7Gdw@mail.gmail.com>
	<xmqqedfrovsb.fsf@gitster.g>
Date: Wed, 20 Dec 2023 12:07:12 -0800
Message-ID: <xmqq5y0ssknj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5DCE803C-9F73-11EE-886A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> The attached is one possible way to plug the leak; I am not sure if
> it is the best one, though.  One thing I like about the solution is
> that the approach makes sure that the mode attributes we would ever
> return are very tightly controlled and does not allow a buggy code
> to come up with "mode" to be passed to this new helper function to
> pass random and unsupported mode bits without triggering the BUG().
>
>  attr.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)

Anybody who want to propose a better leakfix (we cannot afford to do
with UNLEAK() as the number of leaked mode string will be unbounded)?

Otherwise, I'll squash it in to Jonanna's patch and merge it down to
'next'.

Thanks.

> diff --git c/attr.c w/attr.c
> index b03c20f768..679e42258c 100644
> --- c/attr.c
> +++ w/attr.c
> @@ -1250,10 +1250,34 @@ static struct object_id *default_attr_source(void)
>  	return &attr_source;
>  }
>  
> +static const char *interned_mode_string(unsigned int mode)
> +{
> +	static struct {
> +		unsigned int val;
> +		char str[7];
> +	} mode_string[] = {
> +		{ .val = 0040000 },
> +		{ .val = 0100644 },
> +		{ .val = 0100755 },
> +		{ .val = 0120000 },
> +		{ .val = 0160000 },
> +	};
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mode_string); i++) {
> +		if (mode_string[i].val != mode)
> +			continue;
> +		if (!*mode_string[i].str)
> +			snprintf(mode_string[i].str, sizeof(mode_string[i].str),
> +				 "%06o", mode);
> +		return mode_string[i].str;
> +	}
> +	BUG("Unsupported mode 0%o", mode);
> +}
> +
>  static const char *builtin_object_mode_attr(struct index_state *istate, const char *path)
>  {
>  	unsigned int mode;
> -	struct strbuf sb = STRBUF_INIT;
>  
>  	if (direction == GIT_ATTR_CHECKIN) {
>  		struct object_id oid;
> @@ -1287,8 +1311,8 @@ static const char *builtin_object_mode_attr(struct index_state *istate, const ch
>  		else
>  			return ATTR__UNSET;
>  	}
> -	strbuf_addf(&sb, "%06o", mode);
> -	return strbuf_detach(&sb, NULL);
> +
> +	return interned_mode_string(mode);
>  }
>  
>  
