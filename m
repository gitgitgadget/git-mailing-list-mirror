Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D71367B65
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 05:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328530; cv=none; b=ORLsPAKx2HPDi7WnomWgPPMbM9YhqpyNoYZAQ5llwxfe46gsp3pJxretyzulCK2+DalnqNbmOmPTf1mi57Yukot3V9HiV/E0IpbgIDNu88j30gneijueYe3O+HpJfgJ5s9RhdgXDiF29FUFY9e3XnXlF4bXfFIKIFEfCANcGHzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328530; c=relaxed/simple;
	bh=jDH9q99mpl8TNn9ECR4pE2jT70wUMbYQ6brjl+j5i+0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTrLV7cga2dHsLQSEf9eDC/p+ntBdKepB18wQRjU7CIJowLjDH0iO4PSlA95Ji6Jon62BF48E82sPHQ9LHScg9VG7t/UHZzZXrgCAbsWeF5x53Rj54chGuL9ykCLP0dgONJTJgjP6DlVoc3MnBM+ZuFVtgY3TOGHsSgpcwH246g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Fz4HyiLc; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Fz4HyiLc"
Received: (qmail 9964 invoked by uid 106); 2 Sep 2026 05:55:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jDH9q99mpl8TNn9ECR4pE2jT70wUMbYQ6brjl+j5i+0=; b=Fz4HyiLczUo1MkED7SaTDH+Aq6+PHAyZ6kCLF10wiXMrH0G7rX36yc9mUPLAfBs3dRJ9Nf7trlO8rf+Gu8EU6/KM3tzKroYoIiHCb7b3LC5v15MLtn77LMDkaRhfBDC12PrMVHGuf00kDyXyotCe3EZywt3GdT9QzSTP/JSBJCJi6sy5skIJI+pb6HCnhyWLxr9p/HRAttkwiU9MESD0KvR5zPaq4R9HGOHi1A55zqU1daPFgHKT1clwhyzTwg9OnQvyPEwk2GIjb7PxOQ7EE14N7C0VAJlgnHBsL6+YJ1US64TW5kZxlcL2TQ//U9FGRzoHV0iifPsS64zOyBY08A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Sep 2026 05:55:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 46850 invoked by uid 111); 2 Sep 2026 05:55:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Sep 2026 01:55:27 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 2 Sep 2026 01:55:26 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 1/2] repository: make repo_clear() idempotent
Message-ID: <20260902055526.GA41747@coredump.intra.peff.net>
References: <20260902055117.GA41587@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902055117.GA41587@coredump.intra.peff.net>

Calling repo_clear() twice in a row will segfault because the second
call will invoke parse_object_pool_clear() on a NULL pointer. This is
not usually a big deal, but we can make some error cleanup a little
simpler if callers do not need to worry about invoking it twice.

We can fix it by catching the NULL case. The rest of repo_clear()
appears to be idempotent.

Signed-off-by: Jeff King <peff@peff.net>
---
This helps in the next patch, but I think it's also just the path of
least surprise.

Arguably this should not be a pointer at all, but the pool code is
weirdly asymmetric. It offers only "new" which allocates a struct, but
only "clear" to clean it up (but not deallocate). Might be worth fixing,
but out of scope for this series.

 repository.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/repository.c b/repository.c
index db4f9d006e..33ad8984bc 100644
--- a/repository.c
+++ b/repository.c
@@ -385,7 +385,8 @@ void repo_clear(struct repository *repo)
 	odb_free(repo->objects);
 	repo->objects = NULL;
 
-	parsed_object_pool_clear(repo->parsed_objects);
+	if (repo->parsed_objects)
+		parsed_object_pool_clear(repo->parsed_objects);
 	FREE_AND_NULL(repo->parsed_objects);
 
 	repo_settings_clear(repo);
-- 
2.55.0.1067.gf7fc94a55c

