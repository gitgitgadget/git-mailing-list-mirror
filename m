Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9547229B793
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934802; cv=none; b=SgZZu4aVycnxpZ6Y9OAXi9dqI9bEM2yaF/Np20K/2Xj30tmEYAL8kHgZs7tEQQnfznzXMfiNiup3Yrm7n+K7S8pIFIEuDySA1V1f/NOeNRe/3weWmwBwLbIfKpEvN0+y3PhKImLz/D3ZXcLwSY6/sjic9rEQmIknjbN1Ka24oag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934802; c=relaxed/simple;
	bh=mGMfIefrSVBZv5FX61IL5HTgRX4xTAXpXD2QXxZkFNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgVXxPon8YLWNByI+5WqYmufCtibIiswRadtJ+nGppHW5mKrJw7P/BZAs+xRLQNgILXHFuXjmYQ8mfUSMP4JwDhH1FVac7MW7gF4oruu0ExVd2R6vzb3o8LKJQnIkrIHATkbyXfn1pAna57gnuuRCDfjXIhuTbjjtiGnQSh6wQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Pb8/F0QC; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Pb8/F0QC"
Received: (qmail 495401 invoked by uid 109); 12 Nov 2025 08:06:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mGMfIefrSVBZv5FX61IL5HTgRX4xTAXpXD2QXxZkFNg=; b=Pb8/F0QC9pB7MVEYJDdcBrQGa8F3h8rvkFdne2hWAbuLXxzQzejAqhcawJU2qvR7WChVlq6yO/K0cDAmnnBv38LNbH/XRHfu8Hkm0WcCa5k6CPf7yt1jZ30/lQ7uyPktbFKOR39EpaDIPISa6avTKlRoMMeHZnAvzCXnL0iXXMDpkYpbjvxKmF14mQ2lpSmSPk4WhZs1oqig9tL2MNcs2GITZTLv6PaSpHHifntQRvWM/P7ztsYpqrya8ukBAT9wu9SV+fWDFNqJsOD4e8j19MwoBOZzTU7qzkr5jKBesmLrG2cQnkQ2jQbP8O4DQDRA/lWrAr+mBYVdd3AhCr73bQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Nov 2025 08:06:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 786414 invoked by uid 111); 12 Nov 2025 08:06:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Nov 2025 03:06:39 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Nov 2025 03:06:39 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: correctmost <cmlists@sent.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 6/9] fsck: avoid strcspn() in fsck_ident()
Message-ID: <20251112080639.GF979063@coredump.intra.peff.net>
References: <20251112075522.GA978866@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112075522.GA978866@coredump.intra.peff.net>

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
2.52.0.rc1.260.g3e4993586f

