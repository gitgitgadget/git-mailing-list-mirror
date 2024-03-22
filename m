Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA55341C70
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711128088; cv=none; b=RPUYwwytmNDgs9pNtau36f+zR8BvtbKaknSLt5jnRorkDsmEieQOyMHUt3He/cajB/v4YjYUCYdCrg5EWXpiPSZgSTsS44S8Gni8WlGik7vuumrlkwEr9jo9zb6H5JPZMhPYUxiNX2ocokDxqiWsF9X1A0xXBiG1RR5HTbDOF0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711128088; c=relaxed/simple;
	bh=jLR8dIWsfLXmOMTMQCcR9POZT2hxkkRK0Eutc+KdFpc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KyEmoeddYSViAEYLAVnRirMTAQkmoaNzET7024prc40xYieEUnEeb2p+xOztnQQtm8Cwi632fV1zxwqCDMJnRX9CQMp15bSADE5RC0VQD9mIiHC/tVW9pV7HjURpkQb2w1vTyMKn2fK+4rhH95cE6GlWYWaepCixgItUobZnzGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wX/ijpau; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wX/ijpau"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B02261F51A9;
	Fri, 22 Mar 2024 13:21:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jLR8dIWsfLXmOMTMQCcR9POZT2hxkkRK0Eutc+
	KdFpc=; b=wX/ijpau1ZLfofmm3AylR/AQa2UaqgrUi+sXrll2Wj2bA6CAfT0GSa
	4DF5jWyzhqd0cXJOEyJ/RjH1KCALBo1S6duhJ3WPoP+I2KlsM/pFQNl15VLnlogb
	FJWkoK076ifB0SCfBO2REhMqzRywplCjX4qQmtYMIIKQDAO2khq/E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A86681F51A8;
	Fri, 22 Mar 2024 13:21:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F3A51F51A7;
	Fri, 22 Mar 2024 13:21:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rebase: use child_process_clear() to clean
In-Reply-To: <20240322103502.GA2045297@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 22 Mar 2024 06:35:02 -0400")
References: <20240322103502.GA2045297@coredump.intra.peff.net>
Date: Fri, 22 Mar 2024 10:21:23 -0700
Message-ID: <xmqqedc218to.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9C4EE9E6-E870-11EE-AE77-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> In the run_am() function, we set up a child_process struct to run
> "git-am", allocating memory for its args and env strvecs. These are
> normally cleaned up when we call run_command(). But if we encounter
> certain errors, we exit the function early and try to clean up ourselves
> by clearing the am.args field. This leaks the "env" strvec.
>
> We should use child_process_clear() instead, which covers both. And more
> importantly, it future proofs us against the struct ever growing more
> allocated fields.

When 21853626 (built-in rebase: call `git am` directly, 2019-01-18)
started using run_command() API to drive "am", there already was
child_process API and child_process_clear() did clear both .args and
.env_array members but we used argv_array_clear() only to clear
am.args, leaking am.env_array.

> These are unlikely errors to happen in practice, so they don't actually
> trigger the leak sanitizer in the tests. But we can add a new test which
> does exercise one of the paths (and fails SANITIZE=leak without this
> patch).
> ...
> Not sure if the test is overkill. It really does nothing useful in a
> non-leak-checking build.

I wonder what are in .env array at this point, though, but that is
mere curiosity and not a problem with this patch.

Thanks.  Will queue.


> diff --git a/t/t3438-rebase-broken-files.sh b/t/t3438-rebase-broken-files.sh
> index c614c4f2e4..821f08e5af 100755
> --- a/t/t3438-rebase-broken-files.sh
> +++ b/t/t3438-rebase-broken-files.sh
> @@ -58,4 +58,13 @@ test_expect_success 'unknown key in author-script' '
>  	check_resolve_fails
>  '
>  
> +test_expect_success POSIXPERM,SANITY 'unwritable rebased-patches does not leak' '
> +	>.git/rebased-patches &&
> +	chmod a-w .git/rebased-patches &&
> +
> +	git checkout -b side HEAD^ &&
> +	test_commit unrelated &&
> +	test_must_fail git rebase --apply --onto tmp HEAD^
> +'
> +
>  test_done
