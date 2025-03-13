Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51261DE2BD
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 05:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741842950; cv=none; b=VQZmL+HuGMCG6XIc/ETippIGV7pZNnqY2JpiNTsQx4YVxa2rE2ZLEokChMr8qCs12NUDSzw52T/MLndfutzxpD6szr7EUgNz5cTcEqp1S43u1wM8L/XrWboMH7t+auYVzVen/WGgcIGdTvzTJdxCbJjGJoUsHYD0KAs7OaYxFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741842950; c=relaxed/simple;
	bh=MPtXV6NzWZrf2LLbYmMRqEJLRJ9V0/IaWpw54MnzwKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB21pECu6bHtyc0ugr/dIRdOTvpUJHveol4YoDBmG+Au8iUSJvZ++cIvMfwOaIf5lNUkqa+IpSuYxbLraHlDTrspT2rQL//bzi5Ovg76bg7EjMf/LNxli+8+6VIdSwxhh9zzpyGN5CKsfydCHqlKBNRyCBi+tCSB0n99kbGC+lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HsUqsuqh; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HsUqsuqh"
Received: (qmail 20574 invoked by uid 109); 13 Mar 2025 05:15:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MPtXV6NzWZrf2LLbYmMRqEJLRJ9V0/IaWpw54MnzwKI=; b=HsUqsuqhACpsJlieel7/dtm6hAfcmhmGTDGDuXMyPsK7ROa0bG8rrGU3FoQXMkm2z7tdlM3ec+u7/oholWwxpoemTWy53nViwsnCYuE7YN8BsHwxzSZH3w1IgXcQSd0rD69QH7WKSihVEO+w8R6lXL69JHDx6Py4CyMapzEXuLum94O35UMaZYXLRDCflq7C4IpRQCxs04sx0h5tu3vQPBE0FeT201bVrUq9KGyMuLlMQdYH5Xu19UnrGlgMkMUh7NAlerHWU1nTfM598EYHvuJs5MvnHiQbJpqLe8M17M8qPkuzN6LWck/StmDUfXRP3v5nWNwLfKMKElRP5gACOw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Mar 2025 05:15:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11283 invoked by uid 111); 13 Mar 2025 05:15:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Mar 2025 01:15:39 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Mar 2025 01:15:38 -0400
From: Jeff King <peff@peff.net>
To: Simon Josefsson <simon@josefsson.org>
Cc: git@vger.kernel.org
Subject: Re: Making bit-by-bit reproducible Git Bundles?
Message-ID: <20250313051538.GA94015@coredump.intra.peff.net>
References: <871pv2jx4a.fsf@josefsson.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871pv2jx4a.fsf@josefsson.org>

On Wed, Mar 12, 2025 at 12:40:05PM +0100, Simon Josefsson wrote:

> If I run the recipe above twice (including the clone), I get different
> checksums.  This even if nothing was committed in the remote repository
> meanwhile.
> 
> Is it possible to create a bit-by-bit reproducible git bundle using some
> other set of commands?  If so, how?  I'm using git 2.48.1 from Guix.

As Junio noted, multithreading is the first problem. E.g., here are some
commands on git.git, using my 8-core machine:

  [try once...]
  $ git bundle create --no-progress - HEAD | sha1sum
  686da850200da487032c9d91bdc544b605a3e426  -

  [and again; oops, it's different]
  $ git bundle create --no-progress - HEAD | sha1sum
  70b018c16d244f32b36e55deb931e29ae15506e3  -

  [now without threading]
  $ git -c pack.threads=1 bundle create --no-progress - HEAD | sha1sum
  c897caf9c68d2c37d997d3973196886af3b0b46e  -

  [and we can do it again. yay!]
  $ git -c pack.threads=1 bundle create --no-progress - HEAD | sha1sum
  c897caf9c68d2c37d997d3973196886af3b0b46e  -

What's happening here is that the bundle mostly consists of a packfile,
where many objects will be stored as deltas against others. The search
for deltas is multi-threaded, so it will find slightly different ones
each time (there surely is an "optimal" answer, but finding it is much
too expensive, so we bound the search with some heuristics).

So disabling threading gives you a deterministic answer. But that's not
the end of the story! We only search for deltas of objects that are not
already stored as deltas in on-disk packfiles. We try to reuse any
deltas we have already on disk (assuming that both the delta and its
base are going to be in the output).

There are options to ask pack-objects (the command which git-bundle uses
under the hood to generate the pack) not to reuse deltas. So
pack-objects running on a single thread without any delta reuse should
generate a deterministic pack. But there are some gotchas:

  1. It's stable only for a given Git version, and with a particular set
     of delta window/depth options. I wouldn't expect behavior to change
     much between versions, but it's not something that we try to
     guarantee.

  2. There is no way to pass pack-objects options down through
     git-bundle. So you'd have to either assemble the bundle yourself,
     or perhaps generate a stable on-disk pack state, and then generate
     the bundle. Perhaps something like:

       # make one single pack, with no reuse, using the default options
       git -c pack.threads=1 repack -adf

       # now we can make a bundle from that. We probably do not even
       # need to disable threads here, since we'd just be picking the
       # deltas from the on-disk file (assuming that you're including
       # all objects in the bundle)
       git bundle create - | sha1sum

  3. It will be really slow. We're throwing out all of the deltas and
     searching from scratch. And doing it single-threaded. I didn't time
     it, but I'd guess from past experience we're talking about hours to
     generate the bundle for something like linux.git.

So I think it's possible, but I doubt it's very ergonomic. You're
probably better off using some checksum over Git's logical model, rather
than the stored bytes. The obvious one is that a single Git commit hash
unambiguously represents the whole tree and all of history leading up to
it, because of the chains of hashes.

But that implies you trust Git's object hash algorithm. If you don't
trust sha1 (and don't want to try out the sha256 support), then you'd
have to design something else.  Perhaps something like:

  # print all commits in topological order, with ties broken by
  # committer date, which should be stable. And then follow up with the
  # trees and blobs for each.
  git rev-list --topo-order --objects HEAD >objects

  # now print the contents of each object (preceded by its name, type,
  # and length, so there's no chance of weird prepending or appending
  # attacks). We cut off the path information from rev-list here, since
  # the ordered set of objects is all we care about.
  cut -d' ' -f1 objects |
  git cat-file --batch >content

  # and then take a hash over that content; this will be unambiguous.
  sha256sum <content

-Peff
