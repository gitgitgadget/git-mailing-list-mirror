Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A814A3D3F
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146656; cv=none; b=ZzNAUE3XeqbTRmHiBqoQxySQXkQSaFrqeBJvDOZdWYwHIaQMSn760SDyM5J9TgYj9cJejPZqnId21EgDp+KrTOSPZm+2cxfUOZ+WUCgOSEImqh3QpSq0s3Mz1LwFx8KBq3m9jJMxK058/qd0EIdl/DfkhYx+SvX/XbecnCTEOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146656; c=relaxed/simple;
	bh=XM+e1UWdtugL6XHrXPUoSq7BKmjIWGsbdRFRk4kkO9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptiTyAsj30zhjoU8erYWfq38P2JXcFOyAGSdu4BYWcj8Mu2l0KyU2jR4kieBptxydAJ6YDTi4L7lmIa5x3MKPqH24dW5aCCDv2jQZuaWBnwG1xpn8rusOrsDmUv8VhyFPbPkG6GH6ZUC0oqoXPb4CdP6HBqGfJvLiSTYFqy9NhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NH85hpil; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NH85hpil"
Received: (qmail 34621 invoked by uid 106); 11 Sep 2026 17:10:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=XM+e1UWdtugL6XHrXPUoSq7BKmjIWGsbdRFRk4kkO9s=; b=NH85hpilSBwkZW2OrOsRUSoTXPMWVIBel/Z7jjxs9nc83qZ6qNjQEAiTN4NKxQWjTYxJnKLTx2Eqc8rlAqd+fAzwYeeF34w1Yj49xuM4QnE2eUhylpCayQ19rPRVa+QU0Nkl2870VVrmGi0cnDoem1Aubc9559n15HYtIp7AsUcEcnOJ6XktdD1/H809QqmBodYSS4KT3GEM5OpEv+220mXUGabzi6Bra6ZUP+D7fNAYdFTCIsF5kkFF4cxfZyhXc3y7Hu8C0ofdWPc0cg9ROPitqVXcq2gE5FQHTEYl5vm7sE0yEv+ckVWrZ6EN2CPHJ6kifaoDS4Bb12jjkzDmHQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Sep 2026 17:10:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 173799 invoked by uid 111); 11 Sep 2026 17:10:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Sep 2026 13:10:44 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 11 Sep 2026 13:10:44 -0400
From: Jeff King <peff@peff.net>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: git@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
	Elijah Newren <newren@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 0/3] merge-ll: Cleanup merge driver temporaries after
Message-ID: <20260911171044.GA1609692@coredump.intra.peff.net>
References: <20260910150608.1867930-1-mkoutny@suse.com>
 <20260910162242.GC251185@coredump.intra.peff.net>
 <aqQN_Q6ZAeyTy7WA@localhost.localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqQN_Q6ZAeyTy7WA@localhost.localdomain>

On Fri, Sep 11, 2026 at 04:43:08PM +0200, Michal Koutný wrote:

> > In the worst case we can just call register_tempfile() on each path, but
> > I think this code could be taught to use the actual creation. Something
> > like the patch below (only lightly tested).
> 
> I've tested it and it works (cleans up both after SIGINT and regular
> termination).

Thanks for testing. I considered putting something in the test suite,
but it gets ugly (we'd have the external driver pause, signal a fifo,
then kill git-merge and it with SIGINT). I guess an alternative would be
setting GIT_ALLOC_LIMIT to something low, and then generating a
too-large output, which would cause xmalloc() to fail, which I believe
would also fail. But then we're not really testing the signal handling.

Hmm. I wonder if leaving the files could actually be a _feature_. If you
completed the merge with the external tool but we barfed reading it back
in, would it be useful to leave the file in place? It's possible, I
suppose, but I think it is more likely to be a nuisance (and we already
delete it for things like read() errors, just not anything that would
cause us to die()).

> (There's only a warning about constness, one should not change the
> tempfile's path buffer. But here the ovewrite happens only if there were
> trialing dirseps, which they aren't as the filename is under control.)

Yeah, I've fixed it in this iteration, plus a few tweaks:

 - I did the strbuf cleanup I mentioned (patch 1)

 - we should be using close_tempfile_gently() instead of close() on the
   tempfiles so that they don't get double-closed when deleting

 - that made me notice a small error-checking bug in the original code,
   fixed in patch 2

> Do you want me to send your variant as v2 or will you?

Here it is. I've labeled it v2, and I stole your commit message for the
third patch.

  [1/3]: merge-ll: use strbuf to read back external merge result
  [2/3]: merge-ll: catch close() errors when writing external tempfiles
  [3/3]: merge-ll: use tempfile API for external driver files

 merge-ll.c | 68 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

-Peff
