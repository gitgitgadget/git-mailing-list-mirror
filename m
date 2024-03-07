Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EBE745FE
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803016; cv=none; b=dCO9r8Reab8SK8HMA2JvtSUnub++IRHnjdoXUlsy0KKE9JYz11ZZGHso8rxFhhEBXrNS/uqQWOidmuNkapATJmuYlrqCdUYsKvIulmSLd3HtP/3VBNfoaQaIVL7T8cXz62iLmTQ5Jd0BSeWaokVMHg3hm05iWiChCQw2tm7RShI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803016; c=relaxed/simple;
	bh=aXEB4GukL7MpNBxHsjGcuhkuWKjeN9GSO/o0embAoyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJJeBwNoOV6AqmBKgGV+PXY39m12KRbAYgyjSvbcR85WouOaPdrx1O+otml2J8l3kvR4uavlRQDygXJSgAAtBbyAWRLxQuiWK75ajNFoaZDV06ZVmKz7JjM0HhtWDY8JktaAHlQ2jR7aHcR0zwlty3VvCexzhicWWVexw4y9cz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6841 invoked by uid 109); 7 Mar 2024 09:16:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 09:16:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12547 invoked by uid 111); 7 Mar 2024 09:16:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 04:16:58 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 04:16:52 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH 02/15] strbuf: avoid static variables in
 strbuf_add_commented_lines()
Message-ID: <20240307091652.GB2080210@coredump.intra.peff.net>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307091407.GA2072522@coredump.intra.peff.net>

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
In the long run we'll end up just passing in the comment-string that the
caller gives us, so this patch could arguably be dropped until that
point.

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
2.44.0.463.g71abcb3a9f

