Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124A44086A
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 05:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767332976; cv=none; b=XMvfA0LuVMAgkhnb0I3M1ttVzQCydbM+s2UiGcGq1aCVBlGSHIczcep5aRs0znifM0pR/LfP3WQIH4L9TFPcnqAF6J22g2wjrHHVrRoVYftNVwJCmRg7wx3kQr+Y9y8Slrx9Kn6fDiOgrrW+8UM/mU+UVHkKZ8o61mZaOA/keiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767332976; c=relaxed/simple;
	bh=NCS0jyQDJZrmQnpBZMal8yZ1C8mo56MsnNYadA1vcfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfLhn03EH4jznwc5XVvAZtgzYvATCFjKl021PQoD07cEMSfFk6hhmGFDEsfzU90FDP5tbvsGxIk1C7JLuO9c1U3XHv3zU9e/zp3/X/wcpv6R9LCN1/NMQu7mKLwazfwFMifQD1ZOFUwLyYCA87WKECBP5h8y+2mU9NeWLBjvdZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=B4o7JvJX; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="B4o7JvJX"
Received: (qmail 552042 invoked by uid 109); 2 Jan 2026 05:49:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NCS0jyQDJZrmQnpBZMal8yZ1C8mo56MsnNYadA1vcfA=; b=B4o7JvJXJDjXWKxJYjpoItFxhu+0OwavT94DkYH2bAnFXOyAYykX/5djQpbVdky5lVgGAKwq9GyeoBerMT/TrdsATmHCeyw9VMaNxfJZw7Q+X+MnqlOUK6Ghf4AWiEHxUUhvYQz6tkmpfY/5iJ2pvhX1WrqmNcvowfa371v/rO2VgdXdV+xAPQLn6i4zweTjjYd7BXpMKkmbvtj4cYK9O4KCqDQ6tsxlKALgODFN8IW6VfgiOWMTVIhWy7JBC5z/QXyeDexh4rE2ReSCwSBni8gHhvMUftHkS5Mr4FVc+rY2K7fJIx+V0gnxwuzTtlPXul6fGNwGbzWCcEXuGsl5kw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Jan 2026 05:49:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 718322 invoked by uid 111); 2 Jan 2026 05:49:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Jan 2026 00:49:27 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Jan 2026 00:49:22 -0500
From: Jeff King <peff@peff.net>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH] fsck: snapshot default refs before object walk
Message-ID: <20260102054922.GA2580212@coredump.intra.peff.net>
References: <pull.2026.git.1767035549378.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2026.git.1767035549378.gitgitgadget@gmail.com>

On Mon, Dec 29, 2025 at 07:12:29PM +0000, Elijah Newren via GitGitGadget wrote:

> Fsck has a race when operating on live repositories; consider the
> following simple script that writes new commits as fsck runs:
> 
>     #!/bin/bash
>     git fsck &
>     PID=$!
> 
>     while ps -p $PID >/dev/null; do
>         sleep 3
>         git commit -q --allow-empty -m "Another commit"
>     done
> 
> Since fsck reads refs at the beginning, walks those for connectivity,
> and then reads the refs again at the end to check, this can cause fsck
> to get confused and think that the new refs refer to missing commits and
> that new reflog entries are invalid.

I'm not sure if this is entirely accurate. Does fsck read refs at the
beginning? I think it walks over everything in the object database
without regard to connectivity, marking each with the HAS_OBJ flag. And
then we use the refs to find the reachable objects, making sure any that
are reachable also have HAS_OBJ set (otherwise they are missing).

So the race is really:

  1. We look at all of the packs and loose objects to set HAS_OBJ.

  2. Somebody else simultaneously adds a new object, which is missed by
     our step 1, and updates a ref to point to it.

  3. We look at the refs for reachability, see the new object, but
     think it is missing because we never saw it in step 1.

And your fix is to snapshot the refs as a "step 0", and use that
snapshot in step 3. So any new objects that are introduced after step 1
will never be referenced, since we are using the snapshot values.

Which makes sense as long as we assume objects are only added to the
repository. I think we'd now have the opposite direction race:

  0. We snapshot the refs.

  1. Somebody else deletes a ref, and then does a pruning git-gc which
     deletes the object it pointed to.

  2. We look at all of the objects and mark them as HAS_OBJ. We do not
     include the now-deleted object.

  3. We do a connectivity check with the snapshot, and are dismayed to
     find that the deleted object (which we believe is still referenced)
     has gone away.

I think you could argue that this is a much more preferable race,
though. A busy server will see lots of new objects introduced and refs
updated, and you do not want to have a stop-the-world lock that prevents
pushes. But it is much less common to do a pruning gc, and it is
probably OK to have a mutually exclusive lock between fsck and gc.

