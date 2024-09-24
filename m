Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794DE146A6B
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214878; cv=none; b=qPSQ7KT5cSLkUlq1+Pl3jlZXWNfJIxjyJVY8qB0kgKiJSdk96MoH/VyiDcngKcnI6oRSKer2LXWJX/4wUcDUowKfbUFze7EI6dE39puvhTd3+1bRuf8CD1APRS6XOsz06ds8xfFL3pCe+THV3ZRJDSUE3MVye44FiK8mazlexzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214878; c=relaxed/simple;
	bh=SlhFq/LhmRnIPGExR8cs48DuqSznyLxQRo8SIzMUICw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hylDQ/BEvmp5bRBpJ1sjfJC+WTeA5nDm3K8QNNSL38kndXUOZ/ejC3pt9EnBowqU6QopbBRBnYWkIlsQ/yBx4VXWLFm4J7jUcPd4AULpmsI4HX9s9MC0VjFY8CImxmT5GJU61ZLYoc1fEZpe6QS/8SNBQRQD+vgg5Fjf7HnW+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15444 invoked by uid 109); 24 Sep 2024 21:54:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 21:54:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18519 invoked by uid 111); 24 Sep 2024 21:54:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 17:54:35 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 17:54:34 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 07/28] commit: avoid leaking already-saved buffer
Message-ID: <20240924215434.GG1143820@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924214930.GA1143523@coredump.intra.peff.net>

When we parse a commit via repo_parse_commit_internal(), if
save_commit_buffer is set we'll stuff the buffer of the object contents
into a cache, overwriting any previous value.

This can result in a leak of that previously cached value, though it's
rare in practice. If we have a value in the cache it would have come
from a previous parse, and during that parse we'd set the object.parsed
flag, causing any subsequent parse attempts to exit without doing any
work.

But it's possible to "unparse" a commit, which we do when registering a
commit graft. And since shallow fetches are implemented using grafts,
the leak is triggered in practice by t5539.

There are a number of possible ways to address this:

  1. the unparsing function could clear the cached commit buffer, too. I
     think this would work for the case I found, but I'm not sure if
     there are other ways to end up in the same state (an unparsed
     commit with an entry in the commit buffer cache).

  2. when we parse, we could check the buffer cache and prefer it to
     reading the contents from the object database. In theory the
     contents of a particular sha1 are immutable, but the code in
     question is violating the immutability with grafts. So this
     approach makes me a bit nervous, although I think it would work in
     practice (the grafts are applied to what we parse, but we still
     retain the original contents).

  3. We could realize the cache is already populated and discard its
     contents before overwriting. It's possible some other code could be
     holding on to a pointer to the old cache entry (and we'd introduce
     a use-after-free), but I think the risk of that is relatively low.

  4. The reverse of (3): when the cache is populated, don't bother
     saving our new copy. This is perhaps a little weird, since we'll
     have just populated the commit struct based on a different buffer.
     But the two buffers should be the same, even in the presence of
     grafts (as in (2) above).

I went with option 4. It addresses the leak directly and doesn't carry
any risk of breaking other assumptions. And it's the same technique used
by parse_object_buffer() for this situation, though I'm not sure when it
would even come up there. The extra safety has been there since
bd1e17e245 (Make "parse_object()" also fill in commit message buffer
data., 2005-05-25).

This lets us mark t5539 as leak-free.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c                      | 3 ++-
 t/t5539-fetch-http-shallow.sh | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 3a54e4db0d..cc03a93036 100644
--- a/commit.c
+++ b/commit.c
@@ -595,7 +595,8 @@ int repo_parse_commit_internal(struct repository *r,
 	}
 
 	ret = parse_commit_buffer(r, item, buffer, size, 0);
-	if (save_commit_buffer && !ret) {
+	if (save_commit_buffer && !ret &&
+	    !get_cached_commit_buffer(r, item, NULL)) {
 		set_commit_buffer(r, item, buffer, size);
 		return 0;
 	}
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
index 3ea75d34ca..82fe09d0a9 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -5,6 +5,7 @@ test_description='fetch/clone from a shallow clone over http'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
-- 
2.46.2.1011.gf1f9323e02

