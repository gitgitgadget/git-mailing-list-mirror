Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1269016DC06
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721672684; cv=none; b=RKLhK5Pyxdkkh1nxzCU98W6aG1Lr+RJqE7ipu+/scjXTgM11pMztrekCRQVjJYChQP2oDRhNq+ejClYTm/1cHwl4fjj2Hi5EGMkjVVKbk3XrdaN8pmO71Sv8jFq93Vn2x8w45xa0GvpNssBy0XWEcwZCiTrYXcATsa21EYZ2oAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721672684; c=relaxed/simple;
	bh=xe8OLGAG1vH3VZxwCG+PuXUzWdmxT0LUbR9xVz7GULs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hltdx4dvW5+wrQ1Pwi/ps+0MW18r0AyG+daX+LzN/giGwtsX3E7iQ6MRItHy8Khi/ry9vb5eZ2vsdmj+f/N/w0wQqliA7kdqP3bqgxKFllURYrFBzMNjLk7MuqBMl8TIeB5BYJNRaHajT/xSYleFF1uyUQ3Kvw9thLF2pjpZvX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oaaPqRqH; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oaaPqRqH"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CA17387CB;
	Mon, 22 Jul 2024 14:24:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xe8OLGAG1vH3VZxwCG+PuXUzWdmxT0LUbR9xVz
	7GULs=; b=oaaPqRqH1cFWvb5imdavc0QueKEheD53nX9U44H+umrt34Asinnd8F
	27RSCWdXlFSoW+j6vMgRUB1aIP+ugJ2/MNRghxZMM8rZL5BUhv7wv9QTcdP1/4Y3
	GEnl1kuPKpyMPslrtQEOQZvXd33/NTs3KDCruL3fNWrsq209cqdP8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 538F5387CA;
	Mon, 22 Jul 2024 14:24:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B20D8387C7;
	Mon, 22 Jul 2024 14:24:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org,  =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/4] t3430: modernize one-shot "VAR=val shell-func"
 invocation
In-Reply-To: <20240722065915.80760-2-ericsunshine@charter.net> (Eric
	Sunshine's message of "Mon, 22 Jul 2024 02:59:11 -0400")
References: <20240722065915.80760-1-ericsunshine@charter.net>
	<20240722065915.80760-2-ericsunshine@charter.net>
Date: Mon, 22 Jul 2024 11:24:34 -0700
Message-ID: <xmqqv80xb7z1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A613D63E-4857-11EF-9F89-BAC1940A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <ericsunshine@charter.net> writes:

> A common way to work around the problem is to wrap a subshell around the
> variable assignments and function call, thus ensuring that the
> assignments are short-lived. However, these days, a more ergonomic
> approach is to employ test_env() which is tailor-made for this specific
> use-case.

OK.  I am not sure if that is "ergonomic", though.  An explict
subshell has a good documentation value that even though we call
test_commit there, we do not care about the committer timestamps
subsequent commits would record, and we do not mind losing the
effect of test_tick from this invocation of test_commit.  Hiding
all of that behind test_env loses the documentation value.

We could resurrect it by explicitly passing "--no-tick" to
test_commit, though ;-).

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t3430-rebase-merges.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index 36ca126bcd..e851ede4f9 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -392,8 +392,8 @@ test_expect_success 'refuse to merge ancestors of HEAD' '
>  
>  test_expect_success 'root commits' '
>  	git checkout --orphan unrelated &&
> -	(GIT_AUTHOR_NAME="Parsnip" GIT_AUTHOR_EMAIL="root@example.com" \
> -	 test_commit second-root) &&
> +	test_env GIT_AUTHOR_NAME="Parsnip" GIT_AUTHOR_EMAIL="root@example.com" \
> +		test_commit second-root &&
>  	test_commit third-root &&
>  	cat >script-from-scratch <<-\EOF &&
>  	pick third-root
