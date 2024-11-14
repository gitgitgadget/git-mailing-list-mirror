Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67AB219EB
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 00:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545817; cv=none; b=af5qYteDqZ4YIWa7lHjUFgDJ/u+Mv8qU4+P7+92FVlqauMCKrVqf+gv4sVeM9ylTTNibtapMKiQEU/sa0vVujp7aUQZaOeZ8L+ZR5w6LjrLsLwRPQACeeOKruuoMIlFgB4qvPZuXduFx/2EAdPLZB7lX+r7JsNmQIA0PdUOlsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545817; c=relaxed/simple;
	bh=ZGmGcqbCV8WWUH6RycL1bKDMGJMs3BSj/uRQN+0h0qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0TBipsI21XsDhl1vuovDGYb2UaW/FG/1J5v61LhzoLFbwxDgljX3qMr+5KF1q/IXlPgCvk0p4Z6zr2tSYEyDxwblk2CbbGqz3I5Q2IbaifcnzImP8irbZJiHNW1dIlh7JVcypqRzxeMZh9GFFVkn9EPWOg2QyI0+FRn+q/O1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ALhiLv3w; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ALhiLv3w"
Received: (qmail 26242 invoked by uid 109); 14 Nov 2024 00:56:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZGmGcqbCV8WWUH6RycL1bKDMGJMs3BSj/uRQN+0h0qE=; b=ALhiLv3wIVw2JRIC8SyOiDWLGmu/XlDIZWCOYfcBmHGioF9IRJF2D/M+6k2ox7DW8FdMR60O6D8Q0pPGoDXvMUpSMvkgOO7c2veowZzdsMWKbG70WuNhpeZjiVkJy6SV0zVhanuH357+lMVrmjA4wL9/rXO4SmUxbMJy3v+c7PIPHfOrvhn0h5t5yHc7YOUusb3f0hq5zInKYz/KE7IPtQc05m7uui8ox2cJlEdOmVjeIgDQmcMrxnHL0wd6COuikFmyEYmsBBe5d/uD0RykpUiXqhUE64TLg6IYXH0dQJ3GG4kybcn2aklmdJqeZdls3zD7Hz80MarlStaqs4Vicw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Nov 2024 00:56:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19875 invoked by uid 111); 14 Nov 2024 00:56:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Nov 2024 19:56:56 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 13 Nov 2024 19:56:52 -0500
From: Jeff King <peff@peff.net>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org, steadmon@google.com, hanyang.tony@bytedance.com,
	me@ttaylorr.com
Subject: Re: [PATCH v2 3/4] t5300: move --window clamp test next to unclamped
Message-ID: <20241114005652.GC1140565@coredump.intra.peff.net>
References: <20241113073500.GA587228@coredump.intra.peff.net>
 <20241113182656.2135341-1-jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113182656.2135341-1-jonathantanmy@google.com>

On Wed, Nov 13, 2024 at 10:26:56AM -0800, Jonathan Tan wrote:

> > The reason these window tests are broken is that the earlier "build pack
> > index for an existing pack" is now finding and storing deltas in a new
> > pack when it does this:
> > 
> >   git index-pack --promisor=message test-3.pack &&
> > 
> > But that command is indexing a pack that is not even in the repository's
> > object store at all! Yet it triggers a call to pack-objects that repacks
> > within that object store.
> 
> As far as I know, index-pack, when run as part of fetch, indexes a pack
> that's not in the repository's object store; it indexes a packfile in a
> temp directory. (So I don't think this is a strange thing to do.)

When fetching (or receiving a push), we use "index-pack --stdin" and do
write the resulting pack into the repository (and the command will
complain if there is no repository).

So I think what the test is doing above (using --promisor on a random
packfile) is questionable. It goes back to 1f52cdfacb (index-pack:
document and test the --promisor option, 2022-03-09). I wonder if that
test is actually valuable now that the --promisor option is actually
triggered via fetch.

If we restricted --promisor to work only with --stdin, that would deal
with both of the issues I saw. And I suspect (but didn't dig deeply or
test) that would be sufficient for how it is called within git. (I
wondered briefly if bundles might index in-place, but they seem to use
--stdin also).


Where it gets weirder to me is with quarantine directories (and maybe
this is what you meant above). On receiving a push, we "index --stdin"
into a temporary quarantine directory. If that kicks off a pack-objects
run, where does that pack-objects put its new pack? Within the
quarantined index-pack we set GIT_OBJECT_DIRECTORY to the quarantine and
add the original repo as an alternate. So I _think_ both the pushed-up
pack and the repacked promisor pack would go into the quarantine dir,
and then we'd migrate both (or neither) when we commit to the push.

Which is OK, but I don't know that I thought that far ahead when writing
the quarantine stuff long ago.

It's probably somewhat academic right now, as I'm not sure if you can
even push reliably into a promisor repo (and it doesn't look like
receive-pack knows about passing --promisor anyway). We don't quarantine
on fetch right now, though we have discussed it in the past (and I think
we should consider doing it).

So this may become more real in the future. I wonder if there is a way
to add a test to future-proof against changes to how the quarantine
system works. The theoretical problem case is if we did quarantine
fetches, but accidentally wrote the new promisor pack into the main
repo instead of the quarantine, and then a fetch rejected the incoming
pack (because of a hook, failed connectivity check, etc). Then we'd end
up with the new promisor pack when we shouldn't, which I guess could
move objects from that incoming pack that we rejected into the main
repo, despite the quarantine?

I can't think of a way to test that now, without the quarantine-on-fetch
feature existing.

> > I'd guess in the real world, we'd only pass that option when indexing
> > packs that we just fetched. But as a bystander to this feature, it feels
> > quite odd to me that index-pack, which I generally consider a "read
> > only" operation except for the index it was asked to write, would be
> > creating a new pack like this. I didn't follow the topic closely enough
> > to comment more intelligently, but would it be possible for the caller
> > of index-pack to trigger the repack as an independent step?
> 
> I thought of that, but as far as I know, during a fetch, index-pack is
> the only time in which the objects in the fetched pack are uncompressed
> in memory. There have been concerns about the performance of various
> ways of solving the promisor-object-and-GC bug, so I took an approach
> that minimizes the performance hit as much as possible, by avoiding yet
> another uncompression (we need to uncompress the objects to find their
> outgoing links, so that we know what to repack).

Hmm, yeah. I can see the appeal of doing the processing there. Kicking
off a pack-objects can be similarly expensive in the worst case, but in
practice it should only be dealing with a few new objects (and we want
to cheaply find out what those objects are, if there are even any at
all).

> We definitely should prevent the segfault, but I think that's better
> done by making --promisor only work if we run index-pack from within a
> repo. I don't think we can restrict the repacking to run only if we're
> indexing a pack within the repo, because in our fetch case, we're
> indexing a new pack - not one within the repo.

I think the "--stdin" thing above neatly solves this.

> Maybe we could conceptualize "index-pack --promisor" as the pack
> giving "testimony" about objects that its objects link to, so we can
> update our own records.

Yeah, I guess the fundamental thing here is that anybody who isn't
passing "--promisor" is not going to be affected, so that at least
limits the opportunity for surprise.

The quarantine discussion above is an example of how there could be
unexpected consequences. I _think_ it's OK based on what I wrote, but
hopefully that explains my general feeling of surprise. I dunno. It
still may be the least bad thing.

-Peff
