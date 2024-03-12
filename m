Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C8478276
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235038; cv=none; b=n2sDhO0EfiPp3A4HtILos60iG2z2PI4tdWj9lNizRHv8InvtJggAKOxjzqyAkzx81Qr9nolsfkUK26IMWdkpXkF/MbfoLttYyCgAqbEnL2fIgDMP6T48BnD5SXfM8eIQgZzgqm3GNIxhvQoQwPNzgABSjnJWNmKPIt71UhQ22lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235038; c=relaxed/simple;
	bh=FKN+Df4IAP5QHRwYjTepM+9uJmbJvW45BxarBARaUeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhUgErbu1mh7GrTz6XQ8/ZoXhjZqXCmzXNqwGztZPZhcV/QmtNbDqDfF9VdQNx7aadSppMkcuS/t5KDpPoA7ok0jYGfcdYTOHS8V1JK1rSAMnozVws2RmG8CsTTPs5pvle4aQ30Z/cizh32jOzOtMWB9JiUxcSHJ3T5cExlCXZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17469 invoked by uid 109); 12 Mar 2024 09:17:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 09:17:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28016 invoked by uid 111); 12 Mar 2024 09:17:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 05:17:20 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 05:17:15 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 03/16] strbuf: avoid static variables in
 strbuf_add_commented_lines()
Message-ID: <20240312091715.GC95609@coredump.intra.peff.net>
References: <20240312091013.GA95442@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240312091013.GA95442@coredump.intra.peff.net>

In strbuf_add_commented_lines(), we have to convert the single-byte
comment_line_char into a string to pass to add_lines(). We cache the
created string using a static-local variable. But this makes the
function non-reentrant, and it's doubtful that this provides any real
performance benefit given that we know the string always contains a
single character.

So let's just create it from scratch each time, and to give the compiler
the maximal opportunity to make it fast we'll ditch the over-complicated
xsnprintf() and just assign directly into the array.

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 689d8acd5e..ca80a2c77e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -361,10 +361,10 @@ static void add_lines(struct strbuf *out,
 void strbuf_add_commented_lines(struct strbuf *out, const char *buf,
 				size_t size, char comment_line_char)
 {
-	static char prefix[2];
+	char prefix[2];
 
-	if (prefix[0] != comment_line_char)
-		xsnprintf(prefix, sizeof(prefix), "%c", comment_line_char);
+	prefix[0] = comment_line_char;
+	prefix[1] = '\0';
 	add_lines(out, prefix, buf, size, 1);
 }
 
-- 
2.44.0.481.gf1a6d20963

