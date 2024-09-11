Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2452F7DA68
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 06:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037320; cv=none; b=TSCHHUhcYTT1jqFWVo23S0GwfXZkVb3LzO9TzslG+8lKP3riEtQSENIyzpNzpqXXjXXa73Prko7M2o9c76w6q8r36N40Qr/JktKu4e6NJwjGbf1WZOHQ+hxjT9RpLrS2jWV9m2cADqjXfdhawiAfGkl9O7u9m64LQC3CCObkpu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037320; c=relaxed/simple;
	bh=esSRIe7YmkiDwlWyJPhhYYCiORoVN8PtvpY4bRGME0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOsT3BxM8M7MQ8vD4ZGei4MKbLibO8qPYc1odYruBQ+BTkuqxPc09ULTPa+5f1dcR1sARob5xjadCfza10hXCuLjCl8lwqpS0m0o1PB6nbLkdzWmaxdUVznwNx7/oGKPpSPqyaEAGYvwBzbXygXY8MWxC6lujDvr+4NCaKxSoag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9634 invoked by uid 109); 11 Sep 2024 06:48:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Sep 2024 06:48:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6047 invoked by uid 111); 11 Sep 2024 06:48:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Sep 2024 02:48:36 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 11 Sep 2024 02:48:36 -0400
From: Jeff King <peff@peff.net>
To: Han Jiang <jhcarl0814@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: `git diff --break-rewrites` does not work (otherwise it should
 break rewrite into delete and create, for `--find-renames` to work)
Message-ID: <20240911064836.GB1538586@coredump.intra.peff.net>
References: <CANrWfmTz6x0qmTDaTOF_USR+fDcVdwfpUJDhjozb_VzBAnUJsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANrWfmTz6x0qmTDaTOF_USR+fDcVdwfpUJDhjozb_VzBAnUJsA@mail.gmail.com>

On Tue, Sep 10, 2024 at 11:07:19PM +1200, Han Jiang wrote:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> cd '/'; cd '/'; rm --force --recursive -- './test_git2'; mkdir "$_"; cd "$_";
> mkdir --parents -- './repo';
> git init './repo'
> echo -e 'a\nb\nc\nd\ne\nf\ng\nh\ni\nj' >'./repo/file1'
> echo -e '0\n1\n2\n3\n4\n5\n6\n7\n8\n9' >'./repo/file2'
> git -C './repo' add './file1' './file2'
> mv './repo/file2' './repo/file3'
> mv './repo/file1' './repo/file2'
> git -C './repo' add --intent-to-add './file3'
> git -C './repo' diff --break-rewrites='50%/50%' --find-renames='50%'
> 
> What did you expect to happen? (Expected behavior)
> 
> `git diff` outputs: file1 rename to file2, file2 rename to file3
> 
> What happened instead? (Actual behavior)
> 
> `git diff` outputs: file1 remove all content, file2 complete rewrite,
> file3 add all content

It's because your toy example is too small. Try:

  seq 400 >repo/file2

instead of the 0-9 input, which will then do what you expect.

There is a hard-coded MINIMUM_BREAK_SIZE limit which requires that one
of the files must be at least 400 bytes, presumably to avoid awkward
corner cases in the heuristics for very small files. That comes from
eeaa460314 ([PATCH] diff: Update -B heuristics., 2005-06-03), so quite
long ago. But I'm not sure if any science went into determining it.

Do you have a real (non-toy) case where it should be triggering but
isn't? I wonder if we should consider making that hard-coded limit
configurable somehow.

-Peff
