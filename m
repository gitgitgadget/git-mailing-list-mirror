Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19B82DD60F
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054029; cv=none; b=OnQZpZDK1l/QSxKLHT9y9v4f4e6LrrCtwYhZQTV9ZIMvYkqM7tKZwfecCvkoSt2vuoKcESpNfr0vYJrY0fcDXaAL370Ug8o4PSR9xoHheePpashSf50bdwMdJ7N6Vajm6kQWGDfAS3Kwp8R6tVFuCj7RckQTMYL3mUkDODxB+K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054029; c=relaxed/simple;
	bh=8r14qc4tJL+9ZpXJQ1bTQOPQWSC5RqQB9qjZ+6HIyIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJwx97TUtoz+0cvshmTZOmBGFrmk26NK5I55gRHVfqdGnDX4Cb2mkYoKi7CBCUNbxZk6TQkffTKYqaIqiIq7PgtfFuV32hGGo6b8CXzn56V1bSMYogvqWCYyeKX06J8nA2UOmMIuQg7f78DP4hcSgeFY7zlatjAIFcVozDYOg1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FSswFrRs; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FSswFrRs"
Received: (qmail 102384 invoked by uid 109); 16 Sep 2025 20:20:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8r14qc4tJL+9ZpXJQ1bTQOPQWSC5RqQB9qjZ+6HIyIc=; b=FSswFrRsH2l8legp4pr+KRhkgcOD+cUS0At2R+/GrCekHD+z5RNyj8AJisH6D2RcjL6b9FqOM697iCHK3NI423f5hjGSMAZImI+Gp/hqBwYDVNSbEzBHKGmvKyqs7Zkox81crAEcgbUlpHOqELqQbdbn4QDWLkXUPJNkP64YI2BjKHp92fMIQ5B/9vFjS4Jsl31Vj9+/T7WbgZwtIls1a8usUA2tTO3fsqTk26dwT14p+PGNjSHv3KL5w+7XQySFAVyJrRFJT9V/GwrRWdTYC4EeZq364gRtNd9anW9yqKORxnml4ThTaGkgL+kJo5/0L9KZRPv1uv3M+qksCnRKiQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 20:20:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166235 invoked by uid 111); 16 Sep 2025 20:20:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 16:20:26 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 16:20:26 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 06/13] diff: pass o->use_color directly to fill_metainfo()
Message-ID: <20250916202026.GF612873@coredump.intra.peff.net>
References: <20250916201036.GA612463@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916201036.GA612463@coredump.intra.peff.net>

We pass the use_color parameter of fill_metainfo() as a strict boolean,
using:

  want_color(o->use_color) && !pgm

to derive its value. But then inside the function, we pass it to
diff_get_color(), which expects one of the git_colorbool enum values,
and so feeds it to want_color() again.

Even though want_color() produces a strict 0/1 boolean, this doesn't
produce wrong results because want_color() is idempotent. Since
GIT_COLOR_ALWAYS and NEVER are defined as 1 and 0, and because
want_color() passes through those values, evaluating "want_color(foo)"
and "want_color(want_color(foo))" will return the same result.

But as part of a longer strategy to align the types we use for storing
these values, let's pass through the colorbool directly. To handle the
"&&" case here, we'll convert the presence of "pgm" into "NEVER", which
arguably makes the intent of the code more clear anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index cc3542e7f4..6b12596642 100644
--- a/diff.c
+++ b/diff.c
@@ -4596,7 +4596,7 @@ static void run_diff_cmd(const struct external_diff *pgm,
 		 */
 		fill_metainfo(msg, name, other, one, two, o, p,
 			      &must_show_header,
-			      want_color(o->use_color) && !pgm);
+			      pgm ? GIT_COLOR_NEVER : o->use_color);
 		xfrm_msg = msg->len ? msg->buf : NULL;
 	}
 
-- 
2.51.0.527.g34bc42dacd

