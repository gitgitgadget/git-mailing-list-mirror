Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D259217557
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727213799; cv=none; b=n3LOAXLlrSvVe7fnQVrpcuiqSw19qfiDuV45cCJTs7Y5Lw+LDed8xBUhgYdT1EUFB1yTSuItYVN88Sv7M6pAT9ip6EELIk93l5Otcjie6S2EqHZxVVO/EMpk25cd3B04lL29T02EpbA6gDGjBMM2igNeFPKykwvIkOGfZynDjXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727213799; c=relaxed/simple;
	bh=YhNBcBmLYZMGmpVNrCH4G2AHZVj8CZlvURZBBBWEJNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CV7U69r/kFz2IL5rQKrR0vInJrOg9g0SEcYWipRbrbX0gttubJVE8OoAfzuQ0zh9+YkJcZ2Vqc4sQ4+GwGkZZxcWaqbQzAQ+l4TwAPP5Zp7HOwdcxSVs/oKaPf2AHO67j692a9yxmlMzmILyZm91AldOvfyjmG2WmCjI8LecrNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14864 invoked by uid 109); 24 Sep 2024 21:36:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 21:36:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17752 invoked by uid 111); 24 Sep 2024 21:36:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 17:36:36 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 17:36:36 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/3] test-lib: show leak-sanitizer logs on --immediate failure
Message-ID: <20240924213636.GB1142403@coredump.intra.peff.net>
References: <20240924213404.GA1142219@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924213404.GA1142219@coredump.intra.peff.net>

When we've compiled with SANITIZE=leak, at the end of the test script
we'll dump any collected logs to stdout. These logs have two uses:

  1. Leaks don't always cause a test snippet to fail (e.g., if they
     happen in a sub-process that we expect to return non-zero).
     Checking the logs catches these cases that we'd otherwise miss
     entirely.

  2. LSan will dump the leak info to stderr, but that is sometimes
     hidden (e.g., because it's redirected by the test, or because it's
     in a sub-process whose stderr goes elsewhere). Dumping the logs is
     the easiest way for the developer to see them.

One downside is that the set of logs for an entire script may be very
long, especially when you're trying to fix existing test scripts. You
can run with --immediate to stop at the first failing test, which means
we'll have accrued fewer logs. But we don't show the logs in that case!

Let's start doing so. This can only help case (2), of course (since it
depends on test failure). And it's somewhat weakened by the fact that
any cases of (1) will pollute the logs. But we can improve things
further in the next patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7d4471fbc5..d624ee186c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -847,6 +847,7 @@ test_failure_ () {
 			GIT_EXIT_OK=t
 			exit 0
 		fi
+		check_test_results_san_file_ "$test_failure"
 		_error_exit
 	fi
 	finalize_test_case_output failure "$failure_label" "$@"
-- 
2.46.2.1011.gf1f9323e02

