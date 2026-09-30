Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBF94AD4C7
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811845; cv=none; b=GYzFzlp8iS4WVAKld0LyHrIWUeRFEudAqNjB7MF9kXQtRLTxBrqp1wnSyGKG7oNK5YXI/PbZ3pLaG0nOeZVqC18RgkN8bVYYSw2dB4IaDsNhrxZNiDeX6uCMg7Oyy8s8BNqnnS0aY5nX2kmstfUn1pc7O+hPD6iNQP6UgK/Kluo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811845; c=relaxed/simple;
	bh=yu57GJ5Pi+P9z0S+aTQNOao64HX/tB5izHI6Y1qxGAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szJiTGYZNMddex1lkpOJl85/8b+sb4eoGpo7R5Vh41u0Al20my9b9pykYB0TRF0OKOk344Y0zY2jyLNWsC+azrYOLes4Pcn353Xm5g0XWh75jsEV0vGLO1RImTgWVJH5XCkch/iQHcIj/RMpqxIvavmppqIIJlsMnE9E1nqyZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=R6mBpduU; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="R6mBpduU"
Received: (qmail 8153 invoked by uid 106); 30 Sep 2026 23:44:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=yu57GJ5Pi+P9z0S+aTQNOao64HX/tB5izHI6Y1qxGAU=; b=R6mBpduU/8IigxOIxmR+1DPknyzkYKL9n9GztJlWtJ5phFhuW34it0E55Tf85NIDjzbLpmuY1weY6OJduGQ7Zd3H6UIsJEiuZMYB4CeVgNDCsY4IxsV2Tp4VhfF/dmzlRQqmmPsnfl88tEemkAsYqE8jCSRMQKFHHavf3u6lEFDWk0hv57DLsCwUlTzS7VKun6CYOl28YgfYiLNCAd5XHrZX+obBPmyRI4HegPpfkYgkhM5sIQ4urhaKWJmn32EoTKxdquuFk/gMv/DeQSbXeeg0oaYqUIe/Di6oDS6bls09vlq7XkcwDmk6h10BoOu5dJuPdPPyO55zMhVykP4CNA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2026 23:44:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20816 invoked by uid 111); 30 Sep 2026 23:44:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2026 19:44:05 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 30 Sep 2026 19:44:02 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 1/7] xdiff: clean up read_mmfile() allocations on error
Message-ID: <20260930234402.GA1347555@coredump.intra.peff.net>
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

When read_mmfile() returns an error, it may or may not have allocated a
buffer in the passed-in mmfile_t. So callers must initialize the pointer
to NULL and free it even on error.

Most callers do this already, but rerere's diff_two() does not, and
would leak the buffer after a read error. We could fix it directly, but
let's instead try to make the interface less error-prone by freeing the
memory when returning failure from read_mmfile().

This fixes (part of) the leak in diff_two(). In theory it also lets us
simplify other callers to skip initializing the mmfile. But in practice
most still need zero-initialization because they may jump to free()
before even calling read_mmfile (e.g., in try_merge()). But we can at
least simplify rerere_forget_one_path() a bit.

I said "part of" earlier. There's a related leak in diff_two(): if
reading the first file succeeds but reading the second fails, we return
early and leak the first buffer. We can fix that by checking each
individually.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rerere.c  | 6 +++++-
 rerere.c          | 3 +--
 xdiff-interface.c | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index a056cb791b..d39c6e8445 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -34,8 +34,12 @@ static int diff_two(const char *file1, const char *label1,
 	mmfile_t minus, plus;
 	int ret;
 
-	if (read_mmfile(&minus, file1) || read_mmfile(&plus, file2))
+	if (read_mmfile(&minus, file1))
 		return -1;
+	if (read_mmfile(&plus, file2)) {
+		free(minus.ptr);
+		return -1;
+	}
 
 	printf("--- a/%s\n+++ b/%s\n", label1, label2);
 	fflush(stdout);
diff --git a/rerere.c b/rerere.c
index 1c3745d9e3..856347c9ae 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1039,7 +1039,7 @@ static int rerere_forget_one_path(struct index_state *istate,
 	for (id->variant = 0;
 	     id->variant < id->collection->status_nr;
 	     id->variant++) {
-		mmfile_t cur = { NULL, 0 };
+		mmfile_t cur;
 		mmbuffer_t result = {NULL, 0};
 		int cleanly_resolved;
 
@@ -1048,7 +1048,6 @@ static int rerere_forget_one_path(struct index_state *istate,
 
 		handle_cache(istate, path, hash, rerere_path(&buf, id, "thisimage"));
 		if (read_mmfile(&cur, rerere_path(&buf, id, "thisimage"))) {
-			free(cur.ptr);
 			error(_("failed to update conflicted state in '%s'"), path);
 			goto fail_exit;
 		}
diff --git a/xdiff-interface.c b/xdiff-interface.c
index db6938689f..e3dd2184ae 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -168,6 +168,7 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 	sz = xsize_t(st.st_size);
 	ptr->ptr = xmalloc(sz ? sz : 1);
 	if (sz && fread(ptr->ptr, sz, 1, f) != 1) {
+		FREE_AND_NULL(ptr->ptr);
 		fclose(f);
 		return error("Could not read %s", filename);
 	}
-- 
2.56.0.354.gb6b32d5be5

