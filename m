Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EA64D8A3
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158192; cv=none; b=c80l1LBARMlY+07qR5HnfFKk4p9GahJ0n7zpzGwrlf5J4Qtw2U8H3Pt8BZySbm0ZL14GKSOnixGiZbY7ntbjyxXQNXCQjDSWhnZ32+ojd821ODFxsxkY+Zh0atf0EPZNSIM2iR9/D2hQ/d5Shv54BdUjuArXxygNIWTcLOrqbg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158192; c=relaxed/simple;
	bh=mAFz6Ku10HIAq/MjF8+HkGxOBHhFpM6egBl9CQ1O9OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFam1DgtfleGUH3QpOgkYRyJRPtygMjGx0LEs2aza2atyARIRKUOShAMASETy37HLI53p7el3208+PIy6OxHGnZvLD3pml8JJ4NC8r+TvtR/wE6D7BjBgfZ6n+tk5zcu5JQ1zu+HjJL0OT/BV5KLxEGrTIgmawJAwKaY+9k/LIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18331 invoked by uid 109); 16 Jul 2024 19:23:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jul 2024 19:23:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12945 invoked by uid 111); 16 Jul 2024 19:23:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jul 2024 15:23:06 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Jul 2024 15:23:07 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Scott Moser <scott.moser@chainguard.dev>, git@vger.kernel.org
Subject: Re: Can dependency on /bin/sh be removed?
Message-ID: <20240716192307.GA12536@coredump.intra.peff.net>
References: <CADaTQqDZ_6wORXOFc2CE90aizgHJ116NDHZhNeY4Nx7NH8DHJw@mail.gmail.com>
 <xmqq8qy21k9f.fsf@gitster.g>
 <20240715235212.GA628996@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240715235212.GA628996@coredump.intra.peff.net>

On Mon, Jul 15, 2024 at 07:52:12PM -0400, Jeff King wrote:

> > We may be able to teach credential.c:credential_do() not to paste
> > the operation verb to the command line so early.  Instead you could
> > teach the function to send the command line and operation verb
> > separately down to run_credential_helper() though.  That way, we
> > might be able to avoid the shell in this particular case.  That is,
> > if we can 
> > 
> >  * Have start_command() -> prepare_cmd() -> prepare_shell_cmd()
> >    codepath to take the usual route _without_ the operation verb
> >    tucked to the command line, we would get cmd->args.v[] that does
> >    not rely on the shell;
> > 
> >  * Then before the prepared command is executed, if we can somehow
> >    _append_ to cmd->args.v[] the operation verb (after all, that
> >    wants to become the argv[1] to the spawned command) before
> >    start_command() exec's it
> > 
> > then we are done.
> 
> Yes, I think this is reasonable. You'd also perhaps want to have it set
> child->git_cmd as appropriate (though really, I do not think that does
> anything except stick "git" into child.args[0], so we could just do that
> ourselves).
> 
> I'm actually a little surprised it was not written this way in the first
> place. In the non-!, non-absolute-path case we are pasting together a
> string that will be passed to the shell, and it includes the "helper"
> argument without further quoting. I don't think you could smuggle a
> semicolon into there (due to our protocol restrictions), but it does
> seem like a possible shell injection route.
> 
> I think it probably goes all the way back to my abca927dbe (introduce
> credentials API, 2011-12-10).

Ah, having tried to refactor it, I see now why it is written as it is.
Even for a regular helper without "!", it is important that we construct
a string and pass it to the shell, since it is legal (and even
encouraged) to do things like:

  [credential]
  helper = cache --socket=/path/to/socket --timeout=123

Arguably we could have gotten away with word-splitting ourselves,
sticking the result in child_process.args, and avoided the shell. But
the use of the shell is documented in gitcredentials(7):

  helper
    The name of an external credential helper, and any associated
    options. If the helper name is not an absolute path, then the string
    git credential- is prepended. The resulting string is executed by
    the shell (so, for example, setting this to foo --option=bar will
    execute git credential-foo --option=bar via the shell. See the
    manual of specific helpers for examples of their use.

So users may be depending on that to do "--socket=$HOME/.foo", or even
more exotic shell constructs.

Again, it's possible that we could detect that no shell metacharacters
are in play and do the word-splitting ourselves. But at that point I
think it should go into run-command's prepare_shell_cmd(). That is, I I
think it could take space out of the list of metachars that force us to
invoke the shell, and do the word-splitting there. But not having
thought very hard about it, there are probably corner cases where that
optimization is detectable by the user (presumably unusual IFS, but
maybe more?).

-Peff
