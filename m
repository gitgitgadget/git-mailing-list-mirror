Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A177C537FC
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JGQZN7kG"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D9BA1D3DE8;
	Thu, 11 Jan 2024 18:00:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uZJnlpuPaxRgaAJHHUQVBx0ybEFN40A+lHXkLa
	fddMc=; b=JGQZN7kG4Ib6jX3bwwovLTq12S5lQRGi5sp+0mZtwWa9egWFx3dNMa
	LK/6HUUBp+uNQA1pgyhfS6TDJUH04YbGgKRGbGq8UZQSdrE67Re9OBC6i1cYBZzv
	UHjHdlRVTAa3YE2Fx8Lnde5Mx5hxsYa7Tl5pklOE/xCcyBmgsb6Yo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3219E1D3DE5;
	Thu, 11 Jan 2024 18:00:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 823B61D3DE4;
	Thu, 11 Jan 2024 18:00:24 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] diffcore-delta: avoid ignoring final 'line' of file
In-Reply-To: <pull.1637.git.1705006074626.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Thu, 11 Jan 2024 20:47:54
	+0000")
References: <pull.1637.git.1705006074626.gitgitgadget@gmail.com>
Date: Thu, 11 Jan 2024 15:00:23 -0800
Message-ID: <xmqqedenearc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3435DB30-B0D5-11EE-92CE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/diffcore-delta.c b/diffcore-delta.c
> index c30b56e983b..7136c3dd203 100644
> --- a/diffcore-delta.c
> +++ b/diffcore-delta.c
> @@ -159,6 +159,10 @@ static struct spanhash_top *hash_chars(struct repository *r,
>  		n = 0;
>  		accum1 = accum2 = 0;
>  	}
> +	if (n > 0) {
> +		hashval = (accum1 + accum2 * 0x61) % HASHBASE;
> +		hash = add_spanhash(hash, hashval, n);
> +	}

OK, so we were ignoring the final short bit that is not terminated
with LF due to the "continue".  Nicely found.

> diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
> index 85be1367de6..29299acbce7 100755
> --- a/t/t4001-diff-rename.sh
> +++ b/t/t4001-diff-rename.sh
> @@ -286,4 +286,23 @@ test_expect_success 'basename similarity vs best similarity' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'last line matters too' '
> +	test_write_lines a 0 1 2 3 4 5 6 7 8 9 >nonewline &&
> +	printf "git ignores final up to 63 characters if not newline terminated" >>nonewline &&
> +	git add nonewline &&
> +	git commit -m "original version of file with no final newline" &&

I found it misleading that the file whose name is nonewline has
bunch of LF including on its last line ;-).

> +	# Change ONLY the first character of the whole file
> +	test_write_lines b 0 1 2 3 4 5 6 7 8 9 >nonewline &&

Same here, but it is too much to bother rewriting it ...

	{
		test_write_lines ...
		printf ...
	} >incomplete

... like so ("incomplete" stands for "file ending with an incomplete line"),
so I'll let it pass.

> +	printf "git ignores final up to 63 characters if not newline terminated" >>nonewline &&


> +	git add nonewline &&
> +	git mv nonewline still-no-newline &&
> +	git commit -a -m "rename nonewline -> still-no-newline" &&
> +	git diff-tree -r -M01 --name-status HEAD^ HEAD >actual &&
> +	cat >expected <<-\EOF &&
> +	R097	nonewline	still-no-newline

I am not very happy with the hardcoded 97.  You are already using
the non-standard 10% threshold.  If the delta detection that
forgets about the last line is so broken as your proposed log
message noted, shouldn't you be able to construct a sample pair of
preimage and postimage for which the broken version gives so low
similarity to be judged not worth treating as a rename, while the
fixed version gives reasonable similarity to be made into a rename,
by the default threshold?  That way, the test only needs to see if
we got a rename (with any similarity) or a delete and an add.
