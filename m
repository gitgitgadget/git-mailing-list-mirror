Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F263C30
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721979724; cv=none; b=c+Cl5pweJmszrug5lbM+hvOuJbzoEmU4Clf66JUv5EuQ0Ha0v9OF3LWgcULhORo7lzY3KmZwyu4kqsVLZ5tDHzsgnmSXCSPqnHcK/NxMrZk/eRCAwKAVprBI34iKdFdTBOilNJlOh4dc/OFyIrGjlt1ru3P2YdYGmWegCHuLBbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721979724; c=relaxed/simple;
	bh=IDO67GMx+xb9ecLnReg7A1TRTNUoB9+/VrZFmg40324=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbCY0qlPgKDl8QBMQc4xTBXi82uX3kP5Zkr9mbtr+VU9xsEALhtioBsBLRMUKQnSk2VNbazxiVMdswZdp3WLOmnP+yenW72OfarA0nfVlwBjTczfpEkAmlV0FSmsNgW1Bj3ZrG17wwyeHhgQmzL1dY51fLuVGcpxsWrjG/oxpvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=Fl5JTVhJ; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="Fl5JTVhJ"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E271F572;
	Fri, 26 Jul 2024 07:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1721979722;
	bh=IDO67GMx+xb9ecLnReg7A1TRTNUoB9+/VrZFmg40324=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fl5JTVhJziBZmkT9SSCcD1Pv5a6vNGx2gqtJxK6xdte7mXAE6x8bv2exTBsizoJps
	 6zJLZjVRgT3Bxg4GiUIXt5I/vNpjfG56hzIroMzjd5dp6M97M2YQ8y7KTVyoTaBSV1
	 GNjg/uINxH6OHWiI3QBNp+8TCKsI8vEf2EWSNYl8=
Date: Fri, 26 Jul 2024 07:42:01 +0000
From: Eric Wong <e@80x24.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 05/10] cat-file: use delta_base_cache entries directly
Message-ID: <20240726074201.M876490@dcvr>
References: <20240715003519.2671385-1-e@80x24.org>
 <20240715003519.2671385-6-e@80x24.org>
 <ZqC872ExETzRH60Z@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqC872ExETzRH60Z@tanuki>

Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Jul 15, 2024 at 12:35:14AM +0000, Eric Wong wrote:
> > For objects already in the delta_base_cache, we can safely use
> > them directly to avoid the malloc+memcpy+free overhead.
> 
> Same here, I feel like you need to explain a bit more in depth what the
> actual idea behind your patch is to help reviewers.

I elaborated more on the speedup gained in the second paragraph
of the commit message:

	... this avoids up to 96MB of duplicated memory in the worst
	case with the default git config.  For a more reasonable 1MB
	delta base object, this eliminates the speed penalty of
	duplicating large objects into memory and speeds up those 1MB
	delta base cached content retrievals by roughly 30%.

> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index bc4bb89610..769c8b48d2 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -24,6 +24,7 @@
> >  #include "promisor-remote.h"
> >  #include "mailmap.h"
> >  #include "write-or-die.h"
> > +#define USE_DIRECT_CACHE 1
> 
> I'm confused by this. Why do we introduce a macro that is always defined
> to a trueish value? Why don't we just remove the code guarded by this?

I wanted to be able to toggle the feature for comparison during
development.  I can eliminate it for v2.

