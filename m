Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEF62D97B5
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934772; cv=none; b=C70MiLf9U3JVsizYPDrRWBigQQfcIaz5OnFwwpn0Q2kDxd4ckcaLtVXBIxoifOA5nmju2jpfzXpfyQdVuU1ADipxf0e4urdPn5CvHEZJBEYpTx99LtjNuT+5QsUfV4U4lh70w6/+dqmcsVNJLSKVwuq8oWGZQh/gL7Riw4u1SHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934772; c=relaxed/simple;
	bh=UJhtGyyoULVhKen0WvLBrhJTf49gzMgEoKLeBbj4oSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mm8b//Y3J4XEEjQP+wjf8oMdDeoK1wKoaGMvlUDDkq8Yuv8tlyZHMi+q/nuAUuGqI6L3OF0qeietWTboCmriBx6i8gQXEyIrRFhKVknHxo0LXVpal5WVNGwK37jbc/4zcSo3FVuuF9caOXUOu57OvHxGj59xfuhHn3kH5BcEAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gwifY6Kj; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gwifY6Kj"
Received: (qmail 495391 invoked by uid 109); 12 Nov 2025 08:06:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=UJhtGyyoULVhKen0WvLBrhJTf49gzMgEoKLeBbj4oSw=; b=gwifY6KjV3C0EUPu4/Qh4h1aP5Q0NMKdG3tw/asR3Bif+fwzy4XGTmiBr391THl4BfZ11L/akEAUCrb99YwNGBrZd8kEtoy2ePQARvX5LSLvt41QkSYRMmuz63AG44IDHMsLAZt493I5aPLBM58ZMpmUusLGnsGwInR113uPQ69J2l/V76lhuzbYA2nwmrpV7n/2K0Et0KG71lSBMC/BYEup8fA/7x7VAZydHdiMPg7VHsMt13938PO02DHaSdx9liGzmDjAsDUulua3/Wn5Icmt8ZBqcDEzBTcPP8YxfWCvHJiY0E3VpZCQWgoifqhE3buwFHNELu8W5kdZTAsetQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Nov 2025 08:06:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 786399 invoked by uid 111); 12 Nov 2025 08:06:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Nov 2025 03:06:10 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Nov 2025 03:06:09 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: correctmost <cmlists@sent.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 5/9] fsck: assert newline presence in fsck_ident()
Message-ID: <20251112080609.GE979063@coredump.intra.peff.net>
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

The fsck code purports to handle buffers that are not NUL-terminated,
but fsck_ident() uses some string functions. This works OK in practice,
as explained in 8e4309038f (fsck: do not assume NUL-termination of
buffers, 2023-01-19). Before calling fsck_ident() we'll have called
verify_headers(), which makes sure we have at least a trailing newline.
And none of our string-like functions will walk past that newline.

However, that makes this code at the top of fsck_ident() very confusing:

    *ident = strchrnul(*ident, '\n');
    if (**ident == '\n')
            (*ident)++;

We should always see that newline, or our memory safety assumptions have
been violated! Further, using strchrnul() is weird, since the whole
point is that if the newline is not there, we don't necessarily have a
NUL at all, and might read off the end of the buffer.

So let's have callers pass in the boundary of our buffer, which lets us
safely find the newline with memchr(). And if it is not there, this is a
BUG(), because it means our caller did not validate the input with
verify_headers() as it was supposed to (and we are better off bailing
rather than having memory-safety problems).

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fsck.c b/fsck.c
index 341e100d24..8991f04943 100644
--- a/fsck.c
+++ b/fsck.c
@@ -860,16 +860,18 @@ static int verify_headers(const void *data, unsigned long size,
 		FSCK_MSG_UNTERMINATED_HEADER, "unterminated header");
 }
 
-static int fsck_ident(const char **ident,
+static int fsck_ident(const char **ident, const char *ident_end,
 		      const struct object_id *oid, enum object_type type,
 		      struct fsck_options *options)
 {
 	const char *p = *ident;
+	const char *nl;
 	char *end;
 
-	*ident = strchrnul(*ident, '\n');
-	if (**ident == '\n')
-		(*ident)++;
+	nl = memchr(p, '\n', ident_end - p);
+	if (!nl)
+		BUG("verify_headers() should have made sure we have a newline");
+	*ident = nl + 1;
 
 	if (*p == '<')
 		return report(options, oid, type, FSCK_MSG_MISSING_NAME_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
@@ -958,7 +960,7 @@ static int fsck_commit(const struct object_id *oid,
 	author_count = 0;
 	while (buffer < buffer_end && skip_prefix(buffer, "author ", &buffer)) {
 		author_count++;
-		err = fsck_ident(&buffer, oid, OBJ_COMMIT, options);
+		err = fsck_ident(&buffer, buffer_end, oid, OBJ_COMMIT, options);
 		if (err)
 			return err;
 	}
@@ -970,7 +972,7 @@ static int fsck_commit(const struct object_id *oid,
 		return err;
 	if (buffer >= buffer_end || !skip_prefix(buffer, "committer ", &buffer))
 		return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
-	err = fsck_ident(&buffer, oid, OBJ_COMMIT, options);
+	err = fsck_ident(&buffer, buffer_end, oid, OBJ_COMMIT, options);
 	if (err)
 		return err;
 	if (memchr(buffer_begin, '\0', size)) {
@@ -1065,7 +1067,7 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 			goto done;
 	}
 	else
-		ret = fsck_ident(&buffer, oid, OBJ_TAG, options);
+		ret = fsck_ident(&buffer, buffer_end, oid, OBJ_TAG, options);
 
 	if (buffer < buffer_end && (skip_prefix(buffer, "gpgsig ", &buffer) || skip_prefix(buffer, "gpgsig-sha256 ", &buffer))) {
 		eol = memchr(buffer, '\n', buffer_end - buffer);
-- 
2.52.0.rc1.260.g3e4993586f

