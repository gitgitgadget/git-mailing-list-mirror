Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33538157464
	for <git@vger.kernel.org>; Fri, 31 May 2024 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154777; cv=none; b=B2ZtgkKI4fbdfegPoa1qfP0qOKHBJe9tSE6+yeVvbH+alwCVB/mCVximKNgfsu3X02nnmTlHAw614ngR9ze6ovtIdDUIN0eR7XfFBWSqE3/prBsW4xj9bAulsqp9az5Hf/wQUJ7c6vXnEOZLM6L1W9jxyBkBfx2ySotylw/89IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154777; c=relaxed/simple;
	bh=5jY58CE3/UVSpWc6tGKNvn48rOmfKqNxOBMy/LimP+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRcJ5QR4YmuiQi+V7Q3iYdkPHu/01OPkKTFhOIj7l1yYdU3EhprQ2uAAuA+lXkxYNp/CBJwdzFE0S/g4yRyoyx+QiW644clpHOAsvqHfCvG3aqkGYP6VBgcVo5GRvu/2REIu0rc2L1i1kKZONJynluE7hvwHp4KCSEHdtl3fXck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22712 invoked by uid 109); 31 May 2024 11:26:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 May 2024 11:26:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9248 invoked by uid 111); 31 May 2024 11:26:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 May 2024 07:26:13 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 31 May 2024 07:26:13 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 02/13] sparse-checkout: pass string literals directly to
 add_pattern()
Message-ID: <20240531112613.GB428814@coredump.intra.peff.net>
References: <20240531112433.GA428583@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531112433.GA428583@coredump.intra.peff.net>

The add_pattern() function takes a pattern string, but neither makes a
copy of it nor takes ownership of the memory. So it is the caller's
responsibility to make sure the string hangs around as long as the
pattern_list which references it.

There are a few cases in sparse-checkout where we use string literal
patterns by stuffing them into a strbuf, detaching the buffer, and then
passing the result into add_pattern(). This creates a leak when the
pattern_list is eventually cleared, since we don't retain a copy of the
detached buffer to free.

But we can observe that the whole strbuf dance is unnecessary. The point
was presumably[1] to satisfy the lifetime requirement of the string. But
string literals have static duration; we can count on them lasting for
the whole program.

So we can fix the leak by just passing them directly. And as a bonus,
that simplifies the code. The leaks can be seen in t7002, which drops
from 25 leaks to 22 with this patch. It also makes t3602 and t1090
leak-free.

In the long run, we will also want to clean up this (undocumented!)
memory lifetime requirement of add_pattern(). But that can come in a
later patch; passing the string literals directly will be the right
thing either way.

[1] The code in question comes from 416adc8711 (sparse-checkout: update
    working directory in-process for 'init', 2019-11-21) and 99dfa6f970
    (sparse-checkout: use in-process update for disable subcommand,
    2019-11-21), but I didn't see anything in their commit messages or
    on the list explaining the strbufs.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/sparse-checkout.c        | 11 +++--------
 t/t1090-sparse-checkout-scope.sh |  1 +
 t/t3602-rm-sparse-checkout.sh    |  1 +
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 8747191484..7c17ed238c 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -442,7 +442,6 @@ static int sparse_checkout_init(int argc, const char **argv, const char *prefix)
 	char *sparse_filename;
 	int res;
 	struct object_id oid;
-	struct strbuf pattern = STRBUF_INIT;
 
 	static struct option builtin_sparse_checkout_init_options[] = {
 		OPT_BOOL(0, "cone", &init_opts.cone_mode,
@@ -493,10 +492,8 @@ static int sparse_checkout_init(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
-	strbuf_addstr(&pattern, "/*");
-	add_pattern(strbuf_detach(&pattern, NULL), empty_base, 0, &pl, 0);
-	strbuf_addstr(&pattern, "!/*/");
-	add_pattern(strbuf_detach(&pattern, NULL), empty_base, 0, &pl, 0);
+	add_pattern("/*", empty_base, 0, &pl, 0);
+	add_pattern("!/*/", empty_base, 0, &pl, 0);
 	pl.use_cone_patterns = init_opts.cone_mode;
 
 	return write_patterns_and_update(&pl);
@@ -893,7 +890,6 @@ static int sparse_checkout_disable(int argc, const char **argv,
 		OPT_END(),
 	};
 	struct pattern_list pl;
-	struct strbuf match_all = STRBUF_INIT;
 
 	/*
 	 * We do not exit early if !core_apply_sparse_checkout; due to the
@@ -919,8 +915,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	pl.use_cone_patterns = 0;
 	core_apply_sparse_checkout = 1;
 
-	strbuf_addstr(&match_all, "/*");
-	add_pattern(strbuf_detach(&match_all, NULL), empty_base, 0, &pl, 0);
+	add_pattern("/*", empty_base, 0, &pl, 0);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.sparse_index = 0;
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
index 3a14218b24..da0e7714d5 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -6,6 +6,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index 08580fd3dc..fcdefba48c 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -2,6 +2,7 @@
 
 test_description='git rm in sparse checked out working trees'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' "
-- 
2.45.1.727.ge984192922

