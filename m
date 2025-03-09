Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DBD17BD6
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 03:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741489370; cv=none; b=El0JUPF8zYB82aJ4gJMx7hGxroFp60nJ/widtOH38uoZOVy7cyIbYRq7HvPIu4asFyVJD5h4U06mEBJoxoE4PxRj2Q5xJBHXbWlJGlZclchIXFSRs+SSHdXXrCMe50r+74c63NlVTu6TsXsJzEG1Aj2m4oFavg3dza4mNtMAYFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741489370; c=relaxed/simple;
	bh=xx374hruO2O3mr/5Ik5tTQn8FmcDHOIaGbe2/aRI4GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyMsyvJLaIVDw/d0LW2QfQaPtCMkZ7rUJjjJNr1ZG6vXsygBCO+gLLGXqUOJQITywpygTziaYGvss7i2uxcl6RbeVUZ+6zFOV6MSlEF/QLSYUOMy6s6eHud859jEMe+icMcdUkJl/zxcOd0lw0xc1iv214kzpg3E0HO8LQVI/CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OtLskgt3; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OtLskgt3"
Received: (qmail 4678 invoked by uid 109); 9 Mar 2025 03:02:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xx374hruO2O3mr/5Ik5tTQn8FmcDHOIaGbe2/aRI4GA=; b=OtLskgt3TIB6ul+aSIK09s/2cu80luSHfWuueP+PWhTaurLlDsHBXbWIOqwhwAq6I2HnMwEwvz8MvkptJprIFM7lD2oq49QbUTCpB1ImNCeLAy9hHyUqwlxCzSCeiNQra/CEso9EE03l9jFyfPFHpiWIMr//lj/iCKpFNGPqqIBAz8YTaet/5I10DV2oLzTTdnC7Z2PjAdVhs6RIN4AJcGrWmhWDAkC3kQHDPCQxXGPLgjJCgaMb54FXOQO5PTjMUs7Kd+99w0RzYw4E0MlrGA8acrYe9YqAjqM/0fbwtvCWxieAKgxuudy2vAEPVcv3qA8mqEjlHILMUk15IX+VfQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 09 Mar 2025 03:02:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4831 invoked by uid 111); 9 Mar 2025 03:02:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Mar 2025 22:02:47 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Mar 2025 22:02:47 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 4/9] t5516: beef up exact-oid ref prefixes test
Message-ID: <20250309030247.GD2334191@coredump.intra.peff.net>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309030101.GA2334064@coredump.intra.peff.net>

Commit 6c301adb0a (fetch: do not pass ref-prefixes for fetch by exact
SHA1, 2018-05-31) added a test that fetching an exact oid with the v2
protocol works. Originally it failed without the code change from that
commit, because fetch failed with "no matching remote head".

That changed in 0177565148 (transport: do not list refs if possible,
2018-09-27), which made fetch more forgiving of this case.

But that now meant the test passes even without its fix! So let's also
have it check the packet listing to make sure we did not ask for the
bogus prefix (ultimately this is less important than whether the command
fails, since it's just an optimization, but we should make sure not to
regress it).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5516-fetch-push.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index e4008f3ca6..2904399e97 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1312,7 +1312,10 @@ test_expect_success 'fetch exact oid in protocol v2' '
 	test_must_fail git -C child cat-file -t $the_commit &&
 
 	# fetching the hidden object succeeds by default
-	git -C child fetch -v ../testrepo $the_commit:refs/heads/copy
+	GIT_TRACE_PACKET=$PWD/trace.out \
+	git -C child fetch -v ../testrepo $the_commit:refs/heads/copy &&
+
+	test_grep ! "ref-prefix.*$the_commit" trace.out
 '
 
 for configallowtipsha1inwant in true false
-- 
2.49.0.rc1.381.gc60f5426ff

