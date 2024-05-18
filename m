Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EBEDF6B
	for <git@vger.kernel.org>; Sat, 18 May 2024 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716066748; cv=none; b=WiBT5jCn0L+OaEwphzy9RYo9RZU3v7PwVjtSQPMzwu1HVtX0uGnFrtf29stPNu2JF9T9fKdnXdUK7fkgn/lJw1c/mucNBZ+bVn2IEh/sNeXqdSnRDvB8+gL3uqBscIN+/cYZuhOtPvCMpCkLtK4xH0BSmkI4ia+YIp8+RmzB5Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716066748; c=relaxed/simple;
	bh=ke9I5+eo17p2o348zh39X4R68ZyNmNplANYNSH1M7rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V87/DpTe08Sl10JO7uXeqjYbwSCMhWbmHWJiQH7DUgbnC6lrhrCmS+HLx8afzUqnF3e8URHVw7Fc/+/SwVR9xNxxlQeVLA70vlDm8qk29nkHoWtl+AlFr906mSX3oyzsJUHGq7iNLnLULz8Za/PEAknjHrOQJemxeXGKC9a6kgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25741 invoked by uid 109); 18 May 2024 21:12:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 May 2024 21:12:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6161 invoked by uid 111); 18 May 2024 21:12:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 May 2024 17:12:27 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 May 2024 17:12:24 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 5/8] hook(clone protections): add escape hatch
Message-ID: <20240518211224.GA1574761@coredump.intra.peff.net>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
 <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
 <b841db8392ebd924d1893829a7e5e22240f1e9cf.1716028366.git.gitgitgadget@gmail.com>
 <20240518181432.GA1570600@coredump.intra.peff.net>
 <c201bbe3-b404-feed-fcef-8333f72068dc@gmx.de>
 <20240518194724.GB1573807@coredump.intra.peff.net>
 <86d57213-e3b2-c985-6d69-71568c66fc9c@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86d57213-e3b2-c985-6d69-71568c66fc9c@gmx.de>

On Sat, May 18, 2024 at 10:06:36PM +0200, Johannes Schindelin wrote:

> > > One disadvantage of config-based hooks is that it is quite hard to
> > > verify the provenance of the settings: Was it the user who added it,
> > > was it a program the user called, or was it exploiting a vulnerability
> > > whereby the config was written inadvertently?
> >
> > But isn't that true of the safe.hook.sha256 value, too?
> 
> No, because `safe.hook.sha256` (like `safe.directory` and
> `safe.bareRepository`) is only respected in "protected" configs, i.e.
> system-wide, user-wide and command-line config. Any such settings in the
> repository-local config are ignored.

Ah, true. I think the issue still holds for all of the other config that
runs arbitrary code, though, doesn't it?

> Rolling back the defense-in-depth would be a mistake: We do see (seemingly
> on a yearly cadence) reports of vulnerabilities in Git that often raise to
> critical severity by exploiting the hooks feature (typically in
> conjunction with submodules). There is no reason to believe that this
> steady trickle will stop any time soon. The defense-in-depth we introduced
> would stop at least that escalation path that turns those vulnerabilities
> into critical attack vectors putting users at risk.

Most of the vulnerabilities that I recall could just as easily write
over .git/config. But I didn't catalog them. Do you have specific ones
in mind?

> Even worse: If we removed these protections without any replacement, now
> we basically told hackers where to look for nice, exploitable bugs,
> publicly.

I don't find this line of reasoning all that compelling. The existing
vulnerabilities that led you to the defense-in-depth protection already
pointed them in the right direction.

So I'm not convinced that temporarily moving back to the v2.45.0 state
is all that dangerous. If it were a known vulnerability, yes, I'd worry.
For defense-in-depth, less so.

> For what it's worth, I was originally also in favor of the pretty surgical
> addition of the hard-coded hashes specifically to unbreak Git LFS-enabled
> clones. You must have seen my proposal that I sent to the Git security
> mailing list.
> 
> However, brian suggested that Git LFS may not be the only 3rd-party
> application that is affected by the clone protections. I have my doubts
> that other applications use a similar route, it strikes me as quite hacky
> to install a hook while running a `smudge` filter, yet I do admit that
> there is a possibility. Which is why we introduced the `safe.hooks.sha256`
> settings.
> 
> This strikes a good balance between unbreaking Git LFS and still
> benefitting from the defense-in-depth that helps fend off future critical
> vulnerabilities.
> 
> If we did not have such a balanced way to address the Git LFS breakage, I
> would totally agree with you that we would need to consider rolling back
> the defense-in-depth. Happily, we don't have to.

My main complaint is that it introduces a confusing and complicated
requirement that LFS (and maybe others) have to think about in
perpetuity. And we may end up with a better solution. We got bit by
pushing out the v2.45.1 change without a lot of end-user testing. Now it
seems like v2.45.2 is being rushed out to fix it. It would hopefully see
_more_ testing, as it's being done in the open.

But it sounds like we're throwing away our usual release-engineering
practices (where the usual practice for a regression is "revert it, it
can happen in the next cycle") in favor of a security fix. Again, for a
vulnerability fix, that makes sense. But for layered defense, I find it
less compelling.

Anyway, I have said my piece and I don't think I have much to add. So
either you agree or not, and if this is the direction the project wants
to go, I won't object further.

> P.S.: For what it's worth, the pattern we see in Git LFS is relatively
> hard to replicate. `git clone` does not offer any easy and convenient way
> to install hooks during the operation other than via templates (which,
> unlike Git LFS-enabled clones, is _not_ broken in v2.45.1). Of course,
> users could start a clone and then manually copy a `post-checkout` hook
> into `.git/hooks/` _while the clone is still running_. I kind of doubt
> that that's common practice we need to support, though.

I think we've run into similar issues with remote helpers, which run
arbitrary code and could install hooks. The recent one I'm thinking of
is:

  https://lore.kernel.org/git/20240503020432.2fxwuhjsvumy7i7z@glandium.org/

though that wasn't a hook problem, but rather leaving the repo in an
uninitialized state for longer.

-Peff
