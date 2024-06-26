Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B678F47
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719435275; cv=none; b=pre7tYYaSfWpogxmLmee3IX+VNhFsSLC4PV5yLTk9Q4uc+0YEkmI+wPm4fu0Op+3sdKWiW3JHU0VJFbi54Zntks0USXGcYCGf8JhjX99SPbgaFJriuO650RdHRNWeMbltT/GdMlgkf9q8YIPB5P4lbJwMiaueSdpsPYUrwXnjL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719435275; c=relaxed/simple;
	bh=xys1S4AX7ZY9PMt9bxQoBf3J9XdaLtTgtl8H39QRIAs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ8c28J8Se1KdjbcaVwLCZnzXPxR82eISYAuRTv6J6eQAR5H+6ZEYmAVRrpfY0ntKaddLFPgT7nX+RMuvBSB6FqXOgBGeekVnb6bq/HyydlJoCcEojsV5zQPgk+Ld4M9Q1QFrUpywEAQ/GkD1iTu99hdafgDC8RMW8gHcmGF5Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26011 invoked by uid 109); 26 Jun 2024 20:54:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Jun 2024 20:54:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25182 invoked by uid 111); 26 Jun 2024 20:54:29 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Jun 2024 16:54:29 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Jun 2024 16:54:28 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 1/3] t5553: use local url for invalid fetch
Message-ID: <20240626205428.GA1457138@coredump.intra.peff.net>
References: <20240626205355.GA1009060@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240626205355.GA1009060@coredump.intra.peff.net>

We test how "fetch --set-upstream" behaves when given an invalid URL,
using the bogus URL "http://nosuchdomain.example.com". But finding out
that it is invalid requires an actual DNS lookup.

Reduce our dependency on external factors by using an invalid local
filesystem URL, which works just as well for our purposes.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5553-set-upstream.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
index 48050162c2..70e3376d31 100755
--- a/t/t5553-set-upstream.sh
+++ b/t/t5553-set-upstream.sh
@@ -73,10 +73,10 @@ test_expect_success 'fetch --set-upstream main:other does not set the branch oth
 	check_config_missing other2
 '
 
-test_expect_success 'fetch --set-upstream http://nosuchdomain.example.com fails with invalid url' '
+test_expect_success 'fetch --set-upstream ./does-not-exist fails with invalid url' '
 	# main explicitly not cleared, we check that it is not touched from previous value
 	clear_config other other2 &&
-	test_must_fail git fetch --set-upstream http://nosuchdomain.example.com &&
+	test_must_fail git fetch --set-upstream ./does-not-exist &&
 	check_config main upstream refs/heads/other &&
 	check_config_missing other &&
 	check_config_missing other2
@@ -143,10 +143,10 @@ test_expect_success 'pull --set-upstream upstream tag does not set the tag' '
 	check_config_missing three
 '
 
-test_expect_success 'pull --set-upstream http://nosuchdomain.example.com fails with invalid url' '
+test_expect_success 'pull --set-upstream ./does-not-exist fails with invalid url' '
 	# main explicitly not cleared, we check that it is not touched from previous value
 	clear_config other other2 three &&
-	test_must_fail git pull --set-upstream http://nosuchdomain.example.com &&
+	test_must_fail git pull --set-upstream ./does-not-exist &&
 	check_config main upstream refs/heads/other &&
 	check_config_missing other &&
 	check_config_missing other2 &&
-- 
2.45.2.1058.g2ff574fec9

