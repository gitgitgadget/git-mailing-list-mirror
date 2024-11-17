Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0978CA92D
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731834525; cv=none; b=mT428p1bLBvWBeJuHJ84sJ+vb1bq6jv+03NNACITFZAWiQM+0D8kbQnwVAD3ZDjmIJ+lOdXEEK1Zxe6S052pp/NnlXoU8eCiGd2+CyUT/9sDuByuLfUcRJtvM9/R850G7XRa9n4g8UWrl52yxwzofC2zZaAR/kJcv1F9r+qHciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731834525; c=relaxed/simple;
	bh=utrCCbGSaUzhvYnMmrB9/RgD71oaxADpQpGlW3VlP3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGyNlNKHTQM7MXwMIknwHqX50df0IE8IqOaeB4M/w+33lLoykdvzg/VibOHJIKy8IggmLwhr8Q4WGkTrzB12t63sQh1+IrWopuGxznY1UXZ2Ydy2OsioYBaCBH4XjNlS7rLgdium6r2K+VrBDODmdkrEpp8vtF52Cy4x+RNgcqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OclhIsw9; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OclhIsw9"
Received: (qmail 9281 invoked by uid 109); 17 Nov 2024 09:08:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=utrCCbGSaUzhvYnMmrB9/RgD71oaxADpQpGlW3VlP3E=; b=OclhIsw9zqt0LcT1GE8n+ekuN1ThvIIwt03IXRo7rNoRetZ/s4DqCdrb6qkoCMZl4c1mcpeM0qGmDaXQpcbGyzRKzdsFMJdADf6pH/9vUobgbzA4fx5uXER9nw1vr/niuYcm70tpGtXRni9LOYalvCwKX/p9Tv1p7sUevShqkwJGQx9drqh92Xd8vSDtzD0xy2uSUSCx0sLgKqCDUacYBV8PsYz1Iw8MjYryrmi1Lx+6JnMTTM4F91OLiIBDMAtNVy231v9G9fphKGRETrcSX25Gwse5xH0lPsWyvpT82EeMIdrffqCNKkSsq/3u7uH8R88yI+J3j8OqLTNgBo2XOQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 17 Nov 2024 09:08:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2231 invoked by uid 111); 17 Nov 2024 09:08:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 17 Nov 2024 04:08:47 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 17 Nov 2024 04:08:42 -0500
From: Jeff King <peff@peff.net>
To: Sam James <sam@gentoo.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: [PATCH 3/5] object-file: move empty_tree struct into
 find_cached_object()
Message-ID: <20241117090842.GC3409496@coredump.intra.peff.net>
References: <20241117090329.GA2341486@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241117090329.GA2341486@coredump.intra.peff.net>

The fake empty_tree struct is a static global, but the only code that
looks at it is find_cached_object(). The struct itself is a little odd,
with an invalid "oid" field that is handled specially by that function.

Since it's really just an implementation detail, let's move it to a
static within the function. That future-proofs against other code trying
to use it and seeing the weird oid value.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index b7c4fdcabd..5fadd470c1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -325,14 +325,13 @@ static struct cached_object {
 } *cached_objects;
 static int cached_object_nr, cached_object_alloc;
 
-static struct cached_object empty_tree = {
-	/* no oid needed; we'll look it up manually based on the_hash_algo */
-	.type = OBJ_TREE,
-	.buf = "",
-};
-
 static struct cached_object *find_cached_object(const struct object_id *oid)
 {
+	static struct cached_object empty_tree = {
+		/* no oid needed; we'll look it up manually based on the_hash_algo */
+		.type = OBJ_TREE,
+		.buf = "",
+	};
 	int i;
 	struct cached_object *co = cached_objects;
 
-- 
2.47.0.541.ge258d9a1f8

