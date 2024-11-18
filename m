Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F8193074
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923722; cv=none; b=DZFz5UrIanmpRmg9xo5TeDDvHLu7wUH3xRdcfHfuq3vYr2Rfok9oTqYPAHX04i802poz8eP79zH8DsiFqKViUlScRChm0zMzNTNOMO+DvzuOYFsP1nxvcXjiyW1EDJaGUbb7gT35PSb2QVis44GXIcflhs7td8VZ81r0ZeHPeJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923722; c=relaxed/simple;
	bh=z06q/pbOACVU03Lw2CBChSgv3Wll1BN0b3HpMw3KazM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcEnR9yzeWkTUCRFDH0L+XfrvrwFKV/ytdcoHMBatm6y9ejphdMqR9zL/+xSelXRpwoIjcX8KFof73bGCkb/Q/YmNekV23Ekuv/P+5J6IeW+8KO1eko4n82oGgm/RaBo43BKSajQOaf4PAaQMi7b3orn1TOPRT0u4y8P4MGfxaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=O/U3QrCp; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="O/U3QrCp"
Received: (qmail 22477 invoked by uid 109); 18 Nov 2024 09:55:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=z06q/pbOACVU03Lw2CBChSgv3Wll1BN0b3HpMw3KazM=; b=O/U3QrCpuPe+Q2o2+6nY3H7WZJJLC9mjk1OgoC9ClzOXz3asIOsQzEXtLc8X4g1QA22MrZljvL/1viRA5iGrHkSB+Uz5aNZoKow+8VVp5qGdq7A21svhBFQQfTQY0SHFdrok777K0FlPFS5r2oqCQ68MYwyenU1KVPDUHhNQJqjDqaZ8iALazbSKTo17oi8I2IuKdRey2gl16ZOlfLvY4E4D6ovsMirDKJYHAoR4l/jKol/5AUtEsjIayCct+IyyVU/kR4yOce/dODcsOwxqT+AquClKbHASsgjd/crRQ+2ppaIavro3Dx4eGo+WOyi+5xZyv/zY26Cfi7AdV9An4w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Nov 2024 09:55:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18326 invoked by uid 111); 18 Nov 2024 09:55:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Nov 2024 04:55:24 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Nov 2024 04:55:19 -0500
From: Jeff King <peff@peff.net>
To: Sam James <sam@gentoo.org>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Subject: [PATCH 5/6] object-file: treat cached_object values as const
Message-ID: <20241118095519.GE3992317@coredump.intra.peff.net>
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

The cached-object API maps oids to in-memory entries. Once inserted,
these entries should be immutable. Let's return them from the
find_cached_object() call with a const tag to make this clear.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index 67a6731066..ec62e5fb3b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -327,14 +327,14 @@ static struct cached_object_entry {
 } *cached_objects;
 static int cached_object_nr, cached_object_alloc;
 
-static struct cached_object *find_cached_object(const struct object_id *oid)
+static const struct cached_object *find_cached_object(const struct object_id *oid)
 {
-	static struct cached_object empty_tree = {
+	static const struct cached_object empty_tree = {
 		.type = OBJ_TREE,
 		.buf = "",
 	};
 	int i;
-	struct cached_object_entry *co = cached_objects;
+	const struct cached_object_entry *co = cached_objects;
 
 	for (i = 0; i < cached_object_nr; i++, co++) {
 		if (oideq(&co->oid, oid))
@@ -1629,7 +1629,7 @@ static int do_oid_object_info_extended(struct repository *r,
 				       struct object_info *oi, unsigned flags)
 {
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
-	struct cached_object *co;
+	const struct cached_object *co;
 	struct pack_entry e;
 	int rtype;
 	const struct object_id *real = oid;
-- 
2.47.0.547.g778689293a

