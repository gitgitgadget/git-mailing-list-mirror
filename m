Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4E62EAF9
	for <git@vger.kernel.org>; Mon, 13 May 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715627023; cv=none; b=EHZWhvFbN9ArAn9BkMNEVJuQRsq0jpll8dbNrV477Aun8dpg7AA/dbtWVqexNS0buhwdE21z/wxO3x9SeU/V6rL00SN4/oGeFmyMzuvWvf+Wa1pEsTGsQn36d5TPtrYifbpqpWn1R9eOPZBtxGh+8IqKn0yEdtH6fAO0wYVTpkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715627023; c=relaxed/simple;
	bh=GWshIEjs5qI7hNKMmoEDKTVRSvJZqPt0QrKdTlUo3K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHsuUXejaamY6JP952i7M32leFTyJ+dJjWaJgFhkKoufrK7tgN3qz9jN8xVkFodpfldj95+ruHg3NBlrBJcHAE5PM4Ai6IhOEzGmeyP8P5znc+Gu9VED3gbCRzs4QissCaD7DuH+ZK/b1sKZpbPGNWC9SzJXBVhS7ZOrGIZTthw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31248 invoked by uid 109); 13 May 2024 19:03:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 May 2024 19:03:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13890 invoked by uid 111); 13 May 2024 19:03:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 May 2024 15:03:42 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 13 May 2024 15:03:40 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/23] pseudo-merge: implement support for selecting
 pseudo-merge commits
Message-ID: <20240513190340.GC2675586@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <86a1e4b8b9be99563836d1539fbf2ed4c4a6920d.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86a1e4b8b9be99563836d1539fbf2ed4c4a6920d.1714422410.git.me@ttaylorr.com>

On Mon, Apr 29, 2024 at 04:43:37PM -0400, Taylor Blau wrote:

> Teach the new pseudo-merge machinery how to select non-bitmapped commits
> for inclusion in different pseudo-merge group(s) based on a handful of
> criteria.
> 
> Pseudo-merges are derived first from named pseudo-merge groups (see the
> `bitmapPseudoMerge.<name>.*` configuration options). They are
> (optionally) further segmented within an individual pseudo-merge group
> based on any capture group(s) within the pseudo-merge group's pattern.
> 
> For example, a configuration like so:
> 
>     [bitmapPseudoMerge "all"]
>         pattern = "refs/"
>         threshold = now
>         stableThreshold = never
>         sampleRate = 100
>         maxMerges = 64
> 
> would group all non-bitmapped commits into up to 64 individual
> pseudo-merge commits.

I was going to complain that explanatory text like this should probably
go into the documentation, not a commit message. But I see you do later
add documentation. Which seems to happen when this code is actually
wired up to the bitmap-writer. Maybe a moot point now that I figured it
out, but I think we'd be better off with the two commits squashed
together.

And consider whether this commit message can be shortened a lot to just
refer to the embedded docs (and especially if there is any useful info
here that is not covered in the docs, and should be moved there). I do
think some of these explanatory examples are good for users, but we
don't necessarily have a good spot to put them. The git-config
documentation is more of a reference, and huge example sections would
probably bog it down. Maybe in the EXAMPLES section of pack-objects?
It's already a pretty big manpage, though, and this is just one tiny
corner.

So I dunno. I just want to make sure we don't bury useful information in
a commit message that most people won't see (something I've definitely
been guilty of in the past, and which has later caused problems).


I've got to break here in reviewing for the moment, but I think in a lot
of ways this commit is going to be the most interesting one, because the
usefulness of the whole pseudo-merge scheme depends on picking good sets
of commits (ones that cover a lot of ground but have a low chance of
being invalidated). So I'll pick up again with a careful look at this
one.

-Peff
