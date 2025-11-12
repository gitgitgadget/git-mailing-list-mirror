Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E78214A60F
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934126; cv=none; b=pVgvr2pT8fCoftwB0hoYpMriEIpDyEYm6gJfjMGcAZ740p70KKlI0lsdUKiz7MjTXEU0ZtWKeS5b+5XLRcnwGqbKh0N9srlAm7V9mUGVFGjQ/JHY9zTY+7ocTzwBCFoXO1B/Nt65kAvpDoMYASFlBAIZE4+Rk4jTfjc9v0zFqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934126; c=relaxed/simple;
	bh=8+AgjjdyvK8N0karYi1VQlXWqgPsChvdmpMWUmMkmr0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jp+lpMPbTHhWuZ1EogWEajrhZ/wKJHa8bQXsZWHPw3cATZKtnAjNP6iqnaIIIwHt4zJ+mh797AGViubskLw6kJxTWaZhakpthhAvE5mmKljf3n/NJCBD0h0hHJGHub7Vqp7N87+8AH0pZTBuZs572gNqhGNg4HeymOQL1DrALQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=coDW3OUO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="coDW3OUO"
Received: (qmail 495302 invoked by uid 109); 12 Nov 2025 07:55:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=8+AgjjdyvK8N0karYi1VQlXWqgPsChvdmpMWUmMkmr0=; b=coDW3OUOJirPRdDwAAzGImLH7wXKrBPRKu8BYkNOJNybfKqFSOpzK26/7M8uTxIJ1sNcMVVNlnlDuGnjN4LGpTTg3Jty6ctFHiT+9yOGRlYN/1cNYd19a1FeKKA/bwrZ0TX1GWPgLaZlZQFiOuPUuyftGyj8BrJpSq4stMJvKtr7dZsji1NF+BZDSmu9zGSplkVbfSzY/yphEYdVJTKjVU4iGQMtaDe84/J1Z/2MrPCIoUGmPawfQmCHh7AOOWBxPqY+T1NGLEMYg3AJxSYplYhJ0Yv8731UygTH5NLDl89FSCUUZUfiQXUv8FUIuqYN7czNXNlNyKXUC/feIn6SHA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Nov 2025 07:55:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 786264 invoked by uid 111); 12 Nov 2025 07:55:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Nov 2025 02:55:23 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Nov 2025 02:55:22 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: correctmost <cmlists@sent.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/9] asan bonanza
Message-ID: <20251112075522.GA978866@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This series fixes a handful of issues that ASan finds in our test suite
if we tweak a few options to let it look deeper.

The cache-tree one was reported to the security list. It's a real bug,
but I don't think is an interesting vulnerability (it's a benign read
off the end of an mmap'd file that is local and not generally under
attacker control).

The bitmap bug is also a real bug in new code that I think is not well
exercised yet (+cc Taylor for that one).

The fsck changes are for false positives in ASan, but I think it is
reasonable for it to complain about this sketchy code. ;) I hope the
result is nicer to read and reason about, but whether it is worth the
churn may be debatable.

Along the way we can turn a few knobs that will potentially help us find
more problems down the road (but ordered so that "make SANITIZE=address"
passes at each step of the series).

  [1/9]: compat/mmap: mark unused argument in git_munmap()
  [2/9]: pack-bitmap: handle name-hash lookups in incremental bitmaps
  [3/9]: Makefile: turn on NO_MMAP when building with ASan
  [4/9]: cache-tree: avoid strtol() on non-string buffer
  [5/9]: fsck: assert newline presence in fsck_ident()
  [6/9]: fsck: avoid strcspn() in fsck_ident()
  [7/9]: fsck: remove redundant date timestamp check
  [8/9]: fsck: avoid parse_timestamp() on buffer that isn't NUL-terminated
  [9/9]: t: enable ASan's strict_string_checks option

 Makefile      |  1 +
 cache-tree.c  | 45 ++++++++++++++++++++++----------
 compat/mmap.c |  2 +-
 fsck.c        | 71 ++++++++++++++++++++++++++++++++++++---------------
 pack-bitmap.c | 27 +++++++++++++++++---
 t/test-lib.sh |  1 +
 6 files changed, 107 insertions(+), 40 deletions(-)

-Peff
