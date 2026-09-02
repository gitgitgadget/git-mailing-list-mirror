Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CF23264F4
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330583; cv=none; b=KCYZfHueJol30uylEQleGierA4gD66y6GH0QWV+VV3V3HdAptemY0Ei3RM6etNvIsH5lp+NttChMt/NTNAnfVbctxiOLpP27//IjptfWEFSK3zUkKfldA9pSskjGhT9leaojueRiA67G06nhUReVgIRT/h8BSMnvRULNaz1yIrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330583; c=relaxed/simple;
	bh=C/suXKgC1x8+G8povRd7ZiXroEVxh99hXZzmYUD4BFE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhpFWVY2XSuIgXhZii46ypyhwcmXtvZ/D2UQyq0IfPy1zK0OGjiSi+97la6VXgF+HVtG5hkHmGETENCj0N+SpWnHhZhCjSv4s9v+17JD0ySzYQ50iRd97YDtbsp94i2m0EQx7PYxEOCKzIHnYVxI4amwVvgvEQV5XcKWZgFYGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=S0UqTUey; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="S0UqTUey"
Received: (qmail 10040 invoked by uid 106); 2 Sep 2026 06:29:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=C/suXKgC1x8+G8povRd7ZiXroEVxh99hXZzmYUD4BFE=; b=S0UqTUeyz5TYWOml42Al0HhVdB/XGh4eHBM/8vzYIhdZFBdqApxJjA9Sdo5L9xOSiZSCU0WkuxqRcayKewnYbDahx/A4J8Yvxyd0EhHcS9Oz6cO3g9djpTXGOVSNDLe+l87SswRjSpHfn57lX3N0i9gDDdAxtKczyI+Qydwp9X9B3NeYBakFm0eb96KvRJa0fE1r1APjlYKCgoBxcfdC58yNvAMaflcuvbxJjGhjgtJhJOpoh6j6fbdUorJvw7VmLhFknOkiuDPR15sjQwrU2v0z0tYYYu4PjoxeZF1/B3PlP5y1LgyCanRsk9vftD2fDzMCf0jdTn7JJeQQgTZxfg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Sep 2026 06:29:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 47071 invoked by uid 111); 2 Sep 2026 06:29:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Sep 2026 02:29:40 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 2 Sep 2026 02:29:40 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: Re: [PATCH 1/2] repository: make repo_clear() idempotent
Message-ID: <20260902062940.GA47676@coredump.intra.peff.net>
References: <20260902055117.GA41587@coredump.intra.peff.net>
 <20260902055526.GA41747@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902055526.GA41747@coredump.intra.peff.net>

On Wed, Sep 02, 2026 at 01:55:27AM -0400, Jeff King wrote:

> Arguably this should not be a pointer at all, but the pool code is
> weirdly asymmetric. It offers only "new" which allocates a struct, but
> only "clear" to clean it up (but not deallocate). Might be worth fixing,
> but out of scope for this series.

I took a quick stab at this, and it gets ugly. There is no mutual
recursion between the parsed_object_pool and repository struct
definitions, but we do end up in a header include loop:

  - repository.h would need object.h (to include the pool struct)

  - object.h includes hash.h for object_id, etc

  - hash.h (sometimes) includes repository.h so it can define
    the_hash_algo when USE_THE_REPOSITORY_VARIABLE is defined

We could break the cycle if we had a separate the-repository.h which
looked like this:

  struct repository;
  extern struct repository *the_repository;

and then included that from hash.h. But then callers which want to use
the_hash_algo would need to include repository.h themselves. It is
just a macro looking at the_repository->hash_algo, so they need the
actual repository definition. About 9 files need to start including
repository.h themselves to make it work. Though a few of them _ought_ to
be including it anyway; they are not using the_hash_algo at all, but
just lucky that hash.h happens to bring repository.h when
USE_THE_REPOSITORY_VARIABLE is set.

An alternative would be to define the_hash_algo as its own pointer,
like:

diff --git a/hash.h b/hash.h
index cf94ad5700..9e21ac6480 100644
--- a/hash.h
+++ b/hash.h
@@ -269,8 +269,7 @@ enum get_oid_result {
 };
 
 #ifdef USE_THE_REPOSITORY_VARIABLE
-# include "repository.h"
-# define the_hash_algo the_repository->hash_algo
+extern struct git_hash_algo *the_hash_algo;
 #endif
 
 /* A suitably aligned type for stack allocations of hash contexts. */
diff --git a/repository.c b/repository.c
index db4f9d006e..f70c4deecf 100644
--- a/repository.c
+++ b/repository.c
@@ -30,6 +30,7 @@ extern struct repository *the_repository;
 /* The main repository */
 static struct repository the_repo;
 struct repository *the_repository = &the_repo;
+struct the_hash_algo = &the_repo->hash_algo;
 
 /*
  * An escape hatch: if we hit a bug in the production code that fails


That makes the_hash_algo just work without most code caring about
repositories at all. But of course it reveals yet more spots which are
relying on hash.h mentioning the_repository. :-/

I'm not sure how much it's worth untangling all of this, but probably
not enough just to remove pointer indirection from repo->parsed_objects.

-Peff
