Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF692F9C32
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957600; cv=none; b=l80FxFyD+ig2LcPRsafeauY0R+bnyj37iiVrRrWEiccnPCBWpEVptlbBjjxNJ8zrAFH+M/q+dI6H4KXN2ukyh+Ye4OHz4mhLUp3OYBf9NWZxVdhNOJXmu7NpvhktXXPw7tt/87N7qK89+2RlLm49IGO+osnv8vJqnhllycDRS4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957600; c=relaxed/simple;
	bh=NOvOZAu/+wXvvUlbldtqxpHWQufs4JSuEY2T/6GrxNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvFTW97aNsdL9KXF/HGK4er/La+XcRqVzbDbdh0/I8Fsd2tsZsJ8eXcC4vknvMH7tIHRjC4Ag+ZwwvoqJyVtr+2Eatm3/AjJDwbEhcV9MCZJTi22tuILdst8zklZiL0/xtNChOKDZVyWbV0naHp+/r+/tswYRYJlQPSK6dn/90E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VmWyi5gV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VmWyi5gV"
Received: (qmail 271820 invoked by uid 109); 5 Dec 2025 17:59:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NOvOZAu/+wXvvUlbldtqxpHWQufs4JSuEY2T/6GrxNw=; b=VmWyi5gVbudseTHkidYdsqbZR6z47+e1olKhZ4XItHAHu8dmoTVHWEk4uc/FlcVLi21cNoNPcGIc1bmCDTg03L8k0yzcssvdFsrfoaEvGlhWHm9MsMFiLrNS11rayeJPO/dOM5MC+TMujOwxSGWA5u7D3e+FxW1Z6s7Pv30G69FbZCFsDq223L60xaxGj3o9f3Lwn73sIGhecLF0cscscjeIuZExqZEWycHIYAPbOsLHzjJ93bmQTlMt8i09PkysCEcKiXWtj7M+McA6mEzBbeqCWrt9CtPCoF0N9wWHTyaWvMoO6DeDMadJv7hm+SRUhpl1a7ioStd1+AG1DVwjBw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Dec 2025 17:59:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 339949 invoked by uid 111); 5 Dec 2025 17:59:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Dec 2025 12:59:58 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Dec 2025 12:59:57 -0500
From: Jeff King <peff@peff.net>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] packfile: skip decompressing and hashing blobs in
 add_promisor_object()
Message-ID: <20251205175957.GB18566@coredump.intra.peff.net>
References: <20251204172132.319360-1-aplattner@nvidia.com>
 <aTLR0YXqRO63GkJu@pks.im>
 <da52d3d8-f70e-4ab9-8752-0ddb7ad145f1@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da52d3d8-f70e-4ab9-8752-0ddb7ad145f1@nvidia.com>

On Fri, Dec 05, 2025 at 08:55:19AM -0800, Aaron Plattner wrote:

> +               if (we_parsed_object)
> +                       free_commit_buffer(pack->repo->parsed_objects,
> commit);
>         } else if (obj->type == OBJ_TAG) {
>                 struct tag *tag = (struct tag *) obj;
>                 oidset_insert(set, get_tagged_oid(tag));
> 
> --
> 
> 
> That said, the memory footprint improvement seems pretty minimal with this
> change:
> 
> Without free_commit_buffer():
> 
> $ /usr/bin/time ~/git/git/git-rev-list --objects --all
> --exclude-promisor-objects --quiet
> 66.19user 38.97system 2:17.46elapsed 76%CPU (0avgtext+0avgdata
> 8171072maxresident)k
> 307985728inputs+0outputs (151871major+1067727minor)pagefaults 0swaps
> 
> With free_commit_buffer():
> 
> $ /usr/bin/time ~/git/git/git-rev-list --objects --all
> --exclude-promisor-objects --quiet
> 66.47user 40.08system 2:18.72elapsed 76%CPU (0avgtext+0avgdata
> 8135640maxresident)k
> 307820424inputs+0outputs (100432major+1065152minor)pagefaults 0swaps
> 
> I'm inclined not to worry about it for now.

I don't think it will make a difference for that command because we
already turn off the "save_commit_buffer" global in rev-list, unless we
are going to show the contents. Perhaps:

  git rev-list --objects --all --format=%s

would show the difference.

If we take the skip-hash suggestion I wrote elsewhere in the thread,
then we would usually not load the commit contents in the first place.
But it could still be worth adding this free_commit_buffer() to catch
commits not covered by the commit-graph.

Another way to do it is to temporarily unset save_commit_buffer in
is_promisor_object() when we start walking the objects. That's how we do
it in other places, like 359b01ca84 (ref-filter: disable
save_commit_buffer while traversing, 2022-07-11). But in this case since
the traversal code is custom it's pretty easy to just free immediately
afterwards.

-Peff