> >  enum batch_mode {
> >  	BATCH_MODE_CONTENTS,
> > @@ -386,7 +387,18 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
> >  
> >  	if (data->content) {
> >  		batch_write(opt, data->content, data->size);
> > -		FREE_AND_NULL(data->content);
> > +		switch (data->info.whence) {
> > +		case OI_CACHED: BUG("FIXME OI_CACHED support not done");
> 
> Is this something that will get addressed in a subsequent patch? If so,
> the commit message and the message here should likely mention this. If
> not, we should have a comment here saying why this is fine to be kept.

Not in this series.  I'm not sure if we'll ever need OI_CACHED
support, here.  However, I've been considering an new cache
that can be shared across multiple cat-file processes, but
that'll be a separate series.

> > diff --git a/object-file.c b/object-file.c
> > index 1cc29c3c58..19100e823d 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1586,6 +1586,11 @@ static int do_oid_object_info_extended(struct repository *r,
> >  			oidclr(oi->delta_base_oid, the_repository->hash_algo);
> >  		if (oi->type_name)
> >  			strbuf_addstr(oi->type_name, type_name(co->type));
> > +		/*
> > +		 * Currently `blame' is the only command which creates
> > +		 * OI_CACHED, and direct_cache is only used by `cat-file'.
> > +		 */
> > +		assert(!oi->direct_cache);
> 
> We shouldn't use asserts, but rather use `BUG()` statements in our
> codebase. `assert()`s don't help users that run production builds.

OK.

> >  		if (oi->contentp)
> >  			*oi->contentp = xmemdupz(co->buf, co->size);
> >  		oi->whence = OI_CACHED;
> > diff --git a/object-store-ll.h b/object-store-ll.h
> > index b71a15f590..50c5219308 100644
> > --- a/object-store-ll.h
> > +++ b/object-store-ll.h
> > @@ -298,6 +298,13 @@ struct object_info {
> >  		OI_PACKED,
> >  		OI_DBCACHED
> >  	} whence;
> > +
> > +	/*
> > +	 * set if caller is able to use OI_DBCACHED entries without copying
> > +	 * TODO OI_CACHED if its use goes beyond blame
> > +	 */
> > +	unsigned direct_cache:1;
> > +
> 
> This comment looks unfinished to me.

Yeah.  I'll elaborate on it's only intended for cat-file atm and
would break if blame (or other callers) used it.

> >  	union {
> >  		/*
> >  		 * struct {
> > diff --git a/packfile.c b/packfile.c
> > index 1a409ec142..b2660e14f9 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -1362,6 +1362,9 @@ static enum object_type packed_to_object_type(struct repository *r,
> >  static struct hashmap delta_base_cache;
> >  static size_t delta_base_cached;
> >  
> > +/* ensures oi->direct_cache is used properly */
> > +static int delta_base_cache_lock;
> > +
> 
> How exactly does it ensure it? What is the intent of this variable and
> how would it be used correctly?

It prevents multiple cache entries from being acquired at once.

> > +static void lock_delta_base_cache(void)
> > +{
> > +	delta_base_cache_lock++;
> > +	assert(delta_base_cache_lock == 1);
> > +}
> > +
> > +void unlock_delta_base_cache(void)
> > +{
> > +	delta_base_cache_lock--;
> > +	assert(delta_base_cache_lock == 0);
> > +}
> 
> Hum. So this looks like a pseudo-mutex to me? Are there any code paths
> where this may be used in a threaded context? I assume not in the
> current state of affairs as we only use it in git-cat-file(1).

No parallelism or threads at all.  It's to ensure callers can't
load multiple entries at the same time since retrieving a delta
base cache entry could invalidate an entry that's already
acquired for use.

> >  static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
> >  {
> >  	free(ent->data);
> > @@ -1453,6 +1468,7 @@ static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
> >  void clear_delta_base_cache(void)
> >  {
> >  	struct list_head *lru, *tmp;
> > +	assert(!delta_base_cache_lock);
> >  	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
> >  		struct delta_base_cache_entry *entry =
> >  			list_entry(lru, struct delta_base_cache_entry, lru);
> > @@ -1466,6 +1482,7 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
> >  	struct delta_base_cache_entry *ent;
> >  	struct list_head *lru, *tmp;
> >  
> > +	assert(!delta_base_cache_lock);
> >  	/*
> >  	 * Check required to avoid redundant entries when more than one thread
> >  	 * is unpacking the same object, in unpack_entry() (since its phases I
> > @@ -1521,11 +1538,16 @@ int packed_object_info(struct repository *r, struct packed_git *p,
> >  		if (oi->sizep)
> >  			*oi->sizep = ent->size;
> >  		if (oi->contentp) {
> > -			if (!oi->content_limit ||
> > -					ent->size <= oi->content_limit)
> > +			/* ignore content_limit if avoiding copy from cache */
> > +			if (oi->direct_cache) {
> > +				lock_delta_base_cache();
> > +				*oi->contentp = ent->data;
> > +			} else if (!oi->content_limit ||
> > +					ent->size <= oi->content_limit) {
> >  				*oi->contentp = xmemdupz(ent->data, ent->size);
> > -			else
> > +			} else {
> >  				*oi->contentp = NULL; /* caller must stream */
> > +			}
> >  		}
> >  	} else if (oi->contentp && !oi->content_limit) {
> >  		*oi->contentp = unpack_entry(r, p, obj_offset, &type,
> 
> Okay, this hunk is the gist of this patch. Instead of copying over the
> delta base, we simply take its data pointer as the content pointer. All
> the other infra that you're adding is mostly only added as a safeguard
> to make sure that we don't discard the delta base while the object is
> getting accessed.

Right.  I'll switch the asserts to BUG calls for v2.
