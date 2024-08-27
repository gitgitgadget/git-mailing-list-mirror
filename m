Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05070158218
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724798346; cv=none; b=GO/RNeimdoP+/cN72WhNp8Kzwk+XsFoGAmct2fzYZkTJX3EbxeMRiVdhWYOd3Gu9Xm2/NjG5u9QGb5cvB4v4JziRDvRmCh8Nut1faF7q2vkD02x0PRRGsrVv49AUq51MIUQbf4tzwF0jnSMPmFtjoRjiDug5xDYCYOoKt3D1TDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724798346; c=relaxed/simple;
	bh=nsAwgaHf+JEzQcCVuhUmmY8q31nzjWw8cThViLEEzpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aJT6RDK/dXziEPqpScvgCJx9sWmUc5Ews/ze41ue4IHmhbYK/hszesOAO7YEayC+W4Er7j8b/7Dl025MJZ1nyaGgXlwFWmyDSjdHLJf2K6TGXoFpZGDQShvA0A7wSHfpU25kfePQKNTyL9aFEVveSTe7+UCHisD4bAk2ewZxNEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JbpI3O34; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JbpI3O34"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18B9D38C20;
	Tue, 27 Aug 2024 18:39:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nsAwgaHf+JEzQcCVuhUmmY8q31nzjWw8cThViL
	EEzpQ=; b=JbpI3O34UZPLfV+lXkfrW7jvdUbmCMSHwjyG8LrBVegViJKKE5A/kP
	u7E8z4rziX6PXnoSyEQ/C+h6GSW1kAQlvLukqIO5mxdDTQV9YpjRUFurBhoiQ4Qe
	6dkPUj3kPOKrvsKpCE1O5ZpZT+Z+fJQ0tDE602DAEWnNSWjpE5kK0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A691738C1E;
	Tue, 27 Aug 2024 18:39:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 054A238C1D;
	Tue, 27 Aug 2024 18:39:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/22] t/test-lib: allow skipping leak checks for
 passing tests
In-Reply-To: <7c158acadf40b44edb3cf186860a3f60818f76f0.1724656120.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 26 Aug 2024 09:21:34 +0200")
References: <cover.1724656120.git.ps@pks.im>
	<7c158acadf40b44edb3cf186860a3f60818f76f0.1724656120.git.ps@pks.im>
Date: Tue, 27 Aug 2024 15:38:59 -0700
Message-ID: <xmqqbk1d7fr0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 285ECD22-64C5-11EF-ADB4-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> With `GIT_TEST_PASSING_SANITIZE_LEAK=check`, one can double check
> whether a memory leak fix caused some test suites to become leak free.
> It is somewhat slow to execute though because it runs all of our test
> suites with the leak sanitizer enabled. It is also pointless in most
> cases, because the only test suites that need to be checked are those
> which _aren't_ yet marked with `TEST_PASSES_SANITIZE_LEAK=true`.
>
> Introduce a new value "check-failing". If set, we will only check those
> tests which are not yet marked as leak free.

A very welcome addition.  I am already liking it while running
locally.

Thanks.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/test-lib.sh | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 54247604cbc..64bd36531c1 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1558,8 +1558,16 @@ then
>  		passes_sanitize_leak=t
>  	fi
>  
> -	if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check"
> +	if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" ||
> +	   test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check-failing"
>  	then
> +		if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check-failing" &&
> +		   test -n "$passes_sanitize_leak"
> +		then
> +			skip_all="skipping leak-free $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=check-failing"
> +			test_done
> +		fi
> +
>  		sanitize_leak_check=t
>  		if test -n "$invert_exit_code"
>  		then
> @@ -1597,6 +1605,7 @@ then
>  	export LSAN_OPTIONS
>  
>  elif test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" ||
> +     test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check-failing" ||
>       test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
>  then
>  	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_PASSING_SANITIZE_LEAK=true"
