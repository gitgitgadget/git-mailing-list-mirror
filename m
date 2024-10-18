Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5388F15DBB3
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 05:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729229396; cv=none; b=pNl23vZydzfyCxSwrF+IH8O3DuYJn4gLq5p8ceNIRcJCA2M1Kq2QX05zN8CgUeN1c9rLyXKIn/iIhG9z8Fh0UQG+nORqOYkKlkDDyq83I9zjnVxXa2pUPqhTAICov160skQZ+Uc8d9085rlVUhF32j+VFNkSAjf2+/mUc5Sn6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729229396; c=relaxed/simple;
	bh=tS6WBpZtcPUcgogJ+06KoJz+ZnHHH/J/Ku56vsYbo7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alPgxUB+aFwBKxWOi20xSLBFqtgagswSoF5sKa7YVFv59gBZSwPZYMZTVTSBoR6i0wntR1tQWiK0cz5tIQIsqZi/miX5695eKx4uNcxOKTN3WMbgw4SPrQ8W7jNePlIo5CQT44qS+sn4x2rZcu4l4uaDgmERMEwdMIPGsfsQyvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SSJOYSWB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SSJOYSWB"
Received: (qmail 32363 invoked by uid 109); 18 Oct 2024 05:29:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=tS6WBpZtcPUcgogJ+06KoJz+ZnHHH/J/Ku56vsYbo7k=; b=SSJOYSWBOaTmkOtUn9bYls50S9s3uEnKDNV2INA8P3Nea3vCvyKsaMjGhXB75gZmtOm9+H7ACkHO+/WdyWzQqLvPaJlWY1mIL2G+6CQK4L9wHOc45vuwZhdPLznoT9oqQcPcvUL9AJubfVQcX8qGqTYeBb5wEWg75c/qNA3znQQnQLcgFwesAtLtfVOyIHAPdHUctmPCkmQLp62Zrr/HKRsjyiKI+tFZDLtAB2MIBTVYr6yIgHBHpoUwguBVEjyb5bFXA3ktmzLeuXYhl2efuECyt4wHzY16T/6312NniY6RX8+ubqLhZJ68n2GIXOog25R+BYQUwkd0kGfutRWcGg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Oct 2024 05:29:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13152 invoked by uid 111); 18 Oct 2024 05:29:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2024 01:29:52 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 18 Oct 2024 01:29:52 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] credential-cache: treat ECONNABORTED like ECONNRESET
Message-ID: <20241018052952.GE2408674@coredump.intra.peff.net>
References: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
 <658fe4fa540a0a5316e11ed43f9139d5ef818ee5.1729226155.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <658fe4fa540a0a5316e11ed43f9139d5ef818ee5.1729226155.git.ps@pks.im>

On Fri, Oct 18, 2024 at 06:36:11AM +0200, Patrick Steinhardt wrote:

> Subject: builtin/credential-cache--daemon: fix error when "exit"ing on Cygwin

I think this commit message has a few unclear or inaccurate bits,
because it's based on the earlier attempt. E.g., the change is now on
the client side, not in credential-cache--daemon.

And I think rather than say "the daemon exit rules are intricate", we
can actually outline the rules. :)

So here's what I had written after reading through the old thread. It
would preferably get Ramsay's Signed-off-by before being applied.

-- >8 --
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] credential-cache: treat ECONNABORTED like ECONNRESET

On Cygwin, t0301 fails because "git credential-cache exit" returns a
non-zero exit code. What's supposed to happen here is:

  1. The client (the "credential-cache" invocation above) connects to a
     previously-spawned credential-cache--daemon.

  2. The client sends an "exit" command to the daemon.

  3. The daemon unlinks the socket and then exits, closing the
     descriptor back to the client.

  4. The client sees EOF on the descriptor and exits successfully.

That works on most platforms, and even _used_ to work on Cygwin. But
that changed in Cygwin's ef95c03522 (Cygwin: select: Fix FD_CLOSE
handling, 2021-04-06). After that commit, the client sees a read error
with errno set to ECONNABORTED, and it reports the error and dies.

It's not entirely clear if this is a Cygwin bug. It seems that calling
fclose() on the filehandles pointing to the sockets is sufficient to
avoid this error return, even though exiting should in general look the
same from the client's perspective.

However, we can't just call fclose() here. It's important in step 3
above to unlink the socket before closing the descriptor to avoid the
race mentioned by 7d5e9c9849 (credential-cache--daemon: clarify "exit"
action semantics, 2016-03-18). The client will exit as soon as it sees
the descriptor close, and the daemon may or may not have actually
unlinked the socket by then. That makes test code like this:

  git credential exit &&
  test_path_is_missing .git-credential-cache

racy.

So we probably _could_ fix this by calling:

  delete_tempfile(&socket_file);
  fclose(in);
  fclose(out);

before we exit(). Or by replacing the exit() with a return up the stack,
in which case the fclose() happens as we unwind. But in that case we'd
still need to call delete_tempfile() here to avoid the race.

But simpler still is that we can notice that we already special-case
ECONNRESET on the client side, courtesy of 1f180e5eb9 (credential-cache:
interpret an ECONNRESET as an EOF, 2017-07-27). We can just do the same
thing here (I suspect that prior to the Cygwin commit that introduced
this problem, we were really just seeing ECONNRESET instead of
ECONNABORTED, so the "new" problem is just the switch of the errno
values).

There's loads more debugging in this thread:

  https://lore.kernel.org/git/9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com/

but I've tried to summarize the useful bits in this commit message.

[jk: commit message]

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/credential-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 5de8b9123b..7789d57d3e 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -30,7 +30,7 @@ static int connection_fatally_broken(int error)
 
 static int connection_closed(int error)
 {
-	return (error == ECONNRESET);
+	return error == ECONNRESET || error == ECONNABORTED;
 }
 
 static int connection_fatally_broken(int error)
-- 
2.47.0.273.g4ed1498264

