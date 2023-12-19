Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1873D0A2
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mx6tON/9"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 33A041B325C;
	Tue, 19 Dec 2023 17:21:46 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4vaLd0NzKYWnh3yFfymvX4/x2hVkXReMK84rYd
	mOl6M=; b=Mx6tON/9B8bIkAZPLbDQXjRLm7Xn+PWjn/coIWOHxT7OV1GcbUavnO
	sYtTXVOCMkSzX3hpcIB75YI4PNLJ9tu/AGENptJ1Eaa8hq3CuJ13jxMyV4S7Reck
	3F4rMKy+eWuHxDfPkIEwcCSpZH3FYG+ZPr47x+PNSGDGVAWINuTWM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B4A51B325B;
	Tue, 19 Dec 2023 17:21:46 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92E9C1B325A;
	Tue, 19 Dec 2023 17:21:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chandra Pratap <chandrapratap376@gmail.com>,
  Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v2] Teach git apply to respect core.fileMode settings
In-Reply-To: <pull.1620.v2.git.1703010646036.gitgitgadget@gmail.com> (Chandra
	Pratap via GitGitGadget's message of "Tue, 19 Dec 2023 18:30:45
	+0000")
References: <pull.1620.git.1702908568890.gitgitgadget@gmail.com>
	<pull.1620.v2.git.1703010646036.gitgitgadget@gmail.com>
Date: Tue, 19 Dec 2023 14:21:44 -0800
Message-ID: <xmqqv88tal53.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FE842E6C-9EBC-11EE-9FD8-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Chandra Pratap <chandrapratap3519@gmail.com>
>
> When applying a patch that adds an executable file, git apply
> ignores the core.fileMode setting (core.fileMode in git config
> specifies whether the executable bit on files in the working tree
> should be honored or not) resulting in warnings like:
>
> warning: script.sh has type 100644, expected 100755
>
> even when core.fileMode is set to false, which is undesired. This
> is extra true for systems like Windows, which don't rely on "lsat()".
>
> Fix this by inferring the correct file mode from the existing
> index entry when core.filemode is set to false. The added
> test case helps verify the change and prevents future regression.

Thanks.  Has _this_ particular iteration of the patch been reviewed
by Dscho?  Otherwise ...

> Reviewed-by: Johannes Schindelin <johannes.schindelin@gmail.com>

... this line is a bit problematic.  Just double-checking.

> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---

> diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
> index e7a7295f1b6..73fc472b246 100755
> --- a/t/t4129-apply-samemode.sh
> +++ b/t/t4129-apply-samemode.sh
> @@ -101,4 +101,29 @@ test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree
>  	)
>  '
>  
> +test_expect_success 'ensure git apply respects core.fileMode' '
> +	test_config core.fileMode false &&
> +	echo true >script.sh &&
> +	git add --chmod=+x script.sh &&
> +	git ls-files -s script.sh | grep "^100755" &&
> +	test_tick && git commit -m "Add script" &&
> +	git ls-tree -r HEAD script.sh | grep "^100755" &&

I am wondering if we want to be more strict about hiding error
return code from "git ls-files" and "git ls-tree" behind pipes
like these.  Usually we encourage using a temporary file, e.g.,

	...
	git ls-files -s script.sh >ls-files-output &&
	test_grep "^100755" ls-files-output &&
	...

> +	echo true >>script.sh &&
> +	test_tick && git commit -m "Modify script" script.sh &&
> +	git format-patch -1 --stdout >patch &&
> +	grep "index.*100755" patch &&

Anchor the pattern when you know where it has to appear and what the
surrounding letters must be, e.g.,

	test_grep "^index .* 100755$" patch &&

A test that expects a match with "grep" is silent when it fails, but
if you use test_grep, the output from "sh t4129-*.sh -i -v" gets
easier to view when the test fails, as it is more verbose and say
"we wanted to see X in the output but your output does not have it".

> +	git switch -c branch HEAD^ &&
> +	git apply --index patch 2>err &&
> +	! grep "has type 100644, expected 100755" err &&

If you wanted to use test_grep here, the way to negate it is a bit
peculiar, i.e.

	test_grep ! "has type ..." err &&

It does not have as much value as the positive case, as "! grep"
that expects to fail would show the unexpected match.  In any case,
making sure this particular error message does not appear in the
output is a good way to test it, instead of insisting that the
output is empty, since we may add output to the standard error
stream for unrelated reasons to issue warnings, etc.

> +	git restore -S script.sh && git restore script.sh &&

Why not "git reset --hard" here?  Just being curious why we want to
waste two invocations of "git restore".

> +	git apply patch 2>err &&
> +	! grep "has type 100644, expected 100755" err &&
> +
> +	git apply --cached patch 2>err &&
> +	! grep "has type 100644, expected 100755" err
> +'
> +
>  test_done
>
> base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
