Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29B6F2F1
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 23:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719011917; cv=none; b=O77nfQTxU4//PT3y0Ev8+iwNYkf86O42R4nzF3c1xFD4p+yUQP72j8+G37BWRls9IqY9xUmu10zhGc0TjjJx5TVnLySf6GqM0i5VU4iZys7K1QCk5AjSM0NM7V1gFIM7pSuwsDEOpbFukBKx1KWLcwB5qZLEDOo39kPnFAeyapI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719011917; c=relaxed/simple;
	bh=PZM0J0P24DxUfn9mym1XagGPVYbBHN5vU/bQu2tccGo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C65xoVCqLt50zOrUVBIWY/8Zmn1LMOh+b7OERRmLA88DLYEXxQX0FlB0nLIezoVLLDtaOcT2eduY5jKe/gRUb9nKNq46KKJPP0eou8iy8X14eTVt9bFkxQaF2rD25eafyz+CpgK61Q9maIVjDPwU91+rmIUpDZVk1FNis6BNmdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UyYcC6U+; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UyYcC6U+"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AACF23CA8;
	Fri, 21 Jun 2024 19:18:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=PZM0J0P24DxUfn9mym1XagGPV
	YbBHN5vU/bQu2tccGo=; b=UyYcC6U+nDYF/brWMmSMTkej48Q0GsJFaeph//i+v
	3euwqxpjjVpmKDLk8xHioHn541e8OkXJCBre7S3i9YzTPsM5z+7n534UbYKcCGus
	zkiCOhiXZL7G9BqAXW/q9j16jlj6bHHyWFuhTxYpmvIJbu1Bwlti9fe/gLwKR9qR
	ms=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2244C23CA7;
	Fri, 21 Jun 2024 19:18:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8949E23CA6;
	Fri, 21 Jun 2024 19:18:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/5] patch-id: call flush_current_id() only when needed
Date: Fri, 21 Jun 2024 16:18:23 -0700
Message-ID: <20240621231826.3280338-3-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-786-g49444cbe9a
In-Reply-To: <20240621231826.3280338-1-gitster@pobox.com>
References: <20240621231826.3280338-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 927376D4-3024-11EF-AB43-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

The caller passes a flag that is used to become no-op when calling
flush_current_id().  Instead of calling something that becomes a
no-op, teach the caller not to call it in the first place.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/patch-id.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 3894d2b970..0f262e7a03 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -6,10 +6,9 @@
 #include "hex.h"
 #include "parse-options.h"
=20
-static void flush_current_id(int patchlen, struct object_id *id, struct =
object_id *result)
+static void flush_current_id(struct object_id *id, struct object_id *res=
ult)
 {
-	if (patchlen)
-		printf("%s %s\n", oid_to_hex(result), oid_to_hex(id));
+	printf("%s %s\n", oid_to_hex(result), oid_to_hex(id));
 }
=20
 static int remove_space(char *line)
@@ -181,7 +180,8 @@ static void generate_id_list(int stable, int verbatim=
)
 	oidclr(&oid);
 	while (!feof(stdin)) {
 		patchlen =3D get_one_patchid(&n, &result, &line_buf, stable, verbatim)=
;
-		flush_current_id(patchlen, &oid, &result);
+		if (patchlen)
+			flush_current_id(&oid, &result);
 		oidcpy(&oid, &n);
 	}
 	strbuf_release(&line_buf);
--=20
2.45.2-786-g49444cbe9a

