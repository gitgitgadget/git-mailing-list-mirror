Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D683B76C8D
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803715; cv=none; b=h8o3ANm5L+U8oxgDOmzHA9TkbGAHNVxB+9CjmxHVZr++j4FL30GjCulKu/NQ43kcVUy5XJV/N2OV7ST6uSSwoDtspX0S6PXL7438Tz2DKxnbDb4wisKUJsO0qlBiOi85/76pftRuZWCKWWeaOFuwrDfysDU2qVnA1C49TMzW8ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803715; c=relaxed/simple;
	bh=OR6hKLTAS2an3PtrDNC/XwutHWUFLLezfxlIQVF/V+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBUqwcHQjcRE06/EXndUYESA6XRYWolZ9u21kZdoV3WpvwiZjHGZih3t2aoRw5X1rkCPW6HwrDQp5zgZjUAVIUQL/XvzhI7KB9ayQbdJ0K6lSaDY+i7NEy2bcg+qKu+F98lDoMhzS2lIY+4Oij26no7MbqrpVWg7XfhNfCBeNQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7051 invoked by uid 109); 7 Mar 2024 09:28:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 09:28:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12726 invoked by uid 111); 7 Mar 2024 09:28:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 04:28:37 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 04:28:32 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH 13/15] wt-status: drop custom comment-char stringification
Message-ID: <20240307092832.GM2080210@coredump.intra.peff.net>
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

In wt_longstatus_print_tracking() we may conditionally show a comment
prefix based on the wt_status->display_comment_prefix flag. We handle
that by creating a local "comment_line_string" that is either the empty
string or the comment character followed by a space.

For a single-byte comment, the maximum length of this string is 2 (plus
a NUL byte). But to handle multi-byte comment characters, it can be
arbitrarily large. One way to handle this is to just call
xstrfmt("%s ", comment_line_str), and then free it when we're done.

But we can simplify things further by just conditionally switching
between our prefix string and an empty string when formatting. We
couldn't just do that with the previous code, because the comment
character was a single byte. There's no way to have a "%c" format switch
between some character and "no character at all". Whereas with "%s" you
can switch between some string and the empty string. So now that we have
a comment string and not a comment char, we can just use it directly
when formatting. Do note that we have to also conditionally add the
trailing space at the same time.

Signed-off-by: Jeff King <peff@peff.net>
---
I had hoped to clean this up as a preparatory commit, but it really is
awkward until we can make use of comment_line_str, for the reasons given
above.

 wt-status.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 084bfc584f..823e8e81b0 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1176,8 +1176,6 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	struct strbuf sb = STRBUF_INIT;
 	const char *cp, *ep, *branch_name;
 	struct branch *branch;
-	char comment_line_string[3];
-	int i;
 	uint64_t t_begin = 0;
 
 	assert(s->branch && !s->is_initial);
@@ -1202,16 +1200,11 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 		}
 	}
 
-	i = 0;
-	if (s->display_comment_prefix) {
-		comment_line_string[i++] = comment_line_char;
-		comment_line_string[i++] = ' ';
-	}
-	comment_line_string[i] = '\0';
-
 	for (cp = sb.buf; (ep = strchr(cp, '\n')) != NULL; cp = ep + 1)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s),
-				 "%s%.*s", comment_line_string,
+				 "%s%s%.*s",
+				 s->display_comment_prefix ? comment_line_str : "",
+				 s->display_comment_prefix ? " " : "",
 				 (int)(ep - cp), cp);
 	if (s->display_comment_prefix)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "%s",
-- 
2.44.0.463.g71abcb3a9f

