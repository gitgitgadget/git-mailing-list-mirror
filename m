Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4927C3126B0
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 09:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457148; cv=none; b=hCBPQNbUZbmnot8ekPEiX7jOhJq8jhr2vYu7EItaiYS/Tm7sgvEfWHJhhIUsAdGkcoanPAumsrka0tr5wNIkHrv4z5zCXhh6o+7Wy3UiRkHFBp4NS5ysTjQskDWcbpoD5pE/AwGiMvy5CiwyY1LvuNunrIWkks4ee/hFSltUACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457148; c=relaxed/simple;
	bh=f6EaXhtIxXVsvphdglDw0bXIv7DiNRoX0vXKK5ZJ1g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iokj+jtEkqmXCCD2p3EYxg2RbsYISJyHjjBZBQONsjxga/Ragb1ybKmpy2qOnds0vc+hnu94PFQclNrGyli5v1is/fvwCdXRCiDSVJnXW2HlRAdOpqMaVBkIedLpEGX19stRBkimgaHK5de8gj3kibubkxN/rnkLIKCOJ5oZIUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TNpBHs7H; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TNpBHs7H"
Received: (qmail 19804 invoked by uid 109); 18 Nov 2025 09:12:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=f6EaXhtIxXVsvphdglDw0bXIv7DiNRoX0vXKK5ZJ1g0=; b=TNpBHs7HCCX01JQZM18m+Lqya6P9Hay2C42RHcHLimu/a3hpdjPPBlG+2cvQ/MbdN/RtruQTmCWk8uwBbLow7yhAzbbTyt4EiZFKbmgLj7tV7hIPsb4MLlUSWSVSyCtLGLQSQnFI6QKxyv0ul090zIZQLqNltQ9465Y7SKpIz9wdxKFgBTm+Cf7gYfaFA6kxsn6lZS7Bl2dXQ6PHj7IPFJRvWk3OZEPvexXDvV6kmi0dcMel1r+9gULJHhYGdwC3vhmbSnuCzxfuftFpWRGL1yXH7NWtZoUDgVfdEv/CDEjuDuT+oNbRV/WsEA+9Xvx9LQx1GFFk0GBIUnpycZZj5Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 09:12:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27409 invoked by uid 111); 18 Nov 2025 09:12:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 04:12:28 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 04:12:23 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 6/9] fsck: avoid strcspn() in fsck_ident()
Message-ID: <20251118091223.GF529192@coredump.intra.peff.net>
References: <20251118091127.GA4175601@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251118091127.GA4175601@coredump.intra.peff.net>

We may be operating on a buffer that is not NUL-terminated, but we use
strcspn() to parse it. This is OK in practice, as discussed in
8e4309038f (fsck: do not assume NUL-termination of buffers, 2023-01-19),
because we know there is at least a trailing newline in our buffer, and
we always pass "\n" to strcspn(). So we know it will stop before running
off the end of the buffer.

But this is a subtle point to hang our memory safety hat on. And it
confuses ASan's strict_string_checks mode, even though it is technically
a false positive (that mode complains that we have no NUL, which is
true, but it does not know that we have verified the presence of the
newline already).

Let's instead open-code the loop. As a bonus, this makes the logic more
obvious (to my mind, anyway). The current code skips forward with
strcspn until it hits "<", ">", or "\n". But then it must check which it
saw to decide if that was what we expected or not, duplicating some
logic between what's in the strcspn() and what's in the domain logic.
Instead, we can just check each character as we loop and act on it
immediately.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/fsck.c b/fsck.c
index 8991f04943..2ee72d573d 100644
--- a/fsck.c
+++ b/fsck.c
@@ -875,18 +875,30 @@ static int fsck_ident(const char **ident, const char *ident_end,
 
 	if (*p == '<')
 		return report(options, oid, type, FSCK_MSG_MISSING_NAME_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
-	p += strcspn(p, "<>\n");
-	if (*p == '>')
-		return report(options, oid, type, FSCK_MSG_BAD_NAME, "invalid author/committer line - bad name");
-	if (*p != '<')
-		return report(options, oid, type, FSCK_MSG_MISSING_EMAIL, "invalid author/committer line - missing email");
+	for (;;) {
+		if (p >= ident_end || *p == '\n')
+			return report(options, oid, type, FSCK_MSG_MISSING_EMAIL, "invalid author/committer line - missing email");
+		if (*p == '>')
+			return report(options, oid, type, FSCK_MSG_BAD_NAME, "invalid author/committer line - bad name");
+		if (*p == '<')
+			break; /* end of name, beginning of email */
+
+		/* otherwise, skip past arbitrary name char */
+		p++;
+	}
 	if (p[-1] != ' ')
 		return report(options, oid, type, FSCK_MSG_MISSING_SPACE_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
-	p++;
-	p += strcspn(p, "<>\n");
-	if (*p != '>')
-		return report(options, oid, type, FSCK_MSG_BAD_EMAIL, "invalid author/committer line - bad email");
-	p++;
+	p++; /* skip past '<' we found */
+	for (;;) {
+		if (p >= ident_end || *p == '<' || *p == '\n')
+			return report(options, oid, type, FSCK_MSG_BAD_EMAIL, "invalid author/committer line - bad email");
+		if (*p == '>')
+			break; /* end of email */
+
+		/* otherwise, skip past arbitrary email char */
+		p++;
+	}
+	p++; /* skip past '>' we found */
 	if (*p != ' ')
 		return report(options, oid, type, FSCK_MSG_MISSING_SPACE_BEFORE_DATE, "invalid author/committer line - missing space before date");
 	p++;
-- 
2.52.0.278.gadc6434dc3

