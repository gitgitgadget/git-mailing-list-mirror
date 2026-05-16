Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3ED1CFBA
	for <git@vger.kernel.org>; Sat, 16 May 2026 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778898193; cv=none; b=SckkOfrJ1BPxNhmbnPvlvpO8ZhEm33K39HC8/OAgOtyCefThdDvB8wTa3z6EoqtSk3TIvy0ZYpVzGoKxExHmfJTkYKBMT40g0GNzNY+pj99iKnClNndDQvjmodqcSUpg7l9L4naxWl0Qk1u3Lv6ouyuXLHUOTRtooakKwAGnizg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778898193; c=relaxed/simple;
	bh=WuCIxf4tyO1iz2GqFoliznRlOWem8TEK+sfc057ZSDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WT395G4Peufh3K6CJefbB4a7QFzipWlMWcRPnYtXDnVSLgRXwouUXrgGxAzEtb/DU7QIOGA4biRhlb/EKGrWd4aRV7aGmpF46+pFphahIT89t9ntTIenzuZCy2w8DT9zGlaVa5WlAbPCJhsZfIH+Y43ycCqSlCn7JbdL3CC2lIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LahRq+sf; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LahRq+sf"
Received: (qmail 3426 invoked by uid 106); 16 May 2026 02:23:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WuCIxf4tyO1iz2GqFoliznRlOWem8TEK+sfc057ZSDk=; b=LahRq+sfhPQUJnQw4XjN9S9pqGxGPzV3CAkidFyZcgSvhM8iIZRSLr7HHqKUCVZ1xeSKZbpkhDbgJDJVGjrVHY56lw6CC47rPn8J+hFTeXoUiTlGmSzWWNdI1R1OMcyFlXPUFZwjtMSFoG+lSvkHOViJPCMhIhDJcrta/eVxxxvyDOwlFSADusq810aaapThf1lgqFsGwldYzgGjDOAFFM2AN7T3zUMOTVBQn66OqC4jKrdg2FfVc+s4GrBgzWpht8XFfy4nGRruXnWCenGcDAm2ArIHfBR7PjCnhBrWK8iEag74IoUf4V21+42HY2qijdon8vw8gJHMlCG8cVfeWQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 May 2026 02:23:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7590 invoked by uid 111); 16 May 2026 02:23:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2026 22:23:10 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 15 May 2026 22:23:10 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH 2/2] commit: handle large commit messages in utf8 verification
Message-ID: <20260516022310.GB744303@coredump.intra.peff.net>
References: <20260516021343.GA174647@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260516021343.GA174647@coredump.intra.peff.net>

Running t4205 under UBSan with the EXPENSIVE prereq enabled triggers an
error when we try to create a commit message that is over 2GB:

  commit.c:1574:6: runtime error: signed integer overflow:
    -2147483648 - 1 cannot be represented in type 'int'

The problem is that find_invalid_utf8() is not prepared to handle
large buffers, as it uses an "int" to represent buffer sizes and
offsets.

