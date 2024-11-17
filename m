Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8FDA92D
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731834515; cv=none; b=qFuNCm6j3qchhZ4PiGwQCLx0O9Z1ydIUNVI6McSWCP73szAD3jUuAHEyikJhtZT4AY30A9ySzQNiy/bWdGkgfp5Alc8YKOWKo1bIi7cCGWID/uzpqufg/DYdtER4Vx6XHelcbxZXWH76sAvoTBBVXCak9B9ALg/QP4qRb1k7naw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731834515; c=relaxed/simple;
	bh=VVmx5Fn7fqyFV+yT8KIh9Bw2ISjDjc+l78zNFcEhFXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oxeo5yE/9P4QgnbRUycw8dWcYD8CzUXyjd3r94AlWiAnz4YcuuCXllcXReOZ6ugexZI5r9lEHyYzOsS3zw5n6x5KtTGCDRqDfc0p4o6/ZMPIX02wYVX1Wn/KNMT4BgEyFqo18jVNAWAGk9p4707RLL5m/ODryeuO4m0du7vEksc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TV1+OaQo; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TV1+OaQo"
Received: (qmail 9271 invoked by uid 109); 17 Nov 2024 09:08:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VVmx5Fn7fqyFV+yT8KIh9Bw2ISjDjc+l78zNFcEhFXw=; b=TV1+OaQobgmJeHLm11x40Aom8RyC2PIsyuzul7ENB5nRVE/tleohVrXin3n4odrkfFNqO9neGimjqUdYM9RY6rzGlmcGvPq5aO3nsz3eYVV6wzVA7QQfyOyhqQVe2MMLDKseahUSwiL+m++iOsESrp7GTIYXEO0REAsbqhn1ELcwxUDOYJ3BvgMKWRbLnaBKYlbZ//SZJgyi/pD6FXqyKDdDr0eGa8ebq/+h5UlAmulAdBmjLIVh4TKlvoqdaLs/Y9cATmYdzOXyDlNmaIom75H6LguIsedTCk1GXUNHDJNuX6GZYPZ9JqpHZJK6d0vuIXxiqO5utTi0fh7ADPQRrg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 17 Nov 2024 09:08:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2224 invoked by uid 111); 17 Nov 2024 09:08:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 17 Nov 2024 04:08:36 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 17 Nov 2024 04:08:31 -0500
From: Jeff King <peff@peff.net>
To: Sam James <sam@gentoo.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: [PATCH 2/5] object-file: drop confusing oid initializer of
 empty_tree struct
Message-ID: <20241117090831.GB3409496@coredump.intra.peff.net>
References: <20241117090329.GA2341486@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241117090329.GA2341486@coredump.intra.peff.net>

We treat the empty tree specially, providing an in-memory "cached" copy,
which allows you to diff against it even if the object doesn't exist in
the repository. This is implemented as part of the larger cached_object
subsystem, but we use a stand-alone empty_tree struct.

We initialize the oid of that struct using EMPTY_TREE_SHA1_BIN_LITERAL.
At first glance, that seems like a bug; how could this ever work for
sha256 repositories?

The answer is that we never look at the oid field! The oid field is used
to look up entries added by pretend_object_file() to the cached_objects
array. But for our stand-alone entry, we look for it independently using
the_hash_algo->empty_tree, which will point to the correct algo struct
for the repository.

This happened in 62ba93eaa9 (sha1_file: convert cached object code to
struct object_id, 2018-05-02), which even mentions that this field is
never used. Let's reduce confusion for anybody reading this code by
replacing the sha1 initializer with a comment. The resulting field will
be all-zeroes, so any violation of our assumption that the oid field is
not used will break equally for sha1 and sha256.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/object-file.c b/object-file.c
index 25ba54594b..b7c4fdcabd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -326,9 +326,7 @@ static struct cached_object {
 static int cached_object_nr, cached_object_alloc;
 
 static struct cached_object empty_tree = {
-	.oid = {
-		.hash = EMPTY_TREE_SHA1_BIN_LITERAL,
-	},
+	/* no oid needed; we'll look it up manually based on the_hash_algo */
 	.type = OBJ_TREE,
 	.buf = "",
 };
-- 
2.47.0.541.ge258d9a1f8

