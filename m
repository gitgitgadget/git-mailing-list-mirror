Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C2522AE65
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783756047; cv=none; b=tWJbPbAPL3A+ZGYIBjY7V7FyAmQ9p6eOev0vz3n5yGz4yXhLa7nSgSGqVwsOiyso0xiWvR8Uwthjyz+tD2hOkgE9BqxZoAKnyDTlNidT/0iCpqkZloWaCHm/wWhm/AMG+B2FWIhjilMVMFKsAhAyyQGKI+A7LG+ZtbHPD/aKFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783756047; c=relaxed/simple;
	bh=4F9Q83c0kNW3WMoui1EHtz3U5ygIyW72DEULbOdTEXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeAgA+qfa4Of1mDILNpenHHfielnX30JG209JqrkE4h0KlSmKkJr3UhoWgG+Jr1JWqIWHq5B+y59tytLtdXaaiJYFPm9ctu0RlOUAj5cX2fUFi6fGUuu4MFDm2qswZOz6En4C9j3ImCvN9Fs0TItaCzZqpK1guok4wUsgS/HeJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TPq5CcGB; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TPq5CcGB"
Received: (qmail 55741 invoked by uid 106); 11 Jul 2026 07:47:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4F9Q83c0kNW3WMoui1EHtz3U5ygIyW72DEULbOdTEXw=; b=TPq5CcGBepeA0bY9O9BL40Aihhn6KtS/22C6c/j0ECC7YW4lyL0f3RzlRruT5nqtBPFUlBJQmVSEaqgcngLgetByeZCpiozsR78rocQfUSv1ac5tNsTjZox0mDIfKK57FixhdpA2RYYj27ULQj6NPM52M/wJChqYPvhWx7ZvS/kDPlj+afkM0ghn5auLQgkY7L3RSjMn52yZzm9XCbWEWl9fXQd7pHJTZz+7IGFsFKaKeE/uwpVCtRvZab8I0a/5zjsg9RC9md1ZoVsYH17nFKCgCaxtkoK8GUzH/sQFFKXF6t7jUauELFNOcFkoy9g/8zp3xzGiG4t2ROT6AZHDhg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Jul 2026 07:47:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 95345 invoked by uid 111); 11 Jul 2026 07:47:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Jul 2026 03:47:23 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 11 Jul 2026 03:47:23 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/7] pack-bitmap: allow aborting iteration of bitmapped
 objects
Message-ID: <20260711074723.GB1457061@coredump.intra.peff.net>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
 <20260709-pks-odb-for-each-object-filter-v1-3-82fe014b12b3@pks.im>
 <alAAN6_ZqLj9tlgV@denethor>
 <alCafO91ZtFdikPg@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alCafO91ZtFdikPg@pks.im>

On Fri, Jul 10, 2026 at 09:08:44AM +0200, Patrick Steinhardt wrote:

> On Thu, Jul 09, 2026 at 03:19:52PM -0500, Justin Tobler wrote:
> > > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > > index ea5eab4cf8..8ff92c5272 100644
> > > --- a/builtin/pack-objects.c
> > > +++ b/builtin/pack-objects.c
> > > @@ -1909,7 +1909,7 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
> > >  		return 0;
> > >  
> > >  	create_object_entry(oid, type, name_hash, 0, 0, pack, offset);
> > > -	return 1;
> > > +	return 0;
> > 
> > I wonder why this was even returning 1 to begin with? As you mentioned,
> > the return value appears to be ignored anyways. I'm assuming it was
> > signal that an object entry was created?
> 
> The function is only called from a single location, and the return value
> was completely ignored until this commit. It has always been this way
> since the function was originally introduced in 6b8fda2db1
> (pack-objects: use bitmaps when packing objects, 2013-12-21), so it
> never seemed to have any purpose. The commit message doesn't mention
> anything either.

I think it was copying the semantics of its non-bitmap counterpart,
add_object_entry(). Of course nobody looks at that return value either!

Long ago there were callers that cared about whether we actually created
an entry, but I think the last one went away in 5379a5c5ee (Thin pack
generation: optimization., 2006-04-05), which was quite some time ago.

So I think we could probably drop the return value from
add_object_entry() entirely (but of course we can't do the same for the
bitmap variant, because of its use as a callback).

I mention this mostly as answering Justin's "I wonder why...", but it
might be worth cleaning up add_object_entry() here, as its return value
semantics have diverged from add_object_entry_from_bitmap().

-Peff
