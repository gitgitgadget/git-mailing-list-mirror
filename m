Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0214C70
	for <git@vger.kernel.org>; Wed,  1 Jan 2025 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735762887; cv=none; b=lI7ko8Ex6I9UiS2COxi8mFXZ/XuEJeXGdhzLiw77/ujBmAKr+nQ9jtjM7Ufsy9qQ3bw0JbnxJ9hca1L2o1v5bb7vTXd4qIlqxiiPMT0WDY/d3ItxaLRdUdmFKH+i0oFnE+hYcs5NM6YR5ypneY67ppP3Zuurn3YcCCma6djSPZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735762887; c=relaxed/simple;
	bh=Ir1E6tAL3wB20C4EAbfVc1I1Vx/UvHwNn7a+XIvb5/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmGBbI8Qk99dph0CA3NFnVQX/+ErNxJQsleHo7EIwWjTeeGzGTzKhnTF3qBTj+qjTdu5HWU5OhatVPr1fzz2eeptBGgfsJzoWmwK2wWIexue5XmVbrWXOR3UKdl23VJJTYEuMIqOSHwTe7URt4FESUkpz8OunIBI4Uxd2XCRBNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=N62byAAP; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="N62byAAP"
Received: (qmail 23181 invoked by uid 109); 1 Jan 2025 20:21:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Ir1E6tAL3wB20C4EAbfVc1I1Vx/UvHwNn7a+XIvb5/0=; b=N62byAAPxFNgMb+yn8pubBIYS5N+PtCp29Beejb/vTNGKySDiv6qnZYtHP6UySa+Mtrk1pTs2QkaXcCxMTVYs2XSMJCfSIgeiqE8TlRgZXti4AIM+60Ii1nDwtjMrlyDj64piEC6Vy3EBAmXgbb0+dR0ggX5xfJhElUV0KSm+6x3rzMKOQncCmzXmnbAOQHt8kYXUegcYTDLc42s753qpXZPbs9t3MMLrUyVvV27BbUrts1M2BDz12kd64hgk3mQWu3iHK49kZleI5ILLH+N25H3iJgNQSmHNRbof/EsmgwjTKyq8ISN0I2MFqw4P+h7GZcssuh5MEp1i85S0lcbtQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jan 2025 20:21:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11533 invoked by uid 111); 1 Jan 2025 20:21:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jan 2025 15:21:24 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jan 2025 15:21:24 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: [PATCH 6/6] test-lib: ignore leaks in the sanitizer's thread code
Message-ID: <20250101202124.GF3305462@coredump.intra.peff.net>
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

Our CI jobs sometimes see false positive leaks like this:

        =================================================================
        ==3904583==ERROR: LeakSanitizer: detected memory leaks

        Direct leak of 32 byte(s) in 1 object(s) allocated from:
            #0 0x7fa790d01986 in __interceptor_realloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:98
            #1 0x7fa790add769 in __pthread_getattr_np nptl/pthread_getattr_np.c:180
            #2 0x7fa790d117c5 in __sanitizer::GetThreadStackTopAndBottom(bool, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:150
            #3 0x7fa790d11957 in __sanitizer::GetThreadStackAndTls(bool, unsigned long*, unsigned long*, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:598
            #4 0x7fa790d03fe8 in __lsan::ThreadStart(unsigned int, unsigned long long, __sanitizer::ThreadType) ../../../../src/libsanitizer/lsan/lsan_posix.cpp:51
            #5 0x7fa790d013fd in __lsan_thread_start_func ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:440
            #6 0x7fa790adc3eb in start_thread nptl/pthread_create.c:444
            #7 0x7fa790b5ca5b in clone3 ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

This is not a leak in our code, but appears to be a race between one
thread calling exit() while another one is in LSan's stack setup code.
You can reproduce it easily by running t0003 or t5309 with --stress
(these trigger it because of the threading in git-grep and index-pack
respectively).

This may be a bug in LSan, but regardless of whether it is eventually
fixed, it is useful to work around it so that we stop seeing these false
positives.

We can recognize it by the mention of the sanitizer functions in the
DEDUP_TOKEN line. With this patch, the scripts mentioned above should
run with --stress indefinitely.

Signed-off-by: Jeff King <peff@peff.net>
---
One small downside here is that this just suppresses the "were there any
leaks" check. If there's a real leak _and_ the race was triggered, then
you'd see the racy false positive in the output. I don't think that's a
big deal, since both the race and real leaks should be rare-ish, and
you'd have to encounter both in the same run of a given test script.

 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c9487d0805..d1f62adbf8 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1177,7 +1177,8 @@ check_test_results_san_file_empty_ () {
 	! find "$TEST_RESULTS_SAN_DIR" \
 		-type f \
 		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
-	xargs grep -q ^DEDUP_TOKEN
+	xargs grep ^DEDUP_TOKEN |
+	grep -qv sanitizer::GetThreadStackTopAndBottom
 }
 
 check_test_results_san_file_ () {
-- 
2.48.0.rc1.363.g2bf91ec010
