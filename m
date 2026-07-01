Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C728328DB54
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 06:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887742; cv=none; b=rCqFEgjnDdhbOTUTBuN9p6i4vRXYAlksYF/drVRDqWtPltK7ySAvO8iRV5XzT+jk7HMoovVy8PSAj2CNGy+eVPWLb0steaN7q/n7OydtLj3INQxGvvo5W2pqlZiKWM2PLQZPhJLPRhH+Jksjn09id+F7HHUZ3MIeLbNXlhNWvps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887742; c=relaxed/simple;
	bh=RkxShwTGLfJFaT6goEsmlUWvmr3G7CzTZwWy8xHitvU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nrAejtDwYYgvFVeKDjNgt4qbnSocK0pTKwPimGxhIgkIgZSBW+Ryu3ZfK+dvOJDhhAq7VlYUHy3i4bgMcCJeQh4vesed3DBx/h4nF/eRVVgzvuHPoA0aSabtZ/e3Uf6UzM+y+o3Z7j1wmOzf7hq+CxcdnSBY8Fp/88L51A7yFVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XD1f6Av+; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XD1f6Av+"
Received: (qmail 76964 invoked by uid 106); 1 Jul 2026 06:35:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=RkxShwTGLfJFaT6goEsmlUWvmr3G7CzTZwWy8xHitvU=; b=XD1f6Av+bNCWy4wCxamN3IklozuQMifI1JoQOniGb9j+OxMOeitA8kstPz0ewv6YE1JfMNNBhfwpbfPENEcKRP/HRaBaLqW/rtkQpH3peWR7vd//aaKpqzcPy7rnVQy5M0nsHO1f68sVrSubdlIgofNJEU4JZG8hRns9Xs5gOaD8jJ8L5MDELVQ6wD/7xbYw6PsWHUWwMd47eapx/7KbVoaujw2UKw5VlLrfS42Ci6DK6wDzEi5XgwhF8F1mT22vREtz0GPnDk0AyjWQ4TkCxLjYSIsPwRr63dEjHjEdIDyrtQqLrS9QMaEbKoiqRnBKZOHGr1nt9My3sCZui5gOCQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jul 2026 06:35:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 157742 invoked by uid 111); 1 Jul 2026 06:35:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jul 2026 02:35:38 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jul 2026 02:35:38 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] bloom-related leak fixes
Message-ID: <20260701063538.GA2579765@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Here are a few small leak fixes that only show up when you run the test
suite with GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1.

Combined with the commit-graph leak-fix here:

  https://lore.kernel.org/git/20260630064301.GB3733961@coredump.intra.peff.net/

and Kaartic's pending fix from this thread:

  https://lore.kernel.org/git/20260614141600.620272-1-kaartic.sivaraam@gmail.com/

This will fix most of the leaks we'd see if we ran linux-TEST-vars jobs
with leak-checking. There are a few more related to building with
openssl for sha1, but I'll tackle those separately.

  [1/3]: bloom: make bloom-filter slab initialization idempotent
  [2/3]: revision: avoid leaking bloom keyvecs with multiple traversals
  [3/3]: line-log: drop extra copy of range with bloom filters

 bloom.c    | 5 +++++
 line-log.c | 3 +--
 revision.c | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

-Peff
