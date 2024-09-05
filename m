Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB815B541
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524879; cv=none; b=lSwRu3VsC8/C0e3WaIvNasuAms2vpeczWypfXUD4nHI1kCrRFd78ZIM4KAEzhet8J3tVybQVG+ax2vc1rBTH+xA16I0YD7MUwp9dowJUV8YImQYAdnJr8FJwEeSXpFmT6lT4zFnCRGAN2JZXlpOawZxD253Uht9az8oIaQx3Lss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524879; c=relaxed/simple;
	bh=NpLy9YVh7xXRKMyAvr3qv8QRbJPnz7Ut+qIonrHdRY8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uXnsnyMX7tA1BsFNSD8LFvxkgNrYeDB9r6P1b+8rJkb71QSlKpmaAY4GRuPry1gsdLwITouUQLVWfbeZppO8432xnQk01kCK6UPhT5hjJR1xcwW1uE/5JQ5bs2Qqt7y35Qzp4aD4Rrs2C8cYWn+WdRcocRcwAlPU78jmkb5Fa08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5746 invoked by uid 109); 5 Sep 2024 08:27:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Sep 2024 08:27:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6916 invoked by uid 111); 5 Sep 2024 08:27:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2024 04:27:51 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Sep 2024 04:27:49 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] sparse-checkout: use fdopen_lock_file() instead of xfdopen()
Message-ID: <20240905082749.GA88220@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

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
    the file into place. Let's likewise report when committing the lock
    fails (rather than quietly returning success from the command).

  - we can get rid of the local "fd" variable, since we never look at it
    ourselves now

Signed-off-by: Jeff King <peff@peff.net>
---
Curiously, this is not reported as a leak by LSan, and it is included in
the "reachable" set by valgrind. I imagine this is because libc has to
maintain a list of open writable handles, since fflush(NULL) is supposed
to flush all of them. I peeked at other fdopen(..., "w") calls to see if
there were other similar spots, but didn't notice any.

I found this because I was building git on an Android system, and they
have an "fdsan" that complains when the underlying descriptor of a
handle is closed. It flagged some other spots, too, but the rest that I
looked at involved the tempfile atexit() handler closing the descriptors
manually (we don't care about flushing there, as our goal is to just
prevent the "can't delete an open file" problem on Windows).

 builtin/sparse-checkout.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 2604ab04df..f1bd31b2f7 100644
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
 	free(sparse_filename);
 
 	result = update_working_directory(pl);
@@ -348,15 +346,17 @@ static int write_patterns_and_update(struct pattern_list *pl)
 		return result;
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
-	commit_lock_file(&lk);
+	if (commit_lock_file(&lk))
+		die_errno(_("unable to write %s"), get_locked_file_path(&lk));
 
 	clear_pattern_list(pl);
 
-- 
2.46.0.802.g13da1a47c4
