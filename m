Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BB378266
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235063; cv=none; b=KInAui4g7lx6yrEhhwXuAz9vQ/W/tuN3qUXRulXvwBw+dQBQEHQb0bR7uzwC7cgiFEzDYNxorvVcMDdQ1svuFUNyilPZNuT7HXT/7lJUC0Q6KVdDZ9doT8oZcyqHkuZ08wIF2OByos/iVCydNpH8HieT7Kj//bJYbn1cHX/luQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235063; c=relaxed/simple;
	bh=c87M49c+2VzVU0Zz4IkcYfQbsjD8YDglBPqfQItAgEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3WvY4AKToseMCYqVB68f7peGHJ+JIr9DMqA/jd3TakxO/nhm8LRiW8vvM8p5XMZCQXbG14RLb2zuoSphMzgiFpLzha3QKDKDOhcbERD2k1g7ebxK+yO1u5EB08n6CKzuj01ARUJRpHmK4TvYVPspH6JTQfio+oJfvnz6hGIFsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17665 invoked by uid 109); 12 Mar 2024 09:17:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 09:17:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28099 invoked by uid 111); 12 Mar 2024 09:17:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 05:17:45 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 05:17:39 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 12/16] find multi-byte comment chars in unterminated
 buffers
Message-ID: <20240312091739.GL95609@coredump.intra.peff.net>
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

As with the previous patch, we need to swap out single-byte matching for
something like starts_with() to match all bytes of a multi-byte comment
character. But for cases where the buffer is not NUL-terminated (and we
instead have an explicit size or end pointer), it's not safe to use
starts_with(), as it might walk off the end of the buffer.

Let's introduce a new starts_with_mem() that does the same thing but
also accepts the length of the "haystack" str and makes sure not to walk
past it.

Note that in most cases the existing code did not need a length check at
all, since it was written in a way that knew we had at least one byte
available (and that was all we checked). So I had to read each one to
find the appropriate bounds. The one exception is sequencer.c's
add_commented_lines(), where we can actually get rid of the length
check. Just like starts_with(), our starts_with_mem() handles an empty
haystack variable by not matching (assuming a non-empty prefix).

A few notes on the implementation of starts_with_mem():

  - it would be equally correct to take an "end" pointer (and indeed,
    many of the callers have this and have to subtract to come up with
    the length). I think taking a ptr/size combo is a more usual
    interface for our codebase, though, and has the added benefit that
    the function signature makes it harder to mix up the three
    parameters.

  - we could obviously build starts_with() on top of this by passing
    strlen(str) as the length. But it's possible that starts_with() is a
    relatively hot code path, and it should not pay that penalty (it can
    generally return an answer proportional to the size of the prefix,
    not the whole string).

  - it naively feels like xstrncmpz() should be able to do the same
    thing, but that's not quite true. If you pass the length of the
    haystack buffer, then strncmp() finds that a shorter prefix string
    is "less than" than the haystack, even if the haystack starts with
    the prefix. If you pass the length of the prefix, then you risk
    reading past the end of the haystack if it is shorter than the
    prefix. So I think we really do need a new function.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c    |  3 ++-
 sequencer.c |  4 ++--
 strbuf.c    | 11 +++++++++++
 strbuf.h    |  1 +
 trailer.c   |  4 ++--
 5 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index 467be9f7f9..9cfbe9d657 100644
--- a/commit.c
+++ b/commit.c
@@ -1797,7 +1797,8 @@ size_t ignored_log_message_bytes(const char *buf, size_t len)
 		else
 			next_line++;
 
-		if (buf[bol] == comment_line_char || buf[bol] == '\n') {
+		if (starts_with_mem(buf + bol, cutoff - bol, comment_line_str) ||
+		    buf[bol] == '\n') {
 			/* is this the first of the run of comments? */
 			if (!boc)
 				boc = bol;
diff --git a/sequencer.c b/sequencer.c
index 42125e57a4..ef84832855 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1842,7 +1842,7 @@ static int is_fixup_flag(enum todo_command command, unsigned flag)
 static void add_commented_lines(struct strbuf *buf, const void *str, size_t len)
 {
 	const char *s = str;
-	while (len > 0 && s[0] == comment_line_char) {
+	while (starts_with_mem(s, len, comment_line_str)) {
 		size_t count;
 		const char *n = memchr(s, '\n', len);
 		if (!n)
@@ -2564,7 +2564,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	/* left-trim */
 	bol += strspn(bol, " \t");
 
-	if (bol == eol || *bol == '\r' || *bol == comment_line_char) {
+	if (bol == eol || *bol == '\r' || starts_with_mem(bol, eol - bol, comment_line_str)) {
 		item->command = TODO_COMMENT;
 		item->commit = NULL;
 		item->arg_offset = bol - buf;
diff --git a/strbuf.c b/strbuf.c
index 7c8f582127..291bdc2a65 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -24,6 +24,17 @@ int istarts_with(const char *str, const char *prefix)
 			return 0;
 }
 
+int starts_with_mem(const char *str, size_t len, const char *prefix)
+{
+	const char *end = str + len;
+	for (; ; str++, prefix++) {
+		if (!*prefix)
+			return 1;
+		else if (str == end || *str != *prefix)
+			return 0;
+	}
+}
+
 int skip_to_optional_arg_default(const char *str, const char *prefix,
 				 const char **arg, const char *def)
 {
diff --git a/strbuf.h b/strbuf.h
index 58dddf2777..3156d6ea8c 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -673,6 +673,7 @@ char *xstrfmt(const char *fmt, ...);
 
 int starts_with(const char *str, const char *prefix);
 int istarts_with(const char *str, const char *prefix);
+int starts_with_mem(const char *str, size_t len, const char *prefix);
 
 /*
  * If the string "str" is the same as the string in "prefix", then the "arg"
diff --git a/trailer.c b/trailer.c
index fe18faf6c5..fdb0b8137e 100644
--- a/trailer.c
+++ b/trailer.c
@@ -882,7 +882,7 @@ static size_t find_trailer_block_start(const char *buf, size_t len)
 
 	/* The first paragraph is the title and cannot be trailers */
 	for (s = buf; s < buf + len; s = next_line(s)) {
-		if (s[0] == comment_line_char)
+		if (starts_with_mem(s, buf + len - s, comment_line_str))
 			continue;
 		if (is_blank_line(s))
 			break;
@@ -902,7 +902,7 @@ static size_t find_trailer_block_start(const char *buf, size_t len)
 		const char **p;
 		ssize_t separator_pos;
 
-		if (bol[0] == comment_line_char) {
+		if (starts_with_mem(bol, buf + len - bol, comment_line_str)) {
 			non_trailer_lines += possible_continuation_lines;
 			possible_continuation_lines = 0;
 			continue;
-- 
2.44.0.481.gf1a6d20963

