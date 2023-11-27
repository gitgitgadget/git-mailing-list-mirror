Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DyL4ll9e"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB782CB
	for <git@vger.kernel.org>; Sun, 26 Nov 2023 17:51:05 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6415230069;
	Sun, 26 Nov 2023 20:51:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+YjQvU+bpUNnU3xfadUf+QfAJ1uBTxzkWDdc26
	WvWpg=; b=DyL4ll9eUSmwCnev8YxpLorZz+4jq2MXLKc08ZTZSyT6wwLxcYyhxW
	yacTwifAKohwztSodPXHUeL9vJf5ik1RLFsRlk8tVNEHkTSiF0FMtVN5r04zluoG
	wVg4bnfXtMdF6bFrEOY+GUJ9KJtczjBXuezOVQDasVJkWS2aboyrc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C7B030068;
	Sun, 26 Nov 2023 20:51:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F0F2330066;
	Sun, 26 Nov 2023 20:51:01 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Willem Verstraeten <willem.verstraeten@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] checkout: forbid "-B <branch>" from touching a
 branch used elsewhere
In-Reply-To: <bf848477-b4dd-49d3-8e4b-de0fc3948570@gmail.com> (Phillip Wood's
	message of "Thu, 23 Nov 2023 16:33:11 +0000")
References: <CAGX9RpFMCVLQV7RbK2u9AabusvkZD+RZNv_UD=R00cSUrjutBg@mail.gmail.com>
	<xmqqjzq9cl70.fsf@gitster.g> <xmqqv89tau3r.fsf@gitster.g>
	<xmqqpm01au0w.fsf_-_@gitster.g>
	<bf848477-b4dd-49d3-8e4b-de0fc3948570@gmail.com>
Date: Mon, 27 Nov 2023 10:51:00 +0900
Message-ID: <xmqqwmu42ccb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6B33F4AA-8CC7-11EE-8EB2-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index b4ab972c5a..8a8ad23e98 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -1600,6 +1600,13 @@ static int checkout_branch(struct checkout_opts *opts,
>>   	if (new_branch_info->path && !opts->force_detach && !opts->new_branch)
>>   		die_if_switching_to_a_branch_in_use(opts, new_branch_info->path);
>>   +	/* "git checkout -B <branch>" */
>> +	if (opts->new_branch_force) {
>> +		char *full_ref = xstrfmt("refs/heads/%s", opts->new_branch);
>> +		die_if_switching_to_a_branch_in_use(opts, full_ref);
>> +		free(full_ref);
>
> At the moment this is academic as neither of the test scripts changed
> by this patch are leak free and so I don't think we need to worry
> about it but it raises an interesting question about how we should
> handle memory leaks when dying. Leaving the leak when dying means that
> a test script that tests an expected failure will never be leak free
> but using UNLEAK() would mean we miss a leak being introduced in the
> successful case should the call to "free()" ever be removed.

Is there a leak here?  The piece of memory is pointed at by an on-stack
variable full_ref when leak sanitizer starts scanning the heap and
the stack just before the process exits due to die, so I do not see
a reason to worry about this particular variable over all the other
on stack variables we accumulated before the control reached this
point of the code.

Are you worried about optimizing compilers that behave more cleverly
than their own good to somehow lose the on-stack reference to
full_ref while calling die_if_switching_to_a_branch_in_use()?  We
might need to squelch them with UNLEAK() but that does not mean we
have to remove the free() we see above, and I suspect a more
productive use of our time to solve that issue is ensure that our
leak-sanitizing build will not triger such an unwanted optimization
anyway.

Thanks.
