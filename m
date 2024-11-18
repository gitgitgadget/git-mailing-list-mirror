Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967C717C98
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923711; cv=none; b=DRoFlUIeSGgv+++7lFrQBce64sfr0LRY8WXeJrRF1s+pvGIC591ojynDO/6K3dtIlX7awMWofv6fp3JECAo12nUBM5mSduq/Dssgk3KFdAM79vo4vdMNCOJHd5Tv6HB+5GuTHeAfQYT+lxD1ffyzJkCF6PqAU4Lq/1RpgHFvbpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923711; c=relaxed/simple;
	bh=2MSDKhNjMoZ6RNN2JH2Lt+3ZZr58JMmutz+Q1tlQrwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzWSlxcqqR4QgNkqfw89VdZRqkpxP0ZAYRQGAB2JLG7meOOSZUXFRuRSDH0eIHFkRhA15BBwSkqWUshCYwWFMDoH0Nt9UXVYVHbUmkmZYxRYYhw2+bLku6LLKSUEvsXIr3tf48S7YES/561BS35zvg8eIT4xA9Hg7+3mcKg9N54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aJ6nXZ6n; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aJ6nXZ6n"
Received: (qmail 22418 invoked by uid 109); 18 Nov 2024 09:55:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2MSDKhNjMoZ6RNN2JH2Lt+3ZZr58JMmutz+Q1tlQrwc=; b=aJ6nXZ6n5Lef3kZUdDpTnbte3Mur3TbltsukOzXgalz78w3az3K4Xi9BdTkfgk3lgX48D102ak/4pqOPmJaOI7lYL/NsSBWsbWM+DdgPuPyugvketzcYUexYF6RyGhOECjwm7wCdCv0njEwm+5koXzCBxAmtVLLNJZ9s2qUdXXDVB9gnvktuW2n2434Bzj1/9+XiqA8/n4Q8XbPHit9LU1MB9DbNpLp3n5PSmBdDPJilw8Le+l76vjt56yrXq6FfGHulWX235WPaaER1fHyeH6gl1qAURB/K9wAm+AV1mg2IsHs0FbZCsovGjHl4ReKqjBfhG1bh1AzUVlK+yWuInQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Nov 2024 09:55:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18302 invoked by uid 111); 18 Nov 2024 09:55:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Nov 2024 04:55:12 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Nov 2024 04:55:07 -0500
From: Jeff King <peff@peff.net>
To: Sam James <sam@gentoo.org>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Subject: [PATCH 2/6] object-file: drop confusing oid initializer of
 empty_tree struct
Message-ID: <20241118095507.GB3992317@coredump.intra.peff.net>
References: <20241118095423.GA3990835@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118095423.GA3990835@coredump.intra.peff.net>

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
index 8101585616..19fc4afa43 100644
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
2.47.0.547.g778689293a

