Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D143D2A8E5
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729373183; cv=none; b=bGoZxon8mPX8+2fS1kb8aO0OT7BtQdOxlCWzty8mWOrWkloyQOT0yVspvdHLMXbKD+G/NVySS6jAEF7TlYiPaHSqwQr6/mn8ti1Myeu70w13QrXhA8nC0cV+zPUuU4ki27uT4D2Q5QSqzN6/0OC3R1+o0kMRYB5f8n3lXyKhE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729373183; c=relaxed/simple;
	bh=i/eTDnixc2zK6fPs4NBN7BaxW462mse6JeNCC8/AXVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtlggONJ9vzLdea6rU8kbjyq3UbjdV/kx3Xi4cdN5TjHa9e+dHE75j3aS1zSIBaCb18iJmk2hZqiuuB3veH71rshSGorjdK8C8pSQVpq0cpUUYEjwdVN16OJVhNT1cMlDHu4gkw4RAhjpaWfiQM9/7j3vxjZ9J6VbRT+7YCo6VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PYIBv30v; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PYIBv30v"
Received: (qmail 16342 invoked by uid 109); 19 Oct 2024 21:19:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=i/eTDnixc2zK6fPs4NBN7BaxW462mse6JeNCC8/AXVk=; b=PYIBv30vy70xp2YZMncXbaNujPQXJNj9fKlRYXHAyPeLAdEs2upJmvxOwb4uBRfuG+GFzlZyZ5sGyBp1VR8NEqo7eN2OlKSPgPmVKI/7HpJ3s993KR+NgBOptedQmr7enWCorivRfHrktBkqFolHTJdIF5LaEdsseb4PnnNae0xSDSWb2Wnzn0RSeejtzcx5amdWxMV7RKYqBJDvmlQERO7BymPsr2XH9jC085zfR4de6TIvcEtvqTRKhp/2hWhBNm9aSc4YLcUEUOOAlS+4pC2apxYzI1TlD9OdWntsZwL+eN3GxVSeqBxQptnri11nMYUn492yOawRWsIQJQE4nQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 19 Oct 2024 21:19:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4520 invoked by uid 111); 19 Oct 2024 21:19:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Oct 2024 17:19:39 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 19 Oct 2024 17:19:38 -0400
From: Jeff King <peff@peff.net>
To: Y5 via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Y5 <y5c4l3@proton.me>
Subject: Re: [PATCH] diff: setup pager only before diff contents truly ready
Message-ID: <20241019211938.GA589728@coredump.intra.peff.net>
References: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com>

On Sat, Oct 19, 2024 at 08:39:50PM +0000, Y5 via GitGitGadget wrote:

> git-diff setups pager at an early stage in cmd_diff; running diff with
> invalid options like git diff --invalid will unexpectedly starts a
> pager, which causes behavior inconsistency.

I do think the outcome is a little nicer for the user, but I'd hesitate
to call it more inconsistent. Most of the rest of Git is setting up the
pager in git.c, before we even call into the builtin. So any early
errors will likewise go to the pager. E.g., try "git log --foo".

So I dunno. I'm not strictly opposed to making things nicer when we can
do so easily.  But the endgame of this is probably getting rid of
USE_PAGER entirely and asking each builtin to decide when to commit to
using the pager (presumably after option parsing).

And even then, it wouldn't apply to commands implemented as an external
process. And of course we can still die(), etc, after starting the
pager. So it would never be totally consistent.

> Signed-off-by: y5c4l3 <y5c4l3@proton.me>

We usually ask for something approaching a legal name, as this sign-off
is supposed to be certifying the DCO (see the "dco" section in
Documentation/SubmittingPatches).

>  builtin/diff.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

The patch itself looks plausibly correct. The biggest regression risk
would be missing a spot that needed a new setup_diff_pager() call, and I
suspect we don't have good test coverage here. But going top-down from
builtin_diff(), I don't see any paths you missed.

-Peff
