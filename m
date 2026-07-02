Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F1F3CC313
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978765; cv=none; b=qJXnD5eNxj6VyvJJi0Bmv54nKEDXOF0C0VwVHEcJ0bVS+lKAYO23auZmPUkVJUGkZT9QQ/pi//lHJhKe199GmTdfD3FGIF3Ql2cA8te3laZNjDBREd7kO6J6nsBQhtH1eZdm5u6S2TrAbeVBiC08k1aK+drutqhABXluvw4PNEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978765; c=relaxed/simple;
	bh=iFaPKnVO7eXAJ/Q8MVcn/FOMxu/nilYlTcZScEAcXJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=di8/VWgKcDMxAfB9VyDNt14bulyec/Y2bhEBkqECPCqAHcEykn6MNtuwj09PFlXRmzJwJq463NS+U+IruPV/PoxKmDUS9LbsvoJEQLnTeKMmpvcsXbaJKQf/gA6qY7/GAnM13zCKc3kzfQ5SoccWcekz/RpxHoStiilSqV+DFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=S+YjlStI; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="S+YjlStI"
Received: (qmail 85471 invoked by uid 106); 2 Jul 2026 07:52:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=iFaPKnVO7eXAJ/Q8MVcn/FOMxu/nilYlTcZScEAcXJQ=; b=S+YjlStIvp79BcjL7P3iDsNV1ReRGwyfb8Xem4viKx2Kw20fxq+IWITqfMY5Gvx7WqYfSK0ACQyveyh/cn66oB4Lfrb9vBh8oDK8K6GoWg1QtG5S8OdKN0GD9SewwKkGa/ymaq8YawPICCytnH3PLMBMHQCzrHde+ku5gZPeO1DjrfwbtAF9LASK/6XSrJ7olA4CXL+t8fikgLhlUGiNC1X7BBkutmdEaLSwdS8f7hHIHYZmAXZFoMsBjpamtQleieAAVN6nZDA/v0jWPCpzRmYFzukhlWyxY9P9xubdSDCsDgcElrQcSH031vMOm6U6/xkLsOPsfLv1rEEhf6fYwg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 07:52:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 178097 invoked by uid 111); 2 Jul 2026 07:52:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 03:52:34 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 03:52:34 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/9] hash algorithm leak fixes
Message-ID: <20260702075234.GA1548258@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This series fixes some leaks you can find by running:

  make SANITIZE=leak \
       OPENSSL_SHA256=1 \
       GIT_TEST_DEFAULT_HASH=sha256 \
       test

The crux of the issue is that we depend on calling git_hash_final() to
clean up any git_hash_ctx we've initialized. But we don't always call
that function (we may return early due to an error, etc).

We don't see these in our regular leak-test builds because the default
hash implementations we use treat the hash_ctx as a sequence of bytes.
So there's no cleanup needed, and just letting the context go out of
scope is fine. But other implementations do allocate on initialization,
and need to have some kind of free/discard function. So building with
OPENSSL_SHA256 above is what lets us see the leaks.

You can see the same thing with OPENSSL_SHA1, but of course we don't
recommend that. Using OPENSSL_SHA1_UNSAFE likewise, but it sees only a
subset of the leaks since it is only used in a few code paths. Those
leaks would be found if we turned on leak-checking in the
linux-TEST-vars job, but the rest of them would require leak-checking
the linux-sha256 job.

And as a special bonus, patch 8 is a semi-related leak that only affects
libgcrypt. I don't think we build against that in CI at all. :-/

  [1/9]: csum-file: drop discard_hashfile()
  [2/9]: hash: add discard primitive
  [3/9]: csum-file: always finalize or discard hash
  [4/9]: csum-file: provide a function to release checkpoints
  [5/9]: patch-id: discard hash when done
  [6/9]: check_stream_oid(): discard hash on read error
  [7/9]: http: discard hash in dumb-http http_object_request
  [8/9]: hash: fix memory leak copying sha256 gcrypt handles
  [9/9]: hash: add platform-specific discard functions

 builtin/fast-import.c |  1 +
 builtin/patch-id.c    |  1 +
 csum-file.c           | 30 +++++++++++++++++-------------
 csum-file.h           |  2 +-
 diff.c                |  1 +
 hash.c                | 29 +++++++++++++++++++++++++++++
 hash.h                | 22 ++++++++++++++++++++++
 http.c                |  4 ++++
 http.h                |  1 +
 object-file.c         |  4 ++++
 sha1/openssl.h        |  6 ++++++
 sha256/gcrypt.h       |  7 +++++++
 sha256/openssl.h      |  6 ++++++
 13 files changed, 100 insertions(+), 14 deletions(-)

-Peff
