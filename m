Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A51DE8AF
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736233506; cv=none; b=JKIZQj+sZtS7761nxi4xiKO6dcDBc4K5M4/BoJ0yD1mdJZPb4Fzq7TybdRPZ8p+lZdCES7vn/mghSnNVel+gjMJebrbyA396hX7XT4WWbgPmUaiAtfaI1rhc9/inC96zSdXDRU44WAzC9c9K9EfdXxo/p9nLbrP12GbsVWLBOOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736233506; c=relaxed/simple;
	bh=lQBrc1D4iofCt3iG2WbtOMd4AgUqdSYnSCNbUi6f3Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZAhJfq61SS6RygY/WGpd87LCeppVIHsfBS6aL+OHc9LfC5GXUSxlL6/P4Nt3JWfHP0fPUTnxlf1D31ILyfn3ywsJE9Y5sKALmtpMYJjF/N4nYVk9YClO+/jTJpGjm1OPKjoomwLaj/VTrAhw4WzlSiKDFUJ9EKS0rvG/72aO+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QRWIRmW6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QRWIRmW6"
Received: (qmail 29004 invoked by uid 109); 7 Jan 2025 07:05:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lQBrc1D4iofCt3iG2WbtOMd4AgUqdSYnSCNbUi6f3Ts=; b=QRWIRmW6zNqfXT4o6jFRCmdDjQ322cUX0XzMznyPvIf5ZdPoKv27bpIROwaAJwiAiBpbC30VaLs75TAI2jWsb35FWb0Z0ymAakfbbNdbKkhlqcwOZ9eXjDn9fu2TvV9KYxp6H9QJhyQ4qAVUMhQx/dGHHLIVH8v633z0cXwtxeXIjkpYRTbU6ZjteeRKs5b03qTF7UEvTdHtxl50SLVrUKFIsl0CBmAcH33PPeK4xBZYO0VdkDrq7h0EXug4srPchfFOPJvIaf639zZd7GfeseDWfASVCdQGWMT6OHukozwnfuokN4E9S0xpbTIk/JpGX+ZqxuIXuTt/I305CmADhA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jan 2025 07:05:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21855 invoked by uid 111); 7 Jan 2025 07:05:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jan 2025 02:05:02 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jan 2025 02:05:01 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 1/3] test-lib: invert return value of
 check_test_results_san_file_empty
Message-ID: <20250107070501.GA584668@coredump.intra.peff.net>
References: <20250107070409.GA584456@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107070409.GA584456@coredump.intra.peff.net>

We have a function to check whether LSan logged any leaks. It returns
success for no leaks, and non-zero otherwise. This is the simplest thing
for its callers, who want to say "if no leaks then return early". But
because it's implemented as a shell pipeline, you end up with the
awkward:

  ! find ... |
  xargs grep leaks |
  grep -v false-positives

where the "!" is actually negating the final grep. Switch the return
value (and name) to return success when there are leaks. This should
make the code a little easier to read, and the negation in the callers
still reads pretty naturally.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib-functions.sh | 2 +-
 t/test-lib.sh           | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 78e054ab50..c25cee0ad8 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -927,7 +927,7 @@ test_expect_success () {
 		test -n "$test_skip_test_preamble" ||
 		say >&3 "expecting success of $TEST_NUMBER.$test_count '$1': $test_body"
 		if test_run_ "$test_body" &&
-		   check_test_results_san_file_empty_
+		   ! check_test_results_san_file_has_entries_
 		then
 			test_ok_ "$1"
 		else
diff --git a/t/test-lib.sh b/t/test-lib.sh
index d1f62adbf8..be3553e40e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1169,20 +1169,20 @@ test_atexit_handler () {
 	teardown_malloc_check
 }
 
-check_test_results_san_file_empty_ () {
-	test -z "$TEST_RESULTS_SAN_FILE" && return 0
+check_test_results_san_file_has_entries_ () {
+	test -z "$TEST_RESULTS_SAN_FILE" && return 1
 
 	# stderr piped to /dev/null because the directory may have
 	# been "rmdir"'d already.
-	! find "$TEST_RESULTS_SAN_DIR" \
+	find "$TEST_RESULTS_SAN_DIR" \
 		-type f \
 		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
 	xargs grep ^DEDUP_TOKEN |
 	grep -qv sanitizer::GetThreadStackTopAndBottom
 }
 
 check_test_results_san_file_ () {
-	if check_test_results_san_file_empty_
+	if ! check_test_results_san_file_has_entries_
 	then
 		return
 	fi &&
-- 
2.48.0.rc2.377.g0507c08f68

