Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C7627FB3C
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764956947; cv=none; b=Q/IoukvGg+vUdgaFr7dytRezWGnmxMQwfm//GyiQDxjeqA52n4GYriiRYt4BkpHRHlnpnb99Cdipy07pXjZwuUzPiJvuGnuOmBY928GIAUZz/efPzGLMA0KJ7cEWCB9pFnTVMdxvmNUZfNUnc3h1WTQ6KlK7zY5V9PAAvkOMtoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764956947; c=relaxed/simple;
	bh=lz58dpFU6uqFhjFTL+htQsElbABxioCNlZClUQ3SuuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjH/AjAj0Uc3GKePTxc7EUP+5UJIIm+S0PYR7tBfHV0+057eb/TYjjULcZamPH5vLP4xkyszrHoDZQxM2dWWFiVS7rqMWQJ95kcIcw5tzJUB/g3ttuA1XiO4M/110d5wi5G4RNqVR8fz1Dxn4cOc5Ic1S2gRbyyKEODEZCXgXWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bLnXjkfl; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bLnXjkfl"
Received: (qmail 271800 invoked by uid 109); 5 Dec 2025 17:48:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lz58dpFU6uqFhjFTL+htQsElbABxioCNlZClUQ3SuuU=; b=bLnXjkflFoD0+AZt45vRpF1/fJ9ftqG6xl0pQHCl1bWYlrIfJjM5dtAGQZLHOvoEDVEIjOnaBBgKSWkqLMNV0ipFieU8FMvTG803YuL8ycWGtWe1Jwg6IK1q7U+qWFSuHGpoDL+nkRMR8xOaR7U+FDG8SIOIatUAR9QVcVZ/nnYB0RvXAezgrb/hHzRXK20i/WfKtIqHsvmuE8eJNPdUfic1+QLLkKis0Uqros+kbnKaODnd+4HW4zyBxBDT1idNCrK3t6pIcc5VS88v37VpdzrA4CJ4bBuL3UfNabymfoK7zxXNY7SZAarHHorVE8IF3awgsF6XpMezEIK6dzJIcw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Dec 2025 17:48:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 339846 invoked by uid 111); 5 Dec 2025 17:48:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Dec 2025 12:48:55 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Dec 2025 12:48:54 -0500
From: Jeff King <peff@peff.net>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] packfile: skip decompressing and hashing blobs in
 add_promisor_object()
Message-ID: <20251205174854.GA18566@coredump.intra.peff.net>
References: <20251204172132.319360-1-aplattner@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251204172132.319360-1-aplattner@nvidia.com>

On Thu, Dec 04, 2025 at 09:21:29AM -0800, Aaron Plattner wrote:

> For repositories with large pack files, this can take an extremely long
> time. For example, on a production repository with a 176 GB promisor
> pack:
> 
>  $ time ~/git/git/git-rev-list --objects --all --exclude-promisor-objects --quiet
>  ________________________________________________________
>  Executed in   76.10 mins    fish           external
>     usr time   72.10 mins    1.83 millis   72.10 mins
>     sys time    3.56 mins    0.17 millis    3.56 mins

FWIW, I had a hard time replicating the results with this command,
because it won't necessarily call is_promisor_object(). It only does so
when it finds a missing object. But it also marks everything in the
promisor pack as UNINTERESTING from the start, so you need a
non-promisor commit that points to an object excluded from the narrow
clone.

An easier way to trigger it is with a fake oid like:

  rev-list --objects --all --exclude-promisor-objects $(perl -e 'print "1" x 40')

Then we have to check is_promisor_object() to know that the 111... oid
isn't really a promisor mentioned somewhere.

> For objects that weren't already parsed, use odb_read_object_info() to
> query the object type. If it's a blob, just insert it into the oidset
> without parsing it. This improves performance for very large pack files
> significantly:
> 
>  $ time ~/git/git/git-rev-list --objects --all --exclude-promisor-objects --quiet
>  ________________________________________________________
>  Executed in  118.76 secs    fish           external
>     usr time   50.88 secs   11.02 millis   50.87 secs
>     sys time   36.31 secs    0.08 millis   36.31 secs

Yeah, this is obviously a good idea. This all seemed eerily familiar,
and I wondered if we weren't doing this already. But it looks like it
came up as "maybe we should do this" along with some other
optimizations, but we never did it. Your 176GB (!) repository is
obviously a good way to show off the change. But I think we can see it
even in a fresh clone of linux.git, which (with my command above) goes
from ~7.5 minutes to under 2 minutes with your patch.

But I have an idea that makes your patch a little simpler and should
give us another little speed bump.

> diff --git a/packfile.c b/packfile.c
> index 9cc11b6dc5..563fd14f0e 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -2309,6 +2309,17 @@ static int add_promisor_object(const struct object_id *oid,
>  	if (obj && obj->parsed) {
>  		we_parsed_object = 0;
>  	} else {
> +		/*
> +		 * Blobs don't reference other objects, so skip parsing them
> +		 * to save time.
> +		 */
> +		enum object_type type;
> +		type = odb_read_object_info(pack->repo->objects, oid, NULL);
> +		if (type == OBJ_BLOB) {
> +			oidset_insert(set, oid);
> +			return 0;
> +		}
> +

OK, so we are checking the type up front and then skipping
parse_object() if we can. But there is already some logic inside
parse_object() for these kinds of optimizations. If we tell it we are
not interested in checking the hash of the objects, then it knows it can
skip loading the blob entirely.

But it can _also_ use that flag for other things, like using the
commit-graph rather than loading individual commit objects. So doing
this:
  
diff --git a/packfile.c b/packfile.c
index 9cc11b6dc5..01b992a4e1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2310,7 +2310,8 @@ static int add_promisor_object(const struct object_id *oid,
 		we_parsed_object = 0;
 	} else {
 		we_parsed_object = 1;
-		obj = parse_object(pack->repo, oid);
+		obj = parse_object_with_flags(pack->repo, oid,
+					      PARSE_OBJECT_SKIP_HASH_CHECK);
 	}
 
 	if (!obj)

drops my linux.git case down to 49s. It's skipping the blobs (with no
need for your patch) and loading the commits out of the graph file. Note
that you may need to "git commit-graph write --reachable" to see the
effect (I think we do generate graphs by default in git-gc these days,
but I'm not sure if we do so right after cloning).

-Peff
