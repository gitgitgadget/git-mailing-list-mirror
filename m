Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0A4224C7
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546270; cv=none; b=BxZAU5E4FUQNweyJfOmvq5PvZKvKUMPsP+k1iRM3JLcnvCgsHnFu83zWqfYATTGWgJi3aPLH5rJEfmH3iQbT7T+lL4HabZCC85b//JqBfYW7YulG4O2oTT+GsQMyPitYVmiXJdm4ouskrOaKPyjB3dOGMaF6f71S4GUclOXA4ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546270; c=relaxed/simple;
	bh=i9hKK7seKD4byDX3W3dK66ilX52y2fJskgc0INS6yCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXIjPKZo/ZGqMVmrKzSxiQXIDMdLzBjcNc1sIe+spA+KMZFd83/w2KK/JZOj3kAyWW2TLhiW0jKc2NE7j4IyyFm+/IkOiBIzpfnU1hvijRi3YNfigCDlhxJguiOBYtIw30L9YLY7VxQVTrkWhejECX7vsoAoKZ2OjbLbrbjEggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29708 invoked by uid 109); 4 Mar 2024 09:57:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Mar 2024 09:57:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11644 invoked by uid 111); 4 Mar 2024 09:57:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Mar 2024 04:57:41 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Mar 2024 04:57:36 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Benjamin Flesch <benjaminflesch@icloud.com>
Subject: Re: [PATCH 9/9] upload-pack: free tree buffers after parsing
Message-ID: <20240304095736.GA3723539@coredump.intra.peff.net>
References: <20240228223700.GA1157826@coredump.intra.peff.net>
 <20240228223907.GI1158131@coredump.intra.peff.net>
 <ZeWHdaZnhOHKs5QP@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZeWHdaZnhOHKs5QP@tanuki>

On Mon, Mar 04, 2024 at 09:33:57AM +0100, Patrick Steinhardt wrote:

> > +	if (skip_hash && discard_tree &&
> > +	    (!obj || obj->type == OBJ_TREE) &&
> > +	    oid_object_info(r, oid, NULL) == OBJ_TREE) {
> > +		return &lookup_tree(r, oid)->object;
> > +	}
> 
> The other condition for blobs does the same, but the condition here
> confuses me. Why do we call `oid_object_info()` if we have already
> figured out that `obj->type == OBJ_TREE`? Feels like wasted effort if
> the in-memory object has been determined to be a tree already anyway.
> 
> I'd rather have expected it to look like the following:
> 
> if (skip_hash && discard_tree &&
>     ((obj && obj->type == OBJ_TREE) ||
>      (!obj && oid_object_info(r, oid, NULL)) == OBJ_TREE)) {
> 		return &lookup_tree(r, oid)->object;
> }
> 
> Am I missing some side effect that `oid_object_info()` provides?

Calling oid_object_info() will make sure the on-disk object exists and
has the expected type. Keep in mind that an in-memory "struct object"
may have a type that was just implied by another reference. E.g., if a
commit references some object X in its tree field, then we'll call
lookup_tree(X) to get a "struct tree" without actually touching the odb
at all. When it comes time to parse that object, that's when we'll see
if we really have it and if it's a tree.

In the case of skip_hash (and discard_tree) it might be OK to skip both
of those checks. If we do, I think we should probably do the same for
blobs (in the skip_hash case, we could just return the object we found
already).

But I'd definitely prefer to do that as a separate step (if at all).

-Peff
