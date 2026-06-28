Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B8F25B0A1
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782637397; cv=none; b=JawwKddxzJJEwVvDAIjNjOAT8SJ73mL8crp77yL2+BuvYBJ1y3LdBzPwZjr7oIBH3wWvTE3bF/tMIuMJye1B9JXeiY06DSKLuudCZk+M40leD/+NboUAXIzclbP5CsRoh3+pe5Yq9ILGLwWClpPces+w8tJLHHmddoN3f/go2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782637397; c=relaxed/simple;
	bh=gfUIOpA4rfchWdtaDAMXf78GorflSqgYw0SSxs9pg/A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YiB6oMUuOdbMElrwpfXMKkbI3E9nZ0sLQhty81OmKdaoicP+9slK5StcSYKGlf2yRKAtKG9j4KzJkQ6DuDeiTaZyxAmMAmX9yVk2FYQpxqIf/HQgdQ3qF+tWsLu+58uCv3uL9mOWLPrNBSOApi4DaCHK+XJSGnTHoTrDD4i9FU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dllFsCoH; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dllFsCoH"
Received: (qmail 52610 invoked by uid 106); 28 Jun 2026 09:03:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=gfUIOpA4rfchWdtaDAMXf78GorflSqgYw0SSxs9pg/A=; b=dllFsCoHK7ZdJH8BoEsLm4OmwhIneB/8MtCyokVsTHeWG4TsZdD8s0M+nlWQOUIJZHFA0p3xdobotRIKx8QxaV5+OSe6v/RQ9F04YEf+PfybbmccxxftBc6mCo42r08LQdeYi3ZYfB04ctoITbzRsflKwAqESyBb29M5V40qfiRn/iAGBDm5Yw6PU4MzrzK7ty/jX+870wuFnIFWccFR9LXmOTotoquFqbDScNI3wFPo5i6u+VbrCQtlkejuygXpciWxLaFrHxIdtt/vs7ZWX8NbasMpPnW1MIeSTmqmdAlIVwnmurDLMYYJRVNDF3gIhFTKYpRYL0a1L454M/0Ogg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 28 Jun 2026 09:03:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 111988 invoked by uid 111); 28 Jun 2026 09:03:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Jun 2026 05:03:14 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 28 Jun 2026 05:03:14 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] reftable: fix unlikely leak on API error
Message-ID: <20260628090314.GA661068@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

If the reftable writer sees a bogus block size, we return with
REFTABLE_API_ERROR, leaking the reftable_writer struct we previously
allocated. Originally this case was a BUG(), but it became a regular
return in 445f9f4f35 (reftable: stop using `BUG()` in trivial cases,
2025-02-18).

We could obviously fix it by calling "reftable_free(wp)". But we can
observe that we never use the allocated "wp" until after we've validated
the input options. So let's just bump the allocation down. That fixes
the leak, and I think makes the flow of the function more logical
(we validate our inputs before doing any work).

Signed-off-by: Jeff King <peff@peff.net>
---
Noticed by Coverity as a "new" problem, though it has been there for
over a year.  Presumably the nearby changes from 44f46f2be5 (reftable:
split up write options, 2026-06-25) confused it. There's a backlog of
hundreds of Coverity problems, most of which are garbage, so I tend to
only look at the ones it marks as new.

 reftable/writer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 0133b64975..1bd4aa388b 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -152,16 +152,16 @@ int reftable_writer_new(struct reftable_writer **out,
 	struct reftable_write_options opts = {0};
 	struct reftable_writer *wp;
 
-	wp = reftable_calloc(1, sizeof(*wp));
-	if (!wp)
-		return REFTABLE_OUT_OF_MEMORY_ERROR;
-
 	if (_opts)
 		opts = *_opts;
 	options_set_defaults(&opts);
 	if (opts.block_size >= (1 << 24))
 		return REFTABLE_API_ERROR;
 
+	wp = reftable_calloc(1, sizeof(*wp));
+	if (!wp)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
+
 	reftable_buf_init(&wp->block_writer_data.last_key);
 	reftable_buf_init(&wp->last_key);
 	reftable_buf_init(&wp->scratch);
-- 
2.55.0.rc2.353.gf769b6597e
