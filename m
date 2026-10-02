Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE201F63D9
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 22:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790981044; cv=none; b=poUtLRDE9LNFNwrjAJurYub4l/IbM26Viaj4bVljBMF47gugv97+Rg0q/54Su0eAIVuEyf8KnwBBDVMEKaU8F0DmRUh9MsNPPTI541rfvxmVUtctjlijj6FK5U2OumBiZyUMLSrMWY2LcTno3oOqsokv2LV09NUBzAuXl0hKV9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790981044; c=relaxed/simple;
	bh=sFna1WGFFlf4KUzjzK4nQroyRGErH5kA5qUSdf/gPqY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cUxRtr/AYKK14JGvrboFEN/MOYFaRdu+zdPFxeiEvvhsEWFn+Cy3f96deAOqEOz3e8CgjLmVORwluRqKhSz73LN7SJYd+69Prs9MrXaZjzGeH/WY2kejKoe061u1p8MAsw7UQukLslLdFHcAiVxGszLqj83NrPJvh68lh/T4sVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UqCNmtKE; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UqCNmtKE"
Received: (qmail 16732 invoked by uid 106); 2 Oct 2026 22:44:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=sFna1WGFFlf4KUzjzK4nQroyRGErH5kA5qUSdf/gPqY=; b=UqCNmtKEb6+zwXmKcLXXYoAnWQs/teekKvVELn4toVk8x8++sYsQaGVIJgRLo3O3zfy1isqVZ/a4Jteo+4u6fNJG1ZuJiRCyx0Kts9gW4huvTDs91UZXnMP9nhOgFQp21nqVpyoV9qgkHQ30usDz+vJRz6VIVA7Xo21esJDO9l8Tmtm16heCIq7UAfTfwvje96Eez504ur1LPy6B2lukxYm0DuDtsmSNT2oTlEWjssaAFjFeT8NyCcFL+lCci4OExNBi6eEVCPCgfsl0R1SyctynU6ByjyQfWO6SuZ7WUyYs+keGBcEc2XuCk4fq0erZl0Lr2+2rD1+LWNtJH2lwTg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Oct 2026 22:44:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 48826 invoked by uid 111); 2 Oct 2026 22:44:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Oct 2026 18:44:03 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Oct 2026 18:44:00 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Scott Chacon <schacon@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: a "limbo" object-format state for empty repositories?
Message-ID: <20261002224400.GA834158@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Reading Scott's blog post and accompanying HN comments the other day,
one upcoming usability headache stood out to me: first-time pushes to
newly created repositories.

If you create a bare repo on a forge like GitHub, it must be either sha1
or sha256. If the forge continues to create sha1 bare repos by default,
then all of the post-3.0 sha256 users will get this on first push:

  $ git push
  fatal: the receiving end does not support this repository's hash algorithm
  fatal: the remote end hung up unexpectedly

And then they have to go switch or recreate their remote repo. And if
the forge flips to sha256, then we have the opposite problem for pre-3.0
users (and even 3.0 users who are doing a first-push of existing sha1
repositories).

Savvy users will of course specify the object format they expect to use
when they create the server-side repo. But most users won't know or care
about this, and even if they do, it's an easy thing to forget about. So
I expect we'll see a lot of frustration here.

It would be nice if the empty repository could adapt to the object
format used by its first push. Then everything would just work from the
user's perspective, no matter what they push.

GitHub has long done something similar for the HEAD pointer; on first
push of a single branch it is pointed at that branch. There it was not
too hard to add custom code around Git that detected the situation and
set up the symref. But I don't think you can quite do the same thing for
the object format, because the push advertisement actually says "hey,
I'm a <hash> repo" in its capabilities. So the client says "oh, that
doesn't match me" and bails before actually pushing anything.

So what I'm suggesting instead is that the server be allowed to
advertise a limbo state: it has no object format yet. And then client
can recognize object-format=limbo, and send back "I'm a <sha1|sha256>
repo, so that's what I'm sending you" in its capabilities response.  And
then the server receives that and shifts its local object-format to
match.

There are some tricky bits on the server side (e.g., you'd want to flip
the value atomically so that if you get two simultaneous mismatched
pushes, one of them gets rejected). But I can't think of any reason that
it couldn't conceptually work, and I feel like it would save a lot of
headaches.

But I also did just think of this idea, and haven't implemented anything
(nor do I have immediate plans to). So it might be half-baked. But I
thought I'd toss it out there and see if any body has thoughts, or feels
strongly enough to try implementing it.

-Peff
