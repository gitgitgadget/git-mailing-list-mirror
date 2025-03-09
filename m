Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292833209
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741489629; cv=none; b=Gk4MuDc4g6B+rwbKQrkSv8RURJS1hMj3p6B3nbLL3MR2eJWlmg8INNpE9/E8v4I9TkCm52Y2KfXjvn6cGobYCBMYES6lD0RdyneV9MlmCEesY6uY6Aw+S0JXRKWOsk9O8LZbYTLtUIKHgibKYbmSbQSqbcAtXEPiOXUkFURa3c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741489629; c=relaxed/simple;
	bh=gT7/ZFv6rC20DRIwYynuIOgVtIBbc1eOqQP/18eQYcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcbtaYevETGrEHhoBeysYHLAugy2T2XqyQHUb6YNLLS5bY0uMoy8dZ7jfIBUNSmJgJJQeDITtHe+JhQd210M4qHXLPQ5Gbhq2BHXHhY2uQncNIxk2uXS8tbz3baC9OqYcMjxTsCYJCrMcDhECWaWAvWD5/tFawIhz2qSXL8Bf94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QcqabLRr; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QcqabLRr"
Received: (qmail 4737 invoked by uid 109); 9 Mar 2025 03:07:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gT7/ZFv6rC20DRIwYynuIOgVtIBbc1eOqQP/18eQYcQ=; b=QcqabLRrHNoezmKGOP6UrG6cV5kvlFrwL1+d19K+MjASWeiqAgtTVHjp7Qgzf6p6VCvzsgNBZ3UBmksKfpbQdnySKBxLRjDw+z34SJxKy402G6MUCdd3yk6GHAuOAoFHu2KQy6Q5agAmJOstFV5APV1ljJGFOOViBAhbZ1RbMuaXno8lTn6E8+Z7gCoaJUtRV0va7ptmVgyAJ8dNXQ2srUu13BzWMABCRXrOWz/bD2n3opAiSxwuuqQOgzX7isEumv/rWoR9zSKDG6E0YbliUrauaEi3HP9xtFfBNJNWArF9lBHUB/SR5weFLO5Y9M+9uYGpR/mrwAFnmrx/w56Jrg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 09 Mar 2025 03:07:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4912 invoked by uid 111); 9 Mar 2025 03:07:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Mar 2025 22:07:06 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Mar 2025 22:07:06 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 5/9] refspec_ref_prefixes(): clean up refspec_item logic
Message-ID: <20250309030706.GE2334191@coredump.intra.peff.net>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309030101.GA2334064@coredump.intra.peff.net>

The point of refspec_ref_prefixes() is to look over the set of refspecs
and set up an appropriate list of "ref-prefix" strings to send to the
server.

The logic for handling individual refspec_items has some confusing bits.
The final part of our if/else cascade checks this:

  else if (item->src && !item->exact_sha1)
	prefix = item->src;

But we know that "item->exact_sha1" can never be true, because earlier
we did:

  if (item->exact_sha1 || item->negative)
	continue;

This is due to 6c301adb0a (fetch: do not pass ref-prefixes for fetch by
exact SHA1, 2018-05-31), which added the continue. So it is tempting to
remove the extra exact_sha1 at the end of the cascade, leaving the one
at the top of the loop.

But I don't think that's quite right. The full cascade is:

  if (rs->fetch == REFSPEC_FETCH)
	prefix = item->src;
  else if (item->dst)
	prefix = item->dst;
  else if (item->src && !item->exact_sha1)
	prefix = item->src;

which all comes from 6373cb598e (refspec: consolidate ref-prefix
generation logic, 2018-05-16). That first "if" is supposed to handle
fetches, where we care about the source name, since that is coming from
the server. And the rest should be for pushes, where we care about the
destination, since that's the name the server will use. And we get that
either explicitly from "dst" (for something like "foo:bar") or
implicitly from the source (a refspec like "foo" is treated as
"foo:foo").

But how should exact_sha1 interact with those? For a fetch, exact_sha1
always means we do not care about sending a name to the server (there is
no server refname at all). But pushing an exact sha1 should still care
about the destination on the server! It is only if we have to fall back
to the implicit source that we need to care if it is a real ref (though
arguably such a push does not even make sense; where would the server
store it?).

So I think that 6c301adb0a "broke" the push case by always skipping
exact_sha1 items, even though a push should only care about the
destination.

Of course this is all completely academic. We have still not implemented
a v2 push protocol, so even though we do call this function for pushes,
we'd never actually send these ref-prefix lines.

However, given the effort I spent to figure out what was going on here,
and the overlapping exact_sha1 checks, I'd like to rewrite this to
preemptively fix the bug, and hopefully make it less confusing.

This splits the "if" at the top-level into fetch vs push, and then each
handles exact_sha1 appropriately itself. The check for negative refspecs
remains outside of either (there is no protocol support for them, so we
never send them to the server, but rather use them only to reduce the
advertisement we receive).

The resulting behavior should be identical for fetches, but hopefully
sets us up better for a potential future v2 push.

Signed-off-by: Jeff King <peff@peff.net>
---
This could be dropped without affecting the rest of the series if it's
too churn-y.

 refspec.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/refspec.c b/refspec.c
index 4cb80b5208..c6ad515f04 100644
--- a/refspec.c
+++ b/refspec.c
@@ -246,14 +246,24 @@ void refspec_ref_prefixes(const struct refspec *rs,
 		const struct refspec_item *item = &rs->items[i];
 		const char *prefix = NULL;
 
-		if (item->exact_sha1 || item->negative)
+		if (item->negative)
 			continue;
-		if (rs->fetch == REFSPEC_FETCH)
-			prefix = item->src;
-		else if (item->dst)
-			prefix = item->dst;
-		else if (item->src && !item->exact_sha1)
+
+		if (rs->fetch == REFSPEC_FETCH) {
+			if (item->exact_sha1)
+				continue;
 			prefix = item->src;
+		} else {
+			/*
+			 * Pushes can have an explicit destination like
+			 * "foo:bar", or can implicitly use the src for both
+			 * ("foo" is the same as "foo:foo").
+			 */
+			if (item->dst)
+				prefix = item->dst;
+			else if (item->src && !item->exact_sha1)
+				prefix = item->src;
+		}
 
 		if (!prefix)
 			continue;
-- 
2.49.0.rc1.381.gc60f5426ff

