Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354EA28F5
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782076334; cv=none; b=Uefw+URJBFkAuOvlk2TsdHiU6qyXSBgZhxbbBLMKSQrkA/q73nB+Grfaaz7KJFzfLbBIcPW09jUNl+HhaHcU75kHXdHnJSfboKOFIhAfoj1mR/VohfkjH7A+Tue//yEJgBsJoeCmtT3PiEGvXOtzcYKPBbijAEUxpQViRUV4OeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782076334; c=relaxed/simple;
	bh=y+uN9YipyYLagg3kiSSQ2Hhpkm4lczq58WxMKXLHFzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/xyttu3n0oUxbHFzfEzy0dDJjCGfi99SLCb9klp+aplBDAL9P+sITFq5eBxK5i02pkgEh0khW5eWAMeztAYSuketkd0hgkkOV7/8bv26PqjqdQjC6JDIZjKg/WIz9i4566h7+dnpqcK0ikq6n21kwaTwJGFmgk5SalX+dpe8VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KzBU5ci8; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KzBU5ci8"
Received: (qmail 208484 invoked by uid 106); 21 Jun 2026 21:12:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=y+uN9YipyYLagg3kiSSQ2Hhpkm4lczq58WxMKXLHFzM=; b=KzBU5ci8i/WZZLM1In51dJA26BjkYSub9noTQC/ZcCfT/ogZHeDIjOTyEnKdjCjNU8D6kF5RsRM8toqAuf8NxuJ+ukg9fHvlrB6LA1vRlDDWgAm7FkCmYNnpk7l39DSfoZXcDJoAO2gh5Da48SFZ2oYlGU2LnYZOc/BZkU0t9+JI81LgQVEgbW5qP4CIxIaPvU7cAF8fnMs4YiCH5dtgzqxYcy5VUNm8lLK0ZSa4cP3k6aO9WOqhJaemH2l1thKXqJqvRBYh9nyobYvwnZhFAwyk0SFdQylWJfxPxbtBiHzBkVKGEh7FXVnf1WUmd2g5v12CbL/KKm/gsVK2DJ6nCA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 21 Jun 2026 21:12:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 526404 invoked by uid 111); 21 Jun 2026 21:12:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Jun 2026 17:12:14 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 21 Jun 2026 17:12:11 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 7/8] refs: fix recursing `get_main_ref_store()` with
 "onbranch" config
Message-ID: <20260621211211.GA2297179@coredump.intra.peff.net>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
 <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-7-f4854aa99859@pks.im>
 <20260618164035.GA1218204@coredump.intra.peff.net>
 <ajTggBKIzgSpp99X@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ajTggBKIzgSpp99X@pks.im>

On Fri, Jun 19, 2026 at 08:25:42AM +0200, Patrick Steinhardt wrote:

> On Thu, Jun 18, 2026 at 12:40:35PM -0400, Jeff King wrote:
> > On Mon, Jun 15, 2026 at 03:56:53PM +0200, Patrick Steinhardt wrote:
> [snip]
> > I'd expect the ref database config (like the ref format) to be read not
> > through the regular config subsystem, but via read_repository_format()
> > and friends. And while that does build on the regular config code, it
> > should never enable includes at all. So includeIf.onbranch:foo.path is
> > just another uninteresting config key to it.
> 
> This feels rather painful though, as we'd now have to do this for every
> single backend that we know about. Also, I think not enabling includes
> is an overly broad fix: there isn't any reason why "includeif.gitdir"
> and all the other conditions shouldn't apply. We really only want to
> disable "onbranch".

Sorry, I should probably gone back and edited my email after finishing
it. I was thinking that you meant not general config, but the specific
extensions.refStorage key. Which is not really config, but repo metadata
we happen to store in the .git/config file. And obviously you cannot
read any refs until you know what's in that key.

And that _is_ read separately while loading the repo config, which I
think is right. Other options, like core.logallrefupdates, are handled
separately. And I realized halfway through my reply that was probably
what you meant.

I agree those are user-facing config options that should generally
respect includes in the normal way. I thinks are a bit funny there,
though. See below.

> I actually tried lazy-loading, but I found it to be quite painful
> overall, as the above setting isn't the only one we use. The reftable
> backend for example has a bunch of additional settings that it reads.
> 
> We could of course start lazy-loading all of these. But that may not
> work for future backends that really _need_ to parse some configuration
> at initiation time.

Yes, obviously there's some true chicken-and-egg issues if there are
config keys that are needed to initialize the backend. But I think there
are many that are not needed immediately (e.g., because they relate only
to writes, not reads) but still block loading.

For example, try this:

  git init
  git config core.logallrefupdates false
  git config includeIf.onbranch:main.path alt-config
  git config -f .git/alt-config core.logallrefupdates true
  git commit --allow-empty -qm foo

  echo "git-config => $(git config core.logallrefupdates)"
  echo "reflog => $(git reflog show)"

git-config will report the value as true, but git-commit will not
respect it. But this used to work! Back when onbranch was added, we'd
create the reflog. Bisecting turns up eafb126456 (environment: stop
storing "core.logAllRefUpdates" globally, 2024-09-12), which makes
sense. That commit pushed the config read down into the ref
initialization function, which created the chicken-and-egg.

Now the config shown above is a bit silly, and I don't expect anybody to
do it in real life. But what worries me is two-fold:

  1. There are some magic variables that just won't work with onbranch
     includes, but the user doesn't necessarily know what they are.

  2. We try to cache the results of config reads. Is it possible for an
     "early" request like this to cache a state that skipped the
     onbranch include, and then we use that state to look up other
     unrelated variables? Or could we see a partially completed state in
     the cache when we lookup a ref variable?

     I'm not sure. The actual backend lookups use the uncached
     repo_config() interface (and in your series here, explicitly
     disables the use of refs during that read). But the
     core.logallrefupdates lookup uses the cached version, and I think
     there are others (some of which happen deep under the hood
     through library calls, like calc_shared_perm()).

I tried to construct a few cases that might tickle this behavior, but
couldn't come up with one. But I have a nagging feeling that we are
mostly getting lucky on some of the ordering, and a seemingly unrelated
change could have bad effects.

Sorry, I know that's kind of vague and hand-wavy.

I'm not sure I have a specific recommendation for a direction. It just
feels like we're piling up hacks to avoid infinite recursion without a
clear model of what config is read when. I guess if I could suggest
anything, it would be that ref backends initialize themselves to do
reads while loading as little config as possible, and then perhaps load
additional config through the non-caching repo_config() path.

-Peff
