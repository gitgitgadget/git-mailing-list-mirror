Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976AE4502D
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951590; cv=none; b=tV6oWGq22VB/hDIl0l+jeK0uoBe8H3SvvkAgHSfs7Eda70MT78mQc7KioXocwXab2RRaET9+CBaiofLwzG20xNzSmNie/lTPFmYDbTyLjulnT1g7UqiuAs2ivDo3o25f1t9UVEDzjejmT0Q0QcJmpvQ7/dHI51r+Rz86hjq1/H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951590; c=relaxed/simple;
	bh=ElfRjGG+jBrFWPN4yEcLagwCyWpIOd71xCM8Pti8sDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CmOPaW0rGhCBdxs6ka+2aC6t7nFXhBkm/Do0Bf+tbO10/Ts/dUXhkOPMCMpAQyosbt/N9T2K5xvb3YYrPCnWYgDuzzDZpnt9n0iDqW4HLs+Wti+/Qnf2mNouzKdrlcOQukWHqFBDK5PMvYloqef/I12SHEuLftyzb7L9uqsYuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bQ7hwNgx; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bQ7hwNgx"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 01BD62150A;
	Wed, 14 Feb 2024 17:59:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ElfRjGG+jBrFWPN4yEcLagwCyWpIOd71xCM8Pt
	i8sDQ=; b=bQ7hwNgxefEqUYUzZjyEDkTxJnS7mWUaDGsN9jyHExwOeYzEGOmWNK
	taGiO9Lqz8zr2ezX6OM78rHJponjLaMKIHFvEI6SZB88bIgzzbdJfIqoDO4LVgnq
	HVTz0WxT5CxW9QXYFDOTf7eXA3ags7HrxraykaLO56bSCz5ZZgrP8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EE7C821509;
	Wed, 14 Feb 2024 17:59:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9DDDE21507;
	Wed, 14 Feb 2024 17:59:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] t1400: exercise reflog with gaps with reftable backend
In-Reply-To: <9d8eed354ee3f0c9f66c22d92afd4c4c80f102e4.1707463221.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 9 Feb 2024 08:23:18 +0100")
References: <cover.1707463221.git.ps@pks.im>
	<9d8eed354ee3f0c9f66c22d92afd4c4c80f102e4.1707463221.git.ps@pks.im>
Date: Wed, 14 Feb 2024 14:59:43 -0800
Message-ID: <xmqqh6iatzxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BE7A804E-CB8C-11EE-911C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In t1400, we have a test that exercises whether we print a warning
> message as expected when the reflog contains entries which have a gap
> between the old entry's new object ID and the new entry's old object ID.
> While the logic should apply to all ref backends, the test setup writes
> into `.git/logs` directly and is thus "files"-backend specific.
>
> Refactor the test to instead use `git reflog delete` to create the gap
> and drop the REFFILES prerequisite.

This rewrite looks good.

Instead of mucking with the implementation detail, we achieve the
same with proper use of the tools provided.  Very nice.

Thanks.


> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t1400-update-ref.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 3294b7ce08..3aeb103d34 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -426,15 +426,15 @@ test_expect_success 'Query "main@{2005-05-28}" (past end of history)' '
>  rm -f expect
>  git update-ref -d $m
>  
> -test_expect_success REFFILES 'query reflog with gap' '
> +test_expect_success 'query reflog with gap' '
>  	test_when_finished "git update-ref -d $m" &&
>  
> -	git update-ref $m $F &&
> -	cat >.git/logs/$m <<-EOF &&
> -	$Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 -0500
> -	$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 -0500
> -	$D $F $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150680 -0500
> -	EOF
> +	GIT_COMMITTER_DATE="1117150320 -0500" git update-ref $m $A &&
> +	GIT_COMMITTER_DATE="1117150380 -0500" git update-ref $m $B &&
> +	GIT_COMMITTER_DATE="1117150480 -0500" git update-ref $m $C &&
> +	GIT_COMMITTER_DATE="1117150580 -0500" git update-ref $m $D &&
> +	GIT_COMMITTER_DATE="1117150680 -0500" git update-ref $m $F &&
> +	git reflog delete $m@{2} &&
>  
>  	git rev-parse --verify "main@{2005-05-26 23:33:01}" >actual 2>stderr &&
>  	echo "$B" >expect &&
