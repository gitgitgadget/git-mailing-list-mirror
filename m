Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D41E53F
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715754847; cv=none; b=XfEms6Tr1KJNFpFALAOJmrBpGpeA44TPCBePxPxKY7N+RJfZ5Rd7nZrIxtE+P2J46uWzoSTeC1/8SAGCaT5jRBrdqR0MRH2oqEOJEFAg7+yarW0DCE1iLI/4mr78QBb16tmEwXXm2w3H7jyJ0hQNp5ipLMfdUNEZQexJojfMpps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715754847; c=relaxed/simple;
	bh=Trmcfk+LML7RYMH3xympg+BvTu0JQE1IZkKrlzbhPZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yw2ymVT1HNGOMStYXcWy9KMHxd9sQTQAdMxi78q4j+2tGGiPHpzz8HFzPBSh2/+D/dVortiwvy2bVpjddHZpft+1de0oIaE5RmftZzOSHC1UsB/AlepyDmZmj4HtbB5i46PJ9Tk0bZdOdjMJatspf4XlojbQN+f3ehUNIyIZDiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15492 invoked by uid 109); 15 May 2024 06:34:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 May 2024 06:34:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30771 invoked by uid 111); 15 May 2024 06:34:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 May 2024 02:34:05 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 15 May 2024 02:34:00 -0400
From: Jeff King <peff@peff.net>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Sam Clymer <clymersam@gmail.com>, git@vger.kernel.org
Subject: Re: Bug in git log -S
Message-ID: <20240515063400.GD110841@coredump.intra.peff.net>
References: <ED9E5AD9-D15D-4E63-AF80-209EAAEBAD5C@gmail.com>
 <8bfa50e3-996a-407b-9c02-a9fcacfebc4f@kdbg.org>
 <8B9537F6-A76A-4CF8-9EE4-2CC3C98D5784@gmail.com>
 <6d7ac19b-fede-4534-aee2-5c0cb20f955e@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d7ac19b-fede-4534-aee2-5c0cb20f955e@kdbg.org>

On Mon, May 13, 2024 at 11:01:25PM +0200, Johannes Sixt wrote:

> Am 13.05.24 um 20:58 schrieb Sam Clymer:
> > There does seem to be a bug on my end. I am searching for
> > “net8.0-windows” and it’s not finding an instance where it’s added.
> > It is not a line of code that is moved around it is purely added so I
> > think there is indeed something wrong with git log -S.
> 
> You would have to show more evidence for a bug before anything can
> happen. Start with showing the commands typed and their output, ideally
> you point at a commit history that shows the problem, etc. Otherwise, we
> can only say: "it works here".

I agree that we do not have much to go on here, but here are some
possible lines of enquiry:

  - if we have a specific commit that we expect "-S" to find, what does
    that commit look like? Is it a merge commit? If so, then maybe "-m"
    or "-c" would help? By default I don't think "log -S" will diff
    merges at all. "-m" will diff against both parents (so it is more
    likely to find introductions/deletions, but may show diffs against
    both parents). "-c" should I think mostly show just places where the
    content was introduced by the merge itself, though I haven't thought
    very hard on whether there are weird corner cases.

  - if there's a non-merge commit that we expect to find it in, then
    maybe checking:

      git cat-file blob $commit:$file | grep -Fc net8.0-windows
      git cat-file blob $commit^:$file | grep -Fc net8.0-windows

    would verify that the counts before/after that commit have changed?
    Note that "-F" is important, because -S is by default a string
    match, not a regex. And if the suspected file is binary, then the
    results may depend on your version of grep (GNU grep will correctly
    report the count for items in a binary file).

-Peff
