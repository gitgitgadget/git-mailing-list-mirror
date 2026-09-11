Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F326537A827
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146689; cv=none; b=Hww+NEogn0TbtkvEW1Qu9JBSiTSPLhyCEEvGf1ctDZOYyxXVG9Fd04Xq1C1UvmUYE29MuZ1QN6E2SDaV9xM7ze8jyfBDJ20V3cX+xbuwDHVoPMNzE1292IeC62Lb06MB2jvHYVyNaoA/6UbZBOdwWgXzWXHDBNxF7BemSBEBmKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146689; c=relaxed/simple;
	bh=LD+oK7rpfGkJDWrIkmhMFws5aUKfZHpUpkPesdHgauk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdkM1uGZHqRLNunJsrcdDerqsRinakrBqKBnY0dEz7IOMWnou3ohXC3taOFZc8pM1nYpe96CMGpxRpgjioFDEaPSa3hIGZ5v7o2an6owZoJaOwQdZyXPJTWWxqO6OiG2SskPPUlYGRZ2lnYRPiQDFJmfKz2MwulRFbOlaeIG7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IXXL1Lte; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IXXL1Lte"
Received: (qmail 34645 invoked by uid 106); 11 Sep 2026 17:11:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LD+oK7rpfGkJDWrIkmhMFws5aUKfZHpUpkPesdHgauk=; b=IXXL1LterMBgzJ1+Ou0ZngP+NP9xTufJdMzfhDFv7Z8mHx6yx1ygb92/P5yEUZr3tDOAmlSAOrJf+WczCq9Yf5C7yG7Ag+UeK/DvK1ylzdb/r6kLBUzW4T4urkkTVg+zcTcmO1Xkt4jgRJ6CX2nSiALLuPaBeK3bCMFgYUCtVX+rcq9vbaTUmfjcbUBvHhdGrmnJGz1KpEP1qknZ27I+wGrRbS08KDTljA8s3JoWITF0O1NZgyndkQgkkrYjMQ6Rx7qvrp8L8UHoMwbXrs6tAQe2J8BlBd1OdeScbjfLF0q3/S7dD+aNyXLBeuRxUDrJ3f5OvNINY1k9qKStxfhmuw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Sep 2026 17:11:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 173821 invoked by uid 111); 11 Sep 2026 17:11:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Sep 2026 13:11:25 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 11 Sep 2026 13:11:24 -0400
From: Jeff King <peff@peff.net>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: git@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
	Elijah Newren <newren@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 1/3] merge-ll: use strbuf to read back external merge
 result
Message-ID: <20260911171124.GA1610200@coredump.intra.peff.net>
References: <20260911171044.GA1609692@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260911171044.GA1609692@coredump.intra.peff.net>

After the external merge runs, we read the file back into a heap buffer.
This ancient code does it by hand, but these days we can make the code
shorter and less error prone by using strbuf_read_file().

It's not quite a one-liner replacement, because we have to copy the
pointer and size into an mmbuffer_t. Two things to note there:

  1. We can't just pass result->size to strbuf_detach(), since the
     former uses long instead of size_t (something that we'd ideally fix
     in the long run, but is way out of scope here).

  2. We can leave result untouched on error; we zero it at the top of
     the function (confusingly we may still return LL_MERGE_OK and a
     NULL result if we hit an I/O error, but that is how the function
     has always behaved, and callers know to check for NULL).

Signed-off-by: Jeff King <peff@peff.net>
---
Not strictly needed for the rest of the series, but it felt like a
cleanup worth doing, and it conflicts textually.

 merge-ll.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/merge-ll.c b/merge-ll.c
index ef5287dee8..5b6af15e23 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -201,8 +201,8 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 	struct strbuf cmd = STRBUF_INIT;
 	const char *format = fn->cmdline;
 	struct child_process child = CHILD_PROCESS_INIT;
-	int status, fd, i;
-	struct stat st;
+	int status, i;
+	struct strbuf result_buf = STRBUF_INIT;
 	enum ll_merge_result ret;
 	assert(opts);
 
@@ -241,20 +241,12 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 	child.use_shell = 1;
 	strvec_push(&child.args, cmd.buf);
 	status = run_command(&child);
-	fd = open(temp[1], O_RDONLY);
-	if (fd < 0)
-		goto bad;
-	if (fstat(fd, &st))
-		goto close_bad;
-	result->size = st.st_size;
-	result->ptr = xmallocz(result->size);
-	if (read_in_full(fd, result->ptr, result->size) != result->size) {
-		FREE_AND_NULL(result->ptr);
-		result->size = 0;
+
+	if (strbuf_read_file(&result_buf, temp[1], 0) >= 0) {
+		result->size = result_buf.len;
+		result->ptr = strbuf_detach(&result_buf, NULL);
 	}
- close_bad:
-	close(fd);
- bad:
+
 	for (i = 0; i < 3; i++)
 		unlink_or_warn(temp[i]);
 	strbuf_release(&cmd);
-- 
2.56.0.rc0.314.g7a874b6915

