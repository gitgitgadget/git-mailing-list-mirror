Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B78120BB44
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399981; cv=none; b=INI843a0jRFMo7hqd4XAm7bXdLk6Ot4yWbS7zKk5rfFQ3joV/5Hzac1j8U3IjPC+CY/4SDIV2sgN+rftpNAdErDPiHzGgExddEMNSe6qd/RsCxz3FitxQhadWzh0JvHCvrYABK4OYXK9CkHnVch8STA5t64nLzfM67RJQg42u6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399981; c=relaxed/simple;
	bh=HnGEViKukYCyx1rgOQeQWX7tXfXRhKTtXhg+CmPLXaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnAaenhrIC4yv/NOfaNp+c27w4c149AHyw48ubUyUEYfTalRguusXDut3IEbim3mbrMHPQVV2r0/L6PIuei2rsRwQsW0fdpaxlfdAlxkprkHK/xcUvczl1w+v0NoN3rH7IF3iB/8dt5r0pA7NQgtibPvi5IxtJGIcsSaWbK2ASc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bGo9Mum2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bGo9Mum2"
Received: (qmail 30199 invoked by uid 109); 12 Nov 2024 08:26:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HnGEViKukYCyx1rgOQeQWX7tXfXRhKTtXhg+CmPLXaQ=; b=bGo9Mum2k9nSHxX6KZ/5cbdeCrrXZCoIwacihvyxcO5Qqsk3QreJuVzZFYEq+5bp+qmvnAmq9TyOSyB6N+88LnJ9/EtwtJksS4iKBYulpNlXJWRJ5iOpO5Gu/Ye46GmGHXQZRu4sXr53JSOqM6Lj0OCI7qwqL5Gmx2UM6ZvR72acJBmRxMcxyMrxDF0VKZghetm86K9wRGdhQoPYeECIJPuVR1XL4g7sIeK5VxRhsP1o6z01Mo649HyAhIsu4IezNd8OHYxaEDh94YEMZGhi4tUoZWbey2dwjSryNc5yXS9V9NTAWUNqVKrfPOu0iTkibIUpr0shF3NHX3Bs9kFt8w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Nov 2024 08:26:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27435 invoked by uid 111); 12 Nov 2024 08:26:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Nov 2024 03:26:14 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Nov 2024 03:26:09 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH v2 21/27] global: drop `UNLEAK()` annotation
Message-ID: <20241112082609.GA3166560@coredump.intra.peff.net>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
 <20241111-b4-pks-leak-fixes-pt10-v2-21-6154bf91f0b0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-21-6154bf91f0b0@pks.im>

On Mon, Nov 11, 2024 at 11:38:50AM +0100, Patrick Steinhardt wrote:

> There are two users of `UNLEAK()` left in our codebase:
> 
>   - In "builtin/clone.c", annotating the `repo` variable. That leak has
>     already been fixed though as you can see in the context, where we do
>     know to free `repo_to_free`.
> 
>   - In "builtin/diff.c", to unleak entries of the `blob[]` array. That
>     leak has also been fixed, because the entries we assign to that
>     array come from `rev.pending.objects`, and we do eventually release
>     `rev`.

Yay, as the author of UNLEAK() I'm in favor of getting rid of it.

> This neatly demonstrates one of the issues with `UNLEAK()`: it is quite
> easy for the annotation to become stale. A second issue is that its
> whole intent is to paper over leaks. And while that has been a necessary
> evil in the past, because Git was leaking left and right, it isn't
> really much of an issue nowadays where our test suite has no known leaks
> anymore.

I do agree that stale annotations are a weakness (they do not hurt the
leak-checker if they exist, but they are an eye-sore).

I'm not sure I would agree that the intent was to paper over leaks. The
point was to avoid noise from the leak-checker about memory that was
intentionally held until program exit and released by returning from
main(). I think the main thing that made it obsolete is that we decided
it was worth it to spend the cycles freeing that memory rather than
ignoring it.

But it's possible I'm just splitting hairs. :)

At any rate, for whatever reason people did not seem to use it as
intended, and _did_ end up annotating real leaks (papering over them). I
guess I could have done a better job of explaining it.

-Peff
