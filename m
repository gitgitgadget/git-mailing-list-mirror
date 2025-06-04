Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443C979D0
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749070509; cv=none; b=jO6lyJzGicCHiWgNJD0VDfOHMtfFdZ44NF4hOOWxaKmS5uR0/BENavZ48plbm8v8NDeDl113T9ZeAXUtgoKClSfCIqjZeIyVh6tbGsIpmgpEPozqCAOY1SSuyLwyConPcuzSXfwZtEYlJJQCUrJuiL9NYPMmW/STWfBNxWl/BMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749070509; c=relaxed/simple;
	bh=DPIm+GYkGE8LFaeVwx4aNJVczL9GgrCAnkw5FtA2AOM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aPHaufopQMZYhPVcx1U7n91qORvhbX7+Qu6E92OgKutFDOxpLRtk2CCNapvtQe2w0y2m3tCfTB/4JpTo7Z5CiBbMLcoVVus9kkwXdRpnkq59NPQrehHpKL6Z8bjrsrqmtJFcHO9rJuRNM4+4PtgyvcC/7Pd9R540Sc9/TSmyq34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=C/0+apQ5; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="C/0+apQ5"
Received: (qmail 14293 invoked by uid 109); 4 Jun 2025 20:55:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type; s=20240930; bh=DPIm+GYkGE8LFaeVwx4aNJVczL9GgrCAnkw5FtA2AOM=; b=C/0+apQ5FlAxA+rxXJfq56DOkNKFCS0J3aIlgQyFLqWC/j7Q20ii/M/RBbZcsiyYq9ua0l+VZLGmL3AWH0XtOgkiaKnzYm9sw94R+4ma/v+ODVa1pgWdEpvnEhChgi+w4+1Tgw+Dgh1bYAMgBRC+6i1RREN0lzSsNvOVH36nEKl2e3VwLnOx90Kgekr+WofVephOaFhynLCdUwbdjrFnZUcLAd6LrWct/9xD5R2Im7x4EFFXDe3kUFlpXXNZjKHX/DcaCzrsNGC3wontdqdyVN41qMCRcJib2/XBhkbPSbKhu/ujLArfXLLyqiBOgsdNRWkSeogkF3212jixVWLjMg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Jun 2025 20:55:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13750 invoked by uid 111); 4 Jun 2025 20:55:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Jun 2025 16:55:07 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Jun 2025 16:55:05 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 0/3] silencing warnings with curl 8.14
Message-ID: <20250604205505.GA1510724@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The new version of curl (which hit Debian unstable a few days ago)
causes a bunch of compiler warnings because we are passing regular ints
to curl_easy_setopt() instead of longs. Passing longs has always been
what you're supposed to do, but the new version is better about
generating warnings with gcc (I think the type-check has been there for
a long time, but I gather it was broken and recently fixed).

I split this into three patches since the solutions vary slightly (well,
the last two are the same, but my pontificating on the solution varies).

  [1/3]: curl: fix integer constant typechecks with curl_easy_setopt()
  [2/3]: curl: fix integer variable typechecks with curl_easy_setopt()
  [3/3]: curl: fix symbolic constant typechecks with curl_easy_setopt()

 http-push.c   |  2 +-
 http.c        | 28 ++++++++++++++--------------
 imap-send.c   |  6 +++---
 remote-curl.c |  6 +++---
 4 files changed, 21 insertions(+), 21 deletions(-)

-Peff
