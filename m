Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55133149C4E
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299630; cv=none; b=ormaJ9rNeWNT+B8G9YReWtQgHy15NeWnHiUlSKoPLa27t49g/hHhqJJLKF0qncXZFiRRLO/84t9DhOesajLhImuH0KU7jZgx5kCSh0ki076tZqyIidVm4eF/qzTaKV03U+LzseHajVuYv1kISbG+ZsricCd3cED7KLsCCkkuPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299630; c=relaxed/simple;
	bh=+hGY3r7OH1TG7WJr6ISQgnBdlVEkxOF7zlvEE+mNBu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hWtcmNZdIU1utumsLtoEqT3g12343/4QI+lZb4zuIKlH11O1N4yelK9cAD+QMP9bBC9wRo8fPxyanROc14QlcO6Lx0ZYqQPrcGpNRTkpei0+x6SPC9IyiLzXTxpfpcQseaWrBefpeU7/UMDha0zxrD1LqMIdILLJISrWO5pMsaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PVXPv7w7; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PVXPv7w7"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 02FAC2A49C;
	Thu, 13 Jun 2024 13:27:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+hGY3r7OH1TG7WJr6ISQgnBdlVEkxOF7zlvEE+
	mNBu0=; b=PVXPv7w7BSgbmXnY+CEivmIaxiBWwxuyV8cCIsdeHGRwmfrZb+bWpz
	4kCzczvbu0S9Uw4ToFpWiVkcyrbEQMPM6souYAhRkKovXxQk6vR7HpcxnGzq80hF
	Cv/do5aMp5y/Iy6xBNBjMnYQAEpHKkDE4EFVdBhFOQlu5Lw2Eb1TU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D36002A49A;
	Thu, 13 Jun 2024 13:27:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0EA972A499;
	Thu, 13 Jun 2024 13:27:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kyle Zhao <kylezhao@tencent.com>
Subject: Re: [PATCH v5] merge: avoid write merge state when unable to write
 index
In-Reply-To: <pull.1731.v5.git.1718173639942.gitgitgadget@gmail.com> (Kyle
	Zhao via GitGitGadget's message of "Wed, 12 Jun 2024 06:27:19 +0000")
References: <pull.1731.v4.git.1715920862420.gitgitgadget@gmail.com>
	<pull.1731.v5.git.1718173639942.gitgitgadget@gmail.com>
Date: Thu, 13 Jun 2024 10:27:04 -0700
Message-ID: <xmqqh6dwlpnb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2869FB8A-29AA-11EF-8BE8-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

"Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kyle Zhao <kylezhao@tencent.com>
>
> When running a merge while the index is locked (presumably by another
> process), the merge state is written, the index is not updated, and then
> the merge fails. This might cause unexpected results.

Failing the merge is good thing.

> E.g., if another running process is "git commit", MERGE_HEAD and other
> state files we write on our side will be taken into account by them and
> cause them to record a merge, even though they may have been trying to
> record something entirely different.

If I recall the previous discussion correctly, I think the primary
thing this change achieves is to get us closer to a state where
competing commands (a "git commit" run while we are doing something
else like "git merge") take the index.lock as the first thing (so
others are blocked), before making auxiliary files like MERGE_HEAD
that would affect the behaviour of whoever has index.lock (and thus
making a new commit).  And that is what we need to stress in the
proposed log message, I would think.

But this is probably only half-a-solution.

> Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
> ---
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 6a6d3798858..12c1b048fe1 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -699,7 +699,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
>  	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET,
>  					 SKIP_IF_UNCHANGED, 0, NULL, NULL,
>  					 NULL) < 0)
> -		return error(_("Unable to write index."));
> +		die(_("Unable to write index."));
>  
>  	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree") ||
>  	    !strcmp(strategy, "ort")) {

If we fail to write the index here, even if we have other strategies
to try after the current one fails, it probably is a good idea to die
and stop the other ones from being tried, not because their attempt
to write the index might fail the same way, but because it is likely
that we are really in a weird situation and the user would want to
inspect the situation before this process makes too much damage to
the working tree and the index.

But this is probably only half-a-solution.  Because we release the
index.lock when the refresh-and-write call returns, and the
index.lock is free for the other process to grab, do whatever they
want to do to the index and the working tree (including making a new
commit out of it and update the HEAD), before or after we write out
the merge state files. So in that sense, this patch is *not* solving
the "E.g., if another running process is ..."  problem at all.

So ...

> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index e5ff073099a..ef54cff4faa 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -236,6 +236,16 @@ test_expect_success 'merge c1 with c2' '
>  	verify_parents $c1 $c2
>  '
>  
> +test_expect_success 'merge c1 with c2 when index.lock exists' '
> +	test_when_finished rm .git/index.lock &&
> +	git reset --hard c1 &&
> +	>.git/index.lock &&
> +	test_must_fail git merge c2 &&
> +	test_path_is_missing .git/MERGE_HEAD &&
> +	test_path_is_missing .git/MERGE_MODE &&
> +	test_path_is_missing .git/MERGE_MSG

... I do not quite see the point of this exercise.  It is good to
make sure that "git merge c2" fails while it is clear that somebody
else is mucking with the same repository touching the index.  But it
does not help the other process all that much if we stop only when
they happen to be holding lock at the point we try to refresh the
index.  It is making the race window smaller by a tiny bit.

So, I am not sure if this is worth doing.

