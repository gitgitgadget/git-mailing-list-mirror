Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9567F73163
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390373; cv=none; b=DyUzNYZiofJhtQ7vaZZFB/VIBjPqwzYU3bwrzUGDtORMEllagiJ0ZNdhreg41zqbbG0jHD9ZoinDfsJK7i+3Wu6RsImqRv14bmriNu2IYcct5zQEEcJcUAZvmQ4WJJYxtvOqf1/jSLZMWBa79jFt4HrVNyPB8hJm9M/EYC3qJOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390373; c=relaxed/simple;
	bh=v17pTs/G5Aox01z+cboI3ntshR0SHRQ08GHmOePgR9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iWdZirZANOdtFw41rso0BDWscUzTi6vHbuF3bzRg8BTkgsGgCl+Elq7KrPtIdQj9EI0ftvT5GdHobQb7eD+SSCBvwMgIiP+MgpbarTe0GWTI1DrPvHwFnH4qhtM8C75ZhXnVEnOUAowVsGtqk4K17nF7ZR49Bp+ql7l4r9K5084=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mzeVLyEe; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mzeVLyEe"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E4340264B1;
	Mon, 25 Mar 2024 14:12:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=v17pTs/G5Aox01z+cboI3ntshR0SHRQ08GHmOe
	PgR9A=; b=mzeVLyEeksZbDR6OpzJuGV+AjQDzGjUPWzW/m2L8bKlWrzF3Yk95mW
	peGAr9iGu2nzD7suprMVeaFBsHcxm87Qntvz27mJLJasm21sLWMabvgdnBhLBfy/
	WiWjoge6IJ+D7r9oj8efzCzNsRV0Yh1d7fv8xCNzssEyhMyXFyvNk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DCD92264B0;
	Mon, 25 Mar 2024 14:12:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6D8E1264A9;
	Mon, 25 Mar 2024 14:12:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Brian Lyles <brianmlyles@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] pretty: find pretty formats case-insensitively
In-Reply-To: <20240325061452.GA242093@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 25 Mar 2024 02:14:52 -0400")
References: <20240324214316.917513-1-brianmlyles@gmail.com>
	<20240325061452.GA242093@coredump.intra.peff.net>
Date: Mon, 25 Mar 2024 11:12:45 -0700
Message-ID: <xmqqmsqmkwo2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 48C06D62-EAD3-11EE-B01B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> The mention of "recursive" in the function we call made me what wonder
> if we'd need more normalization. And I think we do. Try this
> modification to your test:
>
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index 321e305979..be549b1d4b 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -61,8 +61,9 @@ test_expect_success 'alias user-defined format' '
>  
>  test_expect_success 'alias user-defined format is matched case-insensitively' '
>  	git log --pretty="format:%h" >expected &&
> -	git config pretty.testalias "format:%h" &&
> -	git log --pretty=testAlias >actual &&
> +	git config pretty.testone "format:%h" &&
> +	git config pretty.testtwo testOne &&
> +	git log --pretty=testTwo >actual &&
>  	test_cmp expected actual
>  '

Very good thinking.  I totally missed the short-cut to another
short-cut while reading the patch.

>> +test_expect_success 'alias user-defined format is matched case-insensitively' '
>> +	git log --pretty="format:%h" >expected &&
>> +	git config pretty.testalias "format:%h" &&
>> +	git log --pretty=testAlias >actual &&
>> +	test_cmp expected actual
>> +'
>
> Modern style would be to use "test_config" here (or just "git -c"), but
> I see the surrounding tests are too old to do so. So I'd be OK with
> matching them (but cleaning up all of the surrounding ones would be
> nice, too).

Yup.  I do not mind seeing it done either way, as a preliminary
clean-up before the main fix, just a fix with more modern style
while leaving the clean-up as #leftoverbits to be done after the
dust settles.

> PS The matching rules in find_commit_format_recursive() seem weird
>    to me. We do a prefix match, and then return the entry whose name is
>    the shortest? And break ties based on which came first? So:
>
>      git -c pretty.abcd=format:one \
>          -c pretty.abc=format:two \
>          -c pretty.abd=format:three \
> 	 log -1 --format=ab
>
>    quietly chooses "two". I guess the "shortest wins" is meant to allow
>    "foo" to be chosen over "foobar" if you specify the whole name. But
>    the fact that we don't flag an ambiguity between "abc" and "abd"
>    seems strange.
>    That is all orthogonal to your patch, of course, but just a
>    head-scratcher I noticed while looking at the code.

I think it is not just strange but outright wrong.  I agree that it
is orthogonal to this fix.

Thanks, both.



