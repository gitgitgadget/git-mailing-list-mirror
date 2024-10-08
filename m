Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD913D2B2
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377667; cv=none; b=lEn0KPP3YVEwF24RQ1l5aS/7M9qjZIRomjz/5tLkLHFAGBiVkxjbgO1vNxaubO0TcV372mplThiFWkQN5hl1dssXumQyYyzV6EIoHMWp0OC95fJ+sMUGaJx97Gxy3A146cwlWBDwNLD2LucQ6mAqJQVAMhKJWJ42ztBmc7PUbMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377667; c=relaxed/simple;
	bh=W7tUdOGjJd3FKAT6KLy6BP9bVmkPe+7DtogJcVyAjZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3uaS4EUwSmvso2RKSvcBEbbdIESc/nKlqNISzFduv4Y9ogakqpns8xeIM7usv9m8d83f//ktXFJcgtcW4OvnTAKQEpme0C6mJ8hMBXLIkHkEFfdVDauhsyld5K0SJdbVYHN+vqOULcB+xSm+t+zwxf04BIXc/vKzWK2SrorWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HTQCh5Oz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HTQCh5Oz"
Received: (qmail 9616 invoked by uid 109); 8 Oct 2024 08:54:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=W7tUdOGjJd3FKAT6KLy6BP9bVmkPe+7DtogJcVyAjZM=; b=HTQCh5OzPLa6E+iTEi+eKY5/7YlSKi4BHTH5Ram/F/lb/wTYv/7i1TP+Lh4hAFlAcg9dMHwQSxSHluXTf61PZc5ELsjr8fAJhWHONWx+pzWkglDPnGRt1jASbK+0taZ4feW7Gz8xJ5P4W56HiW5RIiaNJgw1esk6/ntEGEBoQjlUz2HSGtIXGl0AgGoKPAcSqo5NRXuhfMMR5NjdE22vSRalyUekswyI3/ipwoMAiuALBV1jmaGB+F6AIb2IVFjzode09Q8BQZjPBJDbZFNBKGN64jWZT7HSiOvVQSB9/HuNnwcgPpnjMRw79BnBrpshnqbWOt4Volfpw3deAZzJGg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Oct 2024 08:54:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15959 invoked by uid 111); 8 Oct 2024 08:54:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Oct 2024 04:54:24 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 8 Oct 2024 04:54:23 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 15/23] pseudo-merge: fix leaking strmap keys
Message-ID: <20241008085423.GA1211512@coredump.intra.peff.net>
References: <cover.1727687410.git.ps@pks.im>
 <9e1161d55f96253bfeb5cddd1bbd381e2dad8a71.1727687410.git.ps@pks.im>
 <ZvsWlNPGxt5AOQcK@nand.local>
 <ZwOstswKzqMNNOUO@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwOstswKzqMNNOUO@pks.im>

On Mon, Oct 07, 2024 at 11:41:16AM +0200, Patrick Steinhardt wrote:

> > Hmm. I think I am probably splitting hairs, since a few xstrdup() calls
> > between friends is unlikely to matter here, but... ;-)
> > 
> > It does seem wasteful if we can avoid it. We already allocated heap
> > space for the matches via the underlying strbuf, and we really do want
> > to hand ownership over if we can.
> > 
> > Would doing something like this on top of your previous patch do the
> > trick?
> > 
> > --- >8 ---
> > diff --git a/pseudo-merge.c b/pseudo-merge.c
> > index 28782a31c6..6b6605d3dc 100644
> > --- a/pseudo-merge.c
> > +++ b/pseudo-merge.c
> > @@ -110,6 +110,7 @@ void pseudo_merge_group_release(struct pseudo_merge_group *group)
> >  		free(matches->stable);
> >  		free(matches->unstable);
> >  		free(matches);
> > +		free((char*)e->key);
> >  	}
> >  	strmap_clear(&group->matches, 0);
> > --- 8< ---
> > 
> > That introduces an ugly const-cast, but I think it's tolerable (and may
> > be moreso with a comment explaining why it's safe).
> 
> Well, to me this is a tradeoff between complexity and performance. If
> the performance benefit outweighs the additional complexity that this
> shared ownership of keys brings along with it then I'm okay with the
> code being intimate with each others lifetime requirements.
> 
> But as far as I can see the number of entries is determined by the group
> pattern, and I expect that in most cases it's going to be quite limited.
> So it does not feel like this should lead to all that many extra
> allocations, and thus I tend to prefer the simpler solution.

I'd tend to agree with you that the allocations aren't a big deal here.
But I think we've run into this kind of strbuf-detaching thing before,
and there's another pattern that is efficient without getting too
intimate between modules. Like this (plus your change to set the
strmap's strdup_strings mode):

diff --git a/pseudo-merge.c b/pseudo-merge.c
index 10ebd9a4e9..fb1164edfa 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -210,6 +210,7 @@ static int find_pseudo_merge_group_for_ref(const char *refname,
 	struct bitmap_writer *writer = _data;
 	struct object_id peeled;
 	struct commit *c;
+	struct strbuf group_name = STRBUF_INIT;
 	uint32_t i;
 	int has_bitmap;
 
@@ -227,10 +228,11 @@ static int find_pseudo_merge_group_for_ref(const char *refname,
 	for (i = 0; i < writer->pseudo_merge_groups.nr; i++) {
 		struct pseudo_merge_group *group;
 		struct pseudo_merge_matches *matches;
-		struct strbuf group_name = STRBUF_INIT;
 		regmatch_t captures[16];
 		size_t j;
 
+		strbuf_reset(&group_name);
+
 		group = writer->pseudo_merge_groups.items[i].util;
 		if (regexec(group->pattern, refname, ARRAY_SIZE(captures),
 			    captures, 0))
@@ -256,8 +258,7 @@ static int find_pseudo_merge_group_for_ref(const char *refname,
 		matches = strmap_get(&group->matches, group_name.buf);
 		if (!matches) {
 			matches = xcalloc(1, sizeof(*matches));
-			strmap_put(&group->matches, strbuf_detach(&group_name, NULL),
-				   matches);
+			strmap_put(&group->matches, group_name.buf, matches);
 		}
 
 		if (c->date <= group->stable_threshold) {
@@ -270,9 +271,9 @@ static int find_pseudo_merge_group_for_ref(const char *refname,
 			matches->unstable[matches->unstable_nr++] = c;
 		}
 
-		strbuf_release(&group_name);
 	}
 
+	strbuf_release(&group_name);
 	return 0;
 }
 

Now we skip the duplicate allocations because we are reusing the
group_name scratch buffer in the loop over and over. But wait, there's
more! We're actually _more_ efficient than the original which did one
allocation per entry, because:

  1. We can allocate the correct number of bytes for each name, rather
     than using the over-estimated buffer made by strbuf.

  2. In strdup_strings mode, strmap is smart enough to use a FLEXPTR to
     stick the name inside the struct. So we've actually reduced the
     number of allocations per entry by 1.

Now possibly it is not even worth doing this optimization, because this
is not really a hot path. But it doesn't violate any module boundaries,
and I think the "loop over a reusable strbuf" trick is a general idiom
for solving these kinds of allocation problems. So a good thing to keep
in our toolbox.

-Peff
