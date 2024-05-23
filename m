Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A3280C
	for <git@vger.kernel.org>; Thu, 23 May 2024 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716424895; cv=none; b=CYcuCRDMn7/alkCC8SkLZbhnsbzBZ8dNZ1pUhM9bOcnS9LKXdvCKxCIwRyPbePG99MYvrSMZ8Y0V6BrHGb5GCrE0NN0cBo6QNPA33OJ9RYkFklPSeXUj4NSzCra9dkU/GA4nFLH11SuxhcAHknC4xjrY1OM3LejoayxE4SkInrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716424895; c=relaxed/simple;
	bh=WxICJIqU580BS/cAwNBhi4HREvWqkUyb+SGtICwwZ6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hJhUahgolN6VR4Iao5Lsem8/FoOYFGZxFZy4a9KHtj7vkbuqNFR8AvFQ8LSv6UpP+3Y1wpYq04R8NGrZInu4JKaIU6XGrISnyYunR8GYZ+rnl8y31J0mR1n9gJ2fTxPbqisG4WlOYmkiQahQvsnh2L7WScPi81+AIP/ix2yMz+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uRj90Zcr; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uRj90Zcr"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C33037F46;
	Wed, 22 May 2024 20:41:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WxICJIqU580BS/cAwNBhi4HREvWqkUyb+SGtIC
	wwZ6M=; b=uRj90ZcrXqzPswZ2c+RXR2w51dUlaVVmj9ZqQKyCsttODKLPLe0k23
	EuJyHIRnRl30hfm9I2m2h2av1NmBUjtRsgt7wuOTNrf2FCInDgGFK48kMtgKOuXC
	Wug/iLY6nUifjYEepw1NVoidwHLhAQ7uCIuJiZPgxjMTYOP9W7fJ8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F0DF37F45;
	Wed, 22 May 2024 20:41:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3D5C537F44;
	Wed, 22 May 2024 20:41:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Heghedus Razvan <heghedus.razvan@protonmail.com>
Subject: Re: [PATCH] setup: fix bug with "includeIf.onbranch" when
 initializing dir
In-Reply-To: <cf182bb9ee7d4a7eb46e5dbf4f3ef5deb198d823.1716374321.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 22 May 2024 12:38:46 +0200")
References: <D1F5SJ52H4Z0.1NR7M8APRFTOB@protonmail.com>
	<cf182bb9ee7d4a7eb46e5dbf4f3ef5deb198d823.1716374321.git.ps@pks.im>
Date: Wed, 22 May 2024 17:41:28 -0700
Message-ID: <xmqq4jap1hs7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 322F27E4-189D-11EF-A22E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The bug has been introduced in 173761e21b (setup: start tracking ref
> storage format, 2023-12-29), which wired up the ref storage format. The
> root cause is in `init_db()`, which tries to read the config before we
> have initialized `the_repository` and most importantly its ref storage
> format. We eventually end up calling `include_by_branch()` and execute
> `refs_resolve_ref_unsafe()`, but because we have not initialized the ref
> storage format yet this will trigger the above bug.

So I was trying to see how feasible it would be to backport this fix
on top of v2.44.0 which was the first version that was shipped with
173761e2 (setup: start tracking ref storage format, 2023-12-29),
which is v2.44.0-rc0~78^2~8 and noticed something curious.

As your addition to t0001-init.sh wants to try converting the ref
backends to and from files and reftable, it actually will barf until
b4385bf0 (Merge branch 'ps/reftable-backend', 2024-02-26), which is
v2.45.0-rc0~176, but even with a reinit with the same backend, the
problem should manifest itself, right?

> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index b131d665db..2239bed198 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -584,14 +584,38 @@ test_expect_success 'init with --ref-format=files' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 're-init with same format' '
> -	test_when_finished "rm -rf refformat" &&
> -	git init --ref-format=files refformat &&
> -	git init --ref-format=files refformat &&
> -	echo files >expect &&
> -	git -C refformat rev-parse --show-ref-format >actual &&
> -	test_cmp expect actual
> -'

So we used to have "files to files" and nothing else.  But

> +for from_format in files reftable
> +do
> +	for to_format in files reftable
> +	do
> +		if test "$from_format" = "$to_format"
> +		then
> +			continue
> +		fi
> +
> +		test_expect_success "re-init with same format ($from_format)" '
> +			test_when_finished "rm -rf refformat" &&
> +			git init --ref-format=$from_format refformat &&
> +			git init --ref-format=$from_format refformat &&
> +			echo $from_format >expect &&
> +			git -C refformat rev-parse --show-ref-format >actual &&
> +			test_cmp expect actual
> +		'

This is very iffy, isn't it?  This one wants to do the same format
reinit, but it is behind "if from and to are the same, skip the rest"
in the loop.

I think the "same format" loop should be lifted outside and
immediately before the inner loop and we should be OK.

> +		test_expect_success "re-init with different format fails ($from_format -> $to_format)" '
> +			test_when_finished "rm -rf refformat" &&
> +			git init --ref-format=$from_format refformat &&
> +			cat >expect <<-EOF &&
> +			fatal: attempt to reinitialize repository with different reference storage format
> +			EOF
> +			test_must_fail git init --ref-format=$to_format refformat 2>err &&
> +			test_cmp expect err &&
> +			echo $from_format >expect &&
> +			git -C refformat rev-parse --show-ref-format >actual &&
> +			test_cmp expect actual
> +		'
> +	done
> +done

In any case, this "reinitialize to a different format is too late"
test has nothing to do with the problem we are fixing with this
patch, no?  It is a valuable set of tests in the post b4385bf0 world
where we can choose between the two, but it is somewhat out of scope
of the "we need to initialize the ref backend before we can do onbranch
config".

I'll send your patch backported to v2.44.0, plus the change needed
to review the merge of it into v2.45.0 codebase later.
