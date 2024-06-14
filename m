Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582501922DF
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360689; cv=none; b=l1qxCzw4mPec5fdvm2nlsf3haWC6a3y5O8kCl/NcgHTAHqTDX4NVwVfVKTIN23XHaAxQwTQbZimwPh4eTe3l6Y+Bdi84ke2SXBWQswDAAjIDBJ6LApSTMRM88bcjqpaOxWU9Yvw6SbMnw+5rfApS+Zj2a9nDvTXgAnScJ39NXYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360689; c=relaxed/simple;
	bh=5JLmpGwkUcBOnRiZ8I8SsLOqBwbjCofOW6Kj62wzLhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKvJoIJGoiPPWMv37nUXGKUthgA1Gcsuhq+al7fs3daMXH2ddhTMo7Sf9j8oyTfYxrXbzOkUxGH2KFVkCgh5eIq/O1Z52UE/rTGA7JyEN6BleE2nfJa+ufByMNC/D/Wr+aIYaW7d4cfzanYevJkYy3qhWlAK2Fy1IoSCCCkz2yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16437 invoked by uid 109); 14 Jun 2024 10:24:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Jun 2024 10:24:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27050 invoked by uid 111); 14 Jun 2024 10:24:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Jun 2024 06:24:37 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Jun 2024 06:24:39 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Subject: [PATCH 0/11] allow overriding remote.*.url
Message-ID: <20240614102439.GA222287@coredump.intra.peff.net>
References: <83D801A8-3878-43C1-B7A7-78B3B7315FD8@gmail.com>
 <20240611075137.GF3248245@coredump.intra.peff.net>
 <xmqq34pjxzva.fsf@gitster.g>
 <20240613102409.GE817573@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240613102409.GE817573@coredump.intra.peff.net>

On Thu, Jun 13, 2024 at 06:24:09AM -0400, Jeff King wrote:

> > I was expecting (with excitement) a mess, but the above is as clean
> > as we can make the idea, I would say.  Lack of documentation and
> > tests do count as incompleteness though of course.
> 
> Yeah, and we should probably do the same for pushurl. And I think there
> could be some cleanup of the memory ownership handling of add_url().

So as always with this crufty 2009-era code, there turned out to be some
subtleties. ;)

The good news is that I think dealing with them left the code in a
better place. It's easier to reason about, and a few possible leaks have
been plugged (I don't know if they were triggered in the test suite or
not; if so they weren't enough to tip any scripts over to being
leak-free).

We can split the series into segments:

  [01/11]: archive: fix check for missing url

    A nearby trivial bugfix.

  [02/11]: remote: refactor alias_url() memory ownership
  [03/11]: remote: transfer ownership of memory in add_url(), etc
  [04/11]: remote: use strvecs to store remote url/pushurl
  [05/11]: remote: simplify url/pushurl selection

    Fixing memory handling weirdness, which is a necessary prereq for
    the "reset" operation to avoid leaking. The switch to using a strvec
    isn't strictly necessary, but it does make the code (including the
    later patch 7) simpler.

  [06/11]: config: document remote.*.url/pushurl interaction
  [07/11]: remote: allow resetting url list

    The actual change is in patch 7 here, but it was hard to add new
    docs to the rather anemic existing ones. Hence patch 6.

  [08/11]: t5801: make remote-testgit GIT_DIR setup more robust
  [09/11]: t5801: test remote.*.vcs config
  [10/11]: remote: always require at least one url in a remote
  [11/11]: remote: drop checks for zero-url case

    This is a related cleanup I found while working in the area.
    Arguably it could be a separate topic, though it does depend
    textually on what came before.

 Documentation/config/remote.txt | 11 +++-
 builtin/archive.c               |  4 +-
 builtin/clone.c                 |  4 +-
 builtin/ls-remote.c             |  6 +--
 builtin/push.c                  | 28 ++--------
 builtin/remote.c                | 88 +++++++++---------------------
 remote-curl.c                   |  2 +-
 remote.c                        | 94 ++++++++++++++++++---------------
 remote.h                        | 13 ++---
 t/helper/test-bundle-uri.c      |  2 -
 t/t5505-remote.sh               | 36 +++++++++++++
 t/t5801-remote-helpers.sh       | 23 ++++++++
 t/t5801/git-remote-nourl        |  3 ++
 t/t5801/git-remote-testgit      |  3 +-
 transport.c                     | 19 +++----
 15 files changed, 174 insertions(+), 162 deletions(-)
 create mode 100755 t/t5801/git-remote-nourl

-Peff
