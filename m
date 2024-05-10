Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6917C98
	for <git@vger.kernel.org>; Fri, 10 May 2024 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715371277; cv=none; b=hsawAzYMwqeDsD3UlErH07CUTw2kTfjHV9qZMet6RiaJTQTqkJnLoVh9fWkYXOY8vd1tqkPePH81b8qCng7eRK6Z3O2adW1Is903xz8skJdSp4/BprNl29CSyjCN0z07dgv65jOQ8wcYxETxw5ePy1+1Bfk58tJmpIwnCw04dKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715371277; c=relaxed/simple;
	bh=/Dt+8yPytouCenSC5urmX/7ZGoCGE9RhGB2+coucZIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jt4wMdPgeQxz01vobAtSMW+n2FJTRoj7ymUymt6+FiOnXPntHyffq7ll5xd+HufpcAJj4eKWE7tCde23OGhqWkz2HAJNgQiJwWdxbEJC4n0Fsj1K7DHMiUehjSwI1wMN80YEKpq4Sbb4WVolk0R/nG3I/OLWcSXak29JhOWbXT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18943 invoked by uid 109); 10 May 2024 20:01:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 May 2024 20:01:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12291 invoked by uid 111); 10 May 2024 20:01:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 May 2024 16:01:16 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 May 2024 16:01:14 -0400
From: Jeff King <peff@peff.net>
To: Bo Anderson <mail@boanderson.me>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] osxkeychain: lock for exclusive execution
Message-ID: <20240510200114.GC1954863@coredump.intra.peff.net>
References: <pull.1729.git.1715328467099.gitgitgadget@gmail.com>
 <D7A8539F-E33C-44F3-A7BF-5F5D4A26F2A4@boanderson.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D7A8539F-E33C-44F3-A7BF-5F5D4A26F2A4@boanderson.me>

On Fri, May 10, 2024 at 04:02:03PM +0100, Bo Anderson wrote:

> A broader Git-wide question that you perhaps don’t know the answer to
> but someone else here might do is: why are we spamming updates to the
> credential helper? Every parallel fetch instance performing a store
> operation on the same host seems unexpected to me, particularly if
> there’s no actual changes.

The short answer is that Git always passes a credential which has been
used successfully to the helpers to record (if they want to). That's how
stuff gets stored in the first place. And those parallel fetches have no
knowledge of what the other ones are doing, so they all try to store.

But the more interesting question is: why do we tell helpers to store a
credential that we got from helpers in the first place? The behavior is
mostly an artifact of how the original implementation behaved, as it did
not record the source of the credential.

And I think there are several problems with that, besides inefficiency
and locking. See this old patch, which fixes it by remembering when
a credential came from a helper:

  https://lore.kernel.org/git/20120407033417.GA13914@sigill.intra.peff.net/

But we didn't merge it because some people rely on the behavior of
helpers feeding back to themselves. I outlined some solutions there, but
it would definitely be a change in behavior that people would have to
adapt to.

Some possible alternatives:

  - we could remember _which_ helper we got the credential from, and
    avoid invoking it again.

  - we could record a bit saying that the credential came from a helper,
    and then feed that back to helpers when storing. So osxkeychain
    could then decide not to store it.

Both of those solve the repeated stores, but still let credentials
populate across helpers (which I still think is a questionable thing to
do by default, per the discussion in that thread, but is the very thing
that some people rely on).

-Peff
