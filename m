Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFB228C03E
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816727; cv=none; b=VZSwFak3zPSbVMj5pn0dA+8vaHh3iHFTj5usWMVoaeGl9HISD0sr0w+BBxF90i99++2h2gwJeHn+h02Em0uWwLMJLxi5piidV9Qdn6Zkzrei4AKaix/hz4eu1gIWjyNJB2fIkCmFYykCmzceoWacxGV9Y1l0wJrh1w5JwNLsdkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816727; c=relaxed/simple;
	bh=MkgLfDXbvAot+kHLul9O8sWGUTdT39FeaGy+ecgBLaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSuzRhA5J+8Uix5jyZbYw+Y4i0/WdD6Q0QMFo2qXgUD8bsMRpNq1o962/4LYBh8YkiDATWVUXwx6VwhRdMPoaKh4cojzvIYuN4hna5FLonh2NSUFWypB5311lxIIEcEhuWZefQnoSEwJBH17mYhZgEFamS280cbRbDCWbGkxGQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ut916dAc; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ut916dAc"
Received: (qmail 185109 invoked by uid 109); 2 Sep 2025 12:38:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=MkgLfDXbvAot+kHLul9O8sWGUTdT39FeaGy+ecgBLaQ=; b=Ut916dAcqmb4t8LUMLBJl1jThiiuaUsCphCBBbjbmpJBUVbDTCGZKhjQpNYzhCrl/Ak+j4C4MEihPvJJOjy1wX4NpWF4E7GdcCBNmpw87nR2KV/rfGHtGL6/ZIYgpzxU2A+FnXfjmnwYEeo8RLcX4z1acgmqIsu3zszjL124VDKH3GrHZQVri1pges5RY3J6Yhhiqkpwotz/CqFlRztNCxvGwXsHBk5Hik4O9YhpjQW78cVf5A+kxTzwQB1Y5L9RdG0zlz19YXgzgek6BVr84Pqgg46+A2g3x1NyxCSggA/JeaSrQe1fzu4cogD/JOEE12bEwqCW9Is9TobNX6My+Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Sep 2025 12:38:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 324449 invoked by uid 111); 2 Sep 2025 12:38:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Sep 2025 08:38:34 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Sep 2025 08:38:34 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: use khash in finish_depth_computation()
Message-ID: <20250902123834.GA711442@coredump.intra.peff.net>
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
 <20250824103117.GA250458@coredump.intra.peff.net>
 <6402268d-bc80-4bfe-abb8-edec9e1b8417@web.de>
 <20250825073403.GA332447@coredump.intra.peff.net>
 <cb192b28-d85a-4866-a312-df4408cae93e@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb192b28-d85a-4866-a312-df4408cae93e@web.de>

On Sun, Aug 31, 2025 at 07:25:13PM +0200, René Scharfe wrote:

> > diff --git a/builtin/describe.c b/builtin/describe.c
> > index edb4dec79d..e024feb080 100644
> > --- a/builtin/describe.c
> > +++ b/builtin/describe.c
> > @@ -289,7 +289,7 @@ static void lazy_queue_clear(struct lazy_queue *queue)
> >  
> >  static inline unsigned int commit_index(const struct commit *commit)
> >  {
> > -	return commit->index;
> > +	return oidhash(&commit->object.oid);
> >  }
> >  
> >  static inline int ptr_eq(const void *a, const void *b)
> > 
> > I get similar results (actually faster, but I think within the noise).
> 
> Sure.  I'm not comfortable with oidhash() though, because it allows
> attackers to influence the hash value, cause collisions and thus
> increase the cost of lookups and inserts to O(N), leading to quadratic
> complexity overall.
>
> They "just" need to construct commits with a common hash prefix.  I
> guess that's easy for two bytes and hard for four bytes.  Not sure how
> what an attacker would get out of planting such performance traps, but
> I guess some people would do it just for the heck of it.

I doubt that commit->index is any better in that regard. If I can
influence the order in which Git loads the commits (e.g., by creating a
bunch of refs which get loaded when we walk over for_each_ref), I can
choose the index for each. They'll be unique, but I can still cause
collisions modulo the number of buckets.

Likewise for oidhash(), I'd guess that colliding 4 bytes is not even
necessary to cause trouble, since probing starts by throwing away
everything mod n_buckets. So really you just need to collide however
many low bits you need to make your desired N, and then get O(N^2)
behavior.

I'm not super worried about it, because in my experience Git is already
a perfectly tuned device for convincing other people to waste CPU. ;)
But if we want to address it, I'd rather do so by improving oidhash()
than avoiding it. Specifically...

> Letting oidhash() XOR in another word would close that line of attack
> for quite a while, I assume.

Yeah. We have at least 160 bits in an object hash, and we only bother
with the low 32. We could XOR up to 5 times, but I agree that even a
single extra word would probably be plenty. Might be an interesting
experiment to time something like the patch below on a hash-heavy
workload.

diff --git a/hash.h b/hash.h
index fae966b23c..c9d21f589e 100644
--- a/hash.h
+++ b/hash.h
@@ -457,7 +457,10 @@ static inline unsigned int oidhash(const struct object_id *oid)
 	 * platforms that don't support unaligned reads.
 	 */
 	unsigned int hash;
+	unsigned int entropy;
 	memcpy(&hash, oid->hash, sizeof(hash));
+	memcpy(&entropy, oid->hash + sizeof(hash), sizeof(entropy));
+	hash ^= entropy;
 	return hash;
 }
 

I suspect it won't make a big time difference. The old code should have
been optimized down to a single word load, and now we have two word
loads and an xor. That probably isn't important compared to the actual
5-word memcmp() we have to do in order to verify that we found the right
bucket anyway.

-Peff
