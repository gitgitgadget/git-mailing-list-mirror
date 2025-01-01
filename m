Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DB04C70
	for <git@vger.kernel.org>; Wed,  1 Jan 2025 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735762644; cv=none; b=jn+WbOLPaxn1Bbk9zv+JEhKKS5lmnmilwxOK8PfLSVLuz9Ex8ChQJV99UQFdWEMyAgqnfMsyuuhF7L4OccDGc4RvpRfz8yQwCKkrTNlXvcm023b3bD03SK6PCOxtc8urYJNUVkDU1t2V74qdFof9HyXqwkHk30uC6H5TzUawu6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735762644; c=relaxed/simple;
	bh=Yhqv4yUc4HC6DvIsPu8HwuVZo5JKElaZwtx4t/Rmh2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=am07Qjnhlck78Yh1QugeXNdTdtNh8GhfXiUC1AR1fEBnYzOP+n1H8MoVZdDh4K8P5DGxQWnXyBZpFlo4XECFntR79lmLMZ8EQDl0KM5z8bM6QxfR6AbWphSTmtGloxqnsIbVu/5TJvIzxkMLTnVY0qRS2J4vL0zeFlWq8zK98fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TdR9sNxU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TdR9sNxU"
Received: (qmail 23078 invoked by uid 109); 1 Jan 2025 20:17:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Yhqv4yUc4HC6DvIsPu8HwuVZo5JKElaZwtx4t/Rmh2E=; b=TdR9sNxUn0VVxzNGOzUmU6pS9Wz/MOCDf4Z6sVNuQIjVF/k14mEbPG2uK53dIYBv6XcJcb28bGIKOVuuFcF3+fZn6DAd9Gc3hWJaBvtf21oNps+F8He6xvuAYqfSoeEGE69L0cMktdcAGEsbgcdZ+IRzATDpGotjseWs0WJUlKuEKETEYaRsIErnKO7rrTmXZTM/7B34vtZx6pw/D+xUs83uag5d7EAKecgGYZmnVDJ67Xb2+8q5M4kpNwFbVet5ZmVKFeV6hFpe4lmnrmkq3xghrcbva4K7sXEyecOgU7kBFZkO2PrC8HikrvJ3yRHuJUkkUoRRLN2Dt2qHUExXDQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jan 2025 20:17:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11458 invoked by uid 111); 1 Jan 2025 20:17:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jan 2025 15:17:21 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jan 2025 15:17:21 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: [PATCH 4/6] test-lib: simplify leak-log checking
Message-ID: <20250101201721.GD3305462@coredump.intra.peff.net>
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

We have a function to count the number of leaks found (actually, it is
the number of processes which produced a log file). Once upon a time we
cared about seeing if this number increased between runs. But we
simplified that away in 95c679ad86 (test-lib: stop showing old leak
logs, 2024-09-24), and now we only care if it returns any results or
not.

In preparation for refactoring it further, let's drop the counting
function entirely, and roll it into the "is it empty" check. The outcome
should be the same, but we'll be free to return a boolean "did we find
anything" without worrying about somebody adding a new call to the
counting function.

Signed-off-by: Jeff King <peff@peff.net>
---
We need the extra "!" to invert the exit code of the final grep, which
made my head spin a little at first. Maybe it would be less confusing if
this was reporting non-empty results, as "check_test_results_has_leaks"
or something? We'd have to update the callers, but there are only 2 of
them. I dunno.

 t/test-lib.sh | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index dd2ba6e6cc..23eb26bfbe 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -340,17 +340,6 @@ case "$TRASH_DIRECTORY" in
  *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
 esac
 
-# Utility functions using $TEST_RESULTS_* variables
-nr_san_dir_leaks_ () {
-	# stderr piped to /dev/null because the directory may have
-	# been "rmdir"'d already.
-	find "$TEST_RESULTS_SAN_DIR" \
-		-type f \
-		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
-	xargs grep -lv "Unable to get registers from thread" |
-	wc -l
-}
-
 # If --stress was passed, run this test repeatedly in several parallel loops.
 if test "$GIT_TEST_STRESS_STARTED" = "done"
 then
@@ -1181,8 +1170,14 @@ test_atexit_handler () {
 }
 
 check_test_results_san_file_empty_ () {
-	test -z "$TEST_RESULTS_SAN_FILE" ||
-	test "$(nr_san_dir_leaks_)" = 0
+	test -z "$TEST_RESULTS_SAN_FILE" && return 0
+
+	# stderr piped to /dev/null because the directory may have
+	# been "rmdir"'d already.
+	! find "$TEST_RESULTS_SAN_DIR" \
+		-type f \
+		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
+	xargs grep -qv "Unable to get registers from thread"
 }
 
 check_test_results_san_file_ () {
-- 
2.48.0.rc1.363.g2bf91ec010

