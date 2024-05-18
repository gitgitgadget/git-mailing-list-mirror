Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD77C2C8
	for <git@vger.kernel.org>; Sat, 18 May 2024 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716060933; cv=none; b=n9BbDuCtKufq6F5Fuv5dG570+JmvmIADWNBCfbux4a018vxSJktgQ+qr5kiBipdQTV1PRVQeZQ1YVDB5DCBC8ogt3z8w9p3O1B6vete9gQ+mddnD0HP7nYHVs8akrDMG75Xc0FlT23L+XlFroGlqj8GeVFhQtx7/NaCSnp2P0JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716060933; c=relaxed/simple;
	bh=STlrM8IoynRz46r2Begk9AnPYx+MHLaNC2BLD1/+m+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSU1G+UCf86MZP/OtueYYP2KXc2dwgyXQYjjhW5sGZlDS0AVbrQy/ZYoCGW20AcwRB/gINwMQHGOYRTkCYJBVkO2siai0rlginWdpmEGQQHYHjZh5HiAfAiQYSfzx7hJ9fa31NyX4CALoP5xQdiz1ElXMPH1QMaZQB/wVnrfblY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24108 invoked by uid 109); 18 May 2024 19:35:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 May 2024 19:35:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5076 invoked by uid 111); 18 May 2024 19:35:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 May 2024 15:35:30 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 May 2024 15:35:28 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 5/8] hook(clone protections): add escape hatch
Message-ID: <20240518193528.GA1573807@coredump.intra.peff.net>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
 <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
 <b841db8392ebd924d1893829a7e5e22240f1e9cf.1716028366.git.gitgitgadget@gmail.com>
 <20240518181432.GA1570600@coredump.intra.peff.net>
 <xmqqmsonne6m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsonne6m.fsf@gitster.g>

On Sat, May 18, 2024 at 11:54:41AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In either case, we're considering config to be a trusted source of
> > truth, so I think the security properties are the same. But for the
> > system here, a user updating a hook needs to do multiple steps:
> >
> >   - compute the sha256 of the hook (for which we provide no tooling
> >     support, though hopefully it is obvious how to use other tools)
> >
> >   - add the config for the sha256
> >
> >   - install the new hook into $GIT_DIR/hooks
> 
> I am not sure why any of the above is needed.  
> 
> Hmph.
> 
> I was somehow (because that is how "git config --help" explains
> "safe.hook.*") led to believe that this "safety" was only about "git
> clone would prefer not to run ANY hook before it finishes operation
> and gives back the control to the end user, but historically it ran
> any enabled hooks in the resulting repository that was freshly
> created by it---so let's at least make sure the contents of the
> hooks are known-to-be-good ones when 'git clone' runs the hooks".
> Most importantly, once "git clone" gives control back to the end
> user and the end user had a chance to inspect the resulting
> repository, the files in $GIT_DIR/hooks can be updated and the hooks
> will run without incurring any cost of checking.
> 
> Isn't that what happens?

Yes, sorry if I was unclear. This is _only_ about the hooks-during-clone
safety. So my "a user must do this" is really "a user who wants a hook
to be installed during a clone must do this". And plausibly speaking,
that is mostly going to be script/program writers like git-lfs.

So the extra complexity is limited to those cases.

> Looking at the control flow, hook.c:find_hook() is the one that
> calls the function is_hook_safe_during_clone() to reject "unsafe"
> ones (and allow the white-listed ones), but I do not know offhand
> how the code limits the rejection only during clone.  So perhaps
> this set of patches need further work to restrict the checks only to
> "while we are cloning" case?

I think the git_env_bool() call to check GIT_CLONE_PROTECTION_ACTIVE is
what kicks in here. During non-clone calls, that will use the default of
0.

-Peff
