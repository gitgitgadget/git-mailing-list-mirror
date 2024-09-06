Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4683A41
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 03:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725594524; cv=none; b=vAdz2rvRb11PGRWdJvP4VBAm0VwK+Aa6SWmJwjtdJmFHiHuHH01oXwRyb757eRGXMqfIEe/KWF/zjcSFUe9N2uwh53r2RJsKdOw277xO1VUhtDvKUEpbfRmvt+uGtXa5jI1lLOlr6Qzbt5nOFzeskPYm2XO3SNR5lj1SDVU+em8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725594524; c=relaxed/simple;
	bh=1RItVDw3+16H6+CjyuTePvAs6dY70+QCZvAXpTOm8qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KW3oqP2T77wuyE5xlk4s/tx9p2+0NlHqHw8Ysc6oP7ZA+uXvZMrGZGV9naXNMK8pWT/ESonf2AAtagQwVrNL+D4VBfMsEdkZUzfiI/9rDjjlm0OI9BUwL8i6Q4vCY/mbTy9VPXcubBtgKyw9INQWy67wLr22v+tJC3moiSvcKTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15239 invoked by uid 109); 6 Sep 2024 03:48:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Sep 2024 03:48:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16366 invoked by uid 111); 6 Sep 2024 03:48:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2024 23:48:41 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Sep 2024 23:48:41 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] sparse-checkout: use fdopen_lock_file() instead of
 xfdopen()
Message-ID: <20240906034841.GC4168362@coredump.intra.peff.net>
References: <20240906034557.GA3693911@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240906034557.GA3693911@coredump.intra.peff.net>

When updating sparse patterns, we open a lock_file to write out the new
data. The lock_file struct holds the file descriptor, but we call
fdopen() to get a stdio handle to do the actual write.

After we finish writing, we fflush() so that all of the data is on disk,
and then call commit_lock_file() which closes the descriptor. But we
never fclose() the stdio handle, leaking it.

The obvious solution seems like it would be to just call fclose(). But
when? If we do it before commit_lock_file(), then the lock_file code is
left thinking it owns the now-closed file descriptor, and will do an
extra close() on the descriptor. But if we do it before, we have the
opposite problem: the lock_file code will close the descriptor, and
fclose() will do the extra close().

We can handle this correctly by using fdopen_lock_file(). That leaves
ownership of the stdio handle with the lock_file, which knows not to
double-close it.

We do have to adjust the code a bit:

  - we have to handle errors ourselves; we can just die(), since that's
    what xfdopen() would have done (and we can even provide a more
    specific error message).

  - we no longer need to call fflush(); committing the lock-file
    auto-closes it, which will now do the flush for us. As a bonus, this
    will actually check that the flush was successful before renaming
    the file into place.

  - we can get rid of the local "fd" variable, since we never look at it
    ourselves now

Signed-off-by: Jeff King <peff@peff.net>
---
I left this error message using get_lock_file_path(&lk), which is still
valid, and is arguably correct than sparse_filename.

 builtin/sparse-checkout.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index b5e220cc44..5ccf696862 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -327,7 +327,6 @@ static int write_patterns_and_update(struct pattern_list *pl)
 {
 	char *sparse_filename;
 	FILE *fp;
-	int fd;
 	struct lock_file lk = LOCK_INIT;
 	int result;
 
@@ -336,8 +335,7 @@ static int write_patterns_and_update(struct pattern_list *pl)
 	if (safe_create_leading_directories(sparse_filename))
 		die(_("failed to create directory for sparse-checkout file"));
 
-	fd = hold_lock_file_for_update(&lk, sparse_filename,
-				      LOCK_DIE_ON_ERROR);
+	hold_lock_file_for_update(&lk, sparse_filename, LOCK_DIE_ON_ERROR);
 
 	result = update_working_directory(pl);
 	if (result) {
@@ -346,14 +344,15 @@ static int write_patterns_and_update(struct pattern_list *pl)
 		goto out;
 	}
 
-	fp = xfdopen(fd, "w");
+	fp = fdopen_lock_file(&lk, "w");
+	if (!fp)
+		die_errno(_("unable to fdopen %s"), get_lock_file_path(&lk));
 
 	if (core_sparse_checkout_cone)
 		write_cone_to_file(fp, pl);
 	else
 		write_patterns_to_file(fp, pl);
 
-	fflush(fp);
 	if (commit_lock_file(&lk))
 		die_errno(_("unable to write %s"), sparse_filename);
 
-- 
2.46.0.802.g13da1a47c4
