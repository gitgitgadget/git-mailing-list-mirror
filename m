Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A95919C57E
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134525; cv=none; b=bpsaJExBXIlp5v86BM/gtiV4vO2esKESeoeoiPc3HXEgeCt2hmSsHDfk6O7lb610yO7MaKrl22OSXaZSU7p3llGyGtDsBBzGQHkCYp5mWk/w/fyFpi3DeaVH4yXltunDj3iPqTQH56XCAPSBvIeG23X3Iyn6qTbrj2mBsp4MKMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134525; c=relaxed/simple;
	bh=0bXaUXVbuI71wy+G/9fNYyPO9PL6CMtaTdX5o0jELRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqxVHa50miTry72iCKoz5xOHgZxFQgBIdi9sn6eGg/A+X+0CR/6yz+D9EUQLcbu+glWcVwDeaFyTjqjcbzZE4bcH48EMEcZDwgZe1Z0ROqKFUeijDiR2hD67MerHN4msMbSKRcDbOYTilPqHBQAEza4LDCPKaCRK79ISW0bO+44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17326 invoked by uid 109); 12 Sep 2024 09:48:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Sep 2024 09:48:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23179 invoked by uid 111); 12 Sep 2024 09:48:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2024 05:48:42 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Sep 2024 05:48:41 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH 4/4] ci: use regular action versions for linux32 job
Message-ID: <20240912094841.GD589828@coredump.intra.peff.net>
References: <20240912094238.GA589050@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912094238.GA589050@coredump.intra.peff.net>

The linux32 job runs inside a docker container with a 32-bit libc, etc.
This breaks any GitHub Actions scripts that are implemented in
javascript, because they ship with their own 64-bit version of Node.js
that's dynamically linked. They'll fail with a message like:

    exec /__e/node20/bin/node: no such file or directory

because they can't find the runtime linker.

This hasn't been a problem until recently because we special-case older,
non-javascript versions of these actions for the linux32 job. But it
recently became an issue when our old version of actions/upload-artifact
was deprecated, causing the job to fail. We worked around that in
90f2c7240c (ci: remove 'Upload failed tests' directories' step from
linux32 jobs, 2024-09-09), but it meant a loss of functionality for that
job. And we may eventually run into the same deprecation problem with
actions/checkout, which can't just be removed.

We can solve the linking issue by installing the 64-bit libc and stdc++
packages before doing anything else. Coupled with the switch to a more
recent image in the previous patch, that lets us remove the
special-casing of the action scripts entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
 .github/workflows/main.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index db8e8f75a4..916a64b673 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -350,17 +350,17 @@ jobs:
     runs-on: ubuntu-latest
     container: ${{matrix.vector.image}}
     steps:
-    - uses: actions/checkout@v4
-      if: matrix.vector.jobname != 'linux32'
-    - uses: actions/checkout@v1 # cannot be upgraded because Node.js Actions aren't supported in this container
+    - name: prepare libc6 for actions
       if: matrix.vector.jobname == 'linux32'
+      run: apt -q update && apt -q -y install libc6-amd64 lib64stdc++6
+    - uses: actions/checkout@v4
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-tests.sh
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
-      if: failure() && env.FAILED_TEST_ARTIFACTS != '' && matrix.vector.jobname != 'linux32'
+      if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v4
       with:
         name: failed-tests-${{matrix.vector.jobname}}
-- 
2.46.0.918.gab30941bff