We can fix this with a few changes:

  1. We'll take in "len" as a size_t (which is what the caller has
     anyway, since it's working with a strbuf).

  2. We need to return a size_t to give the offset to the invalid utf8,
     but we also need a sentinel value for "no invalid value"
     (previously "-1"). Let's split these to return a bool for "found
     invalid utf8" and then pass back the offset as an out-parameter.
     We'll switch the function name to match the new semantics.

  3. The caller in verify_utf8() uses a "long" to store buffer
     positions, which is a bit funny. This goes back to 08a94a145c
     (commit/commit-tree: correct latin1 to utf-8, 2012-06-28) and is
     perhaps trying to match our use of "unsigned long" for object sizes
     (though we don't care about it ever becoming negative here). This
     should be a size_t, too, as some platforms (like Windows) still use
     a 32-bit long on machines with 64-bit pointers.

  4. The "bytes" field within find_invalid_utf() does not have range
     problems. It is the number of bytes the utf8 sequence claims to
     have, so is limited by how many bits can be set in a single 8-bit
     byte. However, if we leave it as an "int" then the compiler will
     complain about the sign mismatch when comparing it to "len". So
     let's make it unsigned, too.

All of this is a little silly, of course, because 2GB text commit
messages are clearly nonsense. So we might consider rejecting them
outright, but it is easy enough to make these helper functions more
robust in the meantime.

Signed-off-by: Jeff King <peff@peff.net>
---
I tried to look carefully for any reasons why these variables could ever
be negative, but beyond the sentinel value in the return type, didn't
see one. But reviewers should double check. Note that "bad_offset =
offset-1" in the context looks suspicious, but we are guaranteed that
offset has been advanced at this point.

 commit.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/commit.c b/commit.c
index 4385ae4329..8cf09be39d 100644
--- a/commit.c
+++ b/commit.c
@@ -1558,16 +1558,16 @@ int commit_tree(const char *msg, size_t msg_len, const struct object_id *tree,
 	return result;
 }
 
-static int find_invalid_utf8(const char *buf, int len)
+static bool has_invalid_utf8(const char *buf, size_t len, size_t *bad_offset)
 {
-	int offset = 0;
+	size_t offset = 0;
 	static const unsigned int max_codepoint[] = {
 		0x7f, 0x7ff, 0xffff, 0x10ffff
 	};
 
 	while (len) {
 		unsigned char c = *buf++;
-		int bytes, bad_offset;
+		unsigned bytes;
 		unsigned int codepoint;
 		unsigned int min_val, max_val;
 
@@ -1578,7 +1578,7 @@ static int find_invalid_utf8(const char *buf, int len)
 		if (c < 0x80)
 			continue;
 
-		bad_offset = offset-1;
+		*bad_offset = offset-1;
 
 		/*
 		 * Count how many more high bits set: that's how
@@ -1595,11 +1595,11 @@ static int find_invalid_utf8(const char *buf, int len)
 		 * codepoints beyond U+10FFFF, which are guaranteed never to exist.
 		 */
 		if (bytes < 1 || 3 < bytes)
-			return bad_offset;
+			return true;
 
 		/* Do we *have* that many bytes? */
 		if (len < bytes)
-			return bad_offset;
+			return true;
 
 		/*
 		 * Place the encoded bits at the bottom of the value and compute the
@@ -1617,23 +1617,23 @@ static int find_invalid_utf8(const char *buf, int len)
 			codepoint <<= 6;
 			codepoint |= *buf & 0x3f;
 			if ((*buf++ & 0xc0) != 0x80)
-				return bad_offset;
+				return true;
 		} while (--bytes);
 
 		/* Reject codepoints that are out of range for the sequence length. */
 		if (codepoint < min_val || codepoint > max_val)
-			return bad_offset;
+			return true;
 		/* Surrogates are only for UTF-16 and cannot be encoded in UTF-8. */
 		if ((codepoint & 0x1ff800) == 0xd800)
-			return bad_offset;
+			return true;
 		/* U+xxFFFE and U+xxFFFF are guaranteed non-characters. */
 		if ((codepoint & 0xfffe) == 0xfffe)
-			return bad_offset;
+			return true;
 		/* So are anything in the range U+FDD0..U+FDEF. */
 		if (codepoint >= 0xfdd0 && codepoint <= 0xfdef)
-			return bad_offset;
+			return true;
 	}
-	return -1;
+	return false;
 }
 
 /*
@@ -1645,15 +1645,14 @@ static int find_invalid_utf8(const char *buf, int len)
 static int verify_utf8(struct strbuf *buf)
 {
 	int ok = 1;
-	long pos = 0;
+	size_t pos = 0;
 
 	for (;;) {
-		int bad;
+		size_t bad;
 		unsigned char c;
 		unsigned char replace[2];
 
-		bad = find_invalid_utf8(buf->buf + pos, buf->len - pos);
-		if (bad < 0)
+		if (!has_invalid_utf8(buf->buf + pos, buf->len - pos, &bad))
 			return ok;
 		pos += bad;
 		ok = 0;
-- 
2.54.0.490.gaeb18d0c26
