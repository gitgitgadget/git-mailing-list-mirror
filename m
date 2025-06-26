Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA4F2ED860
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963940; cv=none; b=Q8s1z7HYQRrytmFlMPsuA4aIXVt85GUy3rkxg3FFf5hFy5SO9aDoBc5CWWSEXDii4cVtNVKjRhUnhQManFuqQ/hej76EylzAIvonWSltdqWjdtWEanJPkIX0u6Fkex6oN1pJnVzbm0Hfo3uOM4XylZ0S+0LMqkedulfvRwUHi5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963940; c=relaxed/simple;
	bh=h47XeJ/wz4PkKjTWxj3cGHMPpJhIrZomJGjNDxTkPg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLhQaYv1NIqbbo091qihSWjWJyI6ZwsvQYSNNFUUzGBeVrKYSnuSDDoyrE/ztUEICeY5NLhMuMQmbrKh54U5mePDTx//Bfkj0beYDVUXCBR2G3hmLsTc/vBjjhwqvO6nOZyk1f86a6TjpQ9q3RuAZjjmQ26BeIhYHC5Hr8Igjx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U8dPaU8b; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U8dPaU8b"
Received: (qmail 10641 invoked by uid 109); 26 Jun 2025 18:52:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=h47XeJ/wz4PkKjTWxj3cGHMPpJhIrZomJGjNDxTkPg8=; b=U8dPaU8bvu0GsxK2LpLnGkS8o4XwokJnYTnAipERPregP+MyQJXjhwmX7iZLZJuIxBlzS6zCEYHirMM8w0jjg3W5wqVID+EY9hSAYcQ6nGsKcR4cuXlunlc9aqVeUwXaji4CmgXx1CMROzuTml4B1IZGystIClGY+LN+GHzQGeNLGbKf9zAPgGt+0b36RUGQ3KY0vb73nKCGyENpg5zadYLOUb+6DLNd8OPQm3l1c5dPCBVFqMyIH4nNuF4TpO94AY6i0EUBybF3ToVLJd5y2K261seRQ3s5XXgk7an7apJRc6NNe50xIH1cyZ3jQ/2Ncy2SkAPTDsJ/2b7NpiEWPw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Jun 2025 18:52:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9274 invoked by uid 111); 26 Jun 2025 18:52:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Jun 2025 14:52:18 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Jun 2025 14:52:16 -0400
From: Jeff King <peff@peff.net>
To: Kai Koponen <kaikoponen@google.com>
Cc: git@vger.kernel.org
Subject: Re: [perf] git log --follow seems slow
Message-ID: <20250626185216.GB17172@coredump.intra.peff.net>
References: <CADYQcGoAN8bW3SVEdqPLJAMQbicbo6wQW_nNa_uYkXMouxO=Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADYQcGoAN8bW3SVEdqPLJAMQbicbo6wQW_nNa_uYkXMouxO=Ng@mail.gmail.com>

On Wed, Jun 25, 2025 at 12:44:16PM -0400, Kai Koponen wrote:

> - --follow is not taking advantage of the commit graph (seems likely
> as --follow seems equally slow with core.commitGraph off)

It's mostly this. History pruning is disabled with --follow, since the
path of interest may change as we traverse through history. And the use
of commit graph changed-path bloom filters is tied to the pruning code.
So this hits you two-fold:

  1. For each commit we visit, we actually do a tree diff to see if it
     touched that path (leaving aside rename detection, we still have to
     open the trees down to the path of interest).

  2. We don't prune side-branches of history, so we are visiting more
     commits. Normally when we see a merge of two branches, when one
     parent matches the merge result and the other does not, we know
     that nothing interesting happened on the side branch. So we do not
     traverse those commits at all. But with pruning disabled, that no
     longer happens.

These limitations are mostly due to the hacky way that --follow is
bolted on to the traversal machinery. The "right" way for --follow to
work is to keep a unique pathspec (and bloom filter) for each line of
commits, passing it down as we walk backwards through history (and
modifying it when we see a rename).

It's probably possible to bolt bloom-filter checks onto the existing
--follow feature, but it would probably involve a lot of special casing.

-Peff
