Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F01330320
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768799952; cv=none; b=tPuEBw5ZOuSWcsdZJk8/8R478QBOC+/Ro+YnuqFwUwbzCRtgF8uPG39fh6KzhPBPyUPFvWlBeU7mdBAHyKK06CfjCJtJ0CWRyYqO1oQ8V1hXmthPYQAatPFQHPju9gc/YqTJk9uLSeuK8EKNQdyvV0hk9aK/chKHqWiSHav6+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768799952; c=relaxed/simple;
	bh=ra308uwXrIO5AkfCuWG7NSuENTL2UKUjLLZQDjsQlnc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RkkHLxrDd2ZL+idVqp035ce59s1VUIbw8ez4GPNRnEXgJwU9Zfpdh+wWYKh8Ne06XGlS72NVTWRHfp7E1bSw+YLIiCrXc/gdwaxReEKDDTgUlMubKOEg9qY2HV0zvIQF+AIVzETBorTUpkhWQdFGxHS24/T6RdPQkL6dAN+7qzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Baz+rWYg; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Baz+rWYg"
Received: (qmail 94373 invoked by uid 109); 19 Jan 2026 05:18:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=ra308uwXrIO5AkfCuWG7NSuENTL2UKUjLLZQDjsQlnc=; b=Baz+rWYg4jaSCJnb0cP+RyTHVaKEl7VhzrVtHCFFv6vq8NQjM+HuovvbhmRQ9JdJTIY0Yqq8ocCZaGtN+wdyXN5xYv3nm5/IwqTtr8UpmX9b8iIx0pAE9ghNJ8EryOiqRBKFbQixa2gkWL4Wq32UsE3pktvYg4c1oyqcH+qVPtGVa8wR1oyQgizFVom2CuZygRAEC+K3uPDadojiKzZ0yfo8+MbN0fL7tSCzpXqoeXlIEhj76HwRZXK/4Fwyyg21BDfqAlQgF67BFidgITU8i72DQbXXmpvCTjq15qvh8MZEHJFEnUs2i3PLRD0YLxNZyFvTzw/8pwIPQwlSjnmjDA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Jan 2026 05:18:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 153824 invoked by uid 111); 19 Jan 2026 05:19:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Jan 2026 00:19:02 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Jan 2026 00:18:58 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH 0/4] memory leaks in remote.c
Message-ID: <20260119051858.GA1991308@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This fixes some memory leaks in remote.c. Not urgent, as they are quite
old, but they are newly triggered in the test suite by Harald's
hn/status-compare-with-push topic. So I think we'd want to build that
topic on top of these.

The first two are just preparatory cleanups. Patch 3 fixes the leak that
Harald's series triggers (and adds its own test, of course). Patch 4 is
a hypothetical leak that I don't think can be triggered in practice (so
it's more of a cleanup).

  [1/4]: remote: return non-const pointer from error_buf()
  [2/4]: remote: drop const return of tracking_for_push_dest()
  [3/4]: remote: fix leak in branch_get_push_1() with invalid "simple" config
  [4/4]: remote: always allocate branch.push_tracking_ref

 remote.c                | 24 ++++++++++++++----------
 remote.h                |  2 +-
 t/for-each-ref-tests.sh |  9 +++++++++
 3 files changed, 24 insertions(+), 11 deletions(-)

-Peff
