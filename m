Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066D30675
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qUGPgb7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590AEC433C7;
	Thu,  9 Nov 2023 17:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1699552764;
	bh=6HXrhxfijypudTwjoz2v99Xi/Gux7WtZB2t70zHiKiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUGPgb7/59zrGYFvWhx8b9NAe2eAUua8IBCh0rNdmNO8BybSi1raU2aJxTwfYeW/8
	 SpkUirmADKA4O+/D9RfrpF6Oyj7+6FjX9oic1Z1L4QB0A18g67R4hAAe6rTzPrDhsD
	 1awsvI0e70n0Uw9eQ+ttnKBKFduEdA1MYAmye4SM=
Date: Thu, 9 Nov 2023 12:59:23 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)
Message-ID: <5yn2w52iymgnobesoi2jdwpyzaf5foc4sytxfdzl4vavlox62j@7att57ya6scz>
References: <ZUocFhmPHstwKCkZ@devuan>
 <20231107174803.GA507007@coredump.intra.peff.net>
 <ZUqDwnmu9d1dD1tb@devuan>
 <20231107201655.GA507701@coredump.intra.peff.net>
 <ZUv3gjjmuqvCaJEd@debian>
 <20231108212702.GA1586965@coredump.intra.peff.net>
 <ZUz6H3IqRc1YGPZM@debian>
 <vooebygemslmvmi4fzxtcl474wefcvxnigqeestmruzrsj5zsu@5kkq3pveol6c>
 <ZU0aAQhVj7BQwr0q@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZU0aAQhVj7BQwr0q@debian>

On Thu, Nov 09, 2023 at 06:42:19PM +0100, Alejandro Colomar wrote:
> I haven't yet tried b4(1), and considered trying it some time ago, but
> really didn't find git-send-email(1) and mutt(1) so difficult to use
> that b4(1) would simplify much.

Well, sending is only a small part of what b4 will do for you -- the core
benefits are really cover letter management, automatic versioning and
simplified list trailer collection. It's all tailored to kernel needs, but it
will work for any project that depends on mailed patches.

> But I have tried patatt(1) before, which is what I think b4(1) uses for
> signing.  Here are some of my concerns about patatt(4):
> 
> It doesn't sign the mail, but just the patch.

Well, no, it signs the entire thing, not just the patch, but it's true that
it's specifically targeted at patches (hence the name).

> There's not much
> difference, if any, in authenticability terms, but there's a big
> difference in usability terms:
> 
> To authenticate a given patch submitted to a mailing list, the receiver
> needs to also have patatt(1) configured.  Otherwise, it looks like a
> random message.

Yes, but that's a feature.

> MUAs normally don't show random headers (patatt(1)
> signs by adding the signature header), so unless one is searching for
> that header, it will be ignored.  This means, if I contribute to other
> projects, I need to tell them my patch is signed via patatt(1) in
> order for them to verify.  If instead, I sign the email as usual with my
> MUA, every MUA will recognize the signature by default and show it to
> the reader.

I go into this in the FAQ for patatt:
https://github.com/mricon/patatt#why-not-simply-pgp-sign-all-patches

Basically, developers really hated getting patches signed with PGP, either
inline or MIME, which is why it never took off. Putting it into the header
where it's not seen except by specialized tooling was a design choice.

> It also doesn't allow encrypting mail, so let's say I send some patch
> fixing a security vulnerability, I'll need a custom tool to send it.  If
> instead, I use mutt(1) to send it signed+encrypted to a mailing list
> that provides a PGP public key, I can reuse my usual tools.

Right, the goal was really *just* attestation. For encrypted patch exchange we
have remail (https://korg.docs.kernel.org/remail.html), which worked
significantly better than any other alternative we've considered.

> Also, and I don't know if b4(1) handles this automagically, but AFAIR,
> patatt(1) didn't: fo signing a patch, I had to configure per-directory
> with `patatt install-hook`.  I have more than a hundred git worktrees
> (think of dozens of git repositories, and half a dozen worktrees --see
> git-worktree(1)-- per repository).  If I need to configure every one of
> those worktrees to sign all of my patches, that's going to be
> cumbersome.  Also, I scrape and re-create worktrees for new branches
> all the time, so I'd need to be installing hooks for patatt(1) all the
> time.  Compare that to having mutt(1) configured once.  It doesn't
> scale that well.

Also true -- patatt was really envisioned as a library for b4, where you can
configure patch signing in your ~/.gitconfig for all projects.

-K
