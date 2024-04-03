Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0915099C
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168893; cv=none; b=HsOFnJQIesC1o017CsEPWJD9LqDxYcbqN+bqpLrmaTY2sG+oyiLIGcwukppU3L4IcbmVyhsHd3h0MdhdILW9V2O57HYj1oM+sNOEnw4l54GAu8LMmk0Ec7G9QDajqOd8FJrgqKSQ8ps1Lp1FHTuurWyEYvFjppgvtGtd65dm9vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168893; c=relaxed/simple;
	bh=YADoH2cJm8w0P3ti9PzCE55IM+t7hED2GVdHONTV1cA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sfad85KN0h1APbCDOhuYvnKlmR6ugaTcMW5O6ZojAqQj+lq286PJkMsBxdBgC/Km8vABNSQVtHsdMKdFBQrA2tIuVrmIIYZVX3c7FDdk0g7lWqsBCrDCvPxOM2AmdNkseBKm03T7aR71PUI5yTYkxn4YJiHWbJvqYyDgWy+Kmlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AskeXGV1; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AskeXGV1"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D2EC1DC190;
	Wed,  3 Apr 2024 14:28:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YADoH2cJm8w0P3ti9PzCE55IM+t7hED2GVdHON
	TV1cA=; b=AskeXGV1zza7EXAe00BvpnJWWAs9TuSgd4htvEfRZVZXhzsPIeTEFM
	3Yx9ThmJ6uPCl87bDJKiEx6lrz6/j2ezCDS6mw53Nr1D3xQalLxvDsu+DAgSVd9R
	JEQHQTq3McxmUS+U5F4l6fG4IpdgHr9Qsw34sAXMsuy4bLkYmLkVs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 830901DC18E;
	Wed,  3 Apr 2024 14:28:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 825511DC14D;
	Wed,  3 Apr 2024 14:28:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/9] refs/reftable: fix D/F conflict error message on
 ref copy
In-Reply-To: <14b4dacd731a7d9c19029cd8a0c3b6170c31ae25.1712078736.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 2 Apr 2024 19:29:51 +0200")
References: <cover.1712078736.git.ps@pks.im>
	<14b4dacd731a7d9c19029cd8a0c3b6170c31ae25.1712078736.git.ps@pks.im>
Date: Wed, 03 Apr 2024 11:28:04 -0700
Message-ID: <xmqqr0fm713f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EB7BAEA2-F1E7-11EE-8663-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The `write_copy_table()` function is shared between the reftable
> implementations for renaming and copying refs. The only difference
> between those two cases is that the rename will also delete the old
> reference, whereas copying won't.
>
> This has resulted in a bug though where we don't properly verify refname
> availability. When calling `refs_verify_refname_available()`, we always
> add the old ref name to the list of refs to be skipped when computing
> availability, which indicates that the name would be available even if
> it already exists at the current point in time. This is only the right
> thing to do for renames though, not for copies.
>
> The consequence of this bug is quite harmless because the reftable
> backend has its own checks for D/F conflicts further down in the call
> stack, and thus we refuse the update regardless of the bug. But all the
> user gets in this case is an uninformative message that copying the ref
> has failed, without any further details.
>
> Fix the bug and only add the old name to the skip-list in case we rename
> the ref. Consequently, this error case will now be handled by
> `refs_verify_refname_available()`, which knows to provide a proper error
> message.

OK.  Nicely described.  Instead of letting the reftable code
downstream to notice an update that was left uncaught by an extra
element in &skip, we will let refs_verify_refname_available() to
catch it at the right place.  Makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c    |  3 ++-
>  t/t0610-reftable-basics.sh | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index e206d5a073..0358da14db 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1351,7 +1351,8 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
>  	/*
>  	 * Verify that the new refname is available.
>  	 */
> -	string_list_insert(&skip, arg->oldname);
> +	if (arg->delete_old)
> +		string_list_insert(&skip, arg->oldname);
>  	ret = refs_verify_refname_available(&arg->refs->base, arg->newname,
>  					    NULL, &skip, &errbuf);
>  	if (ret < 0) {
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index 686781192e..055231a707 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -730,6 +730,39 @@ test_expect_success 'reflog: updates via HEAD update HEAD reflog' '
>  	)
>  '
>  
> +test_expect_success 'branch: copying branch with D/F conflict' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit A &&
> +		git branch branch &&
> +		cat >expect <<-EOF &&
> +		error: ${SQ}refs/heads/branch${SQ} exists; cannot create ${SQ}refs/heads/branch/moved${SQ}
> +		fatal: branch copy failed
> +		EOF
> +		test_must_fail git branch -c branch branch/moved 2>err &&
> +		test_cmp expect err
> +	)
> +'
> +
> +test_expect_success 'branch: moving branch with D/F conflict' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit A &&
> +		git branch branch &&
> +		git branch conflict &&
> +		cat >expect <<-EOF &&
> +		error: ${SQ}refs/heads/conflict${SQ} exists; cannot create ${SQ}refs/heads/conflict/moved${SQ}
> +		fatal: branch rename failed
> +		EOF
> +		test_must_fail git branch -m branch conflict/moved 2>err &&
> +		test_cmp expect err
> +	)
> +'
> +
>  test_expect_success 'worktree: adding worktree creates separate stack' '
>  	test_when_finished "rm -rf repo worktree" &&
>  	git init repo &&
