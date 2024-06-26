Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A1A8F47
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719435470; cv=none; b=mD3YuhUsqdH4MHAD9smC5vN70jYai7sOyVSO3v6giWJmk76ybHzmShUGDQMocJPFVW1qDS9h+ezhf8vuBKf/w1AIu/9D4YlyOptUtrfFXLDXaGwryhL59w62neL1StHxV5XYIbBA35yJ8BKJ/9wYy8TAk8bNvkfKzxNmhU+u0EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719435470; c=relaxed/simple;
	bh=py/ZcYIsM2S62F8hMqJIi8l2VOb08GM12fGAJUoKrhQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcwaWV7hrIgpC1o7wDnkpsTgqhMoKl2er/cRpfVchmSIsRs8pS/gEPq0HLkIgtK+3XigliZUgjjESOGIe9T9Y7jVWWl37yuMrM0E/dDXDmPIKKSX0ZadJxdu8ui2sB0ivc8HH+qA/DsP/+59FYR4uNAQYyrdX612kaiqc/G3Ne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26195 invoked by uid 109); 26 Jun 2024 20:57:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Jun 2024 20:57:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25221 invoked by uid 111); 26 Jun 2024 20:57:46 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Jun 2024 16:57:46 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Jun 2024 16:57:45 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 3/3] t/lib-bundle-uri: use local fake bundle URLs
Message-ID: <20240626205745.GC1457138@coredump.intra.peff.net>
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

A few of the bundle URI tests point config at a fake bundle; they care
only that the client has been configured with _some_ bundle, but it
doesn't have to actually contain objects.

For the file:// tests, we use "$BUNDLE_URI_REPO_URI/fake.bdl", a
non-existent file inside the actual remote repo. But for git:// and
http:// tests, we use "https://example.com/fake.bdl". This works OK in
practice, but it means we actually make a request to example.com (which
returns a placeholder HTML response). That can be annoying when running
the test suite on a spotty network (it doesn't produce a wrong result,
since we expect it to fail, but it may introduce delays).

We can reduce our dependency on the outside world by using a local URL.
It would work to just do "file://$PWD/fake.bdl" here, since the bundle
code does not care about the actual location. But in the long run I
suspect we may have more restrictions on which protocols can be passed
around as bundle URIs. So instead, let's stick with the file:// repo's
pattern and just point to a bogus name based on the remote repo's URL.

For http this makes perfect sense; we'll make a request to the local
http server and find that there's nothing there. For git:// it's a
little weird, as you wouldn't normally access a bundle file over git://
at all. But it's probably the most reasonable guess we can make for now,
and anybody who tightens protocol selection later will know better
what's the best path forward.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-bundle-uri-protocol.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-bundle-uri-protocol.sh b/t/lib-bundle-uri-protocol.sh
index a4a1af8d02..de09b6b02e 100644
--- a/t/lib-bundle-uri-protocol.sh
+++ b/t/lib-bundle-uri-protocol.sh
@@ -18,15 +18,15 @@ git)
 	start_git_daemon --export-all --enable=receive-pack
 	BUNDLE_URI_PARENT="$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent"
 	BUNDLE_URI_REPO_URI="$GIT_DAEMON_URL/parent"
-	BUNDLE_URI_BUNDLE_URI="https://example.com/fake.bdl"
+	BUNDLE_URI_BUNDLE_URI="$BUNDLE_URI_REPO_URI/fake.bdl"
 	test_set_prereq BUNDLE_URI_GIT
 	;;
 http)
 	. "$TEST_DIRECTORY"/lib-httpd.sh
 	start_httpd
 	BUNDLE_URI_PARENT="$HTTPD_DOCUMENT_ROOT_PATH/http_parent"
 	BUNDLE_URI_REPO_URI="$HTTPD_URL/smart/http_parent"
-	BUNDLE_URI_BUNDLE_URI="https://example.com/fake.bdl"
+	BUNDLE_URI_BUNDLE_URI="$BUNDLE_URI_REPO_URL/fake.bdl"
 	test_set_prereq BUNDLE_URI_HTTP
 	;;
 *)
-- 
2.45.2.1058.g2ff574fec9
