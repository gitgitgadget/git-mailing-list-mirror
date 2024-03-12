Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020B679B84
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235042; cv=none; b=rOSbRbBFcEGKSOb1Arpd+r9KcfB4BoQUnssVFPn+h1Ios1v+50lDxs+NHq5fbPKfVJl+h1HI3rcGHFDkk8HIkHNFBdN0FmkUVVZYPgCz/bqZ1wdjgGpDYaxcH+1Ru2E02UZtacYPYBZ7LVz1baK7CIOuX8ZfsIrERgxvnhXztXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235042; c=relaxed/simple;
	bh=5dvQ8FE98wHs8EPZ9vnT6GWkPYY46GLGx+3nN3Y5H+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPvnnZoRSLpcezRTaTjXB/BNT8J5MUsjIcCSJ69dGBJtdRMzIVY+Ex5gTepae+JbRriGGcFhLO+1oJaAW6+mzhHVKLgiNTdJsXETIieac+htaqt26m40U3WQOb2fQ1R15cz6fwFxnVoljtTd5AEiKvMxkIhOnz49NnKYz/jlJe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17497 invoked by uid 109); 12 Mar 2024 09:17:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 09:17:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28025 invoked by uid 111); 12 Mar 2024 09:17:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 05:17:24 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 05:17:19 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 04/16] commit: refactor base-case of
 adjust_comment_line_char()
Message-ID: <20240312091719.GD95609@coredump.intra.peff.net>
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

When core.commentChar is set to "auto", we check a set of candidate
characters against the proposed buffer to see which if any can be used
without ambiguity. But before we do that, we optimize for the common
case that the default "#" is fine by just seeing if it is present in the
buffer at all.

The way we do this is a bit subtle, though: we assign the candidate
character to comment_line_char preemptively, then check if it works, and
return if it does. The subtle part is that sometimes setting
comment_line_char is important (after we return, the important outcome
is the fact that we have set the variable) and sometimes it is useless
(if our optimization fails, we go on to do the more careful checks and
eventually assign something else instead).

To make it more clear what is happening (and to make further refactoring
of comment_line_char easier), let's check our candidate character
directly, and then assign as part of returning if it worked out.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a91197245f..b2d05c0cc9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -685,9 +685,10 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	char *candidate;
 	const char *p;
 
-	comment_line_char = candidates[0];
-	if (!memchr(sb->buf, comment_line_char, sb->len))
+	if (!memchr(sb->buf, candidates[0], sb->len)) {
+		comment_line_char = candidates[0];
 		return;
+	}
 
 	p = sb->buf;
 	candidate = strchr(candidates, *p);
-- 
2.44.0.481.gf1a6d20963

