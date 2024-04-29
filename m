Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E7015E8B
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378891; cv=none; b=nZ4SulmKlyCAMlwejz/C5+UZ+lTEqJYGqyZ/ij6+OVZvusKkFKwzEvJXJkcHYmEYEBvR0Pit7DJKLpbh+kL/Glg6ZBp9zsP3PzWOWhHZWvtWqX1I+MnaMbRWMj/HNX+LbmVyFQ7UnBM53FOy1e/wdOhNDCXTEEFq8qKXiOR84+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378891; c=relaxed/simple;
	bh=MOcTaq+LHiJUklOPv1EQ5cLjiU36W66L5zvEsbw+IvY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EZOStiEr7GbgmDWNQXWggNHUHsGS5HNONr5MP9RA/cpLOJ0b2qTXSfxr3xBZ4B3IEOxsLyXW09xCZyhOntDKwkFLL2Q8H0Vknix0bm8xeeoiX2pfCgNFrR4NBkhcZP99/VgfOnKnYfI2cId60vTT3XbTq7UG9NFsbqCkuQl8lrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20190 invoked by uid 109); 29 Apr 2024 08:21:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Apr 2024 08:21:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26831 invoked by uid 111); 29 Apr 2024 08:21:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Apr 2024 04:21:33 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Apr 2024 04:21:28 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 2/8] t5619: use fully qualified refname for branch
Message-ID: <20240429082128.GA233423@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

We use test_commit_bulk to update the ref "main". But without
qualification, that is really creating ".git/main", not an actual branch
in "refs/heads/".

In the end it does not really matter, because after creating "main" its
only purpose is for us to point HEAD to its same commit id. And that
works regardless of how we named it (the later call to update-ref just
calls it "main", but that is OK; we are resolving it to an oid there, so
our DWIM logic will find it in "refs/heads/").

Since it seems like going outside of "refs/" was accidental here, let's
do the more normal thing and just use a branch. That makes the test less
confusing and will future proof us against ref updates becoming more
picky.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5619-clone-local-ambiguous-transport.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5619-clone-local-ambiguous-transport.sh b/t/t5619-clone-local-ambiguous-transport.sh
index cce62bf78d..70db437496 100755
--- a/t/t5619-clone-local-ambiguous-transport.sh
+++ b/t/t5619-clone-local-ambiguous-transport.sh
@@ -21,7 +21,7 @@ test_expect_success 'setup' '
 	echo "secret" >sensitive/secret &&
 
 	git init --bare "$REPO" &&
-	test_commit_bulk -C "$REPO" --ref=main 1 &&
+	test_commit_bulk -C "$REPO" --ref=refs/heads/main 1 &&
 
 	git -C "$REPO" update-ref HEAD main &&
 	git -C "$REPO" update-server-info &&
-- 
2.45.0.rc1.416.gbe2a76c799

