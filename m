Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F301361658
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 04:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103315; cv=none; b=LD31XU8AxrK3m7l1dcLvujnLVcs1v8IYw2gS6uY4EL4lQbL6+KnCbKJhIzCxQDnSkpItpj4vSl5WQ3i0nJ+tnANzCTHn05PrgNjq3JxzbFg46ik3fX6QMO3XiHCOF5UB7IwB5CsnnpJfaPgvyJyl9bofr5CJo9hVwaMEx/E7sRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103315; c=relaxed/simple;
	bh=nBexDPbQbU0/h4t53jYyD10Ib2zR4hqn0IcKu55WxeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKbjykLnKHvgOIzeRpGzZDGbVSF8oLTBqnVifKaB8WrawplHuMQyLtTnc4bWvQPnJnVR7JxrrBgRXfYgWd5aIJNs2whykepH9TExoS24BePfDuHov7jVA/rGR84QiT6AH4QUIE81RU0W/JYiePdlB7Fb/rP+SagZZOwUVauQPH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aaJ6vhNo; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aaJ6vhNo"
Received: (qmail 218917 invoked by uid 106); 2 Apr 2026 04:15:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=nBexDPbQbU0/h4t53jYyD10Ib2zR4hqn0IcKu55WxeM=; b=aaJ6vhNoIsRJPSOXYtuVjL/QBmlSTfbIVa0rDEQ+cVTXxFIQJFoKZb0hD5BWwJdyD9KCQuo8YlKHgnvjbHV0sk8a+4QFrTGcdgUft6XkrSKt7Y0XLWoo0htR3U6939fhIGp8rWMIKyHJBlcdZ/C62FGrqmT1TAHxpPcQgi+qWLyNjuvtaShjxSJ6eQ+mSfqQ3B716C9tiK3BxMBGGJfGdk5Au+pJTPHCnmyvw7Xwn0582UGmP8U7BhZr3GePUGdyXNHyDIfMGUCkNoUenhgk8LWr9YWN9OVX7I+eP8w1ElsyijG9iOtTsgZYlf9y0kKire5mq9hpuWmBGqwbDfGRUg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Apr 2026 04:15:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 349781 invoked by uid 111); 2 Apr 2026 04:15:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Apr 2026 00:15:12 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Apr 2026 00:15:12 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: [PATCH v2 10/12] range-diff: drop const to fix strstr() warnings
Message-ID: <20260402041512.GJ3501239@coredump.intra.peff.net>
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

This is another case where we implicitly drop the "const" from a pointer
by feeding it to strstr() and assigning the result to a non-const
pointer. This is OK in practice, since the const pointer originally
comes from a writable source (a strbuf), but C23 libc implementations
have started to complain about it.

We do write to the output pointer, so it needs to remain non-const. We
can just switch the input pointer to also be non-const in this case.  By
itself that would run into problems with calls to skip_prefix(), but
since that function has now been taught to match in/out constness
automatically, it just works without us doing anything further.

Signed-off-by: Jeff King <peff@peff.net>
---
 range-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index 2712a9a107..8e2dd2eb19 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -88,7 +88,7 @@ static int read_patches(const char *range, struct string_list *list,
 	line = contents.buf;
 	size = contents.len;
 	for (; size > 0; size -= len, line += len) {
-		const char *p;
+		char *p;
 		char *eol;
 
 		eol = memchr(line, '\n', size);
-- 
2.53.0.1172.ge9e20b5838

