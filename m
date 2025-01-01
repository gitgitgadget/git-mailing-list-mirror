Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE79A17548
	for <git@vger.kernel.org>; Wed,  1 Jan 2025 20:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735762362; cv=none; b=KJFnxNq7bWdGdspZ4U+/2ycANxKNnsBzFWeZdMb3ztovFf5Sz0WVjxYopTCNj8I7ECRH/6mpIH1B+dx6Rk4H1LuJa51pPgthFWOKoPbOv0EuPUk31AJwOf2AP/VWJKq5ljqvNQGrLccBPpPajXyVaq+/cXbdFUPGjdLa24ycCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735762362; c=relaxed/simple;
	bh=0Is+TP1bBaWX+RdaL9l6aKSBmp6DSgEnEA1/y0C8/do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq/L6vS/oFp7SaZswLYahYzHFGQst58YfTdD4JVXUZ6qy+Rk2G5RAJJXKtTHp9i1+IWh345isrmLyKTyipac7UOCCvNmSiAV/w/2fUHBs+SGqYLW0sXBPySaspc7fIMdUzyR53bR18miKDJWzoHTV6SjQTph6PyRSRM4leP8AhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iFzzMvqA; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iFzzMvqA"
Received: (qmail 22952 invoked by uid 109); 1 Jan 2025 20:12:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0Is+TP1bBaWX+RdaL9l6aKSBmp6DSgEnEA1/y0C8/do=; b=iFzzMvqAo8coTy4q/L+G9/aBcWL0tVWlHEqNmPOYyw83Ws08ryfS+whugRvknYE4Rlnz6CLdHSAMj5k1fFWYX51YGCBF8N6eqYNHKBG+w5jVezKvzjGY2q1yuXEv/jGvt8zP6m8CmWI0l973V2Ml/xJq6Wi5pR6k10acXwSs9BFFuloRcg2bwWx6aUHibYdrf5JGv5Tbe4lKIP7R+o8VrJZlsFPADlS5GBF0oNbqH1GT5Ep6msXwlF09+uaZSyUCdf+vmzlWdNRjndFem9MVe95k008LUxz0ql4XBaIAk4gm2/uedwlgLoQPZ+SerC9TgmJTxMUJOmyYhq15WKCmfA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jan 2025 20:12:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11395 invoked by uid 111); 1 Jan 2025 20:12:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jan 2025 15:12:39 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jan 2025 15:12:39 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: [PATCH 1/6] test-lib: use individual lsan dir for --stress runs
Message-ID: <20250101201239.GA3305462@coredump.intra.peff.net>
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

When storing output in test-results/, we usually give each numbered run
in a --stress set its own output file. But we don't do that for storing
LSan logs, so something like:

  ./t0003-attributes.sh --stress

will have many scripts simultaneously creating, writing to, and deleting
the test-results/t0003-attributes.leak directory. This can cause logs
from one run to be attributed to another, spurious failures when
creation and deletion race, and so on.

This has always been broken, but nobody noticed because it's rare to do
a --stress run with LSan (since the point is for the code to run quickly
many times in order to hit races). But if you're trying to find a race
in the leak sanitizing code, it makes sense to use these together.

We can fix it by using $TEST_RESULTS_BASE, which already incorporates
the stress job suffix.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1a67adb207..96f2dfb69d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -331,7 +331,7 @@ TEST_RESULTS_BASE="$TEST_RESULTS_DIR/$TEST_NAME$TEST_STRESS_JOB_SFX"
 TEST_RESULTS_SAN_FILE_PFX=trace
 TEST_RESULTS_SAN_DIR_SFX=leak
 TEST_RESULTS_SAN_FILE=
-TEST_RESULTS_SAN_DIR="$TEST_RESULTS_DIR/$TEST_NAME.$TEST_RESULTS_SAN_DIR_SFX"
+TEST_RESULTS_SAN_DIR="$TEST_RESULTS_BASE.$TEST_RESULTS_SAN_DIR_SFX"
 TRASH_DIRECTORY="trash directory.$TEST_NAME$TEST_STRESS_JOB_SFX"
 test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
 case "$TRASH_DIRECTORY" in
-- 
2.48.0.rc1.363.g2bf91ec010

