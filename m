Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF56230EF81
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 21:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759353104; cv=none; b=OA5cK66SSpNPe5KclfcKqDZaU6DDCC56F+mMZPzjQiN0b7LVX/DeAIKgef6y1JynBY/GHSRMldbbnrfzkqaQIdqQTl7IvGAms9h15F/Et0IGp6EAKSrCBrFCdZWe3CLmzXR5sHNnASOjrlSp6ox51e/+IlwyWhTYJ2lpUQIdKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759353104; c=relaxed/simple;
	bh=NcQSgZmBBiA/N4pLZcqqc8m5U3ax2NpqzJevAKJp8K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GM4GduxjQZL7ykVxlsZ+jO+6VJv7oWD5kJxY33/B/fssd/nsgJsNrGVJribU6iPYBa4xWMdjph24Vmy8nx9Mk6/68Cq9Lfbnqsl+T8MbRlc78w7xrd7dA46sPaogN6lcQKtEuNhnkhOBIfOPirUVkz9x0SmxxAKGV+amxs9WKEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YU3AIXiW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YU3AIXiW"
Received: (qmail 98654 invoked by uid 109); 1 Oct 2025 21:11:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NcQSgZmBBiA/N4pLZcqqc8m5U3ax2NpqzJevAKJp8K4=; b=YU3AIXiWCnsY7tPyEHksVFoRt0j5gCrGG3IUT0/0Ga3DQNeFX9ZpAuvIJPyZReMJPZVfVzcgZolEYsyrvNn3kHg5qBL+EGEUKY4LjOlomQ8DrMOySZ63qwMPUny4GvkZhCHlDxg+ldywusufNwxX2vuzCP91a8aQuMIKXy4kzYmEKDiGcw0z7Voh1I+XgYY0CB38jlikNkCh1NPTvqxdENZlBVjdAnBbcxyUFPHaVC+zyez1D3bRzUWx1bRyvWfZuCEbRhHTRm3xUaxFYjV3+zlrKYZOcHMRmGmzhqrD7ifjshGMc6Ghuv0Xxy5EEsikpQSPMhvlvg3XywEBMh3SEQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Oct 2025 21:11:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 140576 invoked by uid 1000); 1 Oct 2025 21:11:40 -0000
Date: Wed, 1 Oct 2025 17:11:40 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] Define an extended tree format
Message-ID: <20251001211140.GA140550@peff.net>
References: <20251001005814.846992-1-sandals@crustytoothpaste.net>
 <20251001005814.846992-2-sandals@crustytoothpaste.net>
 <20251001174110.GA137600@peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251001174110.GA137600@peff.net>

On Wed, Oct 01, 2025 at 01:41:10PM -0400, Jeff King wrote:

> My gut feeling is that would keep the gross-ness confined to a few bits
> of code, and you could still operate on these natively with tools like
> mktree, ls-tree, and so on. The ugly names will leak out to the user
> sometimes, but most porcelain flows would do the right thing.

I was hoping make a proof-of-concept patch to get more familiar with
exactly what it would look like for various commands. So the scenario I
came up with was this:

-- >8 --
#!/bin/sh

# you can have a sha256 module in a sha1 repo or vice versa
sup_algo=$1; shift
sub_algo=$1; shift

rm -rf sub super clone

# a boring sub-project with one commit
git init --object-format=$sub_algo sub &&
(
	cd sub &&
	echo content >file &&
	git add file &&
	git commit -m msg
) &&

# the superproject includes it
git init --object-format=$sup_algo super &&
(
	cd super &&
	git -c protocol.file.allow=always submodule add "$PWD/../sub" foo &&
	git commit -m 'add sub'
) &&

# and then in theory we can clone it and check out the submodule
git -c protocol.file.allow=always clone --recurse-submodules super clone
-- >8 --

But there were two unexpected bits. The first is that the above doesn't
just need a way to store the foreign-hash oid in a tree. It needs to be
in the index, too.

We could perhaps use the same hackery there, storing sha1-...-foo in the
index with the sentinel hash. Or perhaps we could extend the index to
support holding foreign hashes. I'm not sure which would be less
annoying. If the index and trees don't match, then tree-to-index
comparisons get weird. If the index and filesystem don't match, then
index to filesystem comparisons get weird. My gut feeling is that making
index-to-filesystem comparisons weird (so putting the hacked name into
the index) is probably going to be better, just because the filesystem
is already out of our control. So we can do sorted comparisons between
the index and trees, but filesystem operations are inherently asking
about paths one by one. But I'd have to dig deeper to get more confident
in that opinion.

The other unexpected thing is that the sequence above works today! I
think it is mostly accidental, though. When we read the head of the
submodule, we get a "struct object_id" with a different algo field. But
we never pay attention to that field, and just treat it as if it is
using our native algorithm.

So if I use a sha256 submodule in a sha1 repo, the final part of the
output (in the recursive clone) looks like this:

  Submodule path 'foo': checked out 'db8b8f8006f4564e7862b246c4d57100790e2196'

We've truncated the sha256 to 20 bytes (40 hex) and used that instead of
the full oid. But Git is flexible enough that it is happy to find the
object by its abbreviated hash, and checks it out without complaining.

If we go the other way, with a sha1 submodule in a sha256 repo, we get
this final line:

  Submodule path 'foo': checked out '03f08992d562b03e2af5b4256e17b82be8eafa98000000000000000000000000'

I expected to get random garbage at the end, since we only copied in the
first 20 bytes, but since c98d762ed9 (global: ensure that object IDs are
always padded, 2024-06-14) we zero-pad all oids. The intent there was
making internal comparisons fast, but it happens to help us out here. I
am a little puzzled that Git is willing to check out the zero-padded
name, but I wonder if we simply parse it into an object_id struct and
then only look at the first algo->raw_size bytes.

So it all works as expected, but I feel like it's mostly by accident. My
gut feeling is that we probably wanted something like this to protect us
from confusion:

index 06ad74db22..295b0c6318 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -719,6 +719,8 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	if (S_ISDIR(st_mode)) {
 		if (repo_resolve_gitlink_ref(the_repository, path, "HEAD", &oid) < 0)
 			return error(_("'%s' does not have a commit checked out"), path);
+		if (oid.algo != hash_algo_by_ptr(the_repository->hash_algo))
+			return error(_("object format %s of '%s' is incompatible with this repository (%s)"), hash_algos[oid.algo].name, path, the_repository->hash_algo->name);
 		while (namelen && path[namelen-1] == '/')
 			namelen--;
 	}

Of course that is strictly worse for somebody who is relying on the
current accidental behavior. ;) And in the long run, I think this is the
spot we'd want to hook to do whatever massaging we need (whether
converting to the equivalent in-repo algorithm, or hacking up the name
to store the foreign hash).

I also won't be at all surprised if you've run across this already in
your interop work.

-Peff
