Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8226318CBF0
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923282; cv=none; b=BboqKHVBzdXDcEHRMLTU8raKTMhVofnfDUK73J9npvFPUdVrKF2Af16ExFDzMEonDnAxgX7veQ4rU9A3Dv3XIQuIGHAeJF2WHbxZlO7aGQbxHTYbn8NivIH7ZuLGb03yWtax2DM6JfVXgjHanR4sae7Z9SGe5gHXX91na7nnx5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923282; c=relaxed/simple;
	bh=WI0HdZN+G9it+k0m9P5BH2uX7TE5vLXlWAcni/SsNXs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IIesRh7oftS2veGaw5BYeGMOaMB8TnROsISUVpGx2di0binfwOOXghIU1muEpsDtZXXyktxvB61omiy4PEhRMONuNKDZddNxdvNF3k326yEYCf931JFHcGe8eoQbfbrIQzm3fiZMJJdELJN7ObqdznVtmobsVNsoaOUHYx/aF04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32178 invoked by uid 109); 9 Sep 2024 23:07:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Sep 2024 23:07:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24849 invoked by uid 111); 9 Sep 2024 23:07:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2024 19:07:59 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Sep 2024 19:07:58 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Brooke Kuhlmann <brooke@alchemists.io>
Subject: [PATCH 0/9] ref-filter %(trailer) fixes
Message-ID: <20240909230758.GA921697@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This series fixes two bugs noticed by Brooke:

  - parsing trailers from signed tags doesn't work, because the
    signature confuses the trailers code

  - multiple %(trailers) placeholders share some storage, so their
    options may conflict

The fixes for those are in patches 3 and 5, respectively. The other
patches up to there are related cleanups and preparation.

When fixing the second one, I noticed an obvious memory leak, fixed in
patch 6. And then that made me wonder if that made t6300 leak-free. It
didn't, but patches 7-9 get it there.

So 6-9 could be taken as a separate series, but they do textually depend
on what came before.

  [1/9]: t6300: drop newline from wrapped test title
  [2/9]: ref-filter: avoid extra copies of payload/signature
  [3/9]: ref-filter: strip signature when parsing tag trailers
  [4/9]: ref-filter: drop useless cast in trailers_atom_parser()
  [5/9]: ref-filter: store ref_trailer_buf data per-atom
  [6/9]: ref-filter: fix leak of %(trailers) "argbuf"
  [7/9]: ref-filter: fix leak with %(describe) arguments
  [8/9]: ref-filter: fix leak when formatting %(push:remoteref)
  [9/9]: ref-filter: add ref_format_clear() function

 builtin/branch.c        |  1 +
 builtin/for-each-ref.c  |  1 +
 builtin/tag.c           |  1 +
 builtin/verify-tag.c    |  1 +
 ref-filter.c            | 90 ++++++++++++++++++++++++++++++-----------
 ref-filter.h            |  3 ++
 remote.c                |  8 ++--
 remote.h                |  2 +-
 t/t6300-for-each-ref.sh | 41 ++++++++++++++++++-
 9 files changed, 118 insertions(+), 30 deletions(-)

-Peff
