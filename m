Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6603612D8
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 04:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785905430; cv=none; b=HwItB/xzWMumxs0uvKTsIA7xVVwGzHXYnXRasemG/Nmna8lsINGZJ1ZeZGXyLN7nR4Hit5Qw7GLroG2S+RbBrxSo0zrM5gjG37lnEmXF9l1iL/O1NGWlZHlk0UjeqcJAklzL1lE99XEZa6Y/MIVpVYhrIG5nujs8r32E1aS+zTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785905430; c=relaxed/simple;
	bh=L4po1GbiWN4U5uLvIdczWIYlI/D9QF6ascx2ZZFxtQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Axyf8NpXrP+75XHVZMO2/RhpVyy8OQ1UWC0HG420e2Lf8Y+Bjm0ycc+6e2eRiZiCzGIQtMDt0MmBP03pkhBX+K2XGSQj8GvstYsMSfiQ84p6ViPpZENjU/19QwYWqTWIYlHLQSkMDbQ+GnDUV6XwefU/twopbturstZsQd4t+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YwCz55vh; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YwCz55vh"
Received: (qmail 48361 invoked by uid 106); 5 Aug 2026 04:50:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=L4po1GbiWN4U5uLvIdczWIYlI/D9QF6ascx2ZZFxtQw=; b=YwCz55vhzQsto6SfE0MGd1K9WWQ082icka4mj3nE2uSTSebOQLg2eQJe17zHwe/poSN33AG06NA/RECWbjuUxhqeDNxmVz3JgcmsI0Ka7G6myATPDJqVTkNqJjC9UWAbtXBV+jVh/U8lOpAxBaQmdSiL559jiAwP5uOxsUML85zW5CQL6r5sllewHB1QTDS0S7db/GqBx+Wo09F0/jjIAXHgiZcqhxDFiICGfMUK5+qAXNH+7006QGritJZJa5qnK13sxQ7GY6x0HRUubul1NFNprKjfXRoS6wZD2TrKRnsUCvKUX08rhQnjsvYzBoBGk5QGwxTOh90G0qcyb56YbA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Aug 2026 04:50:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 71113 invoked by uid 111); 5 Aug 2026 04:50:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Aug 2026 00:50:27 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 5 Aug 2026 00:50:26 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: Question on textconv
Message-ID: <20260805045026.GA972736@coredump.intra.peff.net>
References: <017e01dd2441$476839f0$d638add0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <017e01dd2441$476839f0$d638add0$@nexbridge.com>

On Tue, Aug 04, 2026 at 02:44:22PM -0400, rsbecker@nexbridge.com wrote:

> The supplied file going to the textconv program looks like
> /tmp/git-blob-GFtIhK/simple
> and is always empty regardless of the file contents.

I can't reproduce the problem here, even for files with embedded NULs.
However...

> When there is only one file named simple in the repository I can find
> it, but otherwise any ambiguity in the name makes textconv processing
> impractical. Somewhere prior to this I was supplied with the actual
> file in the working index instead of a temp file.

This part I can explain. We sometimes try to reuse the working tree
instead of generating a tempfile, as an optimization. We can only do
this when the working tree file is clean. But we also only bother to try
when one of the diff endpoints is the index. So if we set up a sample
textconv like:

  git config diff.foo.textconv 'echo >&2 "got: $*" && tr a-z A-Z <'
  echo "file diff=foo" >.gitattributes

  echo one >file && git add file && git commit -m one
  echo two >file && git add file && git commit -m two

The running either "git diff HEAD^" or "git diff --cached HEAD^" will
convert the copy in the working tree, and you'll get:

  got: /tmp/git-blob-0CLCMr/file
  got: file
  diff --git a/file b/file
  index 5626abf..f719efd 100644
  --- a/file
  +++ b/file
  @@ -1 +1 @@
  -ONE
  +TWO

but if you do "git show HEAD", you'll get two tempfiles:

  got: /tmp/git-blob-w1binM/file
  got: /tmp/git-blob-1nu2Rm/file
  [same diff]

even though this is the same diff! We _could_ try harder to reuse the
working tree copy here by checking whether the path has the same sha1 in
the tree and the index (and that the index entry is clean). But it only
helps in a few special cases, and it's not something users should rely
on (we might choose to create a tempfile anyway if the index is
stat-dirty).

-Peff
