Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F4513A26F
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730927831; cv=none; b=L47rSP3gXJ9qkuqGEsHrnUcOuuepGfi+APL4POHb+KHUP/ejGOQAfDimRMIcojXwXgIosahOrPwmDwBpU8QVUeZ9KmmXKChKK6ZCu/iodzLQqyS4JoUGg67ALaPsuRMQIYvCVQraINZdKPzTh0uxxinp4tvqggLe6jP7PmvnuHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730927831; c=relaxed/simple;
	bh=hygOXaqGLOQiY0hSs+DTl3n66gq84P8lja0zaeveLl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrKSoBI7KZFUUiF0iuU1GLVJaVpqBgJrcbP6P+0UcSaJhZp9raOJrkrjIEQDJ74L5c5C+tgN5D+wMTVHUmRMOQUJwjYJfga50HOvOg2EJ8zG90kgsRog/76wwC4MKhJi8h0q5pF47RVoIn1CO5fv1JxRGn7wcbvkdVdGUoOlXlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gOGYxLmG; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gOGYxLmG"
Received: (qmail 15317 invoked by uid 109); 6 Nov 2024 21:17:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=hygOXaqGLOQiY0hSs+DTl3n66gq84P8lja0zaeveLl0=; b=gOGYxLmGM+GECyz0DewFSH/+zZF8SxNImBUpnvTrQyZuSva+Hu6boSmHLqfiaPHHGoduALzMv9uOVAZGkTPnAahACgNMry6LQmPd8Xy2VlilBJ7BgozuDECqq6eJXXo0WvlbY4+Gky3ieRQMOHWFMqkSDtYFwnMVovIwyT1aOiuBddNmZIBYDjkBZG7nVuBZePjeHYrobcEuUymlS8bUF0NkJJ9VSS9ujvRAM+FoXfCLOqim904byYbb4UKZZIFNABaQY0RgAMu0Mhkig4G/YBR6ryEKwxaND6XqwV3jv3JdnmC49hcQS3NOuWV0se/v6bkRxlLcEvk8EUylahmpmw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Nov 2024 21:17:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8145 invoked by uid 111); 6 Nov 2024 21:17:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Nov 2024 16:17:08 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Nov 2024 16:17:08 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Benno Evers <benno.martin.evers@gmail.com>,
	Rasmus Villemoes <ravi@prevas.dk>, Benno Evers <benno@bmevers.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/4] t/perf: add tests for git-describe
Message-ID: <20241106211708.GB956383@coredump.intra.peff.net>
References: <20241106192236.GC880133@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106192236.GC880133@coredump.intra.peff.net>

We don't have a perf script for git-describe, despite it often being
accused of slowness. Let's add a few simple tests to start with.

Rather than use the existing tags from our test repo, we'll make our own
so that we have a known quantity and position. We'll add a "new" tag
near the tip of HEAD, and an "old" one that is at the very bottom. And
then our tests are:

  1. Describing HEAD naively requires walking all the way down to the
     old tag as we collect candidates. This gives us a baseline for what
     "slow" looks like.

  2. Doing the same with --candidates=1 can potentially be fast, because
     we can quie after finding "new". But we don't, and it's also slow.

  3. Likewise we should be able to quit when there are no more tags to
     find. This can happen naturally if a repo has few tags, but also if
     you restrict the set of tags with --match.

Here are the results running against linux.git. Note that I have a
commit-graph built for the repo, so "slow" here is ~700ms. Without a
commit graph it's more like 9s!

  Test                                           HEAD
  --------------------------------------------------------------
  6100.2: describe HEAD                          0.70(0.66+0.04)
  6100.3: describe HEAD with one max candidate   0.70(0.66+0.04)
  6100.4: describe HEAD with one tag             0.70(0.64+0.06)

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/p6100-describe.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100755 t/perf/p6100-describe.sh

diff --git a/t/perf/p6100-describe.sh b/t/perf/p6100-describe.sh
new file mode 100755
index 0000000000..069f91ce49
--- /dev/null
+++ b/t/perf/p6100-describe.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='performance of git-describe'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+# clear out old tags and give us a known state
+test_expect_success 'set up tags' '
+	git for-each-ref --format="delete %(refname)" refs/tags >to-delete &&
+	git update-ref --stdin <to-delete &&
+	new=$(git rev-list -1000 HEAD | tail -n 1) &&
+	git tag -m new new $new &&
+	old=$(git rev-list       HEAD | tail -n 1) &&
+	git tag -m old old $old
+'
+
+test_perf 'describe HEAD' '
+	git describe HEAD
+'
+
+test_perf 'describe HEAD with one max candidate' '
+	git describe --candidates=1 HEAD
+'
+
+test_perf 'describe HEAD with one tag' '
+	git describe --match=new HEAD
+'
+
+test_done
-- 
2.47.0.441.g1a09955689

