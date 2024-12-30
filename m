Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F9171C9
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 04:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735532645; cv=none; b=i+cSecMBkhJSB+vF4leKxxfqTF9B+Dqe7lRXhLqdcj/bitbJNhxbD7y3WDQq4w1S2IphaeADRzYhiPiU/32NTF4WbhLJVickdqp0fMwSycGYA34cXdiMHQOgvB7iQdpUntQyQkokE0OpyUBk3S4WXMLTR5w2qi30PQhhDY74a+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735532645; c=relaxed/simple;
	bh=GiO5OvRdz0p7pbNPcPLRUv3+HxC4hT+NN0Be+YdOR4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLhvW4LeDZVCLNwqTo3Oqu83vyL5oUir3bfGPsoKAxU338Opcd9hVvklNa3cu8ik6PcKQHxUiLBelXBrjo0yS1sasbzIer2SW6pxtTxoH7KB2W195pF0szHLsBFZAdPxtl/6l3WzEi3Klb7NQxb8hOr/FknErsUHSDwgSjhHfSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KTZa7i2G; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KTZa7i2G"
Received: (qmail 14718 invoked by uid 109); 30 Dec 2024 04:24:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GiO5OvRdz0p7pbNPcPLRUv3+HxC4hT+NN0Be+YdOR4U=; b=KTZa7i2Gc7oX3aX83x9q1k/GWuqldip8uZuae1SMv2pQOMWGmjFOxTJIqbxUEuu3wQG67YlWF9u5/A8pZ6Jcn0UcwKTSPFV0T76ILaOhle6+sKRIQ6q0Hg4ifoBdvxA5WBtSJNQaFQIO8Y8k2FxCHPDKKX35Crj1l5auN0P/uNEW46gA3T0faVNjTm88K4eiQdVEsB9QVQo1yahyf3AS6amHDDFxlW7ffSoy8pRgxV8H59RlwtwSBf35y7Do9vN7U6DHv+eQEi+UpkM0AAGscmlZvyZuKdmCI+gkLLXSmerS+CwCCMVw+ILJsQowffgvqjWE4SZ1l1KyL6csUgFPwg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Dec 2024 04:24:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14249 invoked by uid 111); 30 Dec 2024 04:24:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Dec 2024 23:24:02 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 29 Dec 2024 23:24:01 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] test-lib: use individual lsan dir for --stress runs
Message-ID: <20241230042401.GA113400@coredump.intra.peff.net>
References: <20241230042325.GA112439@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241230042325.GA112439@coredump.intra.peff.net>

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
bar

