Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A841E1C3F
	for <git@vger.kernel.org>; Wed,  1 Jan 2025 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735762487; cv=none; b=O1tT3kVqAfgB8e7rLB5GYwtfxAkxkPkIo3fhd6bc+HshWwTJnmNlpBiUVtbwC1u4ItKbx/nR2WWYqCoKSZ5LutIWrhI1BptxTETRxfvinHPypCCgJLUe0us5xIftFzpQgki5aa+vBWbbDOz1mhbSAdJUAZ1XFsEPLSTxc3ePcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735762487; c=relaxed/simple;
	bh=4Cfd6fxqNEakItmMkE3Twh5HB5M/A+LcG79g5ojo4qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRKj76o5yb6RyFoFc6o7lXTiobJ+uCxWOsqI7n4L2hrgdCrR1eX0hrJ6mqUk+anHdXzM8XeXSltxa5oPVDI253EMQQ7wAa2IZ3pacud2iuXKIMEHAMVF7H+XzdhyEXfPQXhwb20aGpPOY2Vh+fs7Ybdwy5c1yFeTE+sjJzux+ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QkZ4olhM; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QkZ4olhM"
Received: (qmail 23016 invoked by uid 109); 1 Jan 2025 20:14:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4Cfd6fxqNEakItmMkE3Twh5HB5M/A+LcG79g5ojo4qg=; b=QkZ4olhMkq3nZDVJxoWOl0o3/QYipXm0++CpOOq5tV70WJgr74K8MpcOz98J+fi2BFBJq+Jwf10niPZCNM/y2Iq6gp68KKGdyD+h7QGn3TMjO0DTVqQy0QEoMzISop9FCVKxgTYiDktW5h07oYdERqNDLLJ3BkrF4TIfnmgqg7LC9SDKQOw1TiB9okImdNZb2Gc2gRD4cZB0lDlOFR3EkSYNnjiOrcQFh0BS3WpriGWDcU22kQcATuq/HAHPGoUQspTnJRfAmb/+2CtPNGYMGwldUU7y+sZ6NTqTCsZPYy7d+ZVTxnt3C9LviyZ5iclMDK1+2eTqYoEQlsLY4/YU0Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jan 2025 20:14:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11409 invoked by uid 111); 1 Jan 2025 20:14:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jan 2025 15:14:44 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jan 2025 15:14:44 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: [PATCH 3/6] test-lib: rely on logs to detect leaks
Message-ID: <20250101201444.GC3305462@coredump.intra.peff.net>
References: <20250101201226.GA3304465@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250101201226.GA3304465@coredump.intra.peff.net>

When we run with sanitizers, we set abort_on_error=1 so that the tests
themselves can detect problems directly (when the buggy program exits
with SIGABRT). This has one blind spot, though: we don't always check
the exit codes for all programs (e.g., helpers like upload-pack invoked
behind the scenes).

For ASan and UBSan this is mostly fine; they exit as soon as they see an
error, so the unexpected abort of the program causes the test to fail
anyway.

But for LSan, the program runs to completion, since we can only check
for leaks at the end. And in that case we could miss leak reports. And
thus we started checking LSan logs in faececa53f (test-lib: have the
"check" mode for SANITIZE=leak consider leak logs, 2022-07-28).
Originally the logs were optional, but logs are generated (and checked)
always as of 8c1d6691bc (test-lib: GIT_TEST_SANITIZE_LEAK_LOG enabled by
default, 2024-07-11). And we even check them for each test snippet, as
of cf1464331b (test-lib: check for leak logs after every test,
2024-09-24).

So now aborting on error is superfluous for LSan! We can get everything
we need by checking the logs. And checking the logs is actually
preferable, since it gives us more control over silencing false
positives (something we do not yet do, but will soon).

So let's tell LSan to just exit normally, even if it finds leaks. We can
do so with exitcode=0, which also suppresses the abort_on_error flag.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 96f2dfb69d..dd2ba6e6cc 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -80,6 +80,7 @@ prepend_var ASAN_OPTIONS : detect_leaks=0
 export ASAN_OPTIONS
 
 prepend_var LSAN_OPTIONS : $GIT_SAN_OPTIONS
+prepend_var LSAN_OPTIONS : exitcode=0
 prepend_var LSAN_OPTIONS : fast_unwind_on_malloc=0
 export LSAN_OPTIONS
 
-- 
2.48.0.rc1.363.g2bf91ec010

