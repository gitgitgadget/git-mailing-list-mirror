Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374DE52F66
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769892; cv=none; b=e3722oOAMm/99vw3yk4E0D28f9p4WbM/qJsKVRd9ew/oRvT1oJXqkB3CIGxp4RJsSQRVHuhwzAWUGK0jy3QTGa71L9YpxDUaW1ggm1DdcZoZerm8MGWR2OAg1dQeI5nwPn7oDWMGjCOTRCtNjC++7+6BESEsBorfGgEmVuQljwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769892; c=relaxed/simple;
	bh=3cfT4LIUPAqhZIIoVCaLLpfFa03MCzZYA8pp/fAj4Fg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uWAnQNqlzHncLlZt8EMJ8UI7EBmPdviZTrIoHQfu1pcZ8ZpTVffb9GikhPQ8JF2eNG6hD4jnlBT6N9Ni9F3xqm1lVBujqAu4zGFm6pZ1FkVtjVPFG8ys+CqcCMlgoBhylyFR2hc6h/Aaq7Oka0YaQU5aTlLFF5OiUQ3hG28UDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ImPbrC7a; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ImPbrC7a"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1752769884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h7vLaxUIcvsK9pkHot7QOFw3B1dO3ogdR0Um/bw8slo=;
	b=ImPbrC7aJNY4SXYXg5B86GswDqUhLoQBSFbVuvZl+qUvNum6vCLngMIPMBjaykrZdkOi4m
	ghoB6hOiRYGtxstDtsrhAGoBGyvOckwhzW2JT8shcm+Un+lYB2OJYF8HM5wZHnX0Y308S1
	Bsmt811hnBYytrEwAe7MW3cma0DxFec=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Derrick Stolee <stolee@gmail.com>,
 Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 4/6] pretty: allow caller to disable indentation
In-Reply-To: <xmqqbjpkcey4.fsf@gitster.g>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
 <20250716133518.1788126-4-toon@iotcl.com> <xmqqbjpkcey4.fsf@gitster.g>
Date: Thu, 17 Jul 2025 18:31:08 +0200
Message-ID: <87wm86ixtf.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> Most pretty formats indent the commit message with 4 spaces. Add field
>> `no_indent` to `struct pretty_print_context` to suppress this
>> indentation.
>>
>> Signed-off-by: Toon Claes <toon@iotcl.com>
>>
>> # Conflicts:
>> #	pretty.h
>
> Careful.  There is no need to rush your patches to send a version
> that hasn't been proof-read.

Whoops, I missed that. No idea how that happened. I have
`core.commentchar` set to `;`, because I used to write markdown headings
in my commit messages (with leading `#`). But even then, this should not
happen. I'm curious if I'm able to figure out what went wrong...

>>
>> Signed-off-by: Toon Claes <toon@iotcl.com>
>> ---
>
> I doubt that this is what you want in this series anyway, though.
> You use this for "-z --extended", which presumably is about giving
> the output that is as faithful as possible to the original, but if
> you look at pretty_print_commit(), it does a LOT MORE than just
> indent the log by 4 spaces.  I suspect you would rather want to
> avoid even calling pretty_print_commit() in such a code path.

That's a good point. Before I submitted this version I was thinking to
have it support `--format` and `--pretty`, but that was even more
complex than what we have here. Indeed, we probably don't need
pretty_print_commit(). 

-- 
Cheers,
Toon
