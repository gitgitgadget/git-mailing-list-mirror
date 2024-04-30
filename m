Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1013A8CB
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471309; cv=none; b=j2ztWhBgvoNKunhZFS9u0FYB3ef8l2Fyz9XKuJYZTvle8AqyxQ0ggWt0MfUEQMhMvBoQMzsSfcoWeuO8L0LzXASCG8h5d2wVxTqGUMG3QeLVYlqtVvDB40JMgmANbvqanvkTadAEGaaoEjNfPPmCFpX+SAjWlBCSs2wV5G0BAI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471309; c=relaxed/simple;
	bh=zmXiXxR8VrSVL4uXDYf7XiEN1UlMoOjD0Ot9uJ/QCz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zz0PgFQoGnjc4MzIr1aJ6Reixm//NGwD0bcaIbNBkmCOq3jxAYkhhheAagbOBuvYSb5dE7Ox9f3akapYlHXCrYOaslnZsQWEvF55aB4TxMQ14PBYkuYj2EywH+hXik+DmtfP2L3mTAWveN87+KTp/XN6JewJwjsMtUemRM/w4RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 2850 invoked by uid 109); 30 Apr 2024 10:01:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Apr 2024 10:01:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5348 invoked by uid 111); 30 Apr 2024 10:01:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Apr 2024 06:01:51 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Apr 2024 06:01:45 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/8] check_refname_format(): add FULLY_QUALIFIED flag
Message-ID: <20240430100145.GB1279403@coredump.intra.peff.net>
References: <20240429083325.GE233423@coredump.intra.peff.net>
 <ZjB5bHiF5kAcRMpP@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjB5bHiF5kAcRMpP@tanuki>

On Tue, Apr 30, 2024 at 06:54:04AM +0200, Patrick Steinhardt wrote:

> On Mon, Apr 29, 2024 at 04:33:25AM -0400, Jeff King wrote:
> > Before operating on a refname we get from a user, we usually check that
> > it's syntactically valid. As a general rule, refs should be in the
> > "refs/" namespace, the exception being HEAD and pseudorefs like
> > FETCH_HEAD, etc. Those pseudorefs should consist only of all-caps and
> > dash. But the syntactic rules are not enforced by check_refname_format().
> 
> s/dash/underscore, right?

Yep, thanks.

> > Making things even more complicated, refname_is_safe() does enforce
> > these syntax restrictions! When that function was added in 2014, we
> > would have refused to work with such refs entirely. But we stopped being
> > so picky in 03afcbee9b (read_packed_refs: avoid double-checking sane
> > refs, 2015-04-16). That rationale there is that check_refname_format()
> > is supposed to contain a superset of the checks of refname_is_safe().
> > The idea being that we usually would rely on the more-strict
> > check_refname_format(), but for certain operations (e.g., deleting a
> > ref) we want to allow invalid names as long as they are not unsafe
> > (e.g., not escaping the on-disk "refs/" hierarchy).
> 
> I still think we should eventually merge these functions. It's not
> exactly obvious why one would use one or the other. So if we had a
> function with strict default behaviour, where the caller can ask for
> some loosening of the behaviour via flags, then I think it would become
> a ton easier to do the right thing.
> 
> In any case, that doesn't need to be part of this patch series.

Yeah, I think it would be fine to merge them with a flag. With the one
exception that started this topic (and which I think could go away after
this series), every caller of refname_is_safe() only does so in
conjunction with check_refname_format() to check "well, is it at least
safe?".

You will have to tweak the return value somehow to indicate "ok" versus
"bad but safe" versus "unsafe" (e.g., resolving sets REF_BAD_NAME but
continues for the middle one). I think I'd prefer to leave that out of
this series (and after this, I think it becomes easier as a pure
refactoring since the behavior remains the same).

> > The whole ALLOW_ONELEVEL thing is a long-standing confusion, and
> > unfortunately has made it into the hands of users via "git
> > check-ref-format --allow-onelevel". So I think it is there to stay.
> > Possibly we should expose this new feature as --fully-qualified or
> > similar.
> 
> Hm, that's really too bad. I wonder whether we should eventually start
> to deprecate `--allow-onelevel` in favor of `--fully-qualified`. We
> would continue to accept the flag, but remove it from our documentation
> such that scripts start to move over. Then some day, we may replace
> `ALLOW_ONELEVEL` with something like `ALLOW_ROOT_REF` that allows refs
> in the root directory while honoring `is_pseudoref_syntax()`.

I don't know if we could ever get rid of --allow-onelevel. If you want
to check a branch name, say, the replacement for it is to ask about
"refs/heads/$name". But sometimes you don't actually know how the short
name is going to be used, but you want to make sure it's syntactically
valid. E.g., validating a refspec may involve a name like "main" on its
own. I suspect it would be OK in practice to just give it an arbitrary
"refs/foo/$main", but that feels kind of hacky.

-Peff

> > @@ -288,6 +288,15 @@ static int check_or_sanitize_refname(const char *refname, int flags,
> >  {
> >  	int component_len, component_count = 0;
> >  
> > +	if ((flags & REFNAME_FULLY_QUALIFIED)) {
> > +		const char *bare_ref;
> > +
> > +		parse_worktree_ref(refname, NULL, NULL, &bare_ref);
> > +		if (!starts_with(bare_ref, "refs/") &&
> > +		    !is_pseudoref_syntax(bare_ref))
> > +			return -1;
> > +	}
> > +
> >  	if (!strcmp(refname, "@")) {
> >  		/* Refname is a single character '@'. */
> >  		if (sanitized)
> > @@ -322,8 +331,11 @@ static int check_or_sanitize_refname(const char *refname, int flags,
> >  		else
> >  			return -1;
> >  	}
> > -	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
> > +
> > +	if (!(flags & (REFNAME_ALLOW_ONELEVEL | REFNAME_FULLY_QUALIFIED)) &&
> > +	    component_count < 2)
> >  		return -1; /* Refname has only one component. */
> > +
> 
> I first thought that we don't have to handle REFNAME_FULLY_QUALIFIED
> here because the above should already handle it. But we can of course
> have a single component, only, when the ref is "refs/".

I hadn't really considered that case. The reason we have to handle
FULLY_QUALIFIED here is that without it, "FETCH_HEAD" (or for that
matter "HEAD") is forbidden as having only a single component. The
earlier hunk only rejects bad things, so we still end up in this code.

I think that "refs/" is forbidden both before and after my patch because
it's invalid to have a zero-length component (so "foo//bar" is
forbidden, but so is "foo/" because of the empty component on the end).a

-Peff
