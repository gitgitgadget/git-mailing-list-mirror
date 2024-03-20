Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A97639FFF
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927150; cv=none; b=EWp5w52g7kWEjGbRkuh1OR0b02xM2ALXLu28qQDEgY7FUd4tkIAgjtTJpOMi5h+MVjCtzMYoru2hkG1Axta9uWdMbdRGNOlUuG5mL+9RduYwT73A25K3WE2+1eL4GvwZnS7BKlf5qXAGMherjFfqeM+VtFYA6I9kC2Atrb5pW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927150; c=relaxed/simple;
	bh=dr6Fl5dmmsCJ3MZTxp8dRTWUd+nzusXW5qpprEAq+YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwBR6pWIOeIX6ONvoI09vTHs6f33va8XEUabczINIkcZ3kEvFmTnkQ5qfmrAkPgpj4Dz8zLxTo4zCfehaDY+R8z6WkhnTV6F6xkb74pTmYFD1qKRTIJxcN7ctxkBlfSauRv4X9EFFwHoyUkr/AJAbESVlrq90Ap3v4Ur1yGEGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11168 invoked by uid 109); 20 Mar 2024 09:32:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Mar 2024 09:32:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16742 invoked by uid 111); 20 Mar 2024 09:32:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Mar 2024 05:32:31 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 20 Mar 2024 05:32:26 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Eric W. Biederman" <ebiederm@gmail.com>
Subject: [PATCH 0/3] some transport-helper "option object-format" confusion
Message-ID: <20240320093226.GA2445531@coredump.intra.peff.net>
References: <20240307084735.GA2072130@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307084735.GA2072130@coredump.intra.peff.net>

On Thu, Mar 07, 2024 at 03:47:35AM -0500, Jeff King wrote:

> I happened to be looking at the output of t5801 for an unrelated
> problem, and I noticed our git-remote-testgit spewing a bunch of shell
> errors. It turns out that its expectations do not quite match what the
> transport-helper code produces.
> 
> This series brings the test and documentation in line with how the
> transport-helper code behaves. But I'm not sure if we should be going
> the other way (see the comments on patch 2 especially), and bringing the
> transport-helper code in line with the others. Hence the RFC.
> 
>   [1/2]: t5801: fix object-format handling in git-remote-testgit
>   [2/2]: doc/gitremote-helpers: match object-format option docs to code

Here's a non-RFC v2 based on the discussion thus far (thanks brian and
Eric).

The big change is that instead of changing the docs to match true-less
"option object-format", the code is changed to match the docs. That
happens in patch 3 (which subsumes the original patch 1). We continue to
drop the documentation for the "option object-format sha256" form. But
now the commit message justifies it better, and we clean up the stale
code in remote-curl.c.

Patch 1 is a small fix for debugging output that I noticed after getting
confused. :-/ It's not strictly related and could be taken separately.

Eric mentioned having Git check that the helpers never say
":object-format" unless it was negotiated. I stopped short of that. One,
it's a bit tricky to test (since Git will always ask for object-format,
you have to teach remote-testgit to optionally send broken output). And
two, I'm not sure that being strict has much value here. It keeps remote
helpers honest, but the real losers are old versions that do not
understand :object-format, which would fail against such a remote. So I
dunno. It isn't any harder to do it on top later if we want to.

  [1/3]: transport-helper: use write helpers more consistently
  [2/3]: transport-helper: drop "object-format <algo>" option
  [3/3]: transport-helper: send "true" value for object-format option

 Documentation/gitremote-helpers.txt |  7 ++-----
 remote-curl.c                       |  9 ++-------
 t/t5801/git-remote-testgit          |  4 +++-
 transport-helper.c                  | 11 ++++-------
 4 files changed, 11 insertions(+), 20 deletions(-)

-Peff
