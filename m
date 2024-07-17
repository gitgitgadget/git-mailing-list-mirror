Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D5B2C9A
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721195527; cv=none; b=XE1hlRQ7VnUUxBzqlFJZu85XRRdk0/l+rMsYkZUS861erHkW/d8duT/VH2Z5oV5r6D/uXfUF/VSAA/jz5/ADzX8Sre8f8mgktO3kclLXmJVtno2SDzgo6Y2SzSwSV+qYdTCCNS5yY+KCYOV082yTm6egTmntCve1yfSJaeAmI5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721195527; c=relaxed/simple;
	bh=Ybcz2559nSNLR3Z+zsqBRQb0mKE4bulTKfE0GOC9TWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHGYetmiIk1jiT2y63w1Nu9oVGF0x4dJFdnPUmsutvOtZNMMIKEWdiPU13DvEKoIAp+5T68p3UrWf+yPUHMffBMMZ4ohBzTyWDMhA2tqgyez8g/H+bHIW7vScO1x/MAOik8SxYgVWKevRHvD5Wjud5z2C1JSrcLGk76tH15BQaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23379 invoked by uid 109); 17 Jul 2024 05:52:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Jul 2024 05:52:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18770 invoked by uid 111); 17 Jul 2024 05:52:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Jul 2024 01:52:02 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 17 Jul 2024 01:52:03 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Scott Moser <scott.moser@chainguard.dev>, git@vger.kernel.org
Subject: Re: Can dependency on /bin/sh be removed?
Message-ID: <20240717055203.GB547635@coredump.intra.peff.net>
References: <CADaTQqDZ_6wORXOFc2CE90aizgHJ116NDHZhNeY4Nx7NH8DHJw@mail.gmail.com>
 <xmqq8qy21k9f.fsf@gitster.g>
 <20240715235212.GA628996@coredump.intra.peff.net>
 <20240716192307.GA12536@coredump.intra.peff.net>
 <xmqqo76x6r69.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo76x6r69.fsf@gitster.g>

On Tue, Jul 16, 2024 at 01:02:54PM -0700, Junio C Hamano wrote:

> > Again, it's possible that we could detect that no shell metacharacters
> > are in play and do the word-splitting ourselves. But at that point I
> > think it should go into run-command's prepare_shell_cmd(). That is, I I
> > think it could take space out of the list of metachars that force us to
> > invoke the shell, and do the word-splitting there. But not having
> > thought very hard about it, there are probably corner cases where that
> > optimization is detectable by the user (presumably unusual IFS, but
> > maybe more?).
> 
> Well, I strongly object to an approach for us to "parse" anything.

OK, it makes me nervous, too, so I am happy to leave it be (though it is
interesting to hear that "make" does a similar optimization).

> But even then it would be sensible to formulate:
> 
> 	argv[0] = sh
> 	argv[1] = -c
> 	argv[2] = git-credential-cache --socket=/path/	--timeout=123 "$@"
> 	argv[3] = -
> 	argv[4] = NULL
> 
> and if there is an argument say "get", extend it to
> 
> 	argv[0] = sh
> 	argv[1] = -c
> 	argv[2] = git-credential-cache --socket=/path/	--timeout=123 "$@"
> 	argv[3] = -
> 	argv[4] = get
> 	argv[5] = NULL
> 
> before passing the array to execv(), no?

Hmm. I think that is OK. It is a little funny to have some arguments
pasted in and some via "$@", but I think in the end it should be
indistinguishable to the user.

In your example it is "git-credential-cache", whereas we do "git
credential-cache" now. I _think_ the two should be equivalent at this
point (since the parent process running this code would already have set
up GIT_EXEC_PATH to find dashed forms), but it does give me pause.

We could keep saying "git credential-cache", but then in most cases we
would never trigger the metacharacter optimization, because of the
space.

And of course:

Splitting it out like this:

  argv[0] = sh
  argv[1] = -c
  argv[2] = git "$@"
  argv[3] = -
  argv[4] = credential-cache --socket=/path/ --timeout=123
  argv[5] = get
  argv[6] = NULL

is wrong, because argv[4] is really a shell snippet, not a single
argument (and we cannot split it ourselves without doing shell-like
parsing).

> And with the metacharacter optimization to drop .use_shell we
> already have, a single-token /bin/myhelper case would then become
> 
> 	argv[0] = /bin/myhelper
> 	argv[1] = get
> 	argv[2] = NULL
> 
> naturally.

Yes, I think that is the one case that would benefit. I do wonder how
often people point to an absolute path, though, rather than
git-credential-* or a more complex shell invocation.

-Peff
