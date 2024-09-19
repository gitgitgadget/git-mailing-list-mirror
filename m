Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FAB1F16B
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726729916; cv=none; b=i2xvrTSjjhUNPFmvXPBvbeappiXeVMhTJYGuqttO34YCKM1c1gtDyPfyi7PA2Tlxr1hIxmyn1i0KIavUZQEE6b13YED3NbcNtZWK17zxpjSbt+3w5i2WUtM2bKg7M/Co7wbvFIisREBLj2lwfIbCjs83VKOPcdEhIg5KvOloLa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726729916; c=relaxed/simple;
	bh=M4tnrK7iS8UAgXMoR6gsV2kRbc+NaJUjRE6ZW3GMye4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOdJRMEtDq4oFGyFV7O9oMI+vXbNdW0GfXCWpfW6SuZlanrS6+9B5263mrIaCs4IgqswJ+6nHRKFH7F2hiznGTaqKxrh0Rzip1Hd0tRYXSSdvCfk+/UrOb5dTlCWH6LqPmK+UXnEz2bkdlPZIh1/jqThsJXDde+SgL2p11ZG9Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 13385 invoked by uid 109); 19 Sep 2024 07:05:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Sep 2024 07:05:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29142 invoked by uid 1000); 19 Sep 2024 07:05:08 -0000
Date: Thu, 19 Sep 2024 03:05:08 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>,
  Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] ci(linux32): make Javascript Actions work in x86 mode
Message-ID: <20240919070415.GA18979@localhost>
References: <pull.1790.git.1726274559928.gitgitgadget@gmail.com>
 <20240914072932.GB1284567@coredump.intra.peff.net>
 <xmqq34m2tasj.fsf@gitster.g>
 <20240915110706.GA2017642@coredump.intra.peff.net>
 <xmqqr09krijc.fsf@gitster.g>
 <d8b15f7e-7847-f6ff-cf8f-02aee254b070@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8b15f7e-7847-f6ff-cf8f-02aee254b070@gmx.de>

On Tue, Sep 17, 2024 at 02:20:41PM +0200, Johannes Schindelin wrote:

> Installing lib64stdc++ indeed does not rely on the implementation detail
> that `/__e/node20/` contains the Node version used to execute the Actions
> in those Docker containers.
> 
> Of course, the fact that installing lib64stdc++ (and no other 64-bit
> library) "fixes" the 64-bit Node version is also an implementation detail.

Yes, though "provide a 64-bit c/c++ runtime" does not seem all that
exotic. I'd be much more worried about the implicit library version
dependencies that exist, but that is true even on 64-bit systems. As
shown in the issues I linked earlier, lots of people are hitting a
similar problem with containers that have an older glibc.

The real solution there (IMHO) is a statically linked node in the runner
images, but I'm not sure of the reasons they haven't pursued that yet.

In the absence of that, the fact that your solution uses a node build
which (for reasons I'm still not sure I understand) seems to be OK with
an older glibc feels like a compelling reason. In fact, I find that much
more compelling than the risk of 32/64-bit confusion. I think part of
what I was responding to was the focus on that in your commit message.

> In particular given that mapping the "externals" by any other name than
> `/__e/` risks breaking existing GitHub workflows that might make use of
> exactly that directory name, I consider the chances for that name change
> to be negligible. It probably won't change, ever.

Fair enough. Going into this whole problem, I was not clear where /__e/
was coming from. I had thought at first it was something being carried
along by the Actions themselves (and thus action-specific and likely to
change). But it looks like it is part of the runner image and just
mounted into the container volume, so it is a magic keyword that Actions
and runner images both have to depend on.

> Of course, my favorite solution would be for `actions/runner` to be fixed
> so that it detects the situation and uses a 32-bit variant in that case
> [*1*].

Yes, me too (and preferably statically linked :) ).

> And yes, the idea of mixing 32-bit and 64-bit things in a container that
> was specifically used to only have 32-bit things still does not convince
> me, it still looks like a much better idea to either stick with a
> 32-bit-only container, or to just do away with the complexity of a
> container altogether if the environment does not need to be free of 64-bit
> anyway (but why did we bother with that in the first place, then?).

I think 32-bit builds directly inside a 64-bit runner image is a good
way to do the thing you were initially worried about: accidentally using
tools of the wrong type. Doing the whole build and test within the
32-bit container is something we'd want to keep.

The other alternative, which neither of us shown patches for, but which
I mentioned (courtesy of Ed) in the original thread is: do the Actions
outside the 32-bit container, run docker ourselves mounting the repo,
and then build and test inside the container. That's apparently how
libgit2 does it. It sidesteps the issue entirely, as the container never
runs anything external. And it would be applicable to all projects, no
matter what's in their containers (32-bit, old distros, even qemu of
alternate architectures).

I'm not sure how much work it would be to do, though.

Anyway, it sounds like Junio has merged my patches down to get things
moving again. I'm OK if you want to rebase your proposed fix on top of
that.

-Peff
