Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A111E0DAE
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376286; cv=none; b=DIRBh9q3GrVK+64e+8scAz4rc1Zm15cOuZ1SV2aXpvST8cnV5BLGH0Ih86vah+Wb3uYgM5YH6oLDc9aE0zW5TRRo9NHzaN5ekwu+/UqeBGPFC6KnM6cN2zJtBmUoEEQEGHkKkgAfiK8e2zpxkDc7Du2rDoSuPjO7gEwXmxuI0Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376286; c=relaxed/simple;
	bh=su3kEhsV1MyM6pS0qI0EpvN1yFbt1DBn3Csu2ITi0Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NycdbV2czoQJEGLro9aNbcbuKrI8DUnwt6HbWHc/Jb1kIJrLZIjkmX8suMQbugYhPc7xN2aNTJJ0NVtl13fYFaXdJVTJGt6IZZpFPC+oqCAoxN5tDEoMPBvpdaShhmf0KpBLeSLFqwXpgmQO1pF/0ugjUP6E+KJlP8adeBDJm4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=P5qDkT7o; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="P5qDkT7o"
Received: (qmail 9567 invoked by uid 109); 8 Oct 2024 08:31:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=su3kEhsV1MyM6pS0qI0EpvN1yFbt1DBn3Csu2ITi0Eg=; b=P5qDkT7oN0XwsJ0umEkh6gE3m/pWYRSKtRakX/AQAY4Cw18n4KGTFS17XlYK/M+2zzhdsJFOWjI07zyQ+0HiQzBJ2+sbPSh/himC54wLJLR0y0M/8IiG7dX/XsaFNCfyv7V8DjcG0kFwfSQC0M3uZ4zzToQCNhjZH/GRZE5UsJ+7JiO58mzGpkWBbxNl7EuB6BVvbARgr8Q3jSeBNqai0LAmP/5msJeyuFReX8IFXrC7LCGHE9HNaiqZcSE9CaKUMwm4MNMfeidxXKkNCdt3Xmr8pDeUXT3I2/YDgmD7UrauE4ywcBwP1WI2yndeU9ZN//yv+/h8V15Idrn73UUgtg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Oct 2024 08:31:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15751 invoked by uid 111); 8 Oct 2024 08:31:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Oct 2024 04:31:22 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 8 Oct 2024 04:31:21 -0400
From: Jeff King <peff@peff.net>
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH 0/2] alternate approach to fixing fsmonitor hangs
Message-ID: <20241008083121.GA676391@coredump.intra.peff.net>
References: <pull.1804.git.1727862424713.gitgitgadget@gmail.com>
 <20241007055821.GA34037@coredump.intra.peff.net>
 <20241007060813.GA34827@coredump.intra.peff.net>
 <CAOTNsDwwikiX3u6DG=+4hn+mcgfXzzDoqR3ZFVEdGi=mPGQbpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOTNsDwwikiX3u6DG=+4hn+mcgfXzzDoqR3ZFVEdGi=mPGQbpg@mail.gmail.com>

On Mon, Oct 07, 2024 at 06:45:22PM +0900, Koji Nakamaru wrote:

> > -     pthread_mutex_lock(&server_data->work_available_mutex);
> > +     /* If we haven't started yet, we are already holding lock. */
> > +     if (!server_data->started)
> > +             pthread_mutex_lock(&server_data->work_available_mutex);
> >
> >       server_data->shutdown_requested = 1;
> 
> Is this condition inverted?

Yes, good catch.

> > I had also previously checked my suggested solution. So I do think
> > either is a valid solution to the problem.
> 
> I also tested your approach on Windows with a few additions to
> ipc-win32.c, and it worked correctly.

Yeah, I never even tried building mine on Windows, and was just testing
via tmate on our macOS CI environment. :-/

I've added in the necessary Windows bits, along with smoothing a few
rough edges. Especially with the extra Windows changes (which I mostly
had to guess-and-check by pushing to CI), I'm beginning to wonder if my
solution isn't getting a bit too complicated, and maybe yours was the
right way after all.

But I've cleaned it up for presentation here, so at least we can look at
the final form of both and see which we prefer.

  [1/2]: simple-ipc: split async server initialization and running
  [2/2]: fsmonitor: initialize fs event listener before accepting clients

 builtin/fsmonitor--daemon.c          |  6 ++--
 compat/fsmonitor/fsm-listen-darwin.c |  6 ++++
 compat/fsmonitor/fsm-listen-win32.c  |  6 ++++
 compat/simple-ipc/ipc-shared.c       |  5 +--
 compat/simple-ipc/ipc-unix-socket.c  | 28 +++++++++++++---
 compat/simple-ipc/ipc-win32.c        | 48 +++++++++++++++++++++++++---
 simple-ipc.h                         | 17 +++++++---
 7 files changed, 98 insertions(+), 18 deletions(-)

-Peff
