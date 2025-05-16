Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250B21CC46
	for <git@vger.kernel.org>; Fri, 16 May 2025 04:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747370994; cv=none; b=hjWOndFnNAybZ9/wf2OGgYPuR5D3Gs0CShl3aZvmnfWKyHswEzHivW3WCwlC6JGm0ATCgblAtg7DH351Lur/2VUs++zAocp2szXgI/Yp4x9mVyhk92/xztq86WE15FNe0HjKXyiRedoJLTDYTKSK/OXAhNXrvLdAZuBOf6NIoEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747370994; c=relaxed/simple;
	bh=yuhxVLAos3DPyctev3Op64ac04pmeXhj4H0D+B8Vysw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhryArjOuGv36zhySseQRIZKLmqr3S4KyfXKDpeRYzwcfGjlTZAuUfZz/ZHpatp5/kL19v6m2CA4sPOsnApaS62jhnshDgNDc/VmqIiinUORqRg7453u2EFK+bfYETJN156NAuBNLoC3LSsbXuN7UEoa0HC6oBlzvHE/FPF+Lj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YONwQCpC; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YONwQCpC"
Received: (qmail 5163 invoked by uid 109); 16 May 2025 04:49:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=yuhxVLAos3DPyctev3Op64ac04pmeXhj4H0D+B8Vysw=; b=YONwQCpC4bVYAnUaD49PQVHoflKwfJCt575B9uehPRIy+0F8te85GV5fTTh5137bydkVP1visyCdKQcsBgnbVvcaEt5CYjTyk4zv5+NrhrjsOsc92n2H2hmw1GWoDpKhHO4sSWypOSwxa9aNicKfRORGhuiLapM/T7U8Z/+QhWZwkeL3q8f2LH6RwE8gIDUaqn1JJ377p/jE667H8xeF2JnvXr3G27UA4FgyQoLRyS8LoyM3LbrFqfydzgxAwtb8xLCpDJmzhV4zo9slsl2mg//Q1zrC7X79bPYm5zbbQ0N1OLXe8uKJ8czbpNfM1wlYn5TV2eltDERj3t3ptAGSwQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 May 2025 04:49:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4906 invoked by uid 111); 16 May 2025 04:49:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 May 2025 00:49:55 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 16 May 2025 00:49:50 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 05/13] oid_object_info_convert(): stop using string for
 object type
Message-ID: <20250516044950.GE22242@coredump.intra.peff.net>
References: <20250516044916.GA21985@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250516044916.GA21985@coredump.intra.peff.net>

In oid_object_info_convert(), we convert objects between their sha1 and
sha256 variants. To do this, we naturally need to know the type, which
we get from oid_object_info_extended() using its type_name strbuf
option.

But getting the value as a string (versus an object_type enum) is not
helpful. Since we do not allow unknown types, the regular enum is
sufficient. And the resulting code is a bit simpler, as we no longer
have to manage the extra allocation nor convert the string to an enum
ourselves.

Note that at first glance, it might seem like we should retain the error
check for "type == -1" to catch bogus types found by the underlying
parser. But we don't need it, as an unknown type would have yielded an
error from the call to oid_object_info_extended(), which would already
have caused us to return an error.

In fact, I suspect this was always impossible to trigger. Even when we
were converting the string to a type enum ourselves, an invalid type
would never have escaped oid_object_info_extended(), since we never
passed the (now removed) OBJECT_INFO_ALLOW_UNKNOWN_TYPE option.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-store.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/object-store.c b/object-store.c
index 2f51d0e3b0..b8f6955ea7 100644
--- a/object-store.c
+++ b/object-store.c
@@ -727,7 +727,7 @@ static int oid_object_info_convert(struct repository *r,
 {
 	const struct git_hash_algo *input_algo = &hash_algos[input_oid->algo];
 	int do_die = flags & OBJECT_INFO_DIE_IF_CORRUPT;
-	struct strbuf type_name = STRBUF_INIT;
+	enum object_type type;
 	struct object_id oid, delta_base_oid;
 	struct object_info new_oi, *oi;
 	unsigned long size;
@@ -753,7 +753,7 @@ static int oid_object_info_convert(struct repository *r,
 		if (input_oi->sizep || input_oi->contentp) {
 			new_oi.contentp = &content;
 			new_oi.sizep = &size;
-			new_oi.type_name = &type_name;
+			new_oi.typep = &type;
 		}
 		oi = &new_oi;
 	}
@@ -766,12 +766,7 @@ static int oid_object_info_convert(struct repository *r,
 
 	if (new_oi.contentp) {
 		struct strbuf outbuf = STRBUF_INIT;
-		enum object_type type;
 
-		type = type_from_string_gently(type_name.buf, type_name.len,
-					       !do_die);
-		if (type == -1)
-			return -1;
 		if (type != OBJ_BLOB) {
 			ret = convert_object_file(the_repository, &outbuf,
 						  the_hash_algo, input_algo,
@@ -788,10 +783,8 @@ static int oid_object_info_convert(struct repository *r,
 			*input_oi->contentp = content;
 		else
 			free(content);
-		if (input_oi->type_name)
-			*input_oi->type_name = type_name;
-		else
-			strbuf_release(&type_name);
+		if (input_oi->typep)
+			*input_oi->typep = type;
 	}
 	if (new_oi.delta_base_oid == &delta_base_oid) {
 		if (repo_oid_to_algop(r, &delta_base_oid, input_algo,
-- 
2.49.0.896.g93578ceaaf

