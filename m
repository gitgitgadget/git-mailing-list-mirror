Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A3239A056
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664694; cv=none; b=utBVE011sIrmxeCnw6jTAV0X4dlD17RABeZAslnkFEGbo5dWN0od+OTkd6k1HAW9sQp2/aS1a4sB6jApbFuuuNmN9YWGkn9QSRbPvOr5p3adukNwXZSjaQ47AT8YrToyn+diFAe2WvFAfmOljwUVlR4kIKbSd34RjCqA6VRBYSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664694; c=relaxed/simple;
	bh=g0WqAhORQ2Nxu5Jbx1mW0ggnVrdXwv6+etI9Mju8qls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puQHXcX2r3AFM63SHRgB9jfUrJucMSSQZ2Rkvm8MhCOVFT1F9oANeKw9wI4w4clHg4KF4Qs7FBDHxfUiAXEhjn+phS+aC5qWph1gEEO1QHpKs/ZzDyYz4S7vryjrBNGdgyRObfzWD9E1njDzpmm1vmuyVaaupUfaD3dFx2cxFcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XgjFmZkS; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XgjFmZkS"
Received: (qmail 70136 invoked by uid 106); 29 Sep 2026 06:51:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=g0WqAhORQ2Nxu5Jbx1mW0ggnVrdXwv6+etI9Mju8qls=; b=XgjFmZkSiS4L70w3LqI+AkvUGsIzRhh9XyFuZGr6xu7PonmyHJ9jZZeli5Cd3XMjBU3vWvn7l52BKBQs5iIQ6clCdLh9oO/820Fcymzp3MNKMMMLPf9OhkfSBNuZT6a01pRalzxvFmIwY+Dz/F+QfM3Oau+JspvJ1dcwJi+wsd0At7Q12xXLnMLZUEqiUYoxvF4Lvj79WVK2X7/yU7nrNePqCJMXoAnW2Cb29z32okpL57/Z1DtjtL4ApUNIMxjeRbswiPr200wSR6pa8iYtgWa+0bzGoo8MbOumnk8wFJFXCA3Ik8DAzxh4BDWre0MyMIAk9X4tEo+z/HH57wT5jQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2026 06:51:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 289502 invoked by uid 111); 29 Sep 2026 06:51:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Sep 2026 02:51:31 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Sep 2026 02:51:31 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/5] xdiff: clean up read_mmfile() allocations on error
Message-ID: <20260929065131.GA1697497@coredump.intra.peff.net>
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
I found this while reading the code, but never actually triggered it in
practice. It would require some way of having fopen() succeed and
fread() fail.

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
2.56.0.325.g545d7e68bc

