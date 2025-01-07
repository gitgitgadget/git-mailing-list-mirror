Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF2DE573
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 02:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218196; cv=none; b=nBVU4F2wTZ0yLuLQqMhCJGXeFkdG3SGwQtKDGMTxN3f3vJYLrPmXPsoeY/nCGxvPpgPr35+qQumdaxed0Bt4v4yXnoTQ3W5Ct4XJ2xWgIktjDhP8vvLdOzrvW2vX2jk3+QfDEaJVWrJDkOJ8ZTAGgBZ6Q82PGZc+twgbeY5saDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218196; c=relaxed/simple;
	bh=OqzG7EM0E4Vlfcf/GvxV0lN8QRNQjcxcZrYp21QgBYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jD8U82esoyfGSy5neB/h89nHSoUHl80pq0UO4I7dVcGqyDyyCuDrmIEa7vT32LHwsXASrO3eI7SWWVzbhksy+z/1huu7KLglmR17Zhm6ezjYvkQ6c/yUCuRIK+wwbJvA8N++po9hgkYCirEiG8ug6Yrgl6rhHAEdReOAvpwSXV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BYasvD3T; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BYasvD3T"
Received: (qmail 26978 invoked by uid 109); 7 Jan 2025 02:49:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OqzG7EM0E4Vlfcf/GvxV0lN8QRNQjcxcZrYp21QgBYY=; b=BYasvD3TJp6ebWNj5kXjdnYvWVl5eleun5uSUQmZI2UqHs5lpglV7ZlTSz61OySxW4+KGobocFAAEG4CyWR0SNFDBZhzq6ZWrHtIqFtirFDy8TiNjZSBLMG7UQ+pJcgnhzRiypkJtGtKSCgiX02gsKFz+b5wWuLq0F8RMiVO8eZHy8aOsCAEsrh+7uOFcfjecCp7QvKfw/wIYiw/mV8pHr2MTq+KaG036VGBQcHJ3yiAnnpd5MBO7tCkTnGRY/Abl50iktSMupT0uzvPhGQqc6nL0IvkxdQeFDoOfepyeQG3NTDq2zWLzMG8kyHgk/f8kLM87F2qDKXPLA6yS36LAw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jan 2025 02:49:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19281 invoked by uid 111); 7 Jan 2025 02:49:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Jan 2025 21:49:52 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Jan 2025 21:49:51 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/10] t7422: fix flaky test caused by buffered stdout
Message-ID: <20250107024951.GD2363@coredump.intra.peff.net>
References: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
 <20250106-b4-pks-ci-fixes-v2-2-06ae540771b7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106-b4-pks-ci-fixes-v2-2-06ae540771b7@pks.im>

On Mon, Jan 06, 2025 at 12:16:51PM +0100, Patrick Steinhardt wrote:

> Fix the issue by making the writer fill the pipe buffer before we
> execute git-submodule(1). Ideally, it would be git-submodule(1) itself
> that does produce all that data, but it would require us to create a
> large amount of submodules, which is inefficient. Instead, we use Perl
> to print gibberish until the buffer is filled.
> 
> To verify that this works as expected one can apply the following patch
> to the preimage of this commit, which used to reliably trigger the race:
> 
>     diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
>     index f21e920367..9338c75626 100755
>     --- a/t/t7422-submodule-output.sh
>     +++ b/t/t7422-submodule-output.sh
>     @@ -168,7 +168,7 @@ done
> 
>      test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE' '
>             { git submodule status --recursive 2>err; echo $?>status; } |
>     -		grep -q X/S &&
>     +		{ sleep 1 && grep -q X/S; } &&
>             test_must_be_empty err &&
>             test_match_signal 13 "$(cat status)"
>      '
> 
> With the pipe-stuffing workaround the test runs successfully.

Sadly this isn't enough. The pipe-stuffing solves the race with grep
_starting_ (and thus the extra "sleep"), but the fundamental race we've
seen in practice still remains. See my reply the v1 thread for details.

-Peff
