Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8275915575A
	for <git@vger.kernel.org>; Fri, 31 May 2024 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154677; cv=none; b=usaJAUny6spFLp20j934KSWrCXJ2W4GyngqVirSbbokyqkYijEx6Nu/VdBn86p73Z5qJCB1m+fo9zqdNCwTKVVQHQJPzS4VdhXrl4XtuBWJUZ7o+ol8Jd2V+rHRlBjIfpHF+ogrdZ0RA2U/0vJeH+ZY2yqYMOVP7f8LxeKXc75g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154677; c=relaxed/simple;
	bh=nN1qVeCInz9+43xPUYDcIUh+SYKhLx/NAusoX+/vWmU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b4mGYMLaPDVsoSzeS/o8JqXfdFW1RgLqY0KovZhohqE5csQsEf+USFrB5n7wL/ZGc8oqx5oXspL2niY+wMCIWTJRbZl9WQPc1UIjc1xKyzERA+arSHIGksk8RlwM7Tu9JA8U8GdzEeuWI/mSeAs8vLlcKXojnwH9LyFCPFYboS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22700 invoked by uid 109); 31 May 2024 11:24:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 May 2024 11:24:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9211 invoked by uid 111); 31 May 2024 11:24:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 May 2024 07:24:33 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 31 May 2024 07:24:33 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/13] leak fixes for sparse-checkout code
Message-ID: <20240531112433.GA428583@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

So Patrick nerd-sniped me by asking if my earlier leakfix for git-mv was
triggered by the test suite. It was, in t7002, but that wasn't enough to
make the script leak-free. So I figured, how hard could it be to go all
the way?

Well. It only took a few patches (1-5), but in the process I stumbled on
a rather tricky interface oddity of add_pattern(), which caused some
other leaks. The interface is fixed in patch 6, and the matching leak
goes away in patch 7. Of course, I wanted to make sure it was tested, so
after poking around I found that t1091 triggered it.

But as you might guess, that didn't make t1091 leak-free. And I couldn't
bear leaving it on a cliffhanger like that, so patches 8-13 fix the rest
of the issues triggered by that script.

And along the way we managed to make t1090 and t3602 leak-free, too
(actually in patch 2, but I didn't notice until the whole thing was
done).

These should apply on top of jk/leakfixes, since the leak-freeness of
t7002 depends on the fix there.

  [01/13]: sparse-checkout: free string list in write_cone_to_file()
  [02/13]: sparse-checkout: pass string literals directly to add_pattern()
  [03/13]: dir.c: free strings in sparse cone pattern hashmaps
  [04/13]: sparse-checkout: clear patterns when init() sees existing sparse file
  [05/13]: dir.c: free removed sparse-pattern hashmap entries
  [06/13]: dir.c: always copy input to add_pattern()
  [07/13]: sparse-checkout: reuse --stdin buffer when reading patterns
  [08/13]: sparse-checkout: always free "line" strbuf after reading input
  [09/13]: sparse-checkout: refactor temporary sparse_checkout_patterns
  [10/13]: sparse-checkout: free sparse_filename after use
  [11/13]: sparse-checkout: free pattern list in sparse_checkout_list()
  [12/13]: sparse-checkout: free string list after displaying
  [13/13]: sparse-checkout: free duplicate hashmap entries

 builtin/sparse-checkout.c          | 49 +++++++++++++++++++-----------
 dir.c                              | 42 ++++++++++++++++---------
 dir.h                              |  3 +-
 t/t1090-sparse-checkout-scope.sh   |  1 +
 t/t1091-sparse-checkout-builtin.sh |  1 +
 t/t3602-rm-sparse-checkout.sh      |  1 +
 t/t7002-mv-sparse-checkout.sh      |  1 +
 7 files changed, 65 insertions(+), 33 deletions(-)

-Peff
