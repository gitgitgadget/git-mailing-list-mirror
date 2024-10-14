Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA44C1A7074
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896933; cv=none; b=mDHciUb0AAMaHF+oRsF7LpwQmUPp4buoTOzwgXoTIn/jwsARFeFmQrPodd75j0LzXZihzLPQDkr6+aEMGAkN4AJhleu3odpgIrhp/Ekt00KQuAIsxCH0778rxKlb8attp8dZgo4sdWxgNIBbUjBGtGkHAfYVRPWX55YfYqfHBaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896933; c=relaxed/simple;
	bh=dmTGAqiX4FLDQlrd2PrY+yNXDSQuzDcz5cr56x5+Jzo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IBf8ffpEO8QanqdLrQkkKtLdinwkrRjUqb6g8wNj9jDjnNpBO9RaJpYuxO9zKDLUMc+JA63edb/cHUXFA43ZhtHNBVRgd4dr4DWrW/sfmjUphXWknq4WguxgG09AFyKf0eF2l74TgxMt7Hmf149ANU0lRCX7A6pdYyxgmz4Poxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=hGIJZjBI; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="hGIJZjBI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1728896925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kdAGohnqlrPU46Ffr0xNEcsg0YsFWzEVPcdLSwCHXzg=;
	b=hGIJZjBInFgny+wH237FFSbU14zdg1/3l9XXP4Q3oq/zEIqwe0jKtm/Cxn9BWq2B3brJhW
	9zc9WjZlBBIXc4EeQSahB2d0nizyNbF6yznlAtlxCPlYh9z36K2g8gqH8e12Nnkc8cEx1U
	1cawFC8emThnDcqSbSsP/f7VRSqTzV4=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, karthik.188@gmail.com
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com,
 johannes.schindelin@gmx.de, spectral@google.com
Subject: Re: [PATCH v3 1/3] clang-format: re-adjust line break penalties
In-Reply-To: <74bbd2f9db1ddfd5210be8fde2db84f67acff27d.1728697428.git.karthik.188@gmail.com>
References: <cover.1728697428.git.karthik.188@gmail.com>
 <74bbd2f9db1ddfd5210be8fde2db84f67acff27d.1728697428.git.karthik.188@gmail.com>
Date: Mon, 14 Oct 2024 11:08:29 +0200
Message-ID: <871q0jrr02.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

[snip]

> This avoids weird formatting like:
>
>    static const struct strbuf *
>           a_really_really_large_function_name(struct strbuf resolved,
>           const char *path, int flags)
>
> or
>
>    static const struct strbuf *a_really_really_large_function_name(
>    	    struct strbuf resolved, const char *path, int flags)
>
> to instead have something more readable like:
>
>    static const struct strbuf *a_really_really_large_function_name(struct strbuf resolved,
>           const char *path, int flags)
>
> This is done by bumping the values of 'PenaltyReturnTypeOnItsOwnLine'
> and 'PenaltyBreakOpenParenthesis' to 300. This is so that we can allow a
> few characters above the 80 column limit to make code more readable.

I'm really liking the idea of penalties, but I feel we're relying too
much on guestimation of these values. What do you think about adding
example files to our codebase? Having concrete examples at hand will
allow us to tweak the values in the future, while preserving behavior
for existing cases. Or when we decide to change them, we understand
what and when.

Now, I'm not sure where to put such files. I think I would suggest
something like t/style-lint or t/clang-format. Anyway, for our tooling
it doesn't seem to matter, because both `make style` and
`ci/run-style-check.sh` pick up all .c and .h files anywhere in the
source tree. Adding a README to that directory will help people
understand why the files are there.

--
Toon
