Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EAB28EC
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 03:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727408736; cv=none; b=UvsgcDq/xnmz3bilUFPi6LbSMYNod6B4FCMZuSE8JqAlpBvFFLqMkZhoHVXdK/7nlvlxiEmVHgqpUKudH8Al/KQRxpLtHHTbYlRNhQWLjfKuOJUV8MMshyRNACakG0z5LgIf4v+dLKSvPaDh9mq76YXGUDG2qtVS0x/cCK0jdWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727408736; c=relaxed/simple;
	bh=alz1vVuBHOW+wDONJDsPf5XIwHnUqT7gvgFPAGw7ZSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2iVep1ooCCDkAMhmZFRg//6GweDNFZ1edRvnrr4vQxWS3ljL84ptvEPP8DGJB+BGpU1fdl+AGZghjbtOZvZBo2wUYszRU/wSQlS+A4q2XyUMfNkZWIGsxhPDZZ2+SB0+za4VL6UQ5rB5tj+Q4uPRfIvLjMqjfcvJsTD+8HTBM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4816 invoked by uid 109); 27 Sep 2024 03:45:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Sep 2024 03:45:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8982 invoked by uid 111); 27 Sep 2024 03:45:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Sep 2024 23:45:25 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Sep 2024 23:45:25 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/28] fetch-pack, send-pack: clean up shallow oid array
Message-ID: <20240927034525.GA567395@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <20240924215225.GF1143820@coredump.intra.peff.net>
 <ZvVmitkT-QUneqvb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvVmitkT-QUneqvb@pks.im>

On Thu, Sep 26, 2024 at 03:50:02PM +0200, Patrick Steinhardt wrote:

> > diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> > index cfc6951d23..ef4143eef3 100644
> > --- a/builtin/fetch-pack.c
> > +++ b/builtin/fetch-pack.c
> > @@ -294,5 +294,6 @@ int cmd_fetch_pack(int argc,
> >  	free_refs(fetched_refs);
> >  	free_refs(remote_refs);
> >  	list_objects_filter_release(&args.filter_options);
> > +	oid_array_clear(&shallow);
> >  	return ret;
> >  }
> 
> I wonder about the early exit path we have when `finish_connect()`
> returns non-zero. Should we make it go via the common cleanup path as
> well, or do we not care in the error case?

Yeah, I think it would technically be a leak if we hit that error case.
But it's pretty unlikely in practice (you'd have to finish the fetch and
then the "ssh" or "upload-pack" sub-process returns a non-zero exit code
anyway).

I'd prefer not to deal with it here for two reasons:

  1. The same leak is true of all the existing cleanup. So it really is
     orthogonal to what this patch is doing, and should be a separate
     patch.

  2. I think cleaning up in top-level builtins like this is mostly
     cosmetic to appease the leak checker. In the real world the memory
     is going back to the OS when we return anyway. Even in a libified
     world, I don't think cmd_fetch_pack() is a reasonable entry point
     (we already have a more lib-ish fetch_pack() that is used by the
     transport code).

So I don't think it would be wrong to refactor the cleanup to trigger on
that other early return. But I also suspect there are many such paths
lurking (and will continue to lurk, even after we run clean with
SANITIZE=leak) and I'm not sure how productive it is to hunt them down.

> > diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> > index 81fc96d423..c49fe6c53c 100644
> > --- a/builtin/send-pack.c
> > +++ b/builtin/send-pack.c
> > @@ -343,5 +343,6 @@ int cmd_send_pack(int argc,
> >  	free_refs(remote_refs);
> >  	free_refs(local_refs);
> >  	refspec_clear(&rs);
> > +	oid_array_clear(&shallow);
> >  	return ret;
> >  }
> 
> We also have an early exit in this function when `match_push_refs()`
> returns non-zero.

And I think this is in the same boat.


-Peff
