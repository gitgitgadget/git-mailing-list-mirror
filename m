Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DCC21364
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748309; cv=none; b=s5WxwKBa8/gFQyl66jAoLULMU/1ve7cbZjUr7TqBxUwDM7q1fo5LZ7YuxeBEjxeCAFhsgN8c5ASFfEbiQvhMgFSMJZosq4a/wbo0Sr5BqINbYM95IJpZpRIRa8EuN5myl6FkO395O4PUFO7L8ToGK3wLmlNMB0lJ13Yv3QRN6xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748309; c=relaxed/simple;
	bh=s/yAaE0K9uCDp7YGcDxy9v5poBTktcNxcvIhkNRq5Cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hver+IlAbGITQS7CrvmEHh0yJyFdKNjjMyKKu8KhNxCRLzv3AM00akwmJSAOanf9dMF082jzDckymBGVAHbsh5oRa9XXls/e0tMD0k4CXUYjaUqcJhjKiGwgOzcr3RrwJibP/6L9i8qoqzs6FmKyuqmrX3lMf48Ov8qCIRk3q34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=doNVhNP2; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="doNVhNP2"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CD9BD1E7959;
	Fri, 29 Mar 2024 17:38:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=s/yAaE0K9uCDp7YGcDxy9v5poBTktcNxcvIhkN
	Rq5Cs=; b=doNVhNP271jezaaqB0jWimTCUr+hwuZ53B56oGTxLWE1IZw3/unu6+
	rmgmlUh4+M4CQJYFz0u9e+66B2/T1Qa8GEvIreXKXvhabpuqQesO3qNb8kiY/Cia
	fnZGKdz2LBRJ6dJBUgwVWutujBxj/p6XLC3bEatv2zf8CwvPiypyA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C3EC41E7958;
	Fri, 29 Mar 2024 17:38:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 299581E7956;
	Fri, 29 Mar 2024 17:38:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] builtin/commit: error out when passing untracked
 path with -i
In-Reply-To: <20240329205649.1483032-4-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Sat, 30 Mar 2024 02:26:20 +0530")
References: <20240318155219.494206-2-shyamthakkar001@gmail.com>
	<20240329205649.1483032-4-shyamthakkar001@gmail.com>
Date: Fri, 29 Mar 2024 14:38:24 -0700
Message-ID: <xmqqcyrcwwfj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ACDB6A88-EE14-11EE-9F09-25B3960A682E-77302942!pb-smtp2.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> When we provide a pathspec which does not match any tracked path
> alongside --include, we do not error like without --include. If there
> is something staged, it will commit the staged changes and ignore the
> pathspec which does not match any tracked path. And if nothing is
> staged, it will print the status. Exit code is 0 in both cases (unlike
> without --include). This is also described in the TODO comment before
> the relevant testcase.
>
> Fix this by passing a character array to add_files_to_cache() to
> collect the pathspec matching information and error out if the given
> path is untracked. Also, amend the testcase to check for the error
> message and remove the TODO comment.
>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
>  builtin/commit.c                      |  9 ++++++++-
>  t/t7501-commit-basic-functionality.sh | 16 +---------------
>  2 files changed, 9 insertions(+), 16 deletions(-)

Nice.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 24efeaca98..355f25ec2a 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -441,10 +441,17 @@ static const char *prepare_index(const char **argv, const char *prefix,
>  	 * (B) on failure, rollback the real index.
>  	 */
>  	if (all || (also && pathspec.nr)) {
> +		char *ps_matched = xcalloc(pathspec.nr, 1);
>  		repo_hold_locked_index(the_repository, &index_lock,
>  				       LOCK_DIE_ON_ERROR);
>  		add_files_to_cache(the_repository, also ? prefix : NULL,
> -				   &pathspec, NULL, 0, 0);
> +				   &pathspec, ps_matched, 0, 0);
> +		if (!all && report_path_error(ps_matched, &pathspec)) {
> +			free(ps_matched);
> +			exit(1);
> +		}
> +		free(ps_matched);
> +

Looking simple and very nice.

This change would not have to be redone even if we decide not to add
a new parameter to run_diff_files() and instead add a new member to
the revs structure instead, because it all happens at the level or
below add_files_to_cache().
