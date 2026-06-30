Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D7F25A642
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 06:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782801724; cv=none; b=Fosz5RW/WE8txBKVM9G2tUmPgP50f09Jc3lR9CPs0eHEwmuHKJunjCliMboSMOp3KIiQZXccnARboUweFjc6neALuIrIS0nlix2Lbdg6/kp5jBxV944plRWAtGf5Z4+WnEgtu/D3f7+jwHln9nNAtrwQmUdgm0SuSefO3y62bCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782801724; c=relaxed/simple;
	bh=f9cWvMfugolqQ36x/44Ataaaw6qjfvBrXaok42i3KYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvN8M0pLAe51NyE7GCzLNrtlHs5+7+hSajohHpsBLU4TzlJPBS/DCiZJjY9tcJSfvvW4BGvUsK369rHfRidru9LkSwQyiCa2phQavmIBnJXVp+8xTBtb4CB2QNxHdBYwm1L4elAM4tzJCmdK5P0u1C6XfFEVVgiCVrXJ9gqU74M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Y9IQ5t3t; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Y9IQ5t3t"
Received: (qmail 69910 invoked by uid 106); 30 Jun 2026 06:42:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=f9cWvMfugolqQ36x/44Ataaaw6qjfvBrXaok42i3KYY=; b=Y9IQ5t3t20LuPhgjKFSW7My9Daz+EWNhV84ZToV/EOcNgX/KZQfz5r0hFf6CUgMO1mhnDS4EIISKo8jmf+3CLMDIJ7vl1q9JqDR9GcqUyWXPOrf+qXOHk2axeibbaVb7txF5KS6YPF69iA8BKNpzlkls5/UF4Wfg1K4LXP49kO0SRjDIfHWELQyAOaxZ9MYKapdYDTHZ6OfzO/8i4nZZJyzds1KTjxJClZPDNgv5YAy7oGD1CpLb1nR8YslHrTPiLv3FaUkxL1Ikbt9LdDyMoYh7vKaje4mMG/IYXDcOAdpsRX13oD+wAW5EC4haW8Gs3VneG6C0Z9wR9hGkwx/y2Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jun 2026 06:42:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 141385 invoked by uid 111); 30 Jun 2026 06:41:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jun 2026 02:41:59 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jun 2026 02:41:59 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/2] t: move LSan errors from stdout to stderr
Message-ID: <20260630064159.GA3733961@coredump.intra.peff.net>
References: <20260630063944.GA3733670@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630063944.GA3733670@coredump.intra.peff.net>

When we find LSan errors, we dump them via "say_color", which goes to
stdout. This is mostly harmless, since stdout and stderr tend to go to
the same place (either the user's terminal, or to the ".out" file with
--verbose-log).

But when running under a TAP harness like prove, they are split and
stdout is interpreted as TAP output. Historically even this was fine, as
the extra lines on stdout would be ignored. But since 389c83025d (t: let
prove fail when parsing invalid TAP output, 2026-06-04) we instruct the
TAP reader to complain, and a leaking test will result in complaints
like this (this is a real leak which we have yet to fix):

  $ GIT_TEST_COMMIT_GRAPH=1 make SANITIZE=leak test
  [...]
  Test Summary Report
  -------------------
  t4014-format-patch.sh (Wstat: 256 (exited 1) Tests: 226 Failed: 30)
    Failed tests:  197-226
    Non-zero exit status: 1
    Parse errors: Unknown TAP token: ""
                  Unknown TAP token: "================================================================="
                  Unknown TAP token: "==git==3693658==ERROR: LeakSanitizer: detected memory leaks"
                  Unknown TAP token: ""
                  Unknown TAP token: "Direct leak of 200 byte(s) in 1 object(s) allocated from:"
  Displayed the first 5 of 1531 TAP syntax errors.
  Re-run prove with the -p option to see them all.

You still see the failing tests, so it's mostly just an annoyance. We
can fix it by redirecting to stderr (actually descriptor 4, which is our
verbose-respecting variant). I confirmed manually that the output still
appears with --verbose-log, and even with a single-test "-i
--verbose-only=197" going to the terminal.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ceefb99bff..d390c53ec1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1217,14 +1217,14 @@ check_test_results_san_file_ () {
 	then
 		return
 	fi &&
-	say_color error "$(cat "$TEST_RESULTS_SAN_FILE".*)" &&
+	say_color >&4 error "$(cat "$TEST_RESULTS_SAN_FILE".*)" &&
 
 	if test "$test_failure" = 0
 	then
-		say "Our logs revealed a memory leak, exit non-zero!" &&
+		say >&4 "Our logs revealed a memory leak, exit non-zero!" &&
 		invert_exit_code=t
 	else
-		say "Our logs revealed a memory leak..."
+		say >&4 "Our logs revealed a memory leak..."
 	fi
 }
 
-- 
2.55.0.346.g83d0ea82e4

