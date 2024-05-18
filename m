Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B407F1BC4B
	for <git@vger.kernel.org>; Sat, 18 May 2024 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716056084; cv=none; b=ng2jl/nrXiqv9pQojDDkPYRXJlf9Io8IEgt/n3jnowcGYoYuVaN/gq9TY5yC6QnKpXyPTjKXQWrZJ6nmh7jtg7RuQ0caszkX/Ov4C3f7mnvhGbkwmHt4U00xtoWCnXT45BNrcdgBODDHhuI23J9QvPdoyFF7FB5J1SJp+GkvnQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716056084; c=relaxed/simple;
	bh=aBu7N3hq9bH27j6s297zGqVI5yO6yyigWjuX0rQKIzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhPIeycKre4mqpLq0OVQ4LDwx1fDkTXItrk44S1LcMtFLgJEh42EKSqK5yw2ZVmFsuKWSNmUA4RAxRjyMli5yFqOF2+kvNn/Q0pWqh0AtMy9fGWExygi0KXj/aA7Snt/vzkYSdLxLc27QqmXmKkB4F+ocXN4Y7uez7w5PUDw8ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23979 invoked by uid 109); 18 May 2024 18:14:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 May 2024 18:14:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4525 invoked by uid 111); 18 May 2024 18:14:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 May 2024 14:14:34 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 May 2024 14:14:32 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 5/8] hook(clone protections): add escape hatch
Message-ID: <20240518181432.GA1570600@coredump.intra.peff.net>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
 <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
 <b841db8392ebd924d1893829a7e5e22240f1e9cf.1716028366.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b841db8392ebd924d1893829a7e5e22240f1e9cf.1716028366.git.gitgitgadget@gmail.com>

On Sat, May 18, 2024 at 10:32:43AM +0000, Johannes Schindelin via GitGitGadget wrote:

> To help Git LFS, and other tools behaving similarly (if there are any),
> let's add a new, multi-valued `safe.hook.sha256` config setting. Like
> the already-existing `safe.*` settings, it is ignored in
> repository-local configs, and it is interpreted as a list of SHA-256
> checksums of hooks' contents that are safe to execute during a clone
> operation. Future Git LFS versions will need to write those entries at
> the same time they install the `smudge`/`clean` filters.

This scheme seems more complicated for the user than the sometimes
discussed ability to specify hook paths via config (not core.hooksPath,
which covers _all_ hooks, but one which allows a per-hook path).

In either case, we're considering config to be a trusted source of
truth, so I think the security properties are the same. But for the
system here, a user updating a hook needs to do multiple steps:

  - compute the sha256 of the hook (for which we provide no tooling
    support, though hopefully it is obvious how to use other tools)

  - add the config for the sha256

  - install the new hook into $GIT_DIR/hooks

Whereas if the config can just point at the hook, then there is only one
step: add the config for the hook (presumably pointing to a system
version that would have been copied into $GIT_DIR/hooks previously).

Likewise for updates of the hooks, where the sha256 scheme requires
computing and adding a new hash. But when the config just points to the
path, there is no additional step for updating.

In either scheme, programs like git-lfs would have to adjust to the new
world view. The main advantage of the sha256 scheme, it seems to me, is
that the baked-in sha256 values let existing versions of git-lfs work.
But we could also support that internally, without exposing
safe.hook.sha256 to the world (and thus creating an ecosystem where we
have to support it forever).

Implied here is that I also think config-based hooks have a lot of
_other_ advantages, and so would be worth pursuing anyway, and this
extra safety would come along for free. I won't enumerate those
advantages here, but we that can be a separate discussion if need be.

And of course that feature doesn't yet exist, and is a much larger one.
But besides un-breaking current LFS, I'm not sure that we need to rush
out a more generic version of the feature.

-Peff
