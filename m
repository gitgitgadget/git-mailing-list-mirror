Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE562F2E
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054149; cv=none; b=m91bFjuzmLcAwPEZtGZG6I+f8dJkDNvyXGeCFNx7w1EcStSizB1JYbmeNfJiqh6ujQ5MSRDNxH3d3JDuLBhOtgtOlfhmb/t+xphaWcX62urUgnHhfssX1Xv77FLDZRS1jjofaOI1aKSieDCJ94Fej18RP6/rirOcwd1ot0pLs6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054149; c=relaxed/simple;
	bh=YnJXcNPfJGtfUVd0C9Wn2TWuHua5QlhlVPHRYOboZiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoyDGbB2L1b3N9HpNGVJi9DXD7MKwnXswqQRJxKElUnnzDYFnx85jK1hVtYcY4S/CdUzFzV8gneUN2pjhxvju6U60pmBxA+r6OzTl/8uMqJQf9Tg8Ve5UN59Czco49b0gSdDnGwA+QtqBroXAGtJsvXUVSc6Y3f7V9epNzanG4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IWVMXQDo; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IWVMXQDo"
Received: (qmail 102427 invoked by uid 109); 16 Sep 2025 20:22:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YnJXcNPfJGtfUVd0C9Wn2TWuHua5QlhlVPHRYOboZiw=; b=IWVMXQDoohwerSZtcC1oYoJI3y0sAn3wJHxHQq9IQc/Iafze9u+0vmDIRVnrlzCU5L/0hFCBmcriVgpb1NpaRflvGwTtEwOqpnOVU/ypY+/knmdCkD6zh5pPK0xycrZbk3sgqmAfeS1J3OYlsInMrXrajNLWiHa/ROwpfKCMkwrI16MrIWPyKguVrP58jx6aLBNh4+5/WhVBjZHqlV6oxTwtnpWh5hb6n/Ds0OyPuQv9jslQ8HGERt6kofceKoRQSbrJO65lQ9iff0ZXBzMb5SYD7SNgEsJL8ph0UvQj/3+7nABc1TO/PYQkUJ8x+EeQvcGaiAMNWuLj6SgtuZQkyA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 20:22:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166249 invoked by uid 111); 16 Sep 2025 20:22:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 16:22:26 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 16:22:26 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 08/13] pretty: use format_commit_context.auto_color as
 colorbool
Message-ID: <20250916202226.GH612873@coredump.intra.peff.net>
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

When we see "%C(auto)" as a format placeholder, we evaluate the "color"
field of our pretty_print_context to decide whether we want color. The
auto_color field of format_commit_context then stores the boolean result
of want_color(), telling us the yes/no of whether we want color.

But the resulting field is passed to various functions which expect a
git_colorbool, like diff_get_color(), that will then pass it to
want_color() again. It's not wrong to do so, since want_color() is
idempotent. But it makes it harder to reason about the types, since we
sometimes confuse colorbools and strict booleans.

Let's instead store auto_color as the original colorbool itself. We'll
have to make sure it is passed through want_color() when it is
evaluated, but there is only one such spot (right next to where we
assign it!). Every other caller just ends up passing it to get
diff_get_color() either directly or through another helper.

Signed-off-by: Jeff King <peff@peff.net>
---
 pretty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index 0521deadc0..86d69bf877 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1455,8 +1455,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	switch (placeholder[0]) {
 	case 'C':
 		if (starts_with(placeholder + 1, "(auto)")) {
-			c->auto_color = want_color(c->pretty_ctx->color);
-			if (c->auto_color && sb->len)
+			c->auto_color = c->pretty_ctx->color;
+			if (want_color(c->auto_color) && sb->len)
 				strbuf_addstr(sb, GIT_COLOR_RESET);
 			return 7; /* consumed 7 bytes, "C(auto)" */
 		} else {
-- 
2.51.0.527.g34bc42dacd

