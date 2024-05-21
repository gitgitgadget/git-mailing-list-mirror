Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC9560EC4
	for <git@vger.kernel.org>; Tue, 21 May 2024 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285349; cv=none; b=es/G0Xav3lEuT1Oh4ySFDz/zovgx/64dR/JUQzPIMiLmdqjOli1bipJgGgtdm9UIcPcfAODhh49qqEJ16GWBebxfHZzg/CjjuYcg7VnPbxpxb+9HUDjTPVJgGA58RzIQnoxvSe1xg/NNik8BgG6CJwoeXyizA4Gwe8EQp4JlkVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285349; c=relaxed/simple;
	bh=ECwRZCVr5zUZ5At5cxvtPYef+wpDPVyyUaORmYpRigg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mU5W33+E4Mh+hnUYvmYhPivAZttRxDFI6dHaBRTdIvRajCoTYkKLlmDM6n8jpgR6usm+8g/DFn1dZv/ONXrCV+Enbc5l2FeSaskjr4LWKNXmMCZRUYEHXsdvEhaX5BA8Zqsyp+BnC4Z+thVVbxdaIEv2ZifvZYs4Ehjk1u/8bJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23083 invoked by uid 109); 21 May 2024 09:55:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 May 2024 09:55:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7379 invoked by uid 111); 21 May 2024 09:55:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 May 2024 05:55:50 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 21 May 2024 05:55:44 -0400
From: Jeff King <peff@peff.net>
To: Matt Cree <matt.cree@gearset.com>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Issue with git log and reference repositories using --dissociate
 and --filter=blob:none
Message-ID: <20240521095544.GA701795@coredump.intra.peff.net>
References: <3B4EFAA3-0EE1-4C08-ADCD-7B03E184B016@gearset.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3B4EFAA3-0EE1-4C08-ADCD-7B03E184B016@gearset.com>

[+cc Jonathan Tan for his commit mentioned below but also as the general
promisor repacking guru]

On Fri, May 17, 2024 at 02:52:45PM +0100, Matt Cree wrote:

> From what I can tell, what is going on here is the following
> 1. We cloned the repository using --dissociate which forces a repack of the cloned repository
> 2. The clone completes fast (on git 2.40+) but in the background 'git-remote-https' is running
> 3. The bug appears while I request the log during this time
> 4. When the 'git-remote-https' process ends, the log can be requested successfully

Thanks for providing a thorough example, which let me reproduce the
problem. I think the stuff about remote-https is a red herring. The
fundamental issue is some weirdness in the interaction between the
promisor and alternates features when repacking (a "promisor" pack is
one we got from a filtered fetch, where the other side "promises" that
it can give us the rest of the objects later). Plus Git being a little
too hesitant to lazy-fetch the missing commit.

Here's an even simpler from-scratch reproduction:

-- >8 --
# start with a clean slate
rm -rf server client reference

# we have a server that allows partial clones
git init server
git -C server config uploadpack.allowFilter true

# we also have a reference repo which has its first commit
git -C server commit --allow-empty -m one
git clone --bare server reference

# but importantly the server also has a second commit which is not
# in the reference repo
git -C server commit --allow-empty -m two

# now we do a partial reference clone. This is going to get a new copy
# of commit "two" in a pack marked as a promisor (since we know the
# other side can give us anything it points to later if we ask). But it
# won't get a copy of "one", because that's in the reference repo
git clone --no-local --reference reference --filter=blob:none server client

# At this point we're good, and can access all objects. But if we had
# specified --dissociate, it would do the equivalent of these commands:
cd client
git repack -ad
rm -f .git/objects/info/alternates

# And now we find that when we run git-log, we are missing commit "one"!
git --no-pager log
-- >8 --

During that repack we actually make two packs:

  1. We repack all of the promisor objects we have into their own new
     pack (so just "two" in this case).

  2. And then we follow up by making a new pack with all of the
     non-promisor objects (both local and non-local). Which in this case
     would usually be "one". But we tell it to exclude any promisor
     objects, which causes our traversal to mark "two" with the
     UNINTERESTING flag. And then as we traverse, that flag transitively
     applies to things we can reach, including "one", and we exclude it
     from this pack.

     So we realize that "one" is something we _could_ ask the server
     for, even though it's not in a promisor pack itself. But it's sort
     of both a promisor (reachable from a promisor object) and sort of
     not (we don't have it in a promisor pack). And so it's included in
     neither of the new packs.

I think this is sub-optimal, in that we'd usually try to keep promisor
objects we have locally (without alternates, they'd have come from the
original filtered fetch and would be in the promisor pack). But we fail
to migrate them to the new pack in this case.

However, this isn't actually a corruption, because you really can get
"one" from the server. But git-log doesn't ask for it! It used to, but
stopped due to 7e2ad1cda2 (commit: don't lazy-fetch commits,
2022-12-14), where parse_commit(), etc, won't do the lazy fetch. You can
still grab it with something like "git cat-file commit HEAD^", which
lazy-fetches via read_object_file(). After which the repo is repaired
(though of course in a bigger repository there may be many such
commits).

The logic in 7e2ad1cda2 is that we don't have any filters which exclude
commits, so there's no need to lazy-fetch them. But obviously we can
still be missing them due to the promisor repacking scheme, as above. So
I'm not sure if that commit is wrong, or if the repacking should be more
careful about holding on to objects from the reference repo (which would
fix the bug, but also do the more efficient thing the user was trying in
the first place).

-Peff
