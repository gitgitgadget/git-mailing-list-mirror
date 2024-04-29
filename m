Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7941F156CF
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378516; cv=none; b=TlQJvByhRxu90PbXNwzcmGAM5G65FAYpz6TMfvtlU4/pxnwnxDqfAQVaH9AD+er32fBU9SfEgbbLXMTp+IaGeQsFHbFrJmOEaBZf4dxaYpF3YZHLm9tRjVZNm51DGwndqMSYIeoML8bNVma9VI51Q5+Jm5ZOXsQcq3PSLKbrw5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378516; c=relaxed/simple;
	bh=aJ0tW4ddrTtvkpNGsF6bWfk/OgvQCb7zs9rXUsZ+l9M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u/GdXIfZ/K/GDypjQMSN1E+2AJruPXJHDYxMAyV0dFDJO8BDacaHIbmGlT5Sb+YifkkiqaBahYpswj+3+Iqiba3jSCrEL5DJkL3n6GibQT8sBDC1BmYLFQ3R6Ra/gGS+AB0XGgSyplAGnPaJekhoNmOg0lhJqIKd1Y1zrbQW8k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20170 invoked by uid 109); 29 Apr 2024 08:15:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Apr 2024 08:15:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26778 invoked by uid 111); 29 Apr 2024 08:15:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Apr 2024 04:15:17 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Apr 2024 04:15:12 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] tightening ref handling outside of refs/
Message-ID: <20240429081512.GA4130242@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This is picking up the discussion from:

  https://lore.kernel.org/git/20240426211529.GD13703@coredump.intra.peff.net/

The basic issue is that we don't really enforce pseudoref syntax for
names outside of "refs/", so you update random files in .git like:

  git update-ref objects/info/commit-graphs/commit-graph-chain HEAD

This is mitigated a bit by:

  1. You can't usually _overwrite_ files unless they look vaguely
     sha1-ish (in this case the chain file contains hashes of graph
     files, which is enough). So high-ticket items like "config" should
     be immune.

  2. Receive-pack is a bit more careful here, and refuses anything
     outside of "refs/". So you can't get up to any mischief via "git
     push".

But I still find it a bit scary/weird in general. And as noted in that
thread, there's some attempt to enforce this that is done
inconsistently. So you can update and read such refs, but are forbidden
to delete them.

Of course all of this becomes a non-issue with reftables, where those
names are not used in the filesystem at all. But even there I think we'd
probably want to consistently enforce the syntax rules (both between
delete/update/read, but also consistency with the files backend).

This series teaches check_refname_format() to enforce these rules (when
instructed; see patch 6 for a discussion of all sorts of complications).

These changes are not backwards-compatible! But that is kind of the
point. This is stuff that was never supposed to work. My concern would
just be that somehow somebody is relying on it. Pay attention
specifically to patches 4, 7, and 8, which are where the behavior
changes are.

  [1/8]: t0600: don't create ref outside of refs/
  [2/8]: t5619: use fully qualified refname for branch
  [3/8]: refs: move is_pseudoref_syntax() definition earlier
  [4/8]: refs: disallow dash in pseudoref syntax
  [5/8]: refs: use is_pseudoref_syntax() in refname_is_safe()
  [6/8]: check_refname_format(): add FULLY_QUALIFIED flag
  [7/8]: refs: check refnames as fully qualified when writing
  [8/8]: refs: check refnames as fully qualified when resolving

 refs.c                                     | 59 ++++++++++++----------
 refs.h                                     |  1 +
 t/t0600-reffiles-backend.sh                |  2 +-
 t/t1430-bad-ref-name.sh                    | 20 ++++++++
 t/t5619-clone-local-ambiguous-transport.sh |  4 +-
 5 files changed, 57 insertions(+), 29 deletions(-)

-Peff
