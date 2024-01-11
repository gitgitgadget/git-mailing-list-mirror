Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBC757300
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wd6TUufH"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A8B961952F;
	Thu, 11 Jan 2024 15:30:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hdoTioTmYDQPx5FBETqdbiJfuc6SO3r8nhqo8T
	+RNZQ=; b=wd6TUufHUq73IR35/yNtCpflquCPE/7rNGc831QmI7HNsv5CLo8sYF
	DxJZDCjEgHOsRzqjPQtHxJdwhahNCAgRY/Jm1Ru8kYeDBVmoMFxPZmH0D3HRXftk
	z9C0f71Tk1ymWqsfk27RS1jrKyIe81MQPIS2GVB0QnX+Li+R7SD0E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A0C411952E;
	Thu, 11 Jan 2024 15:30:01 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C08901952B;
	Thu, 11 Jan 2024 15:29:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Stan Hu <stanhu@gmail.com>
Subject: Re: [PATCH 1/2] t9902: verify that completion does not print anything
In-Reply-To: <73406ca9c8f38ac2ad8f0e32d6d81f1566a6b4d1.1704969119.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 11 Jan 2024 11:41:54 +0100")
References: <cover.1704969119.git.ps@pks.im>
	<73406ca9c8f38ac2ad8f0e32d6d81f1566a6b4d1.1704969119.git.ps@pks.im>
Date: Thu, 11 Jan 2024 12:29:56 -0800
Message-ID: <xmqqil3zfwaj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2FD8F47E-B0C0-11EE-8933-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The Bash completion script must not print anything to either stdout or
> stderr. Instead, it is only expected to populate certain variables.
> Tighten our `test_completion ()` test helper to verify this requirement.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t9902-completion.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index aa9a614de3..78cb93bea7 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -87,9 +87,11 @@ test_completion ()
>  	else
>  		sed -e 's/Z$//' |sort >expected
>  	fi &&
> -	run_completion "$1" &&
> +	run_completion "$1" >"$TRASH_DIRECTORY"/output 2>&1 &&

OK, there is a call to test_completion after cd and this is a
reasonable way to make sure we write to a known location.

I would have done the "run_completion should be totally silent"
check immediately after this line, as they logically are more
related to each other than to the two lines that implement "the
'out' file when sorted must match the expectation we just prepared",
but that is not a huge deal.

The filename "output" is something that may tempt folks who add more
tests to this file to use for their own purpose; because we use it
only three times locally here, it might be safer to give it a bit
more specific name, e.g., "run-completion-output" or something.



>  	sort out >out_sorted &&
> -	test_cmp expected out_sorted
> +	test_cmp expected out_sorted &&
> +	test_must_be_empty "$TRASH_DIRECTORY"/output &&
> +	rm "$TRASH_DIRECTORY"/output
>  }
>  
>  # Test __gitcomp.
