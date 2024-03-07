Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7068183A01
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803460; cv=none; b=WSDTxgqwQ+pg2u1tIE+Ndgh2V+2jTc6JBig3K2Rx4xONaLqSMm2kputf2xNiqr4aHYWqj1gIAt+7HX9UsOsPFJkIm+hHEb+VGS344exkblB0TFV8Wojf2m9FrLVJQLJFMEKTH31l7UsPsfmAubtqf4Z4JP8oijiS6GjhIoJzm7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803460; c=relaxed/simple;
	bh=pp9ZP8ntWbKCVIScueQ85+Nxx3QM8WrJ64rzCW/qB/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6qFdN7Ec1c1fvl0LePmUkyKAScTQ+7K2JTQhAeAQMw0RN8P/geuFT5QIJN5KWBcWN/soB1KoHN8l4ZI0a8S8lRwztgOJtLaFe/CJL9dRqApdgvUgUy7IOqBvMyJ51XbRmRq5LheSMfVl5fBbqy1/vKmXF5PXBkQPozAP8yzSJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6995 invoked by uid 109); 7 Mar 2024 09:24:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 09:24:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12651 invoked by uid 111); 7 Mar 2024 09:24:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 04:24:21 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 04:24:16 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH 10/15] find multi-byte comment chars in NUL-terminated strings
Message-ID: <20240307092416.GJ2080210@coredump.intra.peff.net>
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

Several parts of the code need to identify lines that begin with the
comment character, and do so with a simple byte equality check. As part
of the transition to handling multi-byte characters, we need to match
all of the bytes. For cases where we are looking in a NUL-terminated
string, we can just use starts_with(), which checks all of the
characters in comment_line_str.

Note that we can drop the "line.len" check in wt-status.c's
read_rebase_todolist(). The starts_with() function handles the case of
an empty haystack buffer (it will always return false for a non-empty
prefix).

Signed-off-by: Jeff King <peff@peff.net>
---
I think the main way these hunks could be wrong is if the buffer is not
in fact NUL-terminated. In most cases we're working with a strbuf,
though.

 add-patch.c | 2 +-
 sequencer.c | 2 +-
 trailer.c   | 2 +-
 wt-status.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 4a10237d50..d599ca53e1 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1139,7 +1139,7 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 	for (i = 0; i < s->buf.len; ) {
 		size_t next = find_next_line(&s->buf, i);
 
-		if (s->buf.buf[i] != comment_line_char)
+		if (!starts_with(s->buf.buf + i, comment_line_str))
 			strbuf_add(&s->plain, s->buf.buf + i, next - i);
 		i = next;
 	}
diff --git a/sequencer.c b/sequencer.c
index 241e185f87..991a2dbe96 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2003,7 +2003,7 @@ static int update_squash_messages(struct repository *r,
 			return error(_("could not read '%s'"),
 				rebase_path_squash_msg());
 
-		eol = buf.buf[0] != comment_line_char ?
+		eol = !starts_with(buf.buf, comment_line_str) ?
 			buf.buf : strchrnul(buf.buf, '\n');
 
 		strbuf_addf(&header, "%s ", comment_line_str);
diff --git a/trailer.c b/trailer.c
index ef9df4af55..fe18faf6c5 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1013,7 +1013,7 @@ static void parse_trailers(struct trailer_info *info,
 	for (i = 0; i < info->trailer_nr; i++) {
 		int separator_pos;
 		char *trailer = info->trailers[i];
-		if (trailer[0] == comment_line_char)
+		if (starts_with(trailer, comment_line_str))
 			continue;
 		separator_pos = find_separator(trailer, separators);
 		if (separator_pos >= 1) {
diff --git a/wt-status.c b/wt-status.c
index b66c30775b..084bfc584f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1382,7 +1382,7 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 			  git_path("%s", fname));
 	}
 	while (!strbuf_getline_lf(&line, f)) {
-		if (line.len && line.buf[0] == comment_line_char)
+		if (starts_with(line.buf, comment_line_str))
 			continue;
 		strbuf_trim(&line);
 		if (!line.len)
-- 
2.44.0.463.g71abcb3a9f

