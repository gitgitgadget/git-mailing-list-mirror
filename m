Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF736A378
	for <git@vger.kernel.org>; Tue, 12 May 2026 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602827; cv=none; b=HyYvIXk3LH+bb4KBT+7X2Nya0MF6n/+YgHOlC/TR3cF5mqZip1jBUHx35IfzxMBkpL5w2c79iLIZM3JI6aEIMpE1vNCa+d3NGyIktHyw6I7QhnOx3wK5fXleZ3Jb0RmjFqWXh1BoF7AiiboVvh8kttRuuLLaYmOcMvY4k/USDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602827; c=relaxed/simple;
	bh=BIEuTK5xQbYM/rjgAT02DEdnAb7Bs1WZtRiGqzANuU4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pBp1yO0tJMtnHVh3cyx3eeFGF6hedxwk2Clphz+3kT3gbldBPoal8GvsoM4tnW/5Fce4ZRN9tnM7M3Mpg7LrE7Fr7Ph6zxR+yTm2H4Z+Hl2bpkwTy6s8R3ScdgKlD8EbIncQgCu8fNBeZHwsO1yE6SPWh3BLSesVtyGc3IGYXr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=W89idIHu; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="W89idIHu"
Received: (qmail 26226 invoked by uid 106); 12 May 2026 16:20:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=BIEuTK5xQbYM/rjgAT02DEdnAb7Bs1WZtRiGqzANuU4=; b=W89idIHuuSulIsBlEAgOK82CjhcNTFiCY0cgXijmXMDRo/ma4Z7zwpGLNzzVsO94KWmxhP/jJbqzROUqlDlPjIHFCe05jgSoEQYEoekIGmm9gkg+fgN3mb3I8hX5zf8kszMD/c+KgUPEUBYKr6HPTwZdbkwl3uktmTrPoAUxu/uZwRSQZpnDUkuL4XgpjyelmI6un1wtApBNc0SK7k/FZDnyRQP6qQsyxjaZ8K9OyDodKfMrqzYyjbCaZsqfZj2gls5XG45hfmJ9QN9p+ZzyJOptCRO27sn2LzksXzU57nDUFolZJYsWdVBYyrrrlYHOzMfDiuP3bOwyTguLwsP/ew==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 May 2026 16:20:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 49756 invoked by uid 111); 12 May 2026 16:20:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 May 2026 12:20:23 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 May 2026 12:20:22 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Luke Martin <lmartin@paramenoeng.com>
Subject: [PATCH] pretty: drop strbuf pre-sizing from add_rfc2047()
Message-ID: <20260512162022.GA69669@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

At the top of add_rfc2047() we do this:

  strbuf_grow(sb, len * 3 + strlen(encoding) + 100);

where "len" is the size of the header (like an author name) we are about
to encode into the buffer. This pre-sizing is purely an optimization; we
use strbuf_addf() and friends to actually write into the buffer, and
they will grow the buffer as necessary.

But there's a problem with the code above: the input can be arbitrarily
large, so we might overflow a size_t while doing that computation,
ending up with a too-small allocation request. Overflowing requires an
impractically large input on a 64-bit system, but is easy to demonstrate
on a 32-bit system with a commit whose author name is ~1.4GB.

Because this pre-sizing is just an optimization, there's no real harm.
We'll start with a smaller buffer and grow it as necessary. But it
_looks_ like a vulnerability, since some other code may pre-size a
strbuf and then write directly into its buffer. So it's worth avoiding
the overflow in the first place.

The obvious way to do that is via checked operations like st_add() and
friends. But taking a step back, is this pre-sizing actually helping
anything?

The computation goes all the way back to 4234a76167 (Extend
--pretty=oneline to cover the first paragraph,, 2007-06-11), but back
then we really were sizing the array to write into directly! In
674d172730 (Rework pretty_print_commit to use strbufs instead of custom
buffers., 2007-09-10) that switched to a strbuf, and at that point it
was a pure optimization.

Is the optimization helping? I don't think so. Even for a gigantic case
like the 1.4GB author name, I couldn't measure any slowdown when
removing it. And most input will be much smaller, and added to a running
strbuf containing the rest of the email-header output. We can just rely
on strbuf's usual amortized-linear growth.

So deleting the line seems like the best way to go. It eliminates the
integer overflow and makes the code a tiny bit simpler.

Reported-by: Luke Martin <lmartin@paramenoeng.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 pretty.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index 814803980b..7328aecf5d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -399,7 +399,6 @@ static void add_rfc2047(struct strbuf *sb, const char *line, size_t len,
 	int i;
 	int line_len = last_line_length(sb);
 
-	strbuf_grow(sb, len * 3 + strlen(encoding) + 100);
 	strbuf_addf(sb, "=?%s?q?", encoding);
 	line_len += strlen(encoding) + 5; /* 5 for =??q? */
 
-- 
2.54.0.420.gf0bcdff42b
