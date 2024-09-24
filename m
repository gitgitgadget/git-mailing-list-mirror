Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72D242A8F
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215456; cv=none; b=UtZOTTLelh3FrREoQCyN6pwbLodGbyjI3RSn3YUEvJQeBU6bFVOThQI5e/3fH9Mr2l3pdjQ1rcq7DJG3AIFLkzp2ailTNfJzrsop7NRMaByQEAFFn3xy5ec1AhRSRaLSpbywzMo4VMFrTVphofzH8P8iRvqIKyQzOF5xgcGVTcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215456; c=relaxed/simple;
	bh=yxy/ehjSlRULAz+qW4t1MyZCqRtjbz1m5luK9HJvDvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVwIWCb/I9DA5p09AsKSqVoMQzrluiWIdWP/yPhssiP/g2GX7Bdibs3BBfhdNhzjXNaLuWN5cU6w7ghFRdS2v8Qooykl9sIttNVRjPvAwlhVWfftmMBWcjfk3mDICJqK2h5qbL9NtpzrdIj4KNf4iQ8iJGFYB7Ry2AAJzcEX/uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15562 invoked by uid 109); 24 Sep 2024 22:04:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 22:04:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18741 invoked by uid 111); 24 Sep 2024 22:04:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 18:04:13 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 18:04:12 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 18/28] http-walker: free fake packed_git list
Message-ID: <20240924220412.GR1143820@coredump.intra.peff.net>
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

The dumb-http walker code creates a "fake" packed_git list representing
packs we've downloaded from the remote (I call it "fake" because
generally that struct is only used and managed by the local repository
struct). But during our cleanup phase we don't touch those at all,
causing a leak.

There's no support here from the rest of the object-database API, as
these structs are not meant to be freed, except when closing the object
store completely. But we can see that raw_object_store_clear() just
calls free() on them, and that's enough here to fix the leak.

I also added a call to close_pack() before each. In the regular code
this happens via close_object_store(), which we do as part of
raw_object_store_clear(). This is necessary to prevent leaking mmap'd
data (like the pack idx) or descriptors. The leak-checker won't catch
either of these itself, but I did confirm with some hacky warning()
calls and running t5550 that it's easy to leak at least index data.

This is all much more intimate with the packed_git struct than I'd like,
but I think fixing it would be a pretty big refactor. And it's just not
worth it for dumb-http code which is rarely used these days. If we can
silence the leak-checker without creating too much hassle, we should
just do that.

This lets us mark t5550 as leak-free.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-walker.c              | 10 ++++++++++
 t/t5550-http-fetch-dumb.sh |  1 +
 2 files changed, 11 insertions(+)

diff --git a/http-walker.c b/http-walker.c
index 9c1e5c37e6..fb2d86d5e7 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -579,8 +579,18 @@ static void cleanup(struct walker *walker)
 	if (data) {
 		alt = data->alt;
 		while (alt) {
+			struct packed_git *pack;
+
 			alt_next = alt->next;
 
+			pack = alt->packs;
+			while (pack) {
+				struct packed_git *pack_next = pack->next;
+				close_pack(pack);
+				free(pack);
+				pack = pack_next;
+			}
+
 			free(alt->base);
 			free(alt);
 
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index ea8e48f627..58189c9f7d 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -4,6 +4,7 @@ test_description='test dumb fetching over http via static file'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if test_have_prereq !REFFILES
-- 
2.46.2.1011.gf1f9323e02

