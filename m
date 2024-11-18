Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C63F17C98
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923715; cv=none; b=fSmtsXwIbrmXIsnfRTbsqBnwSanOV+TXLI1zPT0YLDtPdOSQuH9GB4PcrSxWcOK0l1L+T+orSYHEZBHZUN6G0pwwvcLps8rZLswd3gMZ4qsxt9K6c/Z4+lhxNqb4O2BZJUXxP+5Leke13jLtey8aet7xwJIHYPL3UR96TltL/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923715; c=relaxed/simple;
	bh=Ybgwm0QJkP0HpHgMXBMyz2gzAUa4sHIMs42zVCqw7cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJLmLakpN4GddF2eihf2mfNuAbYdt+8gs2Nd0ZAHrAM9/1vAiju0HE3kiCCIoBJhYcqGcNqT/+QeeDSTCh9MWMgn9J76mXz3viXBUsmWOZic5iB+yJbNF5GwOtAocT9CGCXSuzNTAdNJv0p3D4/N2pdohd0KKeD6I/H27fg0UfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Jg98kf+f; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Jg98kf+f"
Received: (qmail 22436 invoked by uid 109); 18 Nov 2024 09:55:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Ybgwm0QJkP0HpHgMXBMyz2gzAUa4sHIMs42zVCqw7cM=; b=Jg98kf+fNLKQwHrH4jL/Jkb7hBCW+s+bE25yelgtMytFxxCQjJy5HN7bDknpGyHxJPd+3+k30m4Ju2oq2KOYR2YfZXe7NRwnYtWySjFwBKp5CbYQHN3TwEUJC4Gi4RccIAgR1HSUae/gCe0ynLPbcrXb0i1HoxC9awlAacyESsVLDEx2Iherwu0mZX9Q+ELmmWJcmt9U7RP9ki3EhcMMglda26fZV16zt65UCWVv86jSqOSrhwe8hi3nGEM03gjlygbm5i1PO3/zVYhzhzCYJSCQjT1swO5cDhzupJAVpUBiE3jcOVWCsvhotlRxOZLayxpPPRm3CIU8ZlISpAesSQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Nov 2024 09:55:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18310 invoked by uid 111); 18 Nov 2024 09:55:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Nov 2024 04:55:16 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Nov 2024 04:55:11 -0500
From: Jeff King <peff@peff.net>
To: Sam James <sam@gentoo.org>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Subject: [PATCH 3/6] object-file: move empty_tree struct into
 find_cached_object()
Message-ID: <20241118095511.GC3992317@coredump.intra.peff.net>
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

The fake empty_tree struct is a static global, but the only code that
looks at it is find_cached_object(). The struct itself is a little odd,
with an invalid "oid" field that is handled specially by that function.

Since it's really just an implementation detail, let's move it to a
static within the function. That future-proofs against other code trying
to use it and seeing the weird oid value.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 19fc4afa43..4d4280543e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -325,14 +325,13 @@ static struct cached_object {
 } *cached_objects;
 static int cached_object_nr, cached_object_alloc;
 
-static struct cached_object empty_tree = {
-	/* no oid needed; we'll look it up manually based on the_hash_algo */
-	.type = OBJ_TREE,
-	.buf = "",
-};
-
 static struct cached_object *find_cached_object(const struct object_id *oid)
 {
+	static struct cached_object empty_tree = {
+		/* no oid needed; we'll look it up manually based on the_hash_algo */
+		.type = OBJ_TREE,
+		.buf = "",
+	};
 	int i;
 	struct cached_object *co = cached_objects;
 
-- 
2.47.0.547.g778689293a

