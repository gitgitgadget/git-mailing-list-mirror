Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B315D4AF9D7
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 23:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811859; cv=none; b=Fg+/jeR3IJKzyrn1cNKHoZ6uF02vt+DS2ZcHP3fXNdFBj6WAk/WPCJVpwxhjgONii8t4N9Pn6UufuTj6EVW7+lOHxmna4XmLle4moCSO2HcC7fywQetGYAX05axuwWgj2Qrff6qG/eS6YIHFvln2qZlr21oT9PWjnPShK+PMppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811859; c=relaxed/simple;
	bh=6dJmFXT6u9G5Eg7eiqeEioOPGVmcW9Y6QVyTDG2gnyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqxg0QfLlEFpFn7YG7Dx+Ti6HGj02tl7XZhdBGhiCROAMzBH1W2wk5BX/URQOldK5+yOAKQh73gmkMJfUpjMYCoEBd5d9KUQQAk5PZh+lbaVVD/QDcQf+Zz5pUmDjHAHpfSIvUVK2Xv9N3GhYm7JIVUPHNOnWv5e/ZaDWHweUUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XZOjVqXE; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XZOjVqXE"
Received: (qmail 8207 invoked by uid 106); 30 Sep 2026 23:44:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6dJmFXT6u9G5Eg7eiqeEioOPGVmcW9Y6QVyTDG2gnyI=; b=XZOjVqXETuJytO1p4jq+KzC73YmpxrYA8zxh74LEcUHtwBN9a2bN2yWhfgtQr4vaHyTcoLDzZb47ltVKjvHNG4giR+uHfz4owFW4aefq3N5al0AV2aqSNjd4Yxw7QUrShCs1Z5opHvfWdlhmkXhJZpLdQz+QQbrYz1NUtLxA1V12UGaZyjfuNwdgsvjydOVETaS4mn2RRJ94kUlMKVA9jzkNAFVelndC8bcCaLLKKenmytRjINFHDo9INIoQoXYWHlo5sU2b6zI11EedglWtpjBAdBP//FAoodEhL/VdlPenaJf6X5QAMdM1UjC+4d/9Gqd0JcUJ0X8xfrtGuuOOMg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2026 23:44:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20846 invoked by uid 111); 30 Sep 2026 23:44:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2026 19:44:19 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 30 Sep 2026 19:44:16 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 5/7] merge-ll: use read_mmfile() to read external merge
 results
Message-ID: <20260930234416.GE1347555@coredump.intra.peff.net>
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

After running an external merge driver, ll_ext_merge() reads the result
back from a temporary file. We can do the same thing with much less code
by using read_mmfile().

There are also two behavior improvements.

One, read_mmfile() correctly uses xsize_t() to detect the case when we'd
truncate the result.

And two, read_mmfile() will report errors to stderr if it can't read the
file (whereas the existing code silently returned NULL). I think most
callers would have said _something_ in this case like "failed to execute
merge" (from merge-ort), but more specifics are probably helpful (e.g.,
to distinguish a random system error from a badly configured merge
driver).

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
2.56.0.354.gb6b32d5be5

