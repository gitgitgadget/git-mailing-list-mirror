Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB49117557
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727213919; cv=none; b=nsI3jtfD4rpr9YPaq7VdrDWKDPd3WrE0psiSCRzoby4WKpvSGaCsQDbCKkUHYSwVuOsdyW3PGciHN7h9hbCUB+BZVsXqU/PxX2D0cs1SY8gZ6H6iGgn/UvGMkzr3Hb/R8fghe9Itu1G2d0bD3vUF0jM7nXjLQlBhK1i5CjQzEyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727213919; c=relaxed/simple;
	bh=GPEdJoPlQZ7cZUOXdMME0APWIX/PrrU/4Q7pJT8MkwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMHEMdbf/Vqz8YOhZBkbJIYu1qLy5NgiHUXxdFSWOPd8StmC+gf1hdUEArcsqfTXG4XUnz3lvwyzIQsSqQic54H8PsCyIH8EH1I/oeGxi3+u3GTk+ZqEaZsYY8fhpq0Aac1rAGjnVA9Ke6hVG7VS8TSxSz+iKMv3F++lDiel+Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14991 invoked by uid 109); 24 Sep 2024 21:38:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 21:38:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17758 invoked by uid 111); 24 Sep 2024 21:38:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 17:38:36 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 17:38:36 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/3] test-lib: check for leak logs after every test
Message-ID: <20240924213836.GC1142403@coredump.intra.peff.net>
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

If you are trying to find and fix leaks in a large test script, it can
be overwhelming to see the leak logs for every test at once. The
previous commit let you use "--immediate" to see the logs after the
first failing test, but this isn't always the first leak. As discussed
there, we may see leaks from previous tests that didn't happen to fail.

To catch those, let's check for any logs that appeared after each test
snippet is run, meaning that in a SANITIZE=leak build, any leak is an
immediate failure of the test snippet.

This check is mostly free in non-leak builds (just a "test -z"), and
only a few extra processes in a leak build, so I don't think the
overhead should matter (if it does, we could probably optimize for the
common "no logs" case without even spending a process).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib-functions.sh |  3 ++-
 t/test-lib.sh           | 11 ++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index fde9bf54fc..78e054ab50 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -926,7 +926,8 @@ test_expect_success () {
 		test_body_or_stdin test_body "$2"
 		test -n "$test_skip_test_preamble" ||
 		say >&3 "expecting success of $TEST_NUMBER.$test_count '$1': $test_body"
-		if test_run_ "$test_body"
+		if test_run_ "$test_body" &&
+		   check_test_results_san_file_empty_
 		then
 			test_ok_ "$1"
 		else
diff --git a/t/test-lib.sh b/t/test-lib.sh
index d624ee186c..b1a8ee5c00 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1215,12 +1215,13 @@ test_atexit_handler () {
 	teardown_malloc_check
 }
 
+check_test_results_san_file_empty_ () {
+	test -z "$TEST_RESULTS_SAN_FILE" ||
+	test "$(nr_san_dir_leaks_)" = 0
+}
+
 check_test_results_san_file_ () {
-	if test -z "$TEST_RESULTS_SAN_FILE"
-	then
-		return
-	fi &&
-	if test "$(nr_san_dir_leaks_)" = 0
+	if check_test_results_san_file_empty_
 	then
 		return
 	fi &&
-- 
2.46.2.1011.gf1f9323e02
