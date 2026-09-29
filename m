Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBBD3CAE99
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 06:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664885; cv=none; b=TvxoK9u1P5MMHaheiHP2ELDPGq/tzmXeQ5czi64QCbbVx2z4fod/i0L+9r7P7o8V24QohU9MdnV0+hqRICookvXmbdJ71xzrTMVHeq+WZqR+vZirwLOEC2/39TW6rTnaW4z9M4CCU3/MoUkj+Hg2NjN8ueYeEbFfxLMw9AtodxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664885; c=relaxed/simple;
	bh=RI6cRC9Wg8hBg6nfwmm3zPFeNg1MsSgoaMbr/Di6uyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCqJsXePlo7dHhwWkv9lzd4VVlDhtiM8sCXWf8A9FGLRtZGbk2VvwrKurFQZGqEv74wnlr6NKJvYU7y0bYSbCknp7r6ul/YigG00Aeevqzck4erTbyUVJ7XwxtRbuDkAcjsz9ePlR11qQsFJMkBW85f8Zwu+4A0ofOwNfBbVHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=d7MaZrCX; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="d7MaZrCX"
Received: (qmail 70160 invoked by uid 106); 29 Sep 2026 06:54:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RI6cRC9Wg8hBg6nfwmm3zPFeNg1MsSgoaMbr/Di6uyg=; b=d7MaZrCXn6YDE/VmjpDeFtP+V4qOamlkUCZ/X0ukFCILfXmuOWSgvxZ1WLEkA0NZZIqik0Hqv2AaGljLK/g/tofaE23Z6BrWFa9YXFNohLDlEbCmBJ1O8Mll/dK7Sf8JpuIyT8MYlES2yA5MZuhhSBkJQyIctdqleOvIApvn+gW4Y/vY6sqsPNZr0HzoNOQrQAN0/uIGHOILgqj/u14TZ7AjtXwpm8EcgetF7WRgRPkVIREu+BC2Ti7dhLYYLQHGKnb1c+lB35sE7prfs9Vyxk51/+NR+0+9hlN9UGq3iE7ssl0IYEdXecYjcB8P4Xr0zgZijxyiw8InekzRfrTQpQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2026 06:54:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 289522 invoked by uid 111); 29 Sep 2026 06:54:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Sep 2026 02:54:42 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Sep 2026 02:54:42 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH 4/5] merge-ll: use read_mmfile() to read external merge
 results
Message-ID: <20260929065442.GD1697497@coredump.intra.peff.net>
References: <20260929064935.GA1276867@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929064935.GA1276867@coredump.intra.peff.net>

After running an external merge driver, ll_ext_merge() reads the result
back from a temporary file. We can do the same thing with much less code
by using read_mmfile().

As a bonus, note that read_mmfile() correctly uses xsize_t() to detect
the case when we'd truncate the result.

Signed-off-by: Jeff King <peff@peff.net>
---
 merge-ll.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/merge-ll.c b/merge-ll.c
index dfed6411a8..7fab7c5438 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -201,8 +201,7 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 	struct strbuf cmd = STRBUF_INIT;
 	const char *format = fn->cmdline;
 	struct child_process child = CHILD_PROCESS_INIT;
-	int status, fd, i;
-	struct stat st;
+	int status, i;
 	enum ll_merge_result ret;
 	assert(opts);
 
@@ -241,20 +240,10 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
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
-	}
- close_bad:
-	close(fd);
- bad:
+
+	/* We can ignore errors; result is left NULL/0 in that case. */
+	read_mmfile(result, temp[1]);
+
 	for (i = 0; i < 3; i++)
 		unlink_or_warn(temp[i]);
 	strbuf_release(&cmd);
-- 
2.56.0.325.g545d7e68bc

