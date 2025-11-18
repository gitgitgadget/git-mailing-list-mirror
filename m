Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5EA30ACE8
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458366; cv=none; b=oE0126uMOAlytUu7t6vinQ6EUYGhJulSqVqEjPetXR5MutIh/qTQe67eqv/VnqqUp1zayP9A3PP0T+gPuYiNnqkWhIKt4rD4qeQFSs8gmOJs8Vx2+00/B1A7/qPkU6HoouvBvKbyxXucDb/Z961WC2nW77VEe2dLq2eByEw+mWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458366; c=relaxed/simple;
	bh=szUeYLGz8S3vzN6L5moggTSr1l/k08GXTkQC2szCgxs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eeg0CMq4m50crxw9+9kVNeBT5jIOJbLGgNKAgApPRh2Zy9qMciZW1IO/kIv3mOFJZsipwEy41DlJ1sOEfgTnHkWStaCmcBplhav0yu3PryAIzbD93cCtxu97SyEWxNiEsY9uFuVEvxJRCWJiNG1KfvGo5veBBnvQXctZMA//yro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eamYhYAs; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eamYhYAs"
Received: (qmail 20035 invoked by uid 109); 18 Nov 2025 09:32:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=szUeYLGz8S3vzN6L5moggTSr1l/k08GXTkQC2szCgxs=; b=eamYhYAsiax+xc0p1epUIpbqPJ9xDhkiF7948oo8dEcOw9p1/HACG+nmexKm5i7l3nnfeGOMNPD6dApa2HBeiDBO2Ek8iR3OKTiyjjmsPWQRD6+2dvlW2NLVsBk1pgYkJJUA2pR+s+sGDvTaqX5BmUZr9vmaxSGJtNgKTFvnCo/pjPtZqUuwr/zzshVz/U+zjq0LdLp+DdYnVLHlwh5CBfXk/hQ0mpIW75uzTGJVN8QAOC0SDYnBCC1weVO2Okhjqqe61/7LF/AtlVLZep/OVOni7DqiOypwFV9JU319sBqVMZFTqCRzlnrWg2YmhO+qf9sz9wuCuFQrJhkQ6YX6rw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 09:32:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27661 invoked by uid 111); 18 Nov 2025 09:32:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 04:32:48 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 04:32:43 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 1/2] unit-test: ignore --no-chain-lint
Message-ID: <20251118093243.GA530438@coredump.intra.peff.net>
References: <20251118093221.GA530337@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251118093221.GA530337@coredump.intra.peff.net>

In the same spirit as 9faf3963b6 (t: introduce compatibility options to
clar-based tests, 2024-12-13), we should ignore --no-chain-lint passed
to our clar tests, since it may appear in GIT_TEST_OPTS to be used with
other tests.

This is particularly important on Windows CI, where --no-chain-lint is
added to the test options by default, and the meson build will pass all
options to the unit tests. The only reason our meson Windows CI job does
not run into this currently is that it is not respecting GIT_TEST_OPTS
at all! So ignoring this option is a prerequisite to fixing that
situation.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/unit-tests/unit-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
index 5af645048a..752fb38fb3 100644
--- a/t/unit-tests/unit-test.c
+++ b/t/unit-tests/unit-test.c
@@ -29,6 +29,7 @@ int cmd_main(int argc, const char **argv)
 		OPT_NOOP_NOARG('d', "debug"),
 		OPT_NOOP_NOARG(0, "github-workflow-markup"),
 		OPT_NOOP_NOARG(0, "no-bin-wrappers"),
+		OPT_NOOP_ARG(0, "no-chain-lint"),
 		OPT_NOOP_ARG(0, "root"),
 		OPT_NOOP_ARG(0, "stress"),
 		OPT_NOOP_NOARG(0, "tee"),
-- 
2.52.0.278.gadc6434dc3

