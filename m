Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9EF3B293
	for <git@vger.kernel.org>; Fri, 24 May 2024 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716574024; cv=none; b=iorUzb4duxygSBXtf9Np0R3QI6on6fRDGVT9+pnzi8HEm1mgEBRV3uj569rmpuJnZQpozrwBZyxwvKHltPC/qpHUO5IpZUMSu1Yc/us/D7UVtEeRjHw2JRdIP4RX4QqZbUvNawRIn9Ef0bl4vTIMCIrgnK3pVHGrAzPiPlQxTR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716574024; c=relaxed/simple;
	bh=IM6qikzcz2nlYeAUUrnkme0vmm+Wqpl8P2194EiVSFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l4/dNnU/81qTnahZnltheufxuZmU6+VG9Smbkdu5DLdv7WyF9OHuFJdSZUexD2M37bZvyKCUmJ/rq4GPbzlK+SgMFG1wQVhIPcZxSFAIAVXAKB8BKhXNfIpY1z5pP6k6BteHdOoNI6Gy5v9Jj47dA/dG5PF8wcXREXeNM6vim9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tk5qrxCp; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tk5qrxCp"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C23E2A838;
	Fri, 24 May 2024 14:07:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IM6qikzcz2nlYeAUUrnkme0vmm+Wqpl8P2194E
	iVSFU=; b=tk5qrxCps84NQl1gTa126igoWT+SIVyOsqnCKQcK2DkPNHyy31p1Vu
	DNk3A8uZIF+FZhzCwWUh4dP2qUtem160JB08O/CFEndL1aYa/U1NYPRWqv11mu0e
	NR59uBN3mFptFJ2KVbjkm3+g0JBMx6h5joDQJu8vWHb4rrFOhJkhk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 154CB2A837;
	Fri, 24 May 2024 14:07:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 34D4E2A834;
	Fri, 24 May 2024 14:06:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tom Hughes <tom@compton.nu>
Cc: git@vger.kernel.org,  chriscool@tuxfamily.org,  jonathantanmy@google.com
Subject: Re: [PATCH v2] promisor-remote: add promisor.quiet configuration
 option
In-Reply-To: <20240524090937.2448229-1-tom@compton.nu> (Tom Hughes's message
	of "Fri, 24 May 2024 10:09:37 +0100")
References: <20240523131926.1959245-1-tom@compton.nu>
	<20240524090937.2448229-1-tom@compton.nu>
Date: Fri, 24 May 2024 11:06:57 -0700
Message-ID: <xmqqa5kfkrsu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 69F9A36E-19F8-11EF-B163-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Tom Hughes <tom@compton.nu> writes:

> +test_expect_success TTY 'promisor.quiet=false shows progress messages' '
> +	rm -rf server repo &&
> +	test_create_repo server &&
> +	test_commit -C server foo &&
> +	git -C server rm foo.t &&
> +	git -C server commit -m remove &&
> +	git -C server config uploadpack.allowanysha1inwant 1 &&
> +	git -C server config uploadpack.allowfilter 1 &&
> +
> +	git clone --filter=blob:none "file://$(pwd)/server" repo &&
> +	git -C repo config promisor.quiet "false" &&
> +
> +	test_terminal git -C repo cat-file -p foo:foo.t 2>err &&
> +
> +	# Ensure that progress messages are written
> +	grep "Receiving objects" err
> +'
> +
> +test_expect_success TTY 'promisor.quiet=true does not show progress messages' '
> +	rm -rf server repo &&
> +	test_create_repo server &&
> +	test_commit -C server foo &&
> +	git -C server rm foo.t &&
> +	git -C server commit -m remove &&
> +	git -C server config uploadpack.allowanysha1inwant 1 &&
> +	git -C server config uploadpack.allowfilter 1 &&
> +
> +	git clone --filter=blob:none "file://$(pwd)/server" repo &&
> +	git -C repo config promisor.quiet "true" &&
> +
> +	test_terminal git -C repo cat-file -p foo:foo.t 2>err &&
> +
> +	# Ensure that no progress messages are written
> +	! grep "Receiving objects" err
> +'

Wouldn't we want to see this as three (or four) tests,

 (1) "setup" that prepares the server end

 (2) "quiet=false" test that
     - makes a partial clone, 
     - sets .quiet to false, 
     - runs cat-file -p,
     - makes sure that the lazy fetching is chatty.

 (3) "quiet=true" test, which is the same as (2) except that it sets
     .quiet to true and expects the lazy fetching to be silent.

 (4) "quiet=unconfigured" test, which is the same as (2) except that
     it leaves .quiet unconfigured.

Other than that, looking very much nicer than the previous round
that manually mucked with internal implementation on the client end.

Thanks.

