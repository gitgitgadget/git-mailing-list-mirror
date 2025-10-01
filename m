Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B559313291
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359595; cv=none; b=IAZgG3SZOrceOSiuLVJdy9Fun+3OvDJud+BsNZvuUmJ+DU5zVpkJvZBBXoE/2jpfr3Q7ML+/A8cB3xqBw8LTXSpmhWE+KbsHwHE800HClos7X6vVJZDSB5QRhR4dV5rf5NVdgHXICCR/MStLno5cKvygrQJ6k79QqvXnAAgiw70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359595; c=relaxed/simple;
	bh=2W3JEnC4MRSdXqUoCe5lP6j5rwxy5+a8W/T7YC1V43k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8YPmdOBs/pV8g/MR0lchUb8OmKZyUJm4iBtZzp/7B61KFeoODDwSDmpX8Nb02foZgwiMDOPbGiyTZUfq46BpkjbxRDbpre58FaMMIJ5ym5m/04R7NxizaZ1yqP94sHuUAYMFKiU9AZoKAMwyghBnb08m1xVgIIdzOPmyeiTMYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=a4aoiKCp; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="a4aoiKCp"
Received: (qmail 99060 invoked by uid 109); 1 Oct 2025 22:59:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2W3JEnC4MRSdXqUoCe5lP6j5rwxy5+a8W/T7YC1V43k=; b=a4aoiKCpMuRDwrbD2kfu2yDaLs3K1AorPrDX0/t744aHTliXy5sMwM6t3tQuqYDDdvhc4p1CI2yWDddLXwUK2XG2z7r7QMEYRmFqvMTCYCLrPEGv6vxtQkuoJ37NQNIeOh8bmi+ftWwPnjTZzsegBpk8sTTIHBVMGZh2zAr5PBkQeQ+ztMTWAygNwAvknKHPBHY1g3cCICe+b9HJM2ST9yLdcQM6/yFKlT7aoLhFnX5dGofG36Xaq7VDoYSrnBRfqR50ENYYpLNXLRBXvyZv5sxTG/lim6pjgP/DHEqQZD2HBgu+0Lk30460YE5aVNncDFQVH90mdHLTKWIk40HZrQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Oct 2025 22:59:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 142062 invoked by uid 1000); 1 Oct 2025 22:59:51 -0000
Date: Wed, 1 Oct 2025 18:59:51 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] Define an extended tree format
Message-ID: <20251001225951.GA142037@peff.net>
References: <20251001005814.846992-1-sandals@crustytoothpaste.net>
 <20251001005814.846992-2-sandals@crustytoothpaste.net>
 <20251001174110.GA137600@peff.net>
 <20251001211140.GA140550@peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251001211140.GA140550@peff.net>

On Wed, Oct 01, 2025 at 05:11:40PM -0400, Jeff King wrote:

> But there were two unexpected bits. The first is that the above doesn't
> just need a way to store the foreign-hash oid in a tree. It needs to be
> in the index, too.
> 
> We could perhaps use the same hackery there, storing sha1-...-foo in the
> index with the sentinel hash. Or perhaps we could extend the index to
> support holding foreign hashes. I'm not sure which would be less
> annoying. If the index and trees don't match, then tree-to-index
> comparisons get weird. If the index and filesystem don't match, then
> index to filesystem comparisons get weird. My gut feeling is that making
> index-to-filesystem comparisons weird (so putting the hacked name into
> the index) is probably going to be better, just because the filesystem
> is already out of our control. So we can do sorted comparisons between
> the index and trees, but filesystem operations are inherently asking
> about paths one by one. But I'd have to dig deeper to get more confident
> in that opinion.

I know everybody was on the edge of their seats, so here's how far I got
(I will probably be offline for travel for a day or two after this).

This patch generates the hacked-up index entry when you do a "submodule
add" (or even a regular "git add"). I suspect it is missing some corner
cases (in particular, I doubt that it would correctly update with "git
add -u" because the actual filesystem path appears untracked from the
naive perspective of the index).

It is not too ugly, I think:

diff --git a/read-cache.c b/read-cache.c
index 06ad74db22..77072df2f7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -708,6 +708,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
 	unsigned hash_flags = pretend ? 0 : INDEX_WRITE_OBJECT;
 	struct object_id oid;
+	struct strbuf submodule_foreign_path = STRBUF_INIT;
 
 	if (flags & ADD_CACHE_RENORMALIZE)
 		hash_flags |= INDEX_RENORMALIZE;
@@ -719,6 +720,16 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	if (S_ISDIR(st_mode)) {
 		if (repo_resolve_gitlink_ref(the_repository, path, "HEAD", &oid) < 0)
 			return error(_("'%s' does not have a commit checked out"), path);
+		if (oid.algo != hash_algo_by_ptr(the_repository->hash_algo)) {
+			/* XXX maybe need to remove entry for "path"? */
+			strbuf_addf(&submodule_foreign_path, "%s-%s-%s",
+				    hash_algos[oid.algo].name,
+				    oid_to_hex(&oid),
+				    path);
+			path = submodule_foreign_path.buf;
+			namelen = submodule_foreign_path.len;
+		}
+
 		while (namelen && path[namelen-1] == '/')
 			namelen--;
 	}
@@ -768,7 +779,20 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		}
 	}
 	if (!intent_only) {
-		if (index_path(istate, &ce->oid, path, st, hash_flags)) {
+		/*
+		 * We actually re-resolve submodules a second time in
+		 * index_path(). That's perhaps something we should
+		 * avoid in general (because it's racy), but it's
+		 * particularly important for our submodule name
+		 * hackery, since "path" is no longer something exists
+		 * in the filesystem at all, and we want to override it with
+		 * our fake sentinel OID anyway.
+		 */
+		if (submodule_foreign_path.len) {
+			/* probably a constant would be less horrific */
+			oidclr(&ce->oid, the_repository->hash_algo);
+			ce->oid.hash[the_repository->hash_algo->rawsz - 1] = 1;
+		} else if (index_path(istate, &ce->oid, path, st, hash_flags)) {
 			discard_cache_entry(ce);
 			return error(_("unable to index file '%s'"), path);
 		}


But then I took a look at the reading side, and it gets pretty ugly.
Often we have just a submodule name, and we end up referencing it in the
index. But of course we don't know if we need to use the hacked-up name
to do the lookup or not, because it depends on the sentinel hash, but we
don't always have a hash yet! So you'd have to speculatively look up
both names in lots of places.

So I think I do lean more towards the index having the full, correct
information, and just doing this hack at the tree level (and munging as
we read/write the trees).

Or of course deciding it's all too horrible and abandoning it. All of
this was meant to be an exploration. I do think it makes a lot of
potential problems and hassles go away if we can intermix submodules of
different hash algorithms. I'm undecided on whether the solution is
worth than the problem, though.

-Peff
