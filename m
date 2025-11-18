Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D23168F1
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458525; cv=none; b=t0M0hX21w3py4ZzMIMQXz26HHB7sd50/dnOuQv2TDdseorO+ZXGW3wrGx+BKngmJ/L4fq5quJ/y6jpKe9UbX2MgNMj4K09rfQczuXK/TOeTPZb5p42lGJTxIlUTXvoszR0kpDNg509u7XA/3WDl/iiVpCONgiEpP8LDS38FZpS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458525; c=relaxed/simple;
	bh=aZlifDyxfZKsLTqXUbAx0RmEA4Rm0TcucgRQ144nvS0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bl+npIPwh8/7Js2pmw9Jm4NO0bNP2XaNBNqwhPQ7RAQ9dKgRctU167NhCNOeUM9o73JV12WsztIFBmeCEr3J5rhn6AYSySiqRijkErBaJ9F2SBXnMGKBzEbNXNRn8LogN9xNIPASg6EW3GD8f2c5V6ad/kQFkaHC6mDjJVEyGsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZuW/XpxK; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZuW/XpxK"
Received: (qmail 20065 invoked by uid 109); 18 Nov 2025 09:35:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=aZlifDyxfZKsLTqXUbAx0RmEA4Rm0TcucgRQ144nvS0=; b=ZuW/XpxK/3GgEIECDtZcitiEnTKLGKDXfWssF4bq0drKbOa3WqI2JUzN38dOrK0xOLIOlJdqETiN/XNcMJrH35V/FzU2ruXj57zLAzp7B7rRQMrf2nZ+1byXFfAN33q9heC/oq8TGMEngMExzYsKRSw9PT3BKKnkKJAefXbjvxUN0Gl6VmT2gj+WDChcFbMd8MTBMJmi0M15drcWNNFD7IurH8or90xE6ztmLHjIv9CoeIt0xPWlkPCQW9GgSWurfw4FL0pPwggk2lunMiiRoO88vfpVzAVD+oSEzEujmvHsE8AlayxQXnvU3IpWqAAIzz05IZolhbs+hd7mS44vqg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 09:35:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27701 invoked by uid 111); 18 Nov 2025 09:35:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 04:35:25 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 04:35:19 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 2/2] ci(windows-meson-test): handle options and output like
 other test jobs
Message-ID: <20251118093519.GB530438@coredump.intra.peff.net>
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

The GitHub windows-meson-test jobs directly run "meson test" with the
--slice option. This means they skip all of the ci/lib.sh
infrastructure, and in particular:

  1. They do not actually set any GIT_TEST_OPTS like --verbose-log or
     -x.

  2. They do not do the usual handle_failed_tests() magic to print test
     failures or tar up failed directories.

As a result, you get almost no feedback at all when a test fails in this
job, making debugging rather tricky.

Let's try to make this behave more like the other CI jobs. Because we're
on Windows, we can't just use the normal run-build-and-tests.sh script.
Our build runs as a separate job (like the non-meson Windows job), and
then we parallelize the tests across several job slices. So we need
something like the run-test-slice.sh script that the "windows-test" job
uses.

In theory we could just swap out the "make" invocation there for
"meson". But it doesn't quite work, because "make" knows how to pull
GIT_TEST_OPTS out of GIT-BUILD-OPTIONS automatically. But for meson, we
have to extract them into the --test-args option ourselves. I tried
making the logic in run-test-slice.sh conditional, but there ended up
being hardly any common code at all (and there are some tricky ordering
constraints). So I added up with a new meson-specific test-slice runner.

Signed-off-by: Jeff King <peff@peff.net>
---
BTW, one curiosity. I tried swapping out "pwsh" as the shell for "bash",
to match what the non-meson test does. And it _mostly_ works, but
curiously it causes a handful of mergetool tests to fail (it looks like
maybe "c:\foo" Windows-style paths get used where we expect "/c/foo"
paths). I didn't dig further, and just added it to my "things that
confuse and terrify me about Windows" list.

 .github/workflows/main.yml | 12 +++++++++++-
 ci/run-test-slice-meson.sh | 13 +++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100755 ci/run-test-slice-meson.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 816d5a34c4..27ebf2c8cc 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -298,7 +298,17 @@ jobs:
         path: build
     - name: Test
       shell: pwsh
-      run: meson test -C build --no-rebuild --print-errorlogs --slice "$(1+${{ matrix.nr }})/10"
+      run: ci/run-test-slice-meson.sh build ${{matrix.nr}} 10
+    - name: print test failures
+      if: failure() && env.FAILED_TEST_ARTIFACTS != ''
+      shell: bash
+      run: ci/print-test-failures.sh
+    - name: Upload failed tests' directories
+      if: failure() && env.FAILED_TEST_ARTIFACTS != ''
+      uses: actions/upload-artifact@v4
+      with:
+        name: failed-tests-windows-meson-${{ matrix.nr }}
+        path: ${{env.FAILED_TEST_ARTIFACTS}}
 
   regular:
     name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})
diff --git a/ci/run-test-slice-meson.sh b/ci/run-test-slice-meson.sh
new file mode 100755
index 0000000000..961c94fba0
--- /dev/null
+++ b/ci/run-test-slice-meson.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+
+# We must load the build options so we know where to find
+# things like TEST_OUTPUT_DIRECTORY. This has to come before
+# loading lib.sh, though, because it may clobber some CI lib
+# variables like our custom GIT_TEST_OPTS.
+. "$1"/GIT-BUILD-OPTIONS
+. ${0%/*}/lib.sh
+
+group "Run tests" \
+	meson test -C "$1" --no-rebuild --print-errorlogs \
+		--test-args="$GIT_TEST_OPTS" --slice "$((1+$2))/$3" ||
+handle_failed_tests
-- 
2.52.0.278.gadc6434dc3
