Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E62F2E
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054083; cv=none; b=t01Nps+ACwgXsK4ZK3xrvxCYusNtZHGOjkmSFDGUJ6hMxevk1LUcda+BbSh/IAn8hufW++RZQrtrccyE5Gz69VhUJGb/TLCHcEZxZEryuInN61P/xMVPRWiLmxRIfK5TEeZm+x9y+5I9n0hQCzEM+FAszYtHaLN5uW+fnjkg5v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054083; c=relaxed/simple;
	bh=5gJACmtKzQhN8VRfq/pzRNrYpFCMWWIAh3k7bKYfOIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLiw2BWs1a82Bb7r9BqtsUeXzZhC+QxWxBvln+TIy2SXnUyye6yWILpWX+3Gz0EbUNNYRYZqhDvKEy0dyMS/97iidlqCZ9PlkzxGyqGI4ePnTpCRulHw7vSw6nk8IbwLioToadTN/zY5QsBY1oeRICvpZz3eusoHgTsLj8gW9ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FE4KZMMI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FE4KZMMI"
Received: (qmail 102405 invoked by uid 109); 16 Sep 2025 20:21:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5gJACmtKzQhN8VRfq/pzRNrYpFCMWWIAh3k7bKYfOIc=; b=FE4KZMMIw7PRLhv5FmdmPuGV7icoHYhJhkTrELp6e5saKRHnC7+hl8DdH2MbGcE2cI06gqyzzW5+e1uZJmRmEaAwnidmpOHM3TDA0e+Qb+vJi014Lz8RxyYEOt99lVniMSWr2FamxmpOqIkOV78CyvyDPJZ5Yv/GffXyL3DYkc1dPKqNV9KhPDpxVvGj6ooaNvFfBjht9UJzVZCGcTrxkUXFGbKtU0fGE9La1lE7T7xfSnaLEyKBqEafc219EgUkd326psVLf3ab/fquc5MrXc0Ju6tChls/uWk9tRb1FwFCOzTm6HzHAJ8P4FTKO7INrECf2ab8auxFmlzS8v3P/Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 20:21:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166245 invoked by uid 111); 16 Sep 2025 20:21:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 16:21:20 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 16:21:20 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 07/13] diff: stop passing ecbdata->use_color as boolean
Message-ID: <20250916202120.GG612873@coredump.intra.peff.net>
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

In emit_hunk_header(), we evaluate ecbdata->color_diff both as a
git_colorbool, passing it to diff_get_color():

  const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);

and as a strict boolean:

  const char *reverse = ecbdata->color_diff ? GIT_COLOR_REVERSE : "";

At first glance this seems wrong. Usually we store the color decision as
a git_colorbool, so the second line would get confused by GIT_COLOR_AUTO
(which is boolean true, but may still mean we do not produce color).

However, the second line is correct because our caller sets color_diff
using want_color(), which collapses the colorbool to a strict true/false
boolean. The first line is _also_ correct because of the idempotence of
want_color(). Even though diff_get_color() will pass our true/false
value through want_color() again, the result will be left untouched.

But let's pass through the colorbool itself, which makes it more
consistent with the rest of the diff code. We'll need to then call
want_color() whenever we treat it as a boolean, but there is only such
spot (the one quoted above).

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 6b12596642..926429d55b 100644
--- a/diff.c
+++ b/diff.c
@@ -1672,7 +1672,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	const char *frag = diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO);
 	const char *func = diff_get_color(ecbdata->color_diff, DIFF_FUNCINFO);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
-	const char *reverse = ecbdata->color_diff ? GIT_COLOR_REVERSE : "";
+	const char *reverse = want_color(ecbdata->color_diff) ? GIT_COLOR_REVERSE : "";
 	static const char atat[2] = { '@', '@' };
 	const char *cp, *ep;
 	struct strbuf msgbuf = STRBUF_INIT;
@@ -1826,7 +1826,7 @@ static void emit_rewrite_diff(const char *name_a,
 	size_two = fill_textconv(o->repo, textconv_two, two, &data_two);
 
 	memset(&ecbdata, 0, sizeof(ecbdata));
-	ecbdata.color_diff = want_color(o->use_color);
+	ecbdata.color_diff = o->use_color;
 	ecbdata.ws_rule = whitespace_rule(o->repo->index, name_b);
 	ecbdata.opt = o;
 	if (ecbdata.ws_rule & WS_BLANK_AT_EOF) {
@@ -3732,7 +3732,7 @@ static void builtin_diff(const char *name_a,
 		if (o->flags.suppress_diff_headers)
 			lbl[0] = NULL;
 		ecbdata.label_path = lbl;
-		ecbdata.color_diff = want_color(o->use_color);
+		ecbdata.color_diff = o->use_color;
 		ecbdata.ws_rule = whitespace_rule(o->repo->index, name_b);
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
-- 
2.51.0.527.g34bc42dacd

