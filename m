Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5B2C18E
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 02:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708396994; cv=none; b=j2aVKUJfPpF+lY9G+yPjefnSwfcm0W4MpZxED1K+kGc5FKpShrXvP+T9MvlsUzynbKAXSXv37n7bgAlHWqj8VX0cvhBGnQNIGdYV0M7M3VoZOTlZCZcD1GDULX7OvkxRdmsOeTM96WkxgphTetVzQ8RRvlh/pmEuvZiVHtrYZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708396994; c=relaxed/simple;
	bh=iFeBKIuRyELiX6yOqwUYww1l9fuDU0Qwk039LrmZmE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhLYDWUvOoqXhksiUsrFAH8T+iUto8TtBoNBfxzBwjlodWnPo5Ll+uR1Zdkl9yHx02e9oBQjO+Ujf0CZz/TFpy8cqMxuJ4K0uWOFblsDSMLoJLo9zfTx7SqMD9AhwBEKRrgA64yIQNdm85dkjoYQb3QC0BiFabBWdBBKMqi1q4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23470 invoked by uid 109); 20 Feb 2024 02:43:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Feb 2024 02:43:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18868 invoked by uid 111); 20 Feb 2024 02:43:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Feb 2024 21:43:14 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Feb 2024 21:43:10 -0500
From: Jeff King <peff@peff.net>
To: charmocc <charmocc@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git commit causes data download in partial clone
Message-ID: <20240220024310.GD2713741@coredump.intra.peff.net>
References: <OK9E_kNDYqB1tDn6YJhtTgkdDDrcr2LhZEGRdmqismu6KyTki-M22CpCAxXHZCn45SZICjnPNYxvw02BnWeJic3mx47-zeI0HDhzdgoJpG0=@proton.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <OK9E_kNDYqB1tDn6YJhtTgkdDDrcr2LhZEGRdmqismu6KyTki-M22CpCAxXHZCn45SZICjnPNYxvw02BnWeJic3mx47-zeI0HDhzdgoJpG0=@proton.me>

On Sat, Feb 17, 2024 at 08:38:08PM +0000, charmocc wrote:

> I was recently exploring git partial clone feature because I wanted to
> contribute to repository which has a lot of binary files. My intent was to only
> add new files without modifying any existing ones and to download as few data
> as possible in the process. Here are the steps I followed:
> 
> $ git clone --no-checkout --filter=blob:none https://github.com/libretro-thumbnails/Nintendo_-_Nintendo_Entertainment_System.git nes
> $ cd nes
> $ echo foo > bar
> $ git add bar
> $ git commit bar # causes git fetch behind the scene and download of a lot of objects!
> 
> Now for reasons I don't understand the last command cause download of a lot of
> objects from remote (blobs) which is what I was trying to avoid. By enabling
> tracing options I can see that it runs fetch operation in the background:

I think what is happening is something like:

  1. You clone with --no-checkout, so you do not fetch any of the blobs.
     But you also have an empty index, with no entries at all.

  2. Running "git commit" is going to need all of those entries in the
     index (to compute the hash of the new tree). So it will read it
     from the tree of the current HEAD.

  3. When we load entries into the index, the usual next thing to do is
     to check them out. So rather than fetch them one by one as we do
     the actual checkout, the index-reading code collects all of the
     entries we don't have and then does a single fetch for them. This
     is prefetch_cache_entries() in read-cache.c.

Now obviously in your example, the "usual" thing is not happening; we do
not intend to write those entries into the working tree, so fetching
them is pointless.

There may be some room for improvement here. E.g., teaching the
index-reading code a flag that says "don't bother prefetching", and use
it in this call chain. I'm not sure if there would be other gotchas,
though.

But here are a few alternatives that you can try without making any code
changes:

  a. Your --no-checkout skips the checkout, but it does not tell Git
     that you are fundamentally uninterested in those other paths. To do
     that, you can try the sparse-checkout mechanism. I'm not super
     familiar with the feature myself, but doing:

       git clone --sparse --filter=blob:none $url nes

     ends up with an empty checkout to which you can add things (the
     trick is that we do have all of those index entries, but they are
     marked as "not interesting").

     Do note that --sparse checks out the contents of the top-level tree
     by default. That's OK for your repo (all of the files are in the
     Named_Titles directory), but it might not be true for some other
     repos (it may also not work if your intent is to put another entry
     into Named_Titles, though it looks like you might just need to say
     "git add --sparse").

  b. Skip the index entirely and just construct your own tree/commit.
     E.g., doing:

       blob=$(git hash-object -w some-file)
       tree=$({
                git ls-tree HEAD &&
		printf "100644 blob $blob\t%s" some-file
	      } | git mktree --missing)
       commit=$(echo my commit message | git commit-tree -p HEAD $tree)
       git update-ref HEAD $commit

    It gets a little trickier if your want to add to a sub-directory
    (you have to recursively generate each tree).

In both cases you might also want to clone with "--depth 1", so you do
not bother grabbing old commits and trees, either.

> git version 2.34.1 (Ubuntu 22.04)

The sparse-checkout feature is new-ish and has been actively worked on
in the past few years. What I showed above works with the latest release
of Git, but you may or may not need to upgrade (I didn't dig into the
details).

-Peff
