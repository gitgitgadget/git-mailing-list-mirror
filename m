Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE7083CD5
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727213744; cv=none; b=FCx2XTHwY5Z/VjvjN3gmbRyXuJ1hc9Yj4+/HiuePkXi5CVWwc0s8JMMyKzDMma/kYwk7FchnKK+AVtc7BQD1EnuOPWf2W/d/2rQqkLbae4wZKdfAEaXYcnfDVFv5sx4u6tUkka0yiYBJazZZRF0qxbnmU2u0xu4+MEPe303THO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727213744; c=relaxed/simple;
	bh=BPM5l7ACFOzPEhPloL6UTuc1u+AVciS7cAvjU1qMg1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqTvna0s1UbZvt26f1lIrTBNTB7qBM5qbTMaHsYk9a6TirXRW2LR4f1o6uygmLYhTYnSYUr5jJ30d8kntHZUoNUSGtR9WCiMaw9lrqEKmm/rGc1L6VAek8+30WUH2lGAjeI4Tt2N4jJBWmfowW1kQaD08ymKm4u6FjNA2FaTSgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14854 invoked by uid 109); 24 Sep 2024 21:35:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 21:35:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17743 invoked by uid 111); 24 Sep 2024 21:35:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 17:35:41 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 17:35:40 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/3] test-lib: stop showing old leak logs
Message-ID: <20240924213540.GA1142403@coredump.intra.peff.net>
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

We ask LSan to record the logs of all leaks in test-results/, which is
useful for finding leaks that didn't trigger a test failure.

We don't clean out the leak/ directory for each test before running it,
though. Instead, we count the number of files it has, and complain only
if we ended up with more when the script finishes. So we shouldn't
trigger any output if you've made a script leak free. But if you simply
_reduced_ the number of leaks, then there is an annoying outcome: we do
not record which logs were from this run and which were from previous
ones. So when we dump them to stdout, you get a mess of
possibly-outdated leaks. This is very confusing when you are in an
edit-compile-test cycle trying to fix leaks.

The instructions do note that you should "rm -rf test-results/" if you
want to avoid this. But I'm having trouble seeing how this cumulative
count could ever be useful. It is not even counting the number of leaks,
but rather the number of processes with at least one leak!

So let's just blow away the per-test leak/ directory before running. We
already overwrite the ".out" file in test-results/ in the same way, so
this is following that pattern.

Running "make test" isn't affected by this, since it blows away all of
test-results/ already. This only comes up when you are iterating on a
single script that you're running manually.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 35 ++---------------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index e718efe4c6..7d4471fbc5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -322,7 +322,6 @@ TEST_RESULTS_SAN_FILE_PFX=trace
 TEST_RESULTS_SAN_DIR_SFX=leak
 TEST_RESULTS_SAN_FILE=
 TEST_RESULTS_SAN_DIR="$TEST_RESULTS_DIR/$TEST_NAME.$TEST_RESULTS_SAN_DIR_SFX"
-TEST_RESULTS_SAN_DIR_NR_LEAKS_STARTUP=
 TRASH_DIRECTORY="trash directory.$TEST_NAME$TEST_STRESS_JOB_SFX"
 test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
 case "$TRASH_DIRECTORY" in
@@ -1215,42 +1214,15 @@ test_atexit_handler () {
 	teardown_malloc_check
 }
 
-sanitize_leak_log_message_ () {
-	local new="$1" &&
-	local old="$2" &&
-	local file="$3" &&
-
-	printf "With SANITIZE=leak at exit we have %d leak logs, but started with %d
-
-This means that we have a blindspot where git is leaking but we're
-losing the exit code somewhere, or not propagating it appropriately
-upwards!
-
-See the logs at \"%s.*\";
-those logs are reproduced below." \
-	       "$new" "$old" "$file"
-}
-
 check_test_results_san_file_ () {
 	if test -z "$TEST_RESULTS_SAN_FILE"
 	then
 		return
 	fi &&
-	local old="$TEST_RESULTS_SAN_DIR_NR_LEAKS_STARTUP" &&
-	local new="$(nr_san_dir_leaks_)" &&
-
-	if test $new -le $old
+	if test "$(nr_san_dir_leaks_)" = 0
 	then
 		return
 	fi &&
-	local out="$(sanitize_leak_log_message_ "$new" "$old" "$TEST_RESULTS_SAN_FILE")" &&
-	say_color error "$out" &&
-	if test "$old" != 0
-	then
-		echo &&
-		say_color error "The logs include output from past runs to avoid" &&
-		say_color error "that remove 'test-results' between runs."
-	fi &&
 	say_color error "$(cat "$TEST_RESULTS_SAN_FILE".*)" &&
 
 	if test -n "$passes_sanitize_leak" && test "$test_failure" = 0
@@ -1586,16 +1558,13 @@ then
 		test_done
 	fi
 
+	rm -rf "$TEST_RESULTS_SAN_DIR"
 	if ! mkdir -p "$TEST_RESULTS_SAN_DIR"
 	then
 		BAIL_OUT "cannot create $TEST_RESULTS_SAN_DIR"
 	fi &&
 	TEST_RESULTS_SAN_FILE="$TEST_RESULTS_SAN_DIR/$TEST_RESULTS_SAN_FILE_PFX"
 
-	# In case "test-results" is left over from a previous
-	# run: Only report if new leaks show up.
-	TEST_RESULTS_SAN_DIR_NR_LEAKS_STARTUP=$(nr_san_dir_leaks_)
-
 	# Don't litter *.leak dirs if there was nothing to report
 	test_atexit "rmdir \"$TEST_RESULTS_SAN_DIR\" 2>/dev/null || :"
 
-- 
2.46.2.1011.gf1f9323e02

