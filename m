Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549EB63B9
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 00:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708389169; cv=none; b=ahlIKVUZv6kNP9Dv890iHdbsA7KOrGb677QpJztBGe0lPzsl97JmMHbIt0LmVhPAFIVJLe4hy0HTqXtO4mIA3xiOsV98avquri8NMRFMDNci+0c6GZKNjHhag8viWuXW3zqxzpECuBqx6rweYDogvncbn48uwVJJrxrAWmyYn7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708389169; c=relaxed/simple;
	bh=vTp4Gbr+y0fKGG1yVArRRu54ZZPKnuJCG8JlxiTWylE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UBkjkBk9ClHUUjEbUkkJ//njr5VoMEEafWrvcvsM1ZSJrlTJKE1IcPFsFc4tZTRFnWrl3vv6bnNBnlaSUeyX3stRqre1eW1X+puf1xZHrGJluhlq7xX6pVFvAQJJmIKqTgFSx9WZGe+hG2MyUJVDPyN7eezjZBcdLG9jyTThVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VUzsXXOD; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VUzsXXOD"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EEAAE1E2F81;
	Mon, 19 Feb 2024 19:32:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vTp4Gbr+y0fKGG1yVArRRu54ZZPKnuJCG8Jlxi
	TWylE=; b=VUzsXXOD6zOeDcXRB/EDOqzvcUeOtWgCsRuPO+yr4o83wB5Yg4JpIv
	SaK6fg3yWHdrnbizhEau0cwLVPO41jQIV3pGndrJbLYdZXDQ6twQ+wrIOFBKFk1Y
	bpsk6xwK2cd8V3hDUW2BPbMfJ+fiKB/K19+fiNDZPnuiQdojMxP7k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E55681E2F80;
	Mon, 19 Feb 2024 19:32:44 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5DB001E2F7F;
	Mon, 19 Feb 2024 19:32:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] builtin/reflog: introduce subcommand to list reflogs
In-Reply-To: <cddb2de9394a07e405682e9ccdfdf5de92bb9092.1708353264.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 19 Feb 2024 15:35:40 +0100")
References: <cover.1708353264.git.ps@pks.im>
	<cddb2de9394a07e405682e9ccdfdf5de92bb9092.1708353264.git.ps@pks.im>
Date: Mon, 19 Feb 2024 16:32:43 -0800
Message-ID: <xmqq7cj0ynys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9053730C-CF87-11EE-A711-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index d2f5f42e67..6d8d5a253d 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -436,4 +436,73 @@ test_expect_success 'empty reflog' '
>  	test_must_be_empty err
>  '
>  
> +test_expect_success 'list reflogs' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		git reflog list >actual &&
> +		test_must_be_empty actual &&
> +
> +		test_commit A &&
> +		cat >expect <<-EOF &&
> +		HEAD
> +		refs/heads/main
> +		EOF
> +		git reflog list >actual &&
> +		test_cmp expect actual &&
> +
> +		git branch b &&
> +		cat >expect <<-EOF &&
> +		HEAD
> +		refs/heads/b
> +		refs/heads/main
> +		EOF
> +		git reflog list >actual &&
> +		test_cmp expect actual
> +	)
> +'

OK.  This is a quite boring baseline.

> +test_expect_success 'reflog list returns error with additional args' '
> +	cat >expect <<-EOF &&
> +	error: list does not accept arguments: ${SQ}bogus${SQ}
> +	EOF
> +	test_must_fail git reflog list bogus 2>err &&
> +	test_cmp expect err
> +'

Makes sense.

> +test_expect_success 'reflog for symref with unborn target can be listed' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit A &&
> +		git symbolic-ref HEAD refs/heads/unborn &&
> +		cat >expect <<-EOF &&
> +		HEAD
> +		refs/heads/main
> +		EOF
> +		git reflog list >actual &&
> +		test_cmp expect actual
> +	)
> +'

Should this be under REFFILES?  Ah, no, "git symbolic-ref" is valid
under reftable as well, so there is no need to.

Without [5/6], would it have failed to show the reflog for HEAD?

> +test_expect_success 'reflog with invalid object ID can be listed' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit A &&
> +		test-tool ref-store main update-ref msg refs/heads/missing \
> +			$(test_oid deadbeef) "$ZERO_OID" REF_SKIP_OID_VERIFICATION &&
> +		cat >expect <<-EOF &&
> +		HEAD
> +		refs/heads/main
> +		refs/heads/missing
> +		EOF
> +		git reflog list >actual &&
> +		test_cmp expect actual
> +	)
> +'

OK.

>  test_done

It would have been "interesting" to see an example of "there is a
reflog but the underlying ref for it is missing" case, but I think
that falls into a minor repository corruption category, so lack of
such a test is also fine.

