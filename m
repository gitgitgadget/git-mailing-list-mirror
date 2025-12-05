Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D7440855
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764970123; cv=none; b=HLTaBOqKaglzRfggnmGSsHbh19HMjFjdefBLh3ujChkTLv+0ZA4lQbbPEIkekHmFtm3dHwVZr3URPRd1jhxTRA2GKAiCmbLrroVAryx1pz24Uj6rMqjUaVyvSxIRgrXOVGrRrfIUMuco4ozH/R2dPyIgZGg760Rznnbt47p6Z5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764970123; c=relaxed/simple;
	bh=sTGaVjonkxd/sE89Z9ScgF/HXMcil2N2zL3mIyKBk5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGcTM2Pip6AM4Oxotckyh8qz69HSb4hdkzLK8gbGZnsA5LCcE6yHBbEEAzQ5MkRwzjwHUnjKNpqzKKD3SM7n57zHQvhA4fp7oUjrg3B13MxT1S/Ow88t7/xeZnEvaF9l8JUJL8Cb1t2WQmF363E+Birb8/Bz0baUCH5LkzmF9Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RLMDaI00; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RLMDaI00"
Received: (qmail 272876 invoked by uid 109); 5 Dec 2025 21:28:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=sTGaVjonkxd/sE89Z9ScgF/HXMcil2N2zL3mIyKBk5o=; b=RLMDaI00qtDMWQwoiitkyRwftL3k6L/2xS9Fqz4kiy1TYkRWSZmoDbIU1IR4eRHgQHkyKLoIQin6S+or2FxjRelmHp1RrbIHCt5bbh7FMk2pmDgipea7hrTU78xT/grbgep/83J87xIO1ceB2jitDm8u+YZdCxFG48hXU/DJjBm0MQWpVkvOokMQgKLnqXiFWrLGmkTcUmr/TMbfLt7Wfl4ToWlXggy30RJPqpOac2bzLgRRtxnewMLSOHKhFbAnLWjwqgZehoyc0d+og6SOKWtu4L/VESbrVydCrxWxdkLobuKLyujvOzEiLXZQGt9zcrUH373JKmycN05q+Pg0rg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Dec 2025 21:28:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 342302 invoked by uid 111); 5 Dec 2025 21:28:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Dec 2025 16:28:42 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Dec 2025 16:28:39 -0500
From: Jeff King <peff@peff.net>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] packfile: skip decompressing and hashing blobs in
 add_promisor_object()
Message-ID: <20251205212839.GA35153@coredump.intra.peff.net>
References: <20251204172132.319360-1-aplattner@nvidia.com>
 <20251205174854.GA18566@coredump.intra.peff.net>
 <20251205180106.GC18566@coredump.intra.peff.net>
 <235d80bd-2516-47f9-958f-0e5a16892758@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <235d80bd-2516-47f9-958f-0e5a16892758@nvidia.com>

On Fri, Dec 05, 2025 at 10:50:02AM -0800, Aaron Plattner wrote:

> Unfortunately, setting that flag doesn't seem to improve performance for me
> because in parse_object_with_flags(), lookup_object() returns an obj pointer
> with obj->parsed == 0 and obj->type == OBJ_NONE. So it skips this block and
> ends up inflating the object anyway:
> 
> 	if ((!obj || obj->type == OBJ_BLOB) &&
> 	    odb_read_object_info(r->objects, oid, NULL) == OBJ_BLOB) {
> 		if (!skip_hash && stream_object_signature(r, repl) < 0) {
> 			error(_("hash mismatch %s"), oid_to_hex(oid));
> 			return NULL;
> 		}
> 		parse_blob_buffer(lookup_blob(r, oid));
> 		return lookup_object(r, oid);
> 	}
> 
> I was confused about why the check was structured that way, but reading the
> description of commit 8db2dad7a045e376b9c4f51ddd33da43c962e3a4 cleared that
> up. Thank you for thoroughly documenting that!
> 
> Are OBJ_NONE objects expected here? Should the check be
> 
> 	if ((!obj || obj->type == OBJ_NONE || obj->type == OBJ_BLOB) &&
> 	    odb_read_object_info(r->objects, oid, NULL) == OBJ_BLOB) {
> 	    [...]
> 	}
> 
> ?

Yeah, that feels like a bug to me. The idea of that conditional is
"could it be a blob?" and obviously OBJ_NONE does not rule that out.

I do wonder how you end up with OBJ_NONE, though. That implies somebody
created the "struct object" but without knowing which type it was
supposed to be, and then did not follow up by actually parsing it.

That's probably immaterial to what parse_object() should be doing, but
it is certainly a curiosity. And I'm also not sure why I got good
results from my rev-list invocation, but you did not. Weird.

I think we could probably proceed without satisfying our curiosity here,
but if you felt like it, it would be interesting to find such an object
that is fed with OBJ_NONE to parse_object(), then run the command in a
debugger trying to break on the original create_object() call that
matches that oid. (Or if you want to be fancy use a reverse debugger
like rr). I might play around with it and see if I can stimulate it.

> If I make that change combined with your PARSE_OBJECT_SKIP_HASH_CHECK change
> then the time drops to 1:58, so that's great!

Cool, though I think that's about the same that you got with your patch?
I was hoping for a little bit more from skipping the hash checks and
commits, but maybe:

  1. Your commit/tree structure is dominated much more by the blobs than
     the linux.git I used for testing. So there's not much extra gain to
     be had.

  2. You didn't have a commit-graph built.

-Peff