> This problem doesn't occur when refs are specified on the command line
> for us to check, since we use those specified refs for both walking and
> checking.  Using the same refs for walking and checking seems to just
> make sense, so modify the existing code to do the same when refs aren't
> specified.

So I don't think this part is quite right either, then. We're not using
the command-line arguments collect the set of objects in the repo. That
still happens by walking over the odb itself. So if I do:

  git fsck --no-dangling HEAD

in git.git, and while it is running, do this in another terminal:

  git commit --allow-empty -m foo

then I get:

  error: 49a90c19d0cd010ed00fbb1e4256cbefaa8b83e2: object missing

even with your patch. So I think that names given on the command-line
could benefit from this type of snapshot, because they suffer from the
same race. You want to lock in the ref resolution (whether from
iterating or from names on the command-line) before you start walking
over the odb.

  Side note: I do not think I have ever run fsck with refs on the
  command-line. It is not like it saves you any time! Most of the
  expense comes from opening up and verifying the objects in the first
  step, not from looking at ref reachability.

And one final note on the overall direction of the patch. We are
assuming that if we look at the refs first and then the odb second, that
we will be getting a "fresh" view of the odb in that second step. But
that isn't necessarily so, as we might have loaded the set of packs
earlier in the process. I don't know if it is possible to trigger that
during fsck or not, but certainly it is relying on a subtle assumption.
It probably is worth calling odb_reprepare() after taking the snapshot
to ensure we are not getting any results cached from before the snapshot
was taken.

> +struct ref_snapshot {
> +	size_t nr;
> +	size_t name_alloc;
> +	size_t oid_alloc;
> +	char **refname;
> +	struct object_id *oid;
> +};

Minor nit, but: why keep two arrays and not a single struct with both?
After all, you even end up sticking them back in a struct at the only
point of use:

> +	if (the_refs)
> +		for (size_t i = 0; i < the_refs->nr; i++) {
> +			struct reference ref = {
> +				.name = the_refs->refname[i],
> +				.oid = &the_refs->oid[i],
> +			};
> +			fsck_handle_ref(&ref, NULL);
> +		}

So this could really just be an array of "struct reference". You can't
just hold onto the "struct reference" passed in to the snapshot_refs()
callback (because it gets reused as we iterate), but you could do a deep
copy.

That did make me wonder a bit about the other fields in "struct
reference" (which your snapshot just throws away). But it looks like
fsck_handle_ref() only cares about the name and oid, so it is OK.

> @@ -999,6 +1050,19 @@ int cmd_fsck(int argc,
>  	if (check_references)
>  		fsck_refs(the_repository);
>  
> +	/*
> +	 * Take a snapshot of the refs before walking objects to avoid looking
> +	 * at a set of refs that may be changed by the user while we are walking
> +	 * objects. We can still walk over new objects that are added during the
> +	 * execution of fsck but won't miss any objects that were reachable.
> +	 */
> +	use_snapshot = !argc;
> +	if (use_snapshot) {
> +		now = time(NULL);
> +		refs_for_each_rawref(get_main_ref_store(the_repository),
> +				     snapshot_refs, &default_refs_snapshot);
> +	}

BTW, one of the reasons I started looking at this is that Coverity
complained about this segment of code. We set use_snapshot if and only
if we don't have any argc arguments. And then later...

>  	if (!argc) {
> -		get_default_heads();
> +		get_default_heads(use_snapshot ? &default_refs_snapshot : NULL);
>  		keep_cache_objects = 1;
>  	}

...we enter this block only if argc is zero. So we know that
use_snapshot will be true here, and the NULL path (and thus the fallback
code in get_default_heads()) will never be used.

That's not wrong exactly, as it's "just" dead code. But it was what led
me to thinking about whether the case of non-zero argc would benefit
from the snapshot, too.

There are a few other related interesting cases, too:

  - We may use the index file for connectivity, as well. It suffers from
    the same race, and would benefit from a snapshot.

  - In get_default_heads() we also look at worktree HEADs. Those have
    the same race (their normal refs we don't consider here, because
    they were already handled by the overall ref iteration).

I know that neither of those is of particular interest to you as a bare
server repo would have neither. And it may be OK not to handle them, if
the complexity doesn't merit it. But it might be worth documenting the
short-coming.

-Peff

PS The other reason I looked at your patch is that I got deja vu from
   all of this. I thought we had discussed ref snapshotting for fsck
   before, but I couldn't find anything on the list. It may have been
   internal GitHub discussions.
