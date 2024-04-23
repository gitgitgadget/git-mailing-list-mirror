Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1770720B3E
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713909792; cv=none; b=JzDKdZElnVGzOYsF18xtVfz9zNKHH0cEo48wttTilt4RuCrby/jJN36kagC6kPtndOw7Iao6bIzpeR52mr93otsUWHsEN3Fn/k6J82YChsSvvoQXwxWMIxpk1BDUa9PsnvGgfHz/k7ciAph80EDC6ECReSUaXdSL80nUX6bSSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713909792; c=relaxed/simple;
	bh=cPn/4Qvh7niYsKzPeOPEEIQuB5XUnvqdctmcjtXRIg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kp4QjEdqyF69Xs2vmQx0xEf6izEbEtSfTK3++T5uiXzH/oZdv8VGg4UqjVDZddYZzncTDiwB+638atxHrLxc+tT6Z5OpIzO+WNn9ZztPgvOPWN1NnGs+CzJ9WGS8M3pFKxJ/GKgkzzKHwpDRAsvsdWFzKH6qcHRrzlOh3gtBqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7966 invoked by uid 109); 23 Apr 2024 22:03:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Apr 2024 22:03:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5122 invoked by uid 111); 23 Apr 2024 22:03:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Apr 2024 18:03:11 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 23 Apr 2024 18:03:08 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	ps@pks.im
Subject: Re: [PATCH v3 0/8] refs: add symref support to 'git-update-ref'
Message-ID: <20240423220308.GC1172807@coredump.intra.peff.net>
References: <20240412095908.1134387-1-knayak@gitlab.com>
 <20240423212818.574123-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240423212818.574123-1-knayak@gitlab.com>

On Tue, Apr 23, 2024 at 11:28:10PM +0200, Karthik Nayak wrote:

> Changes from v2:
> 1. We no longer have separate commands for symrefs, instead the regular
> commands learn to parse 'ref:<target>' as symref targets. This reduces
> the code in this series. Thanks Patrick for the suggestion.

Hmm. I can see how this makes things a lot simpler, but it introduces an
ambiguity, since you can pass full ref expressions to "update-ref" (like
"ref:foo" to find the "foo" entry in ref^{tree}). I see that you only
kick in the symref "ref:" handling if the regular oid lookup failed, so
there's no backwards-compatibility issue (anything that used to work
will still take precedence, and the new code only runs when the old code
would have reported an error).

But I wonder if it would let somebody cause mischief in a repository
they can push to, but which may get updates from other sources. For
example, imagine a forge like GitLab runs the equivalent of:

  echo "create refs/whatever ref:refs/heads/main" |
  git update-ref --stdin

as part of some system process. Now if I push up "refs/heads/ref" that
contains the path "refs/heads/main" in its tree, that will take
precedence, causing the system process to do something it did not
expect.

I think you'd have to pile on a lot of assumptions to get any kind of
security problem. Something like:

 1. The system has a hidden ref namespace like refs/gitlab that normal
    remote push/fetch users are not allowed to read/write to.

 2. The system tries to make a symlink within that namespace. Say,
    "refs/gitlab/metadata/HEAD" to point to
    "refs/gitlab/metadata/branches/main" or something.

 3. The user pushes up "refs/heads/ref" with a tree that contains
    "refs/gitlab/metadata/branches/main". Now when (2) happens, the
    hidden ref points to user-controlled data.

That's pretty convoluted. But we can avoid it entirely if there's no
ambiguity in the protocol at all.

-Peff
