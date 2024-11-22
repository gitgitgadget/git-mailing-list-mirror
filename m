Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9400013AC1
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732289439; cv=none; b=mPwKmdFTVU5F6KY9Iw2hC9YzQxfCX9lKz9Zh2FbtPoJbKrhQKLsCAZuIFizFP08TvbTgJRNq/b0xXmOAQascM08y2toSx0QLwbaobsbVShcMgBrZxL2EiMFPMcJZe3YQmlYbL/N4qRXEEwTW+JgcnJb6/URzEZlA4O3BDYGAu1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732289439; c=relaxed/simple;
	bh=Y3pnSZwIYJmVfsNykGWmESdfKFLF3ngKUVJePsmTmK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfGvg8ieYcOSBEo3auUIN5vsXp0HwaTXLcAbAObG3WAPeF62fWRue+cpjCKYlOYmXJaRINY70I7pzXAiPWofsA0LagSf55bc+WIYRUOEuoxHEyIj/f3lU9zCHHf1yBQ2s91/AqYiaoYlovptZfebJG02XuGkA8rZlkXq7avH63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EeeZBngu; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EeeZBngu"
Received: (qmail 13576 invoked by uid 109); 22 Nov 2024 15:30:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Y3pnSZwIYJmVfsNykGWmESdfKFLF3ngKUVJePsmTmK0=; b=EeeZBnguRzEbZ5gnB5x+3dRu6mQrbvN1MtVTBzYk2acBak0/AEbOB7GIJeAqIpJvZsyNxGpFBMczOFeYVA/5Mfakyba1OLMP1DCrZ4LOgeh3sSzMsd3yDFalJlGjINvT5ods5SaNXZbVDKf7YAp7mE4S/MYRJNBR8AS4CaUMoYaFsOMlGgVecP6tpHEQvR7c4hbzFP1qykZ1s5DEQFNQCVnEqKKkHtThWNgnGlvaLxFa1yoYZ/RHJP/IhUdqzxSwb/+hWkZwpbVKAEwVzYjQxKGQllnDntDI6Dm7+CSad176//EOo9ShchUI2VLFzYHIQgPoPIkX3+77+gOT0QfC6Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Nov 2024 15:30:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5756 invoked by uid 111); 22 Nov 2024 15:30:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Nov 2024 10:30:34 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 22 Nov 2024 10:30:33 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Miguel Rincon Barahona <mrincon@gitlab.com>,
	Kev Kloss <kkloss@gitlab.com>
Subject: Re: [PATCH] builtin/gc: provide hint when maintenance hits a stale
 schedule lock
Message-ID: <20241122153033.GA1737136@coredump.intra.peff.net>
References: <20241119-pks-maintenance-hint-with-stale-lock-v1-1-f9f9a98e12a0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119-pks-maintenance-hint-with-stale-lock-v1-1-f9f9a98e12a0@pks.im>

On Tue, Nov 19, 2024 at 11:48:43AM +0100, Patrick Steinhardt wrote:

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index c224c8450c85f567bc29258e18b4a59fe6682f0a..6d6ffaaf376bdbadecdb23a460994af1d218dc19 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -1011,4 +1011,12 @@ test_expect_success 'repacking loose objects is quiet' '
>  	)
>  '
>  
> +test_expect_success 'maintenance aborts with existing lock file' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	: >repo/.git/objects/schedule.lock &&
> +	test_must_fail git -C repo maintenance start 2>err &&
> +	test_grep "Another scheduled git-maintenance(1) process seems to be running" err
> +'

This failed for me in all of the macos jobs of GitHub CI. Looks like the
err file contains:

  fatal: launchctl scheduler is not available

So maybe it's a platform image issue?

-Peff
