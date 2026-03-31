Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BCE38F92F
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775000574; cv=none; b=PyxgsfwT3Nl3R1BSKoPlzKkz485KrXytvEZAqB8h5tAiD9pifJ3I1iGy1itPjksOv+89W0IcQg1xntF4eaJnLBqmZAjJ1pgSHVOhXTgGRF7/5mHm1RyOXvVEQd3qbSUW0dt+IVU28b5UuVqdpHN6jqJ5sTKlanbGeD7XDjHrxhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775000574; c=relaxed/simple;
	bh=eRDRVol1U0a2ydYytJ0jGKJZJdMGe2D4BfUGMgKUv8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhdKRXUocxK4rgqbXbt4zGowzEBzkN8mOHKlIf1k6ThpMm9WC5k4fhmXLb2+n15rRW+mRlycnXdcMYm/PYzmE6F9pHB51OiPdyUN/IKUagFGr8fTeD6q+GFPiQe9q6dCLbrpledbicQ0Sp5qyg/r1C1dSCd92koIrDxCcfASOX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U5c4bVHA; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U5c4bVHA"
Received: (qmail 206629 invoked by uid 106); 31 Mar 2026 23:42:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eRDRVol1U0a2ydYytJ0jGKJZJdMGe2D4BfUGMgKUv8o=; b=U5c4bVHAyRio5LlNT5QKFAw8JTLtCPklA1zNFK4RVbHoyiZ/eXcV8kOjOHq4peNfZ1mPv50YQgh7IZllKKbjbnf2vntXwwYtsIPO3q+qIgxpiQuIo9RPeFy9ilnsvI4aaZj0RAhQLDF14gtFEUpcfZBKg6eMxxhGNGjKpoEQt4xdAWSjrnW3KWDDwFEQb8rANAvVZOuaehN/XBg1BVOb8ylF8QfemUY+dlzWAitXzisyKsmX3mHUFmYOzT3u3Iy197OTF3BVT4QJ/gMJ0LOnLrT2gXJYQmxPqGiLx5aSoHDb6raLMGj4NeQat0+YWpJwO6jd85TxNLkDUMLOj9v4ZQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Mar 2026 23:42:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 326439 invoked by uid 111); 31 Mar 2026 23:42:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Mar 2026 19:42:52 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 31 Mar 2026 19:42:51 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>, Michael J Gruber <git@grubix.eu>
Subject: [PATCH 05/12] run-command: explicitly cast away constness when
 assigning to void
Message-ID: <20260331234251.GE2328529@coredump.intra.peff.net>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331233856.GA2327197@coredump.intra.peff.net>

We do this:

  char *equals = strchr(*e, '=');

which implicitly removes the constness from "*e" and cause the compiler
to complain. We never write to "equals", but later assign it to a
string_list util field, which is defined as non-const "void *".

We have to cast somewhere, but doing so at the assignment to util is the
least-bad place, since that is the source of the confusion. Sadly we are
still open to accidentally writing to the string via the util pointer,
but that is the cost of using void pointers, which lose all type
information.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index 32c290ee6a..d6980c79b3 100644
--- a/run-command.c
+++ b/run-command.c
@@ -604,11 +604,11 @@ static void trace_add_env(struct strbuf *dst, const char *const *deltaenv)
 	/* Last one wins, see run-command.c:prep_childenv() for context */
 	for (e = deltaenv; e && *e; e++) {
 		struct strbuf key = STRBUF_INIT;
-		char *equals = strchr(*e, '=');
+		const char *equals = strchr(*e, '=');
 
 		if (equals) {
 			strbuf_add(&key, *e, equals - *e);
-			string_list_insert(&envs, key.buf)->util = equals + 1;
+			string_list_insert(&envs, key.buf)->util = (void *)(equals + 1);
 		} else {
 			string_list_insert(&envs, *e)->util = NULL;
 		}
-- 
2.53.0.1136.gd760fbd4a0

