Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521F39060B
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664579; cv=none; b=URGvxJtAWlhvmitTAS8P/7oDzBdDgaHJyMYEK8hfR5wLBm5BzpGjb4mScHiW+wIYFzCyJO58sXqWpObDuvBvtoPasPDrS6D82a+VwNJP0ErAVPq+tCx71hHl8OnM5xCNUzTHsMUdnm3uUmH+UoZRUj0Q0BNN5V6MwYTQ7umAa88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664579; c=relaxed/simple;
	bh=etpjZukVIi9lJwNAL0ZW8RBUhlz3iUETEVo+O7Uxf24=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EI+pZP8ZLizvXRH5aP09hp8dUdXnI5MZGultP1xz2/Ght9UKv6mQj0ge64t2oKYdAvtuV6H50qtP/NWl1wWrLRxN4lP/YR/rkp7fNTP2/zGeWeMNVJMLHFtZRxoZWHA2GjcG0+g8fQEWNWxmmvfEArzDSBqFyRSjSmYGYPk2qwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XN6ayF6T; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XN6ayF6T"
Received: (qmail 70130 invoked by uid 106); 29 Sep 2026 06:49:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=etpjZukVIi9lJwNAL0ZW8RBUhlz3iUETEVo+O7Uxf24=; b=XN6ayF6TyRz2Wy++jZWh7hL616lXHO+riqq9R7i8+upNrHncFBy48KFDi2942bRcPBz0M9pQThEREOOa3aCLePbtBdqt29XlgIcagTYmvC41H7vz6C6vw3pLpFwvQRXzrVOXd2JEm0pP2dS8s9RuQBBsLCPWPVmSEogq97zmVub+YGmReWWODF0BpZ/ChCwoJOffFdrzR9rrjO2DjRzo0a96DauIbaEViBnR+k20IqVR4yXs19mCHF/XL+FFg+OSNEFwu35NWh/yoxS+/sgQq1s/LTevhxqMhLmBdIYfkHCZDEA7Ng/xH6ZcelVIrbCfmXPk2hzzEuBlFz6fGWsHHw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2026 06:49:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 289464 invoked by uid 111); 29 Sep 2026 06:49:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Sep 2026 02:49:36 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Sep 2026 02:49:35 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/5] use size_t for xdiff mmfile_t
Message-ID: <20260929064935.GA1276867@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

An earlier series tried to simplify ll_ext_merge()'s code to read back
the merge result from a temporary file, but Elijah pointed out some
subtle integer overflow confusion:

  https://lore.kernel.org/git/CABPp-BG9Hkc7i_JxAbYfyzu+b4Mc_pZUr0jJF=vY0jHSARpHzw@mail.gmail.com/

I dug a little bit and found that similar problems exist elsewhere. So
here's an attempt to make things at least incrementally better. And
patch 4 is the original cleanup I set out to do. ;)

There are a few textual conflicts with the v3 of
jk/merge-ll-tempfile-cleanup that I just sent out. They should be
easy-ish to resolve, but I'm happy to just base this on that topic if
it's easier.

  [1/5]: xdiff: clean up read_mmfile() allocations on error
  [2/5]: xdiff: replace mmbuffer_t with mmfile_t
  [3/5]: xdiff: use size_t for buffer sizes
  [4/5]: merge-ll: use read_mmfile() to read external merge results
  [5/5]: xdiff: NUL-terminate buffers read by read_mmfile()

 Documentation/technical/api-merge.adoc |  7 +++---
 apply.c                                |  2 +-
 builtin/checkout.c                     |  2 +-
 builtin/merge-file.c                   |  2 +-
 builtin/merge-tree.c                   |  2 +-
 builtin/rerere.c                       |  8 +++++--
 diff.c                                 |  2 +-
 merge-blobs.c                          |  2 +-
 merge-ll.c                             | 33 +++++++++-----------------
 merge-ll.h                             |  4 ++--
 merge-ort.c                            |  4 ++--
 notes-merge.c                          |  2 +-
 rerere.c                               | 11 ++++-----
 xdiff-interface.c                      |  5 ++--
 xdiff/xdiff.h                          | 11 +++------
 xdiff/xmerge.c                         |  4 ++--
 xdiff/xutils.c                         |  4 ++--
 17 files changed, 46 insertions(+), 59 deletions(-)

-Peff
