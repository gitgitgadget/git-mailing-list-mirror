Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC60219EC
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566415; cv=none; b=jD+58z0sI7dVdT2Cl83UU4DWvsPsyeNxhZH4jkFEq0/m1DfvSMhx6rSuiDe8saym/uvlH3C8dIl0MQaCb2kLppDkOANcnjd23n/nY0+XA79S6xnWVR927k73i3f4HzXPpf95EVZHn35hQ50LpOrAMC8yyP4UFudpHzJaL/AeYAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566415; c=relaxed/simple;
	bh=qNusZbZGQAFIyahrWXZNhiY7RAk6Cy9sYj+NcJufa5g=;
	h=References:DKIM-Signature:X-Report-Abuse:From:To:Cc:Subject:Date:
	 In-reply-to:Message-ID:MIME-Version:Content-Type:X-Migadu-Flow; b=icrRDyofyWa/vi+up9bKjOQsnNYsNoB7vvsnVqLaTXnlbmEvEmxZdYqu3Xw2Uk7zB6uRC9UAiV1rKN6emerVvFjBtrmUU/vmzl1gphCZ9tlNQomSq6GXGq8y76yneq7CnC2dOO8CGQp8ugfo1WI0D4zujMye39GqMl2A3toWNn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=xDJIfXRd; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="xDJIfXRd"
References: <20240110141559.387815-1-toon@iotcl.com>
 <20240110141559.387815-2-toon@iotcl.com>
 <CAPig+cTRHHJ3pzWJtVJf8rKhvAJFYqrO0JsyTRTi6T5s+gznDg@mail.gmail.com>
 <874jflfc26.fsf@iotcl.com> <ZadzwA6vNnRPbKYh@tanuki>
 <xmqqmst3tv7j.fsf@gitster.g>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1705566409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r/yHAaEYn9fToD/nb1Sb0yt5oQ4+Bl+CJq0SNHQKjPc=;
	b=xDJIfXRdZ39D9rAn8khwGsRmZqe1ss/M+3qYq+gx3k7XXj57cUxYHS2i+febUWKRdTfGFK
	Tdn6tMIxzDC14bynf+/e6cwzDbjIvqA6+7/iHk5bCompZqe3+ck/Ycl4mmuGYICUg6OSal
	ehuXg6NYKeoxhRsrk4ZaKoIBpjPqQqw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Eric Sunshine <sunshine@sunshineco.com>,
 git@vger.kernel.org
Subject: Re: [PATCH 1/1] builtin/show-ref: treat directory directory as
 non-existing in --exists
Date: Thu, 18 Jan 2024 09:24:56 +0100
In-reply-to: <xmqqmst3tv7j.fsf@gitster.g>
Message-ID: <87le8nqc73.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT


Junio C Hamano <gitster@pobox.com> writes:

> Yup.  The patch looks good.  Here is what I tentatively queued.
>
> ----- >8 -----
> From: Toon Claes <toon@iotcl.com>
> Date: Wed, 10 Jan 2024 15:15:59 +0100
> Subject: [PATCH] builtin/show-ref: treat directory directory as non-existing
>  in --exists

You have a duplicate "directory" here.

> 9080a7f178 (builtin/show-ref: add new mode to check for reference
> existence, 2023-10-31) added the option --exists to git-show-ref(1).
>
> When you use this option against a ref that doesn't exist, but it is
> a parent directory of an existing ref, you get the following error:
>
>     $ git show-ref --exists refs/heads
>     error: failed to look up reference: Is a directory
>
> when the ref-files backend is in use.  To be more clear to user,
> hide the error about having found a directory.  What matters to the
> user is that the named ref does not exist.  Instead, print the same
> error as when the ref was not found:
>
>     error: reference does not exist
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/show-ref.c  | 2 +-
>  t/t1403-show-ref.sh | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> index 7aac525a87..6025ce223d 100644
> --- a/builtin/show-ref.c
> +++ b/builtin/show-ref.c
> @@ -239,7 +239,7 @@ static int cmd_show_ref__exists(const char **refs)
>  	if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
>  			      &unused_oid, &unused_referent, &unused_type,
>  			      &failure_errno)) {
> -		if (failure_errno == ENOENT) {
> +		if (failure_errno == ENOENT || failure_errno == EISDIR) {
>  			error(_("reference does not exist"));
>  			ret = 2;
>  		} else {
> diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
> index b50ae6fcf1..a8055f7fe1 100755
> --- a/t/t1403-show-ref.sh
> +++ b/t/t1403-show-ref.sh
> @@ -260,9 +260,9 @@ test_expect_success '--exists with non-commit object' '
>
>  test_expect_success '--exists with directory fails with generic error' '
>  	cat >expect <<-EOF &&
> -	error: failed to look up reference: Is a directory
> +	error: reference does not exist
>  	EOF
> -	test_expect_code 1 git show-ref --exists refs/heads 2>err &&
> +	test_expect_code 2 git show-ref --exists refs/heads 2>err &&
>  	test_cmp expect err
>  '

The rest looks all good to me.

--
Toon
