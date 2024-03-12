Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE037C0A3
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281881; cv=none; b=FdFrbLAdiQ079Vu9YYN+E8isvofrxaYuCHhLnNZMoxCAFpJiUQT2/PGN1iTeO3jHa+8Y/jpopraltyM2c9aJdG7Zmv/RjPY1LXus4xPya8dC8bzd5nJa0wBy6KefquShyfXpRLmNO04cu2iM1bFcyVRoAQVbkTdgDGN1qU+myWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281881; c=relaxed/simple;
	bh=+UKz7oyRbmBPIaq9Gxul/4mueVyDI35JAL99aeH5zwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uot6ou8n5SCH5Zhda9GtOkk+qiBqEAIHBOITkQDICXT12XqX5XTNMvUh2Q5UeNyB8xD8Lz5vKVsqn0GYVzhtkJC76lgKvsESyKileNIgm2nt5nLeBxixHGGdcfpo5XWN1o+Fio6ai874kSZBWlhE++oz80LlcFojhZEJrzZbbkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24191 invoked by uid 109); 12 Mar 2024 22:17:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 22:17:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1232 invoked by uid 111); 12 Mar 2024 22:18:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 18:18:01 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 18:17:58 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] cat-file: avoid verifying submodules' OIDs
Message-ID: <20240312221758.GA109417@coredump.intra.peff.net>
References: <pull.1689.git.1710183362.gitgitgadget@gmail.com>
 <951f73397c15f76da75bbd74a02f36da0116623f.1710183362.git.gitgitgadget@gmail.com>
 <xmqqh6hbl2mz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6hbl2mz.fsf@gitster.g>

On Tue, Mar 12, 2024 at 11:35:16AM -0700, Junio C Hamano wrote:

> I actually have to wonder if the new behaviour proposed by this
> patch is a solution that is in search of a problem, or trying to
> solve an unstated problem in a wrong way.
> 
>     O=$(git rev-parse --verify :sha1collisiondetection)
>     git cat-file -t "$O"
>     
> should fail because the object whose name is $O is not available.
> Why should then this succeed and give a different result?
> 
>     git cat-file -t :sha1collisiondetection
> 
> The "cat-file" command is about objects.  While object's type may
> sometimes be inferrable (by being contained in a tree), if the user
> asks us to determine the type of the object, we should actually hit
> the object store, whether the commit object in question happens to
> be on our history or somebody else's history that our gitlink points
> at.
> 
> So, I am not yet convinced that I should take this patch.  Previous
> two steps looked good, though.

I'm not sure about "-t" in particular, but for batch output, I think if
we stop at patch 2 it would be impossible to tell the difference between
a submodule entry and a corrupt repo (or bad request). E.g., if I do
this:

  (echo HEAD:Makefile; echo HEAD:sha1collisiondetection) |
  git cat-file --batch-check='%(objectname) %(objectmode)'

after only patch 2, I'd get:

  4e255c81f22386389c7460d8f5e59426673b5a5a 100644
  HEAD:sha1collisiondetection missing

We can't tell if HEAD didn't resolve, or it doesn't have that path, or
if it's a regular blob entry and the repository is corrupt. Whereas
after patch 3, we get:

  4e255c81f22386389c7460d8f5e59426673b5a5a 100644
  855827c583bc30645ba427885caa40c5b81764d2 160000

and the mode tells us that we resolved it to a submodule.

The current behavior is not too surprising for cat-file, since it's
whole purpose is to give you information about the objects themselves,
and we don't have one here. But with this %(objectmode) format, we're
really moving into a realm of "resolve this name for me and show me the
context". We don't care about the details of the object at all!

I think you could make an argument that the problem is shoe-horning new,
slightly-mismatched functionality into cat-file. But there are lots of
practical reasons to want to do so, as we discussed elsewhere. Since
gitlinks are the only place where we'd expect an object to be missing,
"simulating" them here isn't too bad. But I suspect there's a more
general solution where cat-file learns to print dummy values for any
missing object, letting the caller see what we _could_ find out. And
then the submodule case just falls out naturally. I doubt we could make
it the default for historical compatibility; we'd need a new option.

This is all speculative on my part, of course. Probably Dscho or
Victoria can explain their use case better. :)

-Peff
