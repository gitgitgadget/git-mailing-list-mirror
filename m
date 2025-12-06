Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15073299A96
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 02:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764986812; cv=none; b=aF5zRBqbfkapap1lCSWCmYk5lDNBkgehoSrlauCnqrVl+lI35u1OGoZEc+NfAfz2Z+6TaMDV2XULJLaQlD0OWtIkrLiMaQTWCjGsWklNTPwE7c335YoTCJ2giiBVs+AxUa7bW90R8Ckow5dosjUlgEUajqJ1ZJV8xHwbEXQXp6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764986812; c=relaxed/simple;
	bh=+CkTwjhEG5z6iWdHpf92iXejFNjluZ1ATcQfexMBp1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFEw52A3YCygd0a6F8sSPydXZj7pnlLmmS/YxwGrP+wk4m5UUYLTGhteIa9yColyGuUQ+6cRsI9atL2bdTxGU9aCVsT1uG7z4k8rFeXRYOD226mf+iOLmWQI7LXHOSG2bIPKAnAinonxWGo+lXlVL2kDXwfIyMxIDhRCjjxaNJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iPzKaOxY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iPzKaOxY"
Received: (qmail 274338 invoked by uid 109); 6 Dec 2025 02:06:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+CkTwjhEG5z6iWdHpf92iXejFNjluZ1ATcQfexMBp1s=; b=iPzKaOxYYPo2h0KdrkngZnLB8DD/LRMX9YCuqWUIaOvkrl0Ob3LT0WTc/jT15OvXSV0jJEeWKGMU4RbywxPBsov7mli4inn5l1b1cspMWbJZm5k2ZBd2hu/44cR5/JfaDVJYHAPOiQGUAEVdl1np6Fa3he8IxerTO5zhXEN4mFWtPkPrxyQ+T8GVh92u9lbaxpajVD5P0O6blDDXqKl2FU4iYGtPX0/7ne/at6xEZ1+a1EhTy+hAiGqldcX55Ikad5BwKCHdzdsg7m8aiP72TEkJRdnFfVZHDowRK0GCUimLB4IgCmJRwYR8/Xhl6CRQ4PBzUrJfA/smbtYxoJxpQQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Dec 2025 02:06:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 345646 invoked by uid 111); 6 Dec 2025 02:06:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Dec 2025 21:06:51 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Dec 2025 21:06:48 -0500
From: Jeff King <peff@peff.net>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] packfile: skip decompressing and hashing blobs in
 add_promisor_object()
Message-ID: <20251206020648.GB1714099@coredump.intra.peff.net>
References: <20251206002014.2066644-1-aplattner@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251206002014.2066644-1-aplattner@nvidia.com>

On Fri, Dec 05, 2025 at 04:20:12PM -0800, Aaron Plattner wrote:

> When is_promisor_object() is called for the first time, it lazily
> initializes a set of all promisor objects by iterating through all
> objects in promisor packs. For each object, add_promisor_object() calls
> parse_object(), which decompresses and hashes the entire object.
> 
> For repositories with large pack files, this can take an extremely long
> time. For example, on a production repository with a 176 GB promisor
> pack:
> 
>  $ time ~/git/git/git-rev-list --objects --all --exclude-promisor-objects --quiet
>  ________________________________________________________
>  Executed in   76.10 mins    fish           external
>     usr time   72.10 mins    1.83 millis   72.10 mins
>     sys time    3.56 mins    0.17 millis    3.56 mins
> 
> add_promisor_object() needs the full object for trees, commits, and
> tags. But blobs contain no references to other objects, so the function
> can just insert their oids into the set and move on.
> 
> parse_object_with_flags() has code to skip decompressing blobs, but it
> unfortunately doesn't work with the objects created by
> mark_uninteresting() because they have obj->type == OBJ_NONE. Update
> parse_object_with_flags() to handle blobs and trees that are in this
> state, and then update add_promisor_object() to use
> PARSE_OBJECT_SKIP_HASH_CHECK.

Good catch on the matching tree code. It doesn't trigger for your use
case (the caller has to pass in the DISCARD_TREE flag), but it's a
lurking bug nonetheless.

I'm tempted to say that those changes in parse_object_with_flags()
should happen as a separate patch, since they really are fixing an
existing bug. But I can live with it all as one, too.

One other thing it might be worth thinking about or mentioning in the
commit message: we are skipping the hash check on all objects now (not
just blobs). I think this is OK to do along the lines of discussion in
c868d8e91f (parse_object(): allow skipping hash check, 2022-09-06). I
dunno. Maybe it is kind of self-evident that not every operation needs
to do a consistency check of every object.

>  object.c   | 4 ++--
>  packfile.c | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)

The patch itself looks great to me.

-Peff
