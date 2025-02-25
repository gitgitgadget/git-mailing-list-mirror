Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9DC256C77
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464723; cv=none; b=laRK/PoxlRrymkMeOQdoIpT1JELzTFowRMdPVKVEMnJe/AhxN4EpFrJqkbtabku9QzG0ackvaoCw1PCWsb0qsXRXNs5Y/11uEw33fC3KkFIaiW9N8l/1IP9uMtfrfT50MuEMKjz12d74pobKlBD9FA774ibknGrZhdZvUm+hP94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464723; c=relaxed/simple;
	bh=j9w6lUXpEB9TqLCZ+5zKA00gx4x1v5Ps8nfvYoHnNkE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IXX7BCP/fEoQ5qNRVaEykdJL/II8esg8bZ79fIp58kKUJmMVIeqiYwuWk/xHq00Hz2z/73AAhU6ZhRgZxQt4tbYTWP0SLwmJ2LN2SXO9vOJp6D9gPMBrtzc+HxkN9lFCsZzHkNogVyAAGUe8xy/I9+6Bz1FdZub+E6ose30vLo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=J8ez0o68; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="J8ez0o68"
Received: (qmail 24515 invoked by uid 109); 25 Feb 2025 06:25:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=j9w6lUXpEB9TqLCZ+5zKA00gx4x1v5Ps8nfvYoHnNkE=; b=J8ez0o680qm9x+/bh0TkHRFlzuJrIPEmqyHZJcAGi+G6GnvQRjwy/q7uBCuKBQKM384EYgL5chkp7Iizpz4/9EUgP2CqNroXg2mWr7J6Sxonsw5J5AG2e5+yFnX6UwUaL66i65wxEtUJSZcjr+XNz4T5EhiG9qumpAKJ8Athln/Kri4smnaxOfgY3gQLTtmN2i/ic4rVtt47vnsPhn4xFLeANXBp4yp/UxSs0WNILAU5tajOLmTrGlq/HLCzDCQsRp2n9fgLNq3eXKX3LQC/6DTMHDexMdra1q0cB+waTIxjtLL5ntysm0ObXGhLND4EU47R/QyyCY4hG6Vf8EfrsA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Feb 2025 06:25:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2637 invoked by uid 111); 25 Feb 2025 06:25:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Feb 2025 01:25:18 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 25 Feb 2025 01:25:18 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/10] some zlib inflating bug fixes
Message-ID: <20250225062518.GA1293854@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Here are a few bug fixes related to zlib-inflating objects. One is an
infinite loop, but triggering it requires writing to the local repo
along with running some seldom-used commands, so I think is not a
security risk.  The other can be triggered by sending a specially
crafted pack, but it triggers a BUG(), so you'd only be crashing out
your own push.

The fixes themselves are in patches 4 and 5. The rest are related
cleanups or clarifications in nearby code.

  [01/10]: loose_object_info(): BUG() on inflating content with unknown type
  [02/10]: unpack_loose_header(): simplify next_out assignment
  [03/10]: unpack_loose_header(): report headers without NUL as "bad"
  [04/10]: unpack_loose_header(): fix infinite loop on broken zlib input
  [05/10]: git_inflate(): skip zlib_post_call() sanity check on Z_NEED_DICT
  [06/10]: unpack_loose_header(): avoid numeric comparison of zlib status
  [07/10]: unpack_loose_rest(): avoid numeric comparison of zlib status
  [08/10]: unpack_loose_rest(): never clean up zstream
  [09/10]: unpack_loose_rest(): simplify error handling
  [10/10]: unpack_loose_rest(): rewrite return handling for clarity

 git-zlib.c          | 27 +++++++++++++----------
 object-file.c       | 48 ++++++++++++++++++++--------------------
 t/t1006-cat-file.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 36 deletions(-)

-Peff
