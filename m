Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBDA18563A
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 23:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720569311; cv=none; b=rkUSatuhZGdlkqRUL8ebzfSNBaF5AbizbtIBP/YsUY9yYLiwUcEJmniq6rI8qYuGoJpCfRPhEso+KsZGhyM8Y5tvZUCiyX9hePXjSFslUk5+5toDuHBYrwGiCtKn0cgsLCZ2hGhJD4Lc5ZqO6y9Y3OVXCf2ubWuUhdVDKdTcwZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720569311; c=relaxed/simple;
	bh=DMMGPF23IEVuH9JPXBK3am5UvxrhG0u0WmSynEoRzKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTDb0Lsk96NXYhRG0ZKkZ+czuTgnGA7oy+E1UeKq7Ln6xo7CSC2DilQg74miAimiRFV8qwm9RT1KeX25byuk0Va+31J5vgYyz7MDsfNW6qFL387NBq8JIbZbDGYvQJLYHOstPCAcE6NnlPL2ISWGa7XURq/CfOOZ7akZQ3y7qUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29788 invoked by uid 109); 9 Jul 2024 23:55:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Jul 2024 23:55:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6381 invoked by uid 111); 9 Jul 2024 23:55:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Jul 2024 19:55:06 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 9 Jul 2024 19:55:07 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] builtin/push: call set_refspecs after validating
 remote
Message-ID: <20240709235507.GB1525171@coredump.intra.peff.net>
References: <20240708140350.622986-1-karthik.188@gmail.com>
 <20240709144931.1146528-1-karthik.188@gmail.com>
 <xmqq4j8yflrq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4j8yflrq.fsf@gitster.g>

On Tue, Jul 09, 2024 at 11:44:25AM -0700, Junio C Hamano wrote:

> In any case, an obvious additional fix on top of your change might
> be to do something like this:
> 
>         diff --git i/remote.c w/remote.c
>         index 5fa046c8f8..d7f9ba3571 100644
>         --- i/remote.c
>         +++ w/remote.c
>         @@ -682,7 +682,7 @@ remotes_remote_get_1(
>                 struct remote *ret;
>                 int name_given = 0;
> 
>         -	if (name)
>         +	if (name && *name)
>                         name_given = 1;
>                 else
>                         name = get_default(remote_state, remote_state->current_branch,
> 
> which would give us the default remote name, and we would not call
> add_url_alias() with a bogus empty string to nuke the list.

FWIW, I almost suggested something like this earlier. The outcome will
be the same (remote_get(), etc, will return NULL), but I think it
removes the "this is surprising" comment from my earlier email and makes
things much more explicit.

(I also agree with everything else you said in your review).

-Peff
