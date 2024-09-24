Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B64F80043
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214749; cv=none; b=CpdG7FMiBX6bIMLYYUVsYpWYrqeXMTNCnWAyiBdlVlUPeT6G2Z/+3ekQZrw1LiqXLUfiHN4+vvPrtiJTVvLeiv1K6KMVJG5/f6BHElf8VUsuqAArfquSLOIHitD95C+PU+DcIBDWcMu2zLnYLRxxcDrjjj1Qkw0rHem+njLkSbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214749; c=relaxed/simple;
	bh=Hnt86+wKgbnuSffOjHBa/SMXsgpIv8BKWgcJwfBtbek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNI7a5n67PHpgP212huh4SmVTGYW55fS4uvmr5m4fiP69/zBM7BR3v9jtKhOJ4lIXi3v15nToEYMAZJj7FHQy3ofTLmR0/OEGDp9exRW7IMmTviSlrRboHaj+HBrJRIcvOIfhuyHlpKjklBiIFttx6IVIcx4dhbHfdUKiqOzfvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15431 invoked by uid 109); 24 Sep 2024 21:52:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 21:52:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18511 invoked by uid 111); 24 Sep 2024 21:52:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 17:52:26 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 17:52:25 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 06/28] fetch-pack, send-pack: clean up shallow oid array
Message-ID: <20240924215225.GF1143820@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924214930.GA1143523@coredump.intra.peff.net>

When we call get_remote_heads() for protocol v0, that may populate the
"shallow" oid_array, which must be cleaned up to avoid a leak at the
program exit. The same problem exists for both fetch-pack and send-pack,
but not for the usual transport.c code paths, since we already do this
cleanup in disconnect_git().

Fixing this lets us mark t5542 as leak-free for the send-pack side, but
fetch-pack will need some more fixes before we can do the same for
t5539.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch-pack.c         | 1 +
 builtin/send-pack.c          | 1 +
 t/t5542-push-http-shallow.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index cfc6951d23..ef4143eef3 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -294,5 +294,6 @@ int cmd_fetch_pack(int argc,
 	free_refs(fetched_refs);
 	free_refs(remote_refs);
 	list_objects_filter_release(&args.filter_options);
+	oid_array_clear(&shallow);
 	return ret;
 }
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 81fc96d423..c49fe6c53c 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -343,5 +343,6 @@ int cmd_send_pack(int argc,
 	free_refs(remote_refs);
 	free_refs(local_refs);
 	refspec_clear(&rs);
+	oid_array_clear(&shallow);
 	return ret;
 }
diff --git a/t/t5542-push-http-shallow.sh b/t/t5542-push-http-shallow.sh
index c2cc83182f..07624a1d7f 100755
--- a/t/t5542-push-http-shallow.sh
+++ b/t/t5542-push-http-shallow.sh
@@ -5,6 +5,7 @@ test_description='push from/to a shallow clone over http'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
-- 
2.46.2.1011.gf1f9323e02

