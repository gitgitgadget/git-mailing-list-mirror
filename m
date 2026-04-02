Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4055E35F61F
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 04:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103292; cv=none; b=ZAHXFGSkXlwZlqLWThMJEoEed+lv5Wg5TLU9vjLyGdQFihdrmgvb3URvuAPgFpJdzRj2k67ntM99FO2vvfgtk4R/vGd0W/DNhlp8f6Q9wSl7Uxp9lwGQhjP5DPFHV8391qM5GJjOQJB4C/RIiExmToeWmRjZGFpmtTs+zwf7kqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103292; c=relaxed/simple;
	bh=GWGR+XHlEWBKUe2uKD/uzBMZh1C4l30WdxqO1mtXtAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UERsqkSgpadwTRLemZDkB3PnJNKRIf7U2uo/BKiV05QGMMdMwG0FEP7Rd1jurfxUP76qIwSFXU8nbFYkntb2E7yU8xYqEPJ0wTXUhU9cB+lxOa9+s6MOhICNLG5gy5I0SUjZ1tZYy0eiiuZSUeMOqI4lMRvd/jh8nDwzy8h9oj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZIhsSCBe; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZIhsSCBe"
Received: (qmail 218773 invoked by uid 106); 2 Apr 2026 04:14:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GWGR+XHlEWBKUe2uKD/uzBMZh1C4l30WdxqO1mtXtAQ=; b=ZIhsSCBeyMUn8y5HhI2O/nHPfrRciVXv8PE7F2v9KcoQUt2TF9jmTKaoLh9pCuMOxPju+RhjEk9E0LGJfUwdl9CgsmVA/4N6Ef3Mvlk9rCak1qI3+0P/LlZgonqtkG1/Zy5y0hX+3ufUummufc62wcAtrqSvq0rUgU3R0SsS8isElSl1cR/nPVxQ8LAVK7S5n3h2vj1MCgvssWEzon+5aXibolBLtf5GjpPhDPfQ0re9XlTumwFNBcWZWTuTaNm7WfoiDp2h8/IfufYuKlw/p+JFxRlmhIlqEVY3uoVxHI+GWJNPLLEk7fzPD9Y0uE57WLdGzjwk0Vtn0ZMqWLSZHg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Apr 2026 04:14:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 349696 invoked by uid 111); 2 Apr 2026 04:14:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Apr 2026 00:14:49 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Apr 2026 00:14:49 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: [PATCH v2 01/12] convert: add const to fix strchr() warnings
Message-ID: <20260402041449.GA3501239@coredump.intra.peff.net>
References: <20260402041433.GA3501120@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402041433.GA3501120@coredump.intra.peff.net>

C23 versions of libc (like recent glibc) may provide generic versions of
strchr() that match constness between the input and return value. The
idea being that the compiler can detect when it implicitly converts a
const pointer into a non-const one (which then emits a warning).

There are a few cases here where the result pointer does not need to be
non-const at all, and we should mark it as such. That silences the
warning (and avoids any potential problems with trying to write via
those pointers).

Signed-off-by: Jeff King <peff@peff.net>
---
 convert.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index a34ec6ecdc..eae36c8a59 100644
--- a/convert.c
+++ b/convert.c
@@ -1168,7 +1168,8 @@ static int ident_to_worktree(const char *src, size_t len,
 			     struct strbuf *buf, int ident)
 {
 	struct object_id oid;
-	char *to_free = NULL, *dollar, *spc;
+	char *to_free = NULL;
+	const char *dollar, *spc;
 	int cnt;
 
 	if (!ident)
-- 
2.53.0.1172.ge9e20b5838

