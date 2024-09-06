Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF98241E7
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 04:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725595477; cv=none; b=ddYuXE4BacgZ/Yym1Yt8Wa685tnRQXXTdYJsQuufCrVb5gRVDoTmRaau2dSeLhp8GG3b0IP6rDbYcNn11wpCeGWC9L83AKIyQkx4wRJgDIBO8TwhWObVjZUUO/+w1S9W2vlsLB4wmBk5xtoss1ZtM3yX/4TZ6fig53Wvmzim4MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725595477; c=relaxed/simple;
	bh=EIvbxmTdtns+bJIxbuPiPTSCB6tfS1srdVG4F9OpkdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYU/3TSx6biroJVgzEjcNU+fDoWiCtIXmQiOsm5QJm4e4etBReSwlsbRQCw04rgEFwF6ALL+a4eKsQCt2kU1fhBAPykEWzhd7SZ3OMUzbOGw+RkNcT6uDP7ZonBWKpBmQM46arqH8IMuJijHnmzsnRqWZIoGVfS89kFzCWiuM28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15316 invoked by uid 109); 6 Sep 2024 04:04:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Sep 2024 04:04:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16491 invoked by uid 111); 6 Sep 2024 04:04:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Sep 2024 00:04:35 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 6 Sep 2024 00:04:34 -0400
From: Jeff King <peff@peff.net>
To: Brooke Kuhlmann <brooke@alchemists.io>
Cc: git@vger.kernel.org
Subject: Re: Should Git Tag trailer formatting work?
Message-ID: <20240906040434.GB4168449@coredump.intra.peff.net>
References: <E46F3EFF-66D1-4B29-BCF3-6FFAB2504411@alchemists.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E46F3EFF-66D1-4B29-BCF3-6FFAB2504411@alchemists.io>

On Thu, Sep 05, 2024 at 10:05:24AM -0600, Brooke Kuhlmann wrote:

> With the recent release of Git 2.46.0, the ability to add trailers to tags was added which is great! However, when attempting to list and format trailer information, I don't see the trailer information display using the following Bash code:
> 
> ``` 
> git tag --list \
>         --color \
>         --format="%(color:yellow)%(refname:short)%(color:reset)|%(taggerdate:short)|%(color:blue)%(color:bold)%(taggername)%(color:reset)|%(subject)|%(trailers:key=Insertions)" \
>         | column -s"|" -t
> ```

This seems to work fine for me. If I do:

  {
	echo "Version 0.0.0"
	echo
	echo "An example."
	echo
	echo "Insertions: 10"
  } >input
  git tag -F input foo

then your example above produces:

  foo  2024-09-06  Jeff King  Version 0.0.0  Insertions: 10

I wonder if the contents of the tag are not exactly as you expect, and
that is fooling the trailer parser (which relies on some heuristics to
find the right spot). Can you show us the output of "git cat-file tag
<some-tag>"? Mine looks like:

  $ git cat-file tag foo
  object af1c73c21ab34cfbdc86da838acacc6e45ccd264
  type commit
  tag foo
  tagger Jeff King <peff@peff.net> 1725595316 -0400
  
  Version 0.0.0
  
  An example.
  
  Insertions: 10

-Peff
