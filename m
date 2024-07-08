Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6751149DEF
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466265; cv=none; b=jTMT9MJTUara5byHcnn5oY9TNV/mkfK62ieTwxohoL5FSxIR7XCn0hDy7sZNxUy6sqLmRx3E3UiDEx1GplMEYHhS59lcMU3KWW4y9IAzLiU7nbfgeu/Q1/Zso8trYsMzQTvlwXkwKIKujKwuoX7fwGhpbfS1pC9Z4OslJwElJwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466265; c=relaxed/simple;
	bh=oLaYk8vwd1R8jUx8dRR9aYic5SRyhzQpSEQWZT70nTo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C9k6Mjo5ntDSVaej9OfFMt0IJ8uAjxO9URsie4TSMISxMPIM4HEKGqLphzuKq4GXbmqgXvE/cD2+BCaxGlwYH2WUAQhnfg6Zdz3zmaTrd4vJFP/GLv1g/7CvMwOo9gu8xELaBUrCZdbug6Dr2SLoM73g7tDstYcQDwwANFb66fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=C0uvTLTg; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C0uvTLTg"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7732B35ABB;
	Mon,  8 Jul 2024 15:17:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oLaYk8vwd1R8jUx8dRR9aYic5SRyhzQpSEQWZT
	70nTo=; b=C0uvTLTg9rQaY6nZVyOX4XZBIZCTtsf/4TAKeCfiv7wyKa3IRcxS35
	boYN5TwjkzRQCT6kL4YrNxweG2jppnMMVhrDbl33o3/5s+j2QzI+dskPc1uEt7q6
	MMZqWJgkJrlLYCg4ys3EXwCdfTTJYTdPTA6Mu89i6Wn3E08ei9MNM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5BEA435ABA;
	Mon,  8 Jul 2024 15:17:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DE99C35AB9;
	Mon,  8 Jul 2024 15:17:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH] builtin/push: call set_refspecs after validating remote
In-Reply-To: <20240708140350.622986-1-karthik.188@gmail.com> (Karthik Nayak's
	message of "Mon, 8 Jul 2024 16:03:50 +0200")
References: <20240708140350.622986-1-karthik.188@gmail.com>
Date: Mon, 08 Jul 2024 12:17:38 -0700
Message-ID: <xmqqsewjelrh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BE373052-3D5E-11EF-BC32-C38742FD603B-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Since 9badf97c4 (remote: allow resetting url list),

Please do not be original in places where it shouldn't matter.  Use
"git show -s --format=reference" that includes the datestamp to help
readers judge how old the problem is.

> we reset the remote
> URL if the provided URL is empty. This means any caller of
> `remotes_remote_get()` would now get a NULL remote.

"NULL remote" meaning?

If you have this:

 [remote "multi"]
	url = wrong-one
	url = wrong-two
	url =

and ask "remotes_remote_get()" to give you the remote "multi", you'd
get a remote whose URL array has no elements.  Is that what you are
referring to?

> The 'builtin/push.c' code, calls 'set_refspecs' before validating the
> remote.

There is a comment about "lazily grab remote", so it is very
understandable.

> This worked earlier since we would get a remote, albeit with an
> empty URL. With the new changes, we get a NULL remote and this crashes.

You'd really really need to clarify what you mean by "a NULL remote"
if you want the proposed log message and the change to be
understood.  The change made by 9badf97c (remote: allow resetting
url list, 2024-06-14), as far as I can tell, can make the strvecs
that hold URL and pushURL in a remote structure empty, but it does
not otherwise destroy the remote structure, or nullify a pointer
that points at the remote structure.  So I am completely lost here.
