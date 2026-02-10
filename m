Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CB72288CB
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770763617; cv=none; b=JYlC84w/g/J4Zc950y5yCocccjIf+HDto61jEDWtPSZow2sRFbQBQZ3mUlVXh18xPv/unhAJlq1fozhnPdVVzSBz2FWyK63ngSnNWK9XqpSO1KIylh1LaUy0+X3ZAfbzIBxREHE4gwnI+FKHdHXXVUG/rb2KGVS6VBdGeKUbUpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770763617; c=relaxed/simple;
	bh=DA9LlheF1ZTWNGGqZbsSoS47twLkjThn7YeXhPMTt/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIZTk97Z/D4ZAhaI2t9O8HnW15pvTTiQnuor4YV1UDUq6rS4D/lBhCi0aXpE+sTnTrWkHwulMlMvZJ6/StLhxKlyunIwOkknifCbDG50NYxvmVf20k/sGWzDzLvok8OiqDID02c/v4xSvSCgTUtHFeZyJC5Vlh3bsLIxl6eoOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ztv3h6SH; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ztv3h6SH"
Received: (qmail 6875 invoked by uid 109); 10 Feb 2026 22:46:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=DA9LlheF1ZTWNGGqZbsSoS47twLkjThn7YeXhPMTt/I=; b=Ztv3h6SHqMCvobl2h2MTRzSU1uLCfonGWOgvylc8ozk88nMDR/yTLN8WmUJEXJ5utHiBvGs13tmW6DAms/DvpCNvpTUO+DZe0LjST+lYvwzuKPgOKBg5ApYD576afrRHq1iA3IjuE+qsbS9HTyJZewMGUSvT3BpUPrEWFgZl4pLkBJ3m2cD7CRooa1MDEEihUnuGKgvkHsovJBOjWZHM16gVdV8SDT2SwZYYbjpO9oj1pgInK7o2zHr4ldMOM75fYnr06pxCgRffqiQQQxngKj/IQ4FB4gMmVbedKgdqddbvFPDZqGZK6kdVXzW3IfKPx5X/MDUDUIxfG+VHzuV/3g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Feb 2026 22:46:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13323 invoked by uid 111); 10 Feb 2026 22:46:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Feb 2026 17:46:57 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Feb 2026 17:46:54 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	gitster@pobox.com
Subject: Re: [PATCH v5 2/4] refs: forward and use the reference storage
 payload
Message-ID: <20260210224654.GA1837132@coredump.intra.peff.net>
References: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
 <20260209-kn-alternate-ref-dir-v5-2-740899834ceb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260209-kn-alternate-ref-dir-v5-2-740899834ceb@gmail.com>

On Mon, Feb 09, 2026 at 04:58:19PM +0100, Karthik Nayak wrote:

> +	if (*is_worktree) {
> +		char *wt_id = strrchr(gitdir, '/') + 1;
> +		strbuf_addf(refdir, "/worktrees/%s", wt_id);
> +	}

This is another instance where the new version of glibc will complain
about const-ness. The wt_id variable can just be marked as const.

(This and the other one I pointed out are the only two cases in your
series).

BTW, is it possible to have a gitdir string without a slash in it? I
guess not if it is absolute, but I didn't look at the caller to see if
that is always true. Anyway, I wonder if we should be checking the
result of strrchr() here.

-Peff
