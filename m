Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039804689
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 02:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LPG5kpQO"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9364510A
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 18:21:34 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 15A671BAE1;
	Mon,  6 Nov 2023 21:21:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zvhhroxn+MRLU+p1pXf0xNV7uAZ0WUgfUvLdUU
	q3tSs=; b=LPG5kpQOv4hcB9LrhZkoq5Mz0Fm26g2IbFaUI9/mIhKHvM8lHNaTZO
	K3p8RvtZkxVTn/szDCAZjPr9eAXb59Os4XHnkoDnnhyipGAmtko9ngiRRao0Ffd2
	2POVYP3/VAifBwdKL1jWfl3oIwnEWQ2zfbapVxGjTTzb8biUF8yBA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E02C1BAE0;
	Mon,  6 Nov 2023 21:21:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A1A791BAD0;
	Mon,  6 Nov 2023 21:21:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] list-objects: drop --unpacked non-commit objects
 from results
In-Reply-To: <d3992c98aaa54c3635c249a15d919aa1177324d8.1699311386.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 6 Nov 2023 17:56:30 -0500")
References: <cover.1699311386.git.me@ttaylorr.com>
	<d3992c98aaa54c3635c249a15d919aa1177324d8.1699311386.git.me@ttaylorr.com>
Date: Tue, 07 Nov 2023 11:21:29 +0900
Message-ID: <xmqq7cmub8wm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5CEAC6F2-7D14-11EE-9856-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Subject: Re: [PATCH 1/2] list-objects: drop --unpacked non-commit objects from results

I thought the purpose of this change is to make sure that we drop
packed objects from results when --unpacked is given?  This makes
it sound as if we are dropping unpacked ones instead?  I dunno.

> In git-rev-list(1), we describe the `--unpacked` option as:
>
>     Only useful with `--objects`; print the object IDs that are not in
>     packs.
>
> This is true of commits, which we discard via get_commit_action(), but
> not of the objects they reach. So if we ask for an --objects traversal
> with --unpacked, we may get arbitrarily many objects which are indeed
> packed.

Strictly speaking, as long as all the objects that are not in packs
are shown, "print the object IDs that are not in packs" is satisfied.
With this fix, perhaps we would want to tighten the explanation a
little bit while we are at it.  Perhaps

	print the object names but exclude those that are in packs

or something along that line?

> diff --git a/list-objects.c b/list-objects.c
> index c25c72b32c..c8a5fb998e 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -39,6 +39,9 @@ static void show_object(struct traversal_context *ctx,
>  {
>  	if (!ctx->show_object)
>  		return;
> +	if (ctx->revs->unpacked && has_object_pack(&object->oid))
> +		return;
> +
>  	ctx->show_object(object, name, ctx->show_data);
>  }

The implementation is as straight-forward as it can get.  Very
pleasing.

> diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
> index 12def7bcbf..6289a2e8b0 100755
> --- a/t/t6000-rev-list-misc.sh
> +++ b/t/t6000-rev-list-misc.sh
> @@ -169,4 +169,17 @@ test_expect_success 'rev-list --count --objects' '
>  	test_line_count = $count actual
>  '
>  
> +test_expect_success 'rev-list --unpacked' '
> +	git repack -ad &&
> +	test_commit unpacked &&
> +
> +	git rev-list --objects --no-object-names unpacked^.. >expect.raw &&
> +	sort expect.raw >expect &&
> +
> +	git rev-list --all --objects --unpacked --no-object-names >actual.raw &&
> +	sort actual.raw >actual &&
> +
> +	test_cmp expect actual
> +'
> +
>  test_done
