Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21D47C091
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235068; cv=none; b=JXieBKz3uBQPpDOkYYqyme0K1lDOFrqPbWsqyaX2YqqPVTejdR0TzUh9kJbfCGr2lBIwacQmzAs5AKFGTHjcPCipDG/jOW9WEd4MTebdF99N59zrpyY+WTDpivi8TBP0m/ntMz0lvofP6wl3EvWyPcI4nlhiKdca/Sb7NzDeUVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235068; c=relaxed/simple;
	bh=KrC1XlpYbdGd2krGdt6YFQBmnXkjOs4kms8aFvw/Xlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fh7jFWLbbApdZ9LRfQr+N0Afu6NJa5M6rlFrFKvHfX2X3WcACCifWrAKQDhQGtTYvZm9dlzwOKK4ifpdPxHAm+/0UDt10H7EW9KGaYFbAgUjyjqFmm9/MucDoEx+FDKuZ0EMWYJJLTzZL2gEXtoyOHdA5+NCqqNV75j+L8OUcDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17703 invoked by uid 109); 12 Mar 2024 09:17:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 09:17:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28117 invoked by uid 111); 12 Mar 2024 09:17:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 05:17:50 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 05:17:45 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 14/16] wt-status: drop custom comment-char stringification
Message-ID: <20240312091745.GN95609@coredump.intra.peff.net>
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
 wt-status.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 8753d59f90..7217ff30c5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1180,8 +1180,6 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	struct strbuf sb = STRBUF_INIT;
 	const char *cp, *ep, *branch_name;
 	struct branch *branch;
-	char comment_line_string[3];
-	int i;
 	uint64_t t_begin = 0;
 
 	assert(s->branch && !s->is_initial);
@@ -1206,16 +1204,11 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
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
2.44.0.481.gf1a6d20963

