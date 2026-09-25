Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BEF3B05AA
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368552; cv=none; b=QUuUFCz5KjLTJdOSbocGb6Tj48DrGemnnXv2HpSx3iroYbJiwwDHXJcVs2gjZIYRWyqFCKDs++shTLgtLX3bBND5fBkH3iE7lu1p6ejzX2K1SkD/ZF4rQiJvmJXz0lFs60NPZLF+wJ5heBbdpNvM0VG3HPK5HViEaNgE7xysI70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368552; c=relaxed/simple;
	bh=sJ999ULfuJLvk3P3MDtq0PLi454NdyZA+D9g153+BFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvZp7wbjrYWsGlV/R48s1Yqdj7vaCS6CuQ3BGPbybafSHgaGWBNp9duwGxSR10pkei8YitFx6LtPhrUvrWojTiWvLkyE+MKpaVHRHvRfIP21SVJ+xqa1mPOX1Vas6oJ8qYNYc+IjEJ1NIOGStsE3Ymr2vioS9RrdfyoYe47uSx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KSDCnNTn; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KSDCnNTn"
Received: (qmail 53012 invoked by uid 106); 25 Sep 2026 20:35:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=sJ999ULfuJLvk3P3MDtq0PLi454NdyZA+D9g153+BFY=; b=KSDCnNTntsxMalhMTwo5rG/0VkVBop5Rb2KIR7/efwbXYy8VwGSPfJcU0WwQT5EVvJ1CaBjQi4nd6iNH8MXWkqTanmKQ1v6T8FnXNjFoOZqgCDDBh/xkWNVUQWhlrHUllyCvizlCgvFuMyB+HgM3EKq8VU7TL1puGul5FBA6rr2/ybF62DS1VtnwhxF/HkIUDB6zyC5DJ5v6kMfpjt2wTtn/9qV9S9SUWhxOIZDmVcaQgrWYYUGkX4tAFiHT+656IUVsH/YbS3uY9MOtOCJ96sa6DLXsH8sXwgN8HFPDFyVt8RLZhT43zVdtt9Kz63VI2gfA9xyqooU8LxQgYqp/hA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2026 20:35:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 210187 invoked by uid 111); 25 Sep 2026 20:35:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Sep 2026 16:35:48 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Sep 2026 16:35:48 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: [PATCH 1/2] revision: avoid reporting known options as unknown on
 error
Message-ID: <20260925203548.GA1544493@coredump.intra.peff.net>
References: <20260925203359.GA1506705@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925203359.GA1506705@coredump.intra.peff.net>

In parse_revision_opt(), we report "unknown option" when
handle_revision_opt() returns a negative value or zero. But these are
two different conditions: a negative value indicates a malformed option
(like a missing argument) and zero indicates an unknown option.

So malformed options produce nonsense like this:

  $ git shortlog --default
  error: bad --default argument
  error: unknown option `--default'
  usage: [...]

We should treat a negative return as a logic error which has already
been reported by handle_revision_opt(), and just show the regular usage
message.

Signed-off-by: Jeff King <peff@peff.net>
---
There's obviously a way to write this that makes the diff a little
shorter and doesn't repeat the usage_with_options() line. I think the
if/else cascade makes the mental model more clear, though.

 revision.c          | 5 ++++-
 t/t4201-shortlog.sh | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index ee1df92d1d..f958d8c301 100644
--- a/revision.c
+++ b/revision.c
@@ -2771,7 +2771,10 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 {
 	int n = handle_revision_opt(revs, ctx->argc, ctx->argv,
 				    &ctx->cpidx, ctx->out, NULL);
-	if (n <= 0) {
+	if (n < 0) {
+		/* handle_revision_opt() has already reported the error. */
+		usage_with_options(usagestr, options);
+	} else if (!n) {
 		error("unknown option `%s'", ctx->argv[0]);
 		usage_with_options(usagestr, options);
 	}
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 023fbff546..4ba7f5aec6 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -436,4 +436,10 @@ test_expect_success 'stdin with multiple groups reports error' '
 	test_must_fail git shortlog --group=author --group=committer <log
 '
 
+test_expect_success 'invalid revision options are not reported as unknown' '
+	test_must_fail git shortlog --default 2>err &&
+	test_grep "bad --default argument" err &&
+	test_grep ! "unknown option" err
+'
+
 test_done
-- 
2.56.0.rc2.289.g137cf50cac

