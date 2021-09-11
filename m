Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC16C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 14:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 252EC611BF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 14:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbhIKO15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 10:27:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:44868 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235788AbhIKO15 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 10:27:57 -0400
Received: (qmail 12348 invoked by uid 109); 11 Sep 2021 14:26:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Sep 2021 14:26:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20603 invoked by uid 111); 11 Sep 2021 14:26:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Sep 2021 10:26:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 11 Sep 2021 10:26:43 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] packfile: use oidset for bad objects
Message-ID: <YTy8o3qXvyVv8fNr@coredump.intra.peff.net>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <14d48124-d8bb-aa34-aad0-4203d699e17e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14d48124-d8bb-aa34-aad0-4203d699e17e@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 10:01:40AM +0200, René Scharfe wrote:

> Store the object ID of broken pack entries in an oidset instead of
> keeping only their hashes in an unsorted array.  The resulting code is
> shorter and easier to read.  It also handles the (hopefully) very rare
> case of having a high number of bad objects better.

Yay, I'm very happy to see this kind of cleanup replacing ad hoc data
structures with well-tested ones.

> @@ -303,15 +304,9 @@ static int nth_midxed_pack_entry(struct repository *r,
>  	if (!is_pack_valid(p))
>  		return 0;
> 
> -	if (p->num_bad_objects) {
> -		uint32_t i;
> -		struct object_id oid;
> -		nth_midxed_object_oid(&oid, m, pos);
> -		for (i = 0; i < p->num_bad_objects; i++)
> -			if (hasheq(oid.hash,
> -				   p->bad_object_sha1 + the_hash_algo->rawsz * i))
> -				return 0;
> -	}
> +	nth_midxed_object_oid(&oid, m, pos);
> +	if (oidset_contains(&p->bad_objects, &oid))
> +		return 0;

Calling nth_midxed_object_oid() implies a memcpy() under the hood. In
the old code, we'd skip that in the common case that we had no corrupt
objects, but now we'll pay the cost regardless. memcpy() isn't _that_
expensive, but I'd expect this to be a relatively hot code path.

Is it worth sticking all of this inside:

  if (oidset_size(&p->bad_objects))

?

> diff --git a/packfile.c b/packfile.c
> index 04080a558b..8f6d1d6328 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1163,29 +1163,17 @@ int unpack_object_header(struct packed_git *p,
> 
>  void mark_bad_packed_object(struct packed_git *p, const struct object_id *oid)
>  {
> -	unsigned i;
> -	const unsigned hashsz = the_hash_algo->rawsz;
> -	for (i = 0; i < p->num_bad_objects; i++)
> -		if (hasheq(oid->hash, p->bad_object_sha1 + hashsz * i))
> -			return;

I cringed at the hasheq() and hashcpy() calls in the earlier patches.
Happy to see them go away now. :)

> -	p->bad_object_sha1 = xrealloc(p->bad_object_sha1,
> -				      st_mult(GIT_MAX_RAWSZ,
> -					      st_add(p->num_bad_objects, 1)));
> -	hashcpy(p->bad_object_sha1 + hashsz * p->num_bad_objects, oid->hash);
> -	p->num_bad_objects++;
> +	oidset_insert(&p->bad_objects, oid);
>  }

So now marking a bad object  is a one-liner. We _could_ just inline it
at the callers, but I like keeping the implementation abstract.

>  const struct packed_git *has_packed_and_bad(struct repository *r,
>  					    const struct object_id *oid)
>  {
>  	struct packed_git *p;
> -	unsigned i;
> 
>  	for (p = r->objects->packed_git; p; p = p->next)
> -		for (i = 0; i < p->num_bad_objects; i++)
> -			if (hasheq(oid->hash,
> -				   p->bad_object_sha1 + the_hash_algo->rawsz * i))
> -				return p;
> +		if (oidset_contains(&p->bad_objects, oid))
> +			return p;
>  	return NULL;
>  }

Not related to your patch, but I noticed how terribly inefficient this
function could be in a repo with a lot of packs. But we only call it
once in the error case right before we die(), so a linear scan is no
problem.

> @@ -2016,13 +2004,8 @@ static int fill_pack_entry(const struct object_id *oid,
>  {
>  	off_t offset;
> 
> -	if (p->num_bad_objects) {
> -		unsigned i;
> -		for (i = 0; i < p->num_bad_objects; i++)
> -			if (hasheq(oid->hash,
> -				   p->bad_object_sha1 + the_hash_algo->rawsz * i))
> -				return 0;
> -	}
> +	if (oidset_contains(&p->bad_objects, oid))
> +		return 0;

And this one (and the previous) have the oid already, so they don't have
to worry about optimizing the is-it-empty check first.

-Peff
