Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80EE2C87C
	for <git@vger.kernel.org>; Sat, 18 May 2024 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716061648; cv=none; b=RyqhqdVu8ezu3iDOYkMWok+duY82VSMo8Xd6ub5Gidmq4O2nKllSWExj++M7261gWRC4GJx7eFZNpMcxEMH1q1fq3soHWRuQz7h3ucCTw2EPGYaVQtc6wfFp39zFi7Gr/jPMW48ymwggjFewfkgFnPpdPFyn61tKo0NX/GoudZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716061648; c=relaxed/simple;
	bh=Qe9cPlOWliKle+OCaMXN5QmGzy2wkvJHRGtqjhS10Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFzpSosdP2Kj4e6IWbiGOTGAzpk2Qj2DbPETI4g3AM9ic+ywFa+BL+JhQS1PuIVXb/nQG4t9QNweodLqCs3FSieU4xO0eYORutHVeEZDi9Rlwd8ZNI63Mm1OPjyCnnkHmA4D2Jyoq5tOnnAT3WD0MWkJT62VLl1exNCfJYArwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24193 invoked by uid 109); 18 May 2024 19:47:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 May 2024 19:47:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5160 invoked by uid 111); 18 May 2024 19:47:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 May 2024 15:47:26 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 May 2024 15:47:24 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 5/8] hook(clone protections): add escape hatch
Message-ID: <20240518194724.GB1573807@coredump.intra.peff.net>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
 <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
 <b841db8392ebd924d1893829a7e5e22240f1e9cf.1716028366.git.gitgitgadget@gmail.com>
 <20240518181432.GA1570600@coredump.intra.peff.net>
 <c201bbe3-b404-feed-fcef-8333f72068dc@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c201bbe3-b404-feed-fcef-8333f72068dc@gmx.de>

On Sat, May 18, 2024 at 09:32:07PM +0200, Johannes Schindelin wrote:

> >   - compute the sha256 of the hook (for which we provide no tooling
> >     support, though hopefully it is obvious how to use other tools)
> [...]
> 
> Well, there is tooling support: With the proposed patches (patch 5, to be
> precise), Git will complain about hooks that are installed _during_ a
> clone, and then provide the following advice:
> 
> 	If this is intentional and the hook is safe to run,
> 	please run the following command and try again:
> 
> 	  git config --global --add safe.hook.sha256 <hash>
> 
> While this won't help with the just-completed clone operation, it assists
> preventing the same issue in future clones.

What I meant by tooling support was: how do you find out the sha256 hash
of the hook you're wanting to bless?

I'd imagine you'd reach for the stand-alone "sha256" tool. But there is
no Git tool to compute the hash (you can't use any of the usual tools
like "hash-object" because it is not a pure hash of the content). Should
we provide one? Or at least tell the user which third-party command is
likely to be used?

> > Implied here is that I also think config-based hooks have a lot of
> > _other_ advantages, and so would be worth pursuing anyway, and this
> > extra safety would come along for free. I won't enumerate those
> > advantages here, but we that can be a separate discussion if need be.
> 
> One disadvantage of config-based hooks is that it is quite hard to verify
> the provenance of the settings: Was it the user who added it, was it a
> program the user called, or was it exploiting a vulnerability whereby the
> config was written inadvertently?

But isn't that true of the safe.hook.sha256 value, too? If I can attack
.git/config, then I can set it to match the attack hook (not to mention
the zillion other config options which execute arbitrary code).

If we really want to harden .git against attacks which can overwrite
files in it, then I think the long-term path may be something like:

  - add support for specifying hooks via config. Leave .git/hooks for
    compatibility.

  - introduce a config option to disable .git/hooks support. Respect it
    only outside of .git/config. Default to false to start for backwards
    compatibility. Eventually flip it to true by default.

And then perhaps something similar for in-repo config (add an option to
disable in-repo config except for repos marked as safe).

> > And of course that feature doesn't yet exist, and is a much larger one.
> > But besides un-breaking current LFS, I'm not sure that we need to rush
> > out a more generic version of the feature.
> 
> Exactly. We need to unbreak Git LFS-enabled clones and release v2.45.2
> before I even have the head space to think more about config-based hooks.

To be clear, I'm not proposing doing nothing. I'm proposing un-breaking
LFS either by rolling back the defense-in-depth or adding hard-coded
hashes, neither of which introduces a user-visible feature that must be
supported. And then proceed with new features in the regular cycle.

The hard-coded hashes are obviously a ticking time bomb until lfs
updates again (and they don't help any as-yet-unknown program which does
the same thing). So I'd suggest just rolling back the feature entirely
in the meantime.

-Peff
