Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F276BFC1F
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801581; cv=none; b=Wf8HSPbUlACyOG6Ca6uLljo67HzTMuwuDtCIMHcqEyJjcI28wCF8nUNnrhgdSKBNczMMCwtL3Noa/K7ORjNzZb9GqZI7AEC/J4OhZOMkM/yumlCVHtRRdoO8j+M+877CZrU0j6AhYehAKBCQ62ZqYPs9fH4DmmSKotkx2LgUsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801581; c=relaxed/simple;
	bh=VuH6iPpD60J2jS1qPU66u4UDkrmKhUj4O6N/uF8PVHc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K0730oaQ7TsLG4D+V4byKocOvoQZnJ9TJ2X6FoyFchSKyiifEtvUj9RAmG/UGHOEb6FIN/TAzw3Atf2jdYEqh4rTefuOGft5dwgliDnx6WfEsq7TFjtVIaE1L+DuWgmbbF74iQWEnwKOKT9OA1RId+XuldMxlQsrlv4fuNn2ysA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9182 invoked by uid 109); 19 Jun 2024 12:52:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 Jun 2024 12:52:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21109 invoked by uid 111); 19 Jun 2024 12:52:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 Jun 2024 08:52:55 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 19 Jun 2024 08:52:55 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] t5500: fix mistaken $SERVER reference in helper function
Message-ID: <20240619125255.GA346466@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The end of t5500 contains two tests which use a single helper function,
fetch_filter_blob_limit_zero(). It takes a parameter to point to the
path of the server repository, which we store locally as $SERVER. The
first caller uses the relative path "server", while the second points
into the httpd document root.

Commit 07ef3c6604 (fetch test: use more robust test for filtered
objects, 2019-12-23) refactored some lines, but accidentally switched
"$SERVER" to "server" in one spot. That means the second caller is
looking at the server directory from the previous test rather than its
own.

This happens to work out because the "server" directory from the first
test is still hanging around, and the contents of the two are identical.
But it was clearly not the intended behavior, and is fragile to cleaning
up the leftovers from the first test.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5500-fetch-pack.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 1bc15a3f08..b26f367620 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -1046,7 +1046,7 @@ fetch_filter_blob_limit_zero () {
 
 	# Ensure that commit is fetched, but blob is not
 	commit=$(git -C "$SERVER" rev-parse two) &&
-	blob=$(git hash-object server/two.t) &&
+	blob=$(git hash-object "$SERVER/two.t") &&
 	git -C client rev-list --objects --missing=allow-any "$commit" >oids &&
 	grep "$commit" oids &&
 	! grep "$blob" oids
-- 
2.45.2.949.g1c649f6aed
