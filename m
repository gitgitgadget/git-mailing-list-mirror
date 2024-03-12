Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981FF7AE76
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235060; cv=none; b=QnznyjhHkWxhvmGhto0XOU2wY5J3isuQ4dBGoiqmTyfk5eXJ7rK66/DxOrjfefQjhEju/253OoZPa7bXVov27a9c7QxPEXboSpMCV7DsbhfEXWaZ47mIbrZjFam3NgZWFn3dvruhx6jNh0XsxXJ0ezgjvTj3u4xCpgD482NroJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235060; c=relaxed/simple;
	bh=VfYsPqlVt9M/XLybc6igCh1+5bzSNCscr4iDDx93KQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0EeN9RI7sWlXXVDBTC6vQsP8ajccQX8Ho8zYnRObbm7LFE6HHVRx8v5RXqBFMB73tbTVveYWy63IaDBF/Y1nmC8AP7rzttDsXIMoxL3OgB/JemWvl2lVN/G75nTwCTRpxDrDyvltM18iJe6eyS+tBB4I5gFnzPGVT/yu1t/Xt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17639 invoked by uid 109); 12 Mar 2024 09:17:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 09:17:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28090 invoked by uid 111); 12 Mar 2024 09:17:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 05:17:42 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 05:17:37 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 11/16] find multi-byte comment chars in NUL-terminated
 strings
Message-ID: <20240312091737.GK95609@coredump.intra.peff.net>
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
index b75d0c098d..42125e57a4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2005,7 +2005,7 @@ static int update_squash_messages(struct repository *r,
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
index 6201a97de0..8753d59f90 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1386,7 +1386,7 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 			  git_path("%s", fname));
 	}
 	while (!strbuf_getline_lf(&line, f)) {
-		if (line.len && line.buf[0] == comment_line_char)
+		if (starts_with(line.buf, comment_line_str))
 			continue;
 		strbuf_trim(&line);
 		if (!line.len)
-- 
2.44.0.481.gf1a6d20963

