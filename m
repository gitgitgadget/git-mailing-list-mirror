Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790616F0C3
	for <git@vger.kernel.org>; Thu,  9 May 2024 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271859; cv=none; b=iastB4V6VGSXeaTwsrKpGOOM/0mSWupgYjabspGCBemMyMsMAITkNFE664giOkCEeT7+OVJ4A95oE1ek1bC+DQ8ajV+l/Oo/zQeqRog7h7XqFMrd55NVkDAD5VTvuNPWz8NVdvmpwak/RYMFovoFwHeFHeoQfK4JS69gjwGxd44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271859; c=relaxed/simple;
	bh=6gIWruZBexKKYbonNs0c+wjOUCIMBgorioEiTAxRdr0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qw7EJt2QLP8Q+Au6Oo5q8tWPD8YxoTqxAm9WI4WTZ4gV3nyeW3Qc4fNWjEnLlhOqSwuiXQjunwSHCTbFqNgVrPeaS/YLQz4z8j1Z5yFVoxVmQUZYn2FK6zqWH5w5yiBOInzsQ/+24zayILefDZ+6OBkFRvTorFnYxcyPW46h0MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6915 invoked by uid 109); 9 May 2024 16:24:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 May 2024 16:24:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31123 invoked by uid 111); 9 May 2024 16:24:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 May 2024 12:24:17 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 May 2024 12:24:15 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 2/3] ci: avoid bare "gcc" for osx-gcc job
Message-ID: <20240509162415.GB1708042@coredump.intra.peff.net>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240509162219.GA1707955@coredump.intra.peff.net>

On macOS, a bare "gcc" (without a version) will invoke a wrapper for
clang, not actual gcc. Even when gcc is installed via homebrew, that
only provides version-specific links in /usr/local/bin (like "gcc-13"),
and never a version-agnostic "gcc" wrapper.

As far as I can tell, this has been the case for a long time, and this
osx-gcc job has largely been doing nothing. We can point it at "gcc-13",
which will pick up the homebrew-installed version.

The fix here is specific to the github workflow file, as the gitlab one
does not have a matching job.

It's a little unfortunate that we cannot just ask for the latest version
of gcc which homebrew provides, but as far as I can tell there is no
easy alias (you'd have to find the highest number gcc-* in
/usr/local/bin yourself).

Signed-off-by: Jeff King <peff@peff.net>
---
We'll eventually have to bump "gcc-13" to "gcc-14" here, and so on. I
don't think we ever cared about gcc-13 in particular; it's just that
older versions of the runner image had some ancient version which we
wanted to avoid.

 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 5838986895..5f92a50271 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -284,7 +284,7 @@ jobs:
             cc: clang
             pool: macos-13
           - jobname: osx-gcc
-            cc: gcc
+            cc: gcc-13
             cc_package: gcc-13
             pool: macos-13
           - jobname: linux-gcc-default
-- 
2.45.0.414.g4009e73179

