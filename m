Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0E4492E38
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811853; cv=none; b=BnIJsKinLZ1XBhFUOBQvVZam1MS6sWpZxGgUFx4loQd53jBAF5p9h0pS8miwS0lS5qG63F3b2q/Y9ZY/67PUGk4GnMeE4tEy2W2aJSqVe9FMAq1vyUZrdJaXFsVl5evdLTgqwIvYTOviffeqaRnT/X+s1FvWID+9XQiWCxNSAk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811853; c=relaxed/simple;
	bh=zlsYXwpirP82xASjgtRJYAepK2HlTXGPe0B5HB4TLVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qcc/gougquTPrvOgvnd4Twh/TYNBcMAAQ37hqTZ7Bvl5HW/HR7ehkrTJjhZbuHCOWOCSLMPbOlpdzqQYrYPK8emUnICDSEAZk4MBoonZV7sfcsVDOaeQ0ZTdlRVQ7av4kYj2BGkz9l/XYNfJPymf/kjTyHoTzuzH6RHn1VrNws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Sri7HsVv; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Sri7HsVv"
Received: (qmail 8181 invoked by uid 106); 30 Sep 2026 23:44:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zlsYXwpirP82xASjgtRJYAepK2HlTXGPe0B5HB4TLVM=; b=Sri7HsVvLidWHEM5Bli570Z2sQIL/UPvS2ADB/jF2Ysy21kVZMZrUDQPwMLq56ckUBiihaK90XeZ1MvYdw0ey5s435XGCyPohRLpX65b7aME/oFFevowUXsjHagZxzm+Yi0uZIp0vn/2cdFi61c3pI8jk8zS2W+GU5CumH1twM14WYACt9kgoUQg5K4zmb79Dhm4fxcWjZ5ZrKTJJn+FVBqXjqbiC3ThHa1CjZ6L1W8X9AVQWpoMVITDML7mU1C4ppZBwwmHJDJo4Entg6eNhyzQ5reJpbv1E64XBZVpEbld/XJdIwddpkF6GA8CT69eWykVGh9huY6wqP4czyY0aQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2026 23:44:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20834 invoked by uid 111); 30 Sep 2026 23:44:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2026 19:44:13 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 30 Sep 2026 19:44:10 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 3/7] xdiff: use size_t for buffer sizes
Message-ID: <20260930234410.GC1347555@coredump.intra.peff.net>
References: <20260930234348.GA1340390@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930234348.GA1340390@coredump.intra.peff.net>

An mmfile_t stores its size as a signed long, but the more natural type
for a buffer size is size_t. This not only limits the size of entry we
can hold, but also creates some possible integer overflow issues.

For example, read_mmfile() checks that the file size fits in a size_t
before allocating, but then assigns it to a long. Likewise,
read_mmblob() and fill_mmfile() copy sizes from other types without
checking that they fit.

On LP64 systems like Linux, this is mostly academic. You could wrap to a
negative long value, but you'd need an object that's 2^63 bytes, which
is impractical.

But on an LLP64 system like Windows, a 2^31+1-byte blob could perhaps
cause mischief. We do prevent large values from entering the xdiff code
due to MAX_XDIFF_SIZE (which is itself marked as unsigned, so we'd
convert any negative "long" back to a large unsigned value). But if you
ask for binary diffs, that negative long value could instead be
converted to a huge 64-bit size_t when passed to memcmp(), diff_delta(),
etc. So probably there are paths that can cause an out-of-bounds read,
given the right set of options, but I didn't really dig for them.

On a 32-bit system things are less clear. Because "long" and "size_t"
have the same width, any time we implicitly convert to size_t, we should
get back the original size (even if the intermediate "long" is itself
negative). Probably iterating using a long could be a problem, but most
of that happens inside xdiff, which is protected by MAX_XDIFF_SIZE
(which, again, compares in the unsigned space).

Let's just use the obvious size_t type for counting the bytes. I suspect
you could still find truncation problems on LLP64 systems due to the use
of "unsigned long" throughout the code, but that's a larger problem.
This should at least nudge us in the right direction.

Note that we have to update the printf format in emit_binary_diff_body()
to accommodate the new type. Curiously it was using "%lu", even though
the type was signed (I guess compiler printf-linting is happy enough if
just the width of the format and the type match).

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c        | 2 +-
 xdiff/xdiff.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 414532d09f..b4ac17f8ef 100644
--- a/diff.c
+++ b/diff.c
@@ -3646,7 +3646,7 @@ static void emit_binary_diff_body(struct diff_options *o,
 		data = delta;
 		data_size = delta_size;
 	} else {
-		char *s = xstrfmt("%lu", two->size);
+		char *s = xstrfmt("%"PRIuMAX, (uintmax_t)two->size);
 		emit_diff_symbol(o, DIFF_SYMBOL_BINARY_DIFF_HEADER_LITERAL,
 				 s, strlen(s), 0);
 		free(s);
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 334eb436f6..8fa513fc4e 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -70,7 +70,7 @@ extern "C" {
 
 typedef struct s_mmfile {
 	char *ptr;
-	long size;
+	size_t size;
 } mmfile_t;
 
 typedef struct s_xpparam {
-- 
2.56.0.354.gb6b32d5be5

