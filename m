Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2681F4CB7
	for <git@vger.kernel.org>; Fri, 16 May 2025 04:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747370991; cv=none; b=NAiEItEevKdN+XqbBwT6kVtlSRyKlqebnjJf/wUjpKNrCdkGWccthsxN6572+zgYCojN2zcJx9Rq7rH7XxJl0UQ41OhY0a+N10Zoz1yNY2XhPHsYzbSwBUPADWFXSy3djkAwGg6mlcawV5h5+smcgK1Tqr8EgURM7Lt7RyJpod8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747370991; c=relaxed/simple;
	bh=DMuG++fbboWAuWtcjqDm2cc315MXF02m7hI25RssSBk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxtHLMgbsaPC8HPpufljoHUliJATRv02fyPAAELipGeUDzZvcjZqOUqhtfljhGuJixmZqXzdoAP8IrNSD9YlwvabCbQUb9ZSclXbFAaqk+V6F/mTvHeTLi7Tvtz5gHEsFHK1wDQRNSI4jde+SNOcpbmNpVklF7c/ER0h9ljM1Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LqWDeuhi; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LqWDeuhi"
Received: (qmail 5160 invoked by uid 109); 16 May 2025 04:49:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=DMuG++fbboWAuWtcjqDm2cc315MXF02m7hI25RssSBk=; b=LqWDeuhiMlaYxX4gXVWvFmw+s1kiUFqGXQf4DLf8lpNVcc9XccDfvc+PfxAUmbLKQqQhEkNZPYj/S30WkseUro3NOjGwnvaNxu/m7S155785sabKmVJ/HEs7sgdY6VE19QtluiBMsl1foXq7f50HLrUYorAOhEG/wKV7K9JLydh25OL7tNUMmC3IhIdSIhKYrnKkTAB74lSLwRmdfrXrrVinC5P+444YGnqmLjbcsFYcjMbg2TCUhte4203mE8tVA0PT3Gf+mZVhvQhOMYt/fCzrcfJCWEx36nRvTQa4x8k5x8bqB4cLrlena5duFYbao1YM0po7kKcafsu3IHClCw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 May 2025 04:49:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4902 invoked by uid 111); 16 May 2025 04:49:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 May 2025 00:49:52 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 16 May 2025 00:49:47 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 04/13] cat-file: use type enum instead of buffer for -t option
Message-ID: <20250516044947.GD22242@coredump.intra.peff.net>
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

Now that we no longer support OBJECT_INFO_ALLOW_UNKNOWN_TYPE, there is
no need to pass a strbuf into oid_object_info_extended() to record the
type. The regular object_type enum is sufficient to capture all of the
types we will allow.

This simplifies the code a bit, and will eventually let us drop
object_info's type_name strbuf support.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4adc19aa29..67a5ff2b9e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -109,7 +109,6 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	unsigned long size;
 	struct object_context obj_context = {0};
 	struct object_info oi = OBJECT_INFO_INIT;
-	struct strbuf sb = STRBUF_INIT;
 	unsigned flags = OBJECT_INFO_LOOKUP_REPLACE;
 	unsigned get_oid_flags =
 		GET_OID_RECORD_PATH |
@@ -132,16 +131,12 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	buf = NULL;
 	switch (opt) {
 	case 't':
-		oi.type_name = &sb;
+		oi.typep = &type;
 		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
-		if (sb.len) {
-			printf("%s\n", sb.buf);
-			strbuf_release(&sb);
-			ret = 0;
-			goto cleanup;
-		}
-		break;
+		printf("%s\n", type_name(type));
+		ret = 0;
+		goto cleanup;
 
 	case 's':
 		oi.sizep = &size;
-- 
2.49.0.896.g93578ceaaf

