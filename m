Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D471835F8A8
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 04:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103299; cv=none; b=h4QTP7mpSRAJBO0gaVHIM9ype+R84dtBHV4m/mz8nMo0w8w/qnCXRcFF71uQ6Os6Qqb23mvpyjMeWK+oBi1WQrNTqk1EgOSH/eOR8ZxZnTKtsFGkcdI9PIUi3o7v2if4nr2l76Hp+uBhoOJLCxWHRv3VdadUS6mNT9rerVedA6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103299; c=relaxed/simple;
	bh=fl+ZX/04+UJMH4igvm9U6qJ/9+UhOiQQBtNVi7bDoKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=She/wmAhTyxWlFWuUEjM7HfAeQtwY45wZaJQOGr2IQaaMhxnLnabmZ5mJyag5mV7Q0NXEragiYYBmcOxeR/+02mpwURUqbqOPjzCnESFhnf11MFGCJC39pebuSKnpMwHU7YdUmN0muxv2TX6/0S+QE54/WKaU4P+F3mHhqp9CNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QkuuXKst; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QkuuXKst"
Received: (qmail 218805 invoked by uid 106); 2 Apr 2026 04:14:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fl+ZX/04+UJMH4igvm9U6qJ/9+UhOiQQBtNVi7bDoKE=; b=QkuuXKstyPKk6RZAbo8eLui6fD98zqESgMg0WDLpUsQ76LnKtZLz6gevtHa8ie/fE8qj0R5yGJgOn/q9mdCYsQpbwF1YXpa9T409RW67MQ32oMTsc00u6pcsMqiqPU+Dok7FUUNzFHomJH0vCzRWAA/f77RVtrgnmQvVUzMHz0flP72EbQ1heo6/EZqVKipMxr7Mi/89qmShhGNXhYgYqOBpxqYJkvQeSuNVLGCeIW0urZBWDBMLt/blfWyq3uROOUS6pATad8N8hHIDOOWjCwPlnrAPWzW+OuCbCCU5jvS6cm5fj8+xSN8CqaGw2KQyYZeFtsMPKNbRoKUcG/b1sQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Apr 2026 04:14:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 349715 invoked by uid 111); 2 Apr 2026 04:14:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Apr 2026 00:14:56 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Apr 2026 00:14:56 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: [PATCH v2 03/12] transport-helper: drop const to fix strchr()
 warnings
Message-ID: <20260402041456.GC3501239@coredump.intra.peff.net>
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

We implicitly drop the const from our "key" variable when we do:

  char *p = strchr(key, ' ');

which causes compilation with some C23 versions of libc (notably recent
glibc) to complain.

We need "p" to remain writable, since we assign NUL over the space we
found. We can solve this by also making "key" writable. This works
because it comes from a strbuf, which is itself a writable string.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport-helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 4d95d84f9e..4614036c99 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -781,7 +781,8 @@ static int push_update_ref_status(struct strbuf *buf,
 
 	if (starts_with(buf->buf, "option ")) {
 		struct object_id old_oid, new_oid;
-		const char *key, *val;
+		char *key;
+		const char *val;
 		char *p;
 
 		if (!state->hint || !(state->report || state->new_report))
-- 
2.53.0.1172.ge9e20b5838

