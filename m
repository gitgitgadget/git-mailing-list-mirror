Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077DF21D5A2
	for <git@vger.kernel.org>; Fri, 16 May 2025 04:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747370999; cv=none; b=H6mhhVa2riWfZT62K8JcA+Mym0OlYhh+bohIhMhssa/BvgWHQfEVuxYIYiGpLAxb+OFjn6PE3svsmI7fM264bH/7VXe7jqkXOi1eVyl4BQlDlhNo2wyqSMzvdBXzdHNDJitF9o+5QugUr8luCsx3DWJ/Vsr7bdxvGaUbW3dqxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747370999; c=relaxed/simple;
	bh=E5RUex8XBZX0MhpQpnVAaC3JwiTwLMlqio81lWMdHy0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9jfLCkzHI+sjOkxZgqWD+IsjQal9x3IUEF/tZ6t3zo0RB8I61tMbNNgparILaiVMePDKBpZ7r7au7ieqiIrtENueZ0n9VauxngyNh2Dz4HB6La9MAAzYdd/fatWlkePRwQmi/LOqHYjqPPUiC4kuSC638xQaQfqPZIhVbzR954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YnS4HB6+; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YnS4HB6+"
Received: (qmail 5170 invoked by uid 109); 16 May 2025 04:49:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=E5RUex8XBZX0MhpQpnVAaC3JwiTwLMlqio81lWMdHy0=; b=YnS4HB6+4fdit5+s21t+4PBh5lVOMlkvhW7f9qMkNvo0AHxA6mZP0P0/+L+LkySvaAoGjCVguXjr592Pp7dZbkjcK+AlR1VVEiJgR8sAdBwOhW4nPvenqSH3LrVPs8WT4XC+sb+mDuITDHaN2KmARRPwPXRl9fhBUMSH19BigrCRvfUYqty7os9fC6TQMTbEaGuf8ejumOs+/7fCo1h7pEuY5VkNg7bO8/idZ7GK6kUSacdp5ieSShw8PJy6TiBMj1yKawCSkGo0JU7grwg2AnkNv7Bkhz2dLWZHxkVOurmTrMyP2gk32q1l1pQPmibX1W5PDJkAA5ILVu014gmQ4A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 May 2025 04:49:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4923 invoked by uid 111); 16 May 2025 04:50:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 May 2025 00:50:01 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 16 May 2025 00:49:56 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 07/13] oid_object_info(): drop type_name strbuf
Message-ID: <20250516044956.GG22242@coredump.intra.peff.net>
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

We provide a mechanism for callers to get the object type as a raw
string, rather than an object_type enum. This was in theory useful for
returning types that are not representable in the enum, but we consider
any such type to be an error, and there are no callers that use the
strbuf anymore.

Let's drop support to simplify the code a bit.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c  | 4 +---
 object-store.c | 2 --
 object-store.h | 1 -
 packfile.c     | 7 +------
 4 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/object-file.c b/object-file.c
index 7a35bde96e..b10e283529 100644
--- a/object-file.c
+++ b/object-file.c
@@ -403,8 +403,6 @@ int parse_loose_header(const char *hdr, struct object_info *oi)
 	}
 
 	type = type_from_string_gently(type_buf, type_len, 1);
-	if (oi->type_name)
-		strbuf_add(oi->type_name, type_buf, type_len);
 	if (oi->typep)
 		*oi->typep = type;
 
@@ -466,7 +464,7 @@ int loose_object_info(struct repository *r,
 	 * return value implicitly indicates whether the
 	 * object even exists.
 	 */
-	if (!oi->typep && !oi->type_name && !oi->sizep && !oi->contentp) {
+	if (!oi->typep && !oi->sizep && !oi->contentp) {
 		struct stat st;
 		if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK))
 			return quick_has_loose(r, oid) ? 0 : -1;
diff --git a/object-store.c b/object-store.c
index b8f6955ea7..216c61dcf2 100644
--- a/object-store.c
+++ b/object-store.c
@@ -646,8 +646,6 @@ static int do_oid_object_info_extended(struct repository *r,
 			*(oi->disk_sizep) = 0;
 		if (oi->delta_base_oid)
 			oidclr(oi->delta_base_oid, the_repository->hash_algo);
-		if (oi->type_name)
-			strbuf_addstr(oi->type_name, type_name(co->type));
 		if (oi->contentp)
 			*oi->contentp = xmemdupz(co->buf, co->size);
 		oi->whence = OI_CACHED;
diff --git a/object-store.h b/object-store.h
index cf908fe68e..6b55c245eb 100644
--- a/object-store.h
+++ b/object-store.h
@@ -205,7 +205,6 @@ struct object_info {
 	unsigned long *sizep;
 	off_t *disk_sizep;
 	struct object_id *delta_base_oid;
-	struct strbuf *type_name;
 	void **contentp;
 
 	/* Response */
diff --git a/packfile.c b/packfile.c
index d91016f1c7..80e35f1032 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1598,17 +1598,12 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		*oi->disk_sizep = pack_pos_to_offset(p, pos + 1) - obj_offset;
 	}
 
-	if (oi->typep || oi->type_name) {
+	if (oi->typep) {
 		enum object_type ptot;
 		ptot = packed_to_object_type(r, p, obj_offset,
 					     type, &w_curs, curpos);
 		if (oi->typep)
 			*oi->typep = ptot;
-		if (oi->type_name) {
-			const char *tn = type_name(ptot);
-			if (tn)
-				strbuf_addstr(oi->type_name, tn);
-		}
 		if (ptot < 0) {
 			type = OBJ_BAD;
 			goto out;
-- 
2.49.0.896.g93578ceaaf

