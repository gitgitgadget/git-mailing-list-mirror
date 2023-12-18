Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7862F5D746
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KfHelMBM"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E2861EC48;
	Mon, 18 Dec 2023 13:04:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=W3v6d5lGSdUtWc4l7kq5caVRHhBtKuADe1KAX1
	vBPOs=; b=KfHelMBM2AUcgJavyAUWIlg0YbaJ4Q9TA0YLkAOPV5gJFVcyQ5W4wO
	s97i0hj2X7vXDAuJQ641cmOanun1iBDjl/O2b5PzuqKHpwUZUHEx1Qgabdt1lbcA
	Rq1sHlxwe0e5wFfyOwkm8o7QrGUPhc1X96CvY9ytHKpuh2wAM+9H4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 360421EC47;
	Mon, 18 Dec 2023 13:04:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6DE4F1EC46;
	Mon, 18 Dec 2023 13:04:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chandra Pratap <chandrapratap376@gmail.com>,
  Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH] Teach git apply to respect core.fileMode settings
In-Reply-To: <pull.1620.git.1702908568890.gitgitgadget@gmail.com> (Chandra
	Pratap via GitGitGadget's message of "Mon, 18 Dec 2023 14:09:28
	+0000")
References: <pull.1620.git.1702908568890.gitgitgadget@gmail.com>
Date: Mon, 18 Dec 2023 10:04:06 -0800
Message-ID: <xmqqle9rfkvd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D6EC0F5C-9DCF-11EE-A32D-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Chandra Pratap <chandrapratap3519@gmail.com>
>

This part goes in the final commit when the patch gets applied.
Everything between the three-dash line and the patch (i.e., the
first "diff --get" line) are discarded.  Move what you wrote below
here to make it the proposed log message for this patch.

Assuming that gets done, let's review what will become the proposed
log message.

> CC: Johannes Schindelin <johannes.schindelin@gmail.com>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>     apply: make git apply respect core.fileMode settings
>     
>     When applying a patch that adds an executable file, git apply ignores
>     the core.fileMode setting (core.fileMode in git config specifies whether
>     the executable bit on files in the working tree
>     should be honored or not) resulting in warnings like:
>     
>     warning: script.sh has type 100644, expected 100755
>     
>     even when core.fileMode is set to false, which is undesired. This is
>     extra true for systems like Windows which don't rely on lsat().

"lstat()" you mean.  Add "," between "Windows" and " which".

>     Fix this by inferring the correct file mode from the existing index
>     entry when core.filemode is set to false. The added test case helps
>     verify the change and prevents future regression.

Perfect.

>     
>     Reviewed-by: Johannes Schindelin johannes.schindelin@gmail.com
>     Signed-off-by: Chandra Pratap chandrapratap3519@gmail.com

The e-mail addresses somehow lost <angle brakets> around them.

> diff --git a/apply.c b/apply.c
> index 3d69fec836d..56790f515e0 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3778,8 +3778,11 @@ static int check_preimage(struct apply_state *state,
>  		return error_errno("%s", old_name);
>  	}
>  
> -	if (!state->cached && !previous)
> -		st_mode = ce_mode_from_stat(*ce, st->st_mode);
> +	if (!state->cached && !previous) {
> +		if (!trust_executable_bit && patch->old_mode)
> +			st_mode = patch->old_mode;
> +		else st_mode = ce_mode_from_stat(*ce, st->st_mode);
> +	}

Write the body of the "else" clause on a separate line.

More importantly, even though we know we cannot trust st->st_mode on
such a filesystem (that is what !trust_executable_bit is about),
once we have a cache entry in the in-core index, shouldn't we trust
ce->ce_mode more than what the incoming patch says?  Or is the
executable bit of a cache-entry totally hosed on a platform with
!trust_executable_bit?

I thought the way things should work was

 (1) "--chmod=+x", which you used in the test, should mark the added
     path executable in the index.  Writing that to a tree (by
     making a commit) should record script.sh as an executable
     (i.e., "git ls-tree -r" should show 100755 not 100644).

 (2) if you read such a tree, then the index will have the "correct"
     executable bit in the cache entry (i.e., "git ls-files -s"
     should show 100755 not 100644).

IOW, I am wondering if the above should look more like

	if (!state->cached && !previous) {
		if (!trust_executable_bit) {
			if (*ce)
				st_mode = (*ce)->ce_mode;
			else
				st_mode = patch->old_mode;
		} else {
			st_mode = ce_mode_from_stat(*ce, st->st_mode);
		}
	}

As setting patch->old_mode to st_mode is equivalent to saying "we
blindly trust the data on the patch much more than what we know
about the current repository state", which goes directly against
what "check_preimage()" wants to achieve.

>  
> diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
> index e7a7295f1b6..95917fee128 100755
> --- a/t/t4129-apply-samemode.sh
> +++ b/t/t4129-apply-samemode.sh
> @@ -101,4 +101,19 @@ test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree
>  	)
>  '
>  
> +test_expect_success FILEMODE 'ensure git apply respects core.fileMode' '
> +	test_config core.fileMode false &&
> +	echo true >script.sh &&
> +	git add --chmod=+x script.sh &&

Perhaps we would want to check with "git ls-files -s script.sh" what
its mode bits are (hopefully it would be executable).

> +	test_tick && git commit -m "Add script" &&

Similarly, check with "git ls-tree -r HEAD script.sh" what its mode
bits are?

> +	echo true >>script.sh &&
> +	test_tick && git commit -m "Modify script" script.sh &&

Ditto.

> +	git format-patch -1 --stdout >patch &&

Check that the patch expects script.sh to have its executable bit
here, too?

> +	git switch -c branch HEAD^ &&
> +	git apply patch 2>err &&

We may also want to check "git apply --cached" and "git apply --index"
here, not just the "poor-man's GNU patch emulation" mode.

> +	! test_grep "has type 100644, expected 100755" err

If you use test_grep, the correct negation is not like that, but

	test_grep ! "has type 100644, expected 100755" err

Giving a better diagnosis when the expectation is violated is the
whole point of using "test_grep" not a vanilla "grep", so we need to
tell it that we are reversing our expectations.

Thanks.

> +'
> +
>  test_done
>
> base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
