Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0B7291E
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726858925; cv=none; b=FlsOqN0uMZXutEB4znne0RFmbrxPaYK74xELFVx/2mi3lwFS7ZcfCUrvwYXH0pqK2RvYTz49D5kqdg4Yzh6qAJcUqDgnXvtgiiXgDKzLV/JjLMHXtsXPBwwcFa3mRC6S5i+NcFro6u09xoAtCXXxYIrlXpFyW4spdBpDcPfCDVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726858925; c=relaxed/simple;
	bh=s03aDWaMOZ1dA/tFdJzIhAFjPpAoZQCbciv7yaJnajg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tVWG0QZI3UveNrHQKRJSj51+TrD96h51F5pwxoSCx3e7MH21dCDDc8F5djmqWEow0efarRotpggD6l/AqynRhssISKNnD3ECbeoKn04R9BHhbEKErbuVeSLBqGqGe6XgW7Mc1ovmsOOemfuQRF5tAcMDSWIJi+Nb/hsllDstv8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qnj7sYdC; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qnj7sYdC"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 899D61D94F;
	Fri, 20 Sep 2024 15:02:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=s03aDWaMOZ1dA/tFdJzIhAFjPpAoZQCbciv7ya
	Jnajg=; b=qnj7sYdCEVGLnZSTeh3Il0U1xi9qQVp+Vp0okxCp5WRcdeM+GFVX/l
	DBcgu8+I084j9+7ssSS8r3lfvpnLhptTpFmBsVceoqttk8iPWobdYyJ+pi4xBhU+
	jBXj3iaLpdKLL4hdkmUIAsIc1vQtMwcU3zm8+QNtpwIgVBNGHcgIU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 51EDA1D94E;
	Fri, 20 Sep 2024 15:02:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 89E261D94D;
	Fri, 20 Sep 2024 15:02:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Calvin Wan <calvinwan@google.com>,  Matt Liberty
 <mliberty@precisioninno.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] submodule status: propagate SIGPIPE
In-Reply-To: <pull.1799.git.1726837642511.gitgitgadget@gmail.com> (Phillip
	Wood via GitGitGadget's message of "Fri, 20 Sep 2024 13:07:22 +0000")
References: <pull.1799.git.1726837642511.gitgitgadget@gmail.com>
Date: Fri, 20 Sep 2024 12:01:59 -0700
Message-ID: <xmqqbk0igndk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D0F09036-7782-11EF-BE46-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> It has been reported than running
>
>      git submodule status --recurse | grep -q ^+
>
> results in an unexpected error message
>
>     fatal: failed to recurse into submodule $submodule
> ...
> -		if (run_command(&cpr))
> +		res = run_command(&cpr);
> +		if (res == SIGPIPE + 128)
> +			raise(SIGPIPE);

OK, that is straight-forward.  This makes sure that we do the same
thing we would do if we, not our child, got a SIGPIPE.

> +		else if (res)
>  			die(_("failed to recurse into submodule '%s'"), path);
>  	}

> diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
> index ab946ec9405..c1686d6bb5f 100755
> --- a/t/t7422-submodule-output.sh
> +++ b/t/t7422-submodule-output.sh
> @@ -167,4 +167,11 @@ do
>  	'
>  done
>  
> +test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE' '
> +	{ git submodule status --recursive 2>err; echo $?>status; } |
> +		grep -q X/S &&
> +	test_must_be_empty err &&
> +	test_match_signal 13 "$(cat status)"

I am not a huge fun of assuming SIGPIPE is 13 everywhere, but at
least we can tweak test_match_signal when we find oddball systems,
so ... OK.

In practice, we only use 13 and 15 with test_match_signal, so we
could have a new "test-tool signal-name" that maps textual signal
names to the number the platform gives to them for the platform on
which the tests are running, if it ever turns out to be a problem.

Looking good.

Will queue.  Thanks.
