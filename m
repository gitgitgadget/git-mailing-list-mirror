Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5C03CF213
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979067; cv=none; b=AQse/S7+EkjirXgkfLdCi/QAD6QrpfP81gKTQPX4Ru70u54dn7ngEfb+DxKQjHGUt25rn5qSqSGUeO3Oec791jU0lJ/TATvuhzn3PckgS5OP/4zxCSPP0m0/IGO1tibcVjS8zHTVVKUp82ebQzIp0T10FK7a2cz0KSJiZpUtRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979067; c=relaxed/simple;
	bh=Lb6Q9j6qPltfuPQrZ1QUpWaOsiJxZoYFKdSXL1K9eHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4GQmscJr/DBBDxcI2+GIO20pq/TTD2RXO4wsqTT7UmI8jOXpRE+3u6Zt+CH4ng/NbKp7jCgZmHL129snVW5r7lidtSc7rFngr3xOOo1tc4PGge5epfN7WrYDqmZel6ZwLeiEHlKttyix+DaOPIF3/oGL9itzAUxs4I02eLMpOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dzXdQi6a; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dzXdQi6a"
Received: (qmail 85548 invoked by uid 106); 2 Jul 2026 07:57:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Lb6Q9j6qPltfuPQrZ1QUpWaOsiJxZoYFKdSXL1K9eHw=; b=dzXdQi6aQUmTPpFfR053skm+HKoE78uCxnLiSlvuUBgIiti8fu3yyk0xtw70Nt91JvzPXOjuGSciN9DwXvZtO+v0wmNCMZ7P9J8CMeSocxWgHX7GQrvjHq/tB11haG8PXWreUhaeW2U5IPORYnGeKWh6VWGxv25uDXzw/2napgHRL4R5UDMEG66+x7zqqr7rMJQzzvk1VVLvPARuvtS8PU4vzqDG44vSHngWYMJy2HFBI1asTzyGUpq88uC0WEHsXyZyVv0jC1EpusCWcwI58L8cADKoEdropksjck3rvp+2eUEhpHHI2sSe+14r146wcRvs8DrmThKoJxyI5k2qgA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 07:57:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 178151 invoked by uid 111); 2 Jul 2026 07:57:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 03:57:45 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 03:57:44 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/9] csum-file: drop discard_hashfile()
Message-ID: <20260702075744.GA2029434@coredump.intra.peff.net>
References: <20260702075234.GA1548258@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702075234.GA1548258@coredump.intra.peff.net>

Commit c3d034df16 (csum-file: introduce discard_hashfile(), 2024-07-25)
added a cleanup function that no longer has any callers. In that commit
we adjusted do_write_index() to use the new function. But a similar fix
occurred on a parallel branch, making free_hashfile() public, and the
merge resolution in 1b6b2bfae5 (Merge branch 'ps/leakfixes-part-4',
2024-08-23) took the free_hashfile() version.

So now we have two functions, discard_hashfile() and free_hashfile(),
and we only need one. Which one do we want to keep?

The only difference between them is that the discard variant also closes
the descriptors held in the struct. Let's look at the three callers:

  1. In finalize_hashfile() we've either already closed the descriptors
     (if the CSUM_CLOSE flag is passed) or the caller didn't want them
     closed (if it didn't pass that flag). So we want the more limited
     free_hashfile().

  2. In object-file.c:flush_packfile_transaction() we close the
     descriptor ourselves. So discard_hashfile() could save us a line of
     code.

  3. In do_write_index() we don't close the descriptor. This was the spot
     for which c3d034df16 added the discard function in the first place,
     but I'm skeptical that closing the descriptor here is the right
     thing. It is true that we are done with the descriptor at this
     point and closing it would be ideal. But we don't really own it!

     The descriptor comes from a tempfile struct (as part of a lock) and
     that tempfile will hold on to the descriptor and try to close it
     when it is deleted. This might happen at the end of the program, in
     which case the double-close is mostly harmless (we might
     accidentally close some other open descriptor, but at that point
     we're just closing and unlinking everything we can).

     But in theory it could also cause subtle bugs. If do_write_index()
     fails, we return the error up the stack and would eventually end up
     in write_locked_index(). There we roll back the lock file on error,
     which will close the descriptor. So now we get our double close,
     and we might actually close something else that was opened in the
     interim.

     This is probably unlikely in practice (as soon as we see the error
     we'd mostly be unwinding the stack, not opening new files). But it
     highlights a potential problem with the discard_hashfile()
     interface: the hashfile doesn't necessarily own that descriptor.

Note that I said "descriptors" plural above. Those callers all care
about the "fd" member of the struct. But discard_hashfile() also closes
check_fd. That is only used if the struct is initialized with
hashfd_check(), and neither of its two callers call either discard or
free (they always "finalize" instead). So closing it is irrelevant for
the current callers.

I think we're better off sticking with the simpler free_hashfile()
interface, and the handful of callers can decide how to handle the
descriptors themselves.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a semi-related cleanup that is in this series because we'll be
touching the free function in a bit. And at first I thought we'd
want the discard() variant, but after poking around a bit I'm pretty
sure we don't.

I do like the name discard() better, as it makes it more clear that it
is an alternative to finalize(). Since they have the same signature,
swapping the names/implementations _could_ confuse long-running branches
or topics in flight, but I kind of doubt there are any, given the
history.

 csum-file.c | 9 ---------
 csum-file.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index d7a682c2b6..8ca9246a80 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -101,15 +101,6 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
 	return fd;
 }
 
-void discard_hashfile(struct hashfile *f)
-{
-	if (0 <= f->check_fd)
-		close(f->check_fd);
-	if (0 <= f->fd)
-		close(f->fd);
-	free_hashfile(f);
-}
-
 void hashwrite(struct hashfile *f, const void *buf, uint32_t count)
 {
 	while (count) {
diff --git a/csum-file.h b/csum-file.h
index a270738a7a..d1a0ff29cd 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -74,7 +74,6 @@ void free_hashfile(struct hashfile *f);
  * Finalize the hashfile by flushing data to disk and free'ing it.
  */
 int finalize_hashfile(struct hashfile *, unsigned char *, enum fsync_component, unsigned int);
-void discard_hashfile(struct hashfile *);
 void hashwrite(struct hashfile *, const void *, uint32_t);
 void hashflush(struct hashfile *f);
 void crc32_begin(struct hashfile *);
-- 
2.55.0.418.g37da59dd42

