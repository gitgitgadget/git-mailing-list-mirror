Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920298C0B
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 01:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302268; cv=none; b=cHm0soCDPOpkM8eKXO4RpLPCDv7T/tCOvm5R7IYKENDvkF5Jtb9D3gPHYY0Sk8z5mQUNUamPWUiBMO0My+oGs+IDFREeuTqo1llzuKEOFuOCeTxq7hCeHHPZSnDF3LG44vzggkDcTWRTBf4MS4tOYPmM7NY892DIezEvzcB8a/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302268; c=relaxed/simple;
	bh=UcgcfI/FE1M35x1BylLs9zx58w+hlce1WdVJZHPIwYI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeatBRPVr1y0z4gplZ3+aI+Dl163X7/WGaw5hXx73Ciy7K86+0mgj6SDza0jDNAuGpdA7zjXDWyYX8+MFM1KbntEdctI1FOlI9L84UAUYaFP34Asj5DZ4fBhf4IOmhfFJlo/wHdkVfw9O0BgCLkEsTlA7IJZjSnz/gp0/86YUyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yNcAUDc2; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yNcAUDc2"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D2802CEBE;
	Mon, 29 Jul 2024 21:17:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=UcgcfI/FE1M35x1BylLs9zx58
	w+hlce1WdVJZHPIwYI=; b=yNcAUDc29064ygXMWyDE+wZwhwU1ym/5QhR3LouN0
	eXlZCwPojKBsO1eAtzIeI05Jxnbp5OLHOiw7EYuyEszXVjAJaAOtziyIOEUWs444
	ZOt/7li/RvjeMDJayLilkTEflvSgrl7rebPVzPmGHv/q3kD8cYMLwlHEFs0VtFzK
	bc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8538A2CEBD;
	Mon, 29 Jul 2024 21:17:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F19F12CEBC;
	Mon, 29 Jul 2024 21:17:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 2/5] patch-id: call flush_current_id() only when needed
Date: Mon, 29 Jul 2024 18:17:35 -0700
Message-ID: <20240730011738.4032377-3-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-71-g1aa693ace8
In-Reply-To: <20240730011738.4032377-1-gitster@pobox.com>
References: <20240621231826.3280338-1-gitster@pobox.com>
 <20240730011738.4032377-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 8684FD38-4E11-11EF-ACE6-34EEED2EC81B-77302942!pb-smtp1.pobox.com
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
2.46.0-69-gd0749fd195

