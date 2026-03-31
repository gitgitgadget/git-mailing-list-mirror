Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3284A38F92F
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775000490; cv=none; b=XTk07v08jW0mZQYyim7WIkpDtApvnM9r8ttx/YvYBWfZz7AWxbWxzV/aVqm9mk5tz7nJoIKVXDbyJr2aS0Nn8y2a8Bv0IdbVY2XV6MSrTBBqJP7LfnK3o5Y11ShLEAfv8c1sOAe+EjQa0do+8A8nfNQm7MA1TTs+Soe3RNHtGb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775000490; c=relaxed/simple;
	bh=+gftQ5qPL/rp7MkLy+8XZcPA9Q+StlgcOktfLZWg3uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWMkwwQbmk5bhojG9h4x/fqC9wMrlgGRuPzyqc2P9Mf7chYGwk1+lT03TM5GbQW9xDmptNrbyYOU6X9CHu43pOyPdSDf+14zNqAgyI931n8h8eBw/Gn+vbQdT3BeVJbSqvuiKpN8bQzVjTUzBwPXKhvuepoVqJmHXHfRi+AN22Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Mr3iOxYP; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Mr3iOxYP"
Received: (qmail 206594 invoked by uid 106); 31 Mar 2026 23:41:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+gftQ5qPL/rp7MkLy+8XZcPA9Q+StlgcOktfLZWg3uw=; b=Mr3iOxYPYcSXTCsRAPdKizntaenJxWo1M620yqaeJQV7688Z7utANbD6eBN5R5iosu0deitYYBqLmeCJy5doXoIKmV4OER+BfBVPsHPrHC8DGKrQCyg59Wce05E9T7rePkBS/byOEBzgR2ug1Mqx5gkfZRyuTFGnchlkqRoMPCqFpDOffOLhN0KkRq4Lc/FZg+HHak/E/eLKMhL+SuTnDRTajSo+31lyi2YYOksL6T+COFx5tAqoxugsvjtTatGu1gePKU2nlX31GXahYnIyxmmT3/3Pd3fUagQhYsoW0doi18TBaACAuMSfvCCU2heIVQ6LoZgkHsdb4FUKVUjpgg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Mar 2026 23:41:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 326419 invoked by uid 111); 31 Mar 2026 23:41:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Mar 2026 19:41:27 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 31 Mar 2026 19:41:27 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>, Michael J Gruber <git@grubix.eu>
Subject: [PATCH 02/12] http: add const to fix strchr() warnings
Message-ID: <20260331234127.GB2328529@coredump.intra.peff.net>
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

The "path" field of a "struct repo" (a custom http-push struct, not to
be confused with "struct repository) is a pointer into a const argv
string, and is never written to.

The compiler does not traditionally complain about assigning from a
const pointer because it happens via strchr(). But with some C23 libc
versions (notably recent glibc), it has started to do so. Let's mark the
field as const to silence the warnings.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index 9ae6062198..96df6344ee 100644
--- a/http-push.c
+++ b/http-push.c
@@ -99,7 +99,7 @@ static struct object_list *objects;
 
 struct repo {
 	char *url;
-	char *path;
+	const char *path;
 	int path_len;
 	int has_info_refs;
 	int can_update_info_refs;
-- 
2.53.0.1136.gd760fbd4a0

