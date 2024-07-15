Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4420B1E890
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087542; cv=none; b=YH6ucqY6Uv0QwbC3UV8iSIx2HoshW+MMOW0xJVXbkp/hNjV/l9h3e8O8iJnRmvmMBmy/fZ7FocmQyk08Y75LdMlAFRK0FPTwA0TnRO4YGScbtvd4ZfCauF6TcbLUWgm17A2X+wfJmWUpKBTIlu8MI+I1YaiKp6R/bOAw8m3ueGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087542; c=relaxed/simple;
	bh=tfzCeGfy0Eb8UznZl0sJiFRejjLBOjcuYZMmPlAFYGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsmrXuc+Nt8zCMr5wmBUNEF54P6cvfSb2YljIUT2GzGcIPbqD14Yqn8IPtPzHoPaM3PRYA8ytiqTFK9bIr228YovaT0OKn4xuNXT/V6QUY3t6gS6d1o7QkjfYqvU8/oHIpMkTjI/3hISPtm7TXl4xclz6GS8HjCOEjMIlK+FVyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9095 invoked by uid 109); 15 Jul 2024 23:52:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Jul 2024 23:52:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3612 invoked by uid 111); 15 Jul 2024 23:52:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Jul 2024 19:52:11 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 15 Jul 2024 19:52:12 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Scott Moser <scott.moser@chainguard.dev>, git@vger.kernel.org
Subject: Re: Can dependency on /bin/sh be removed?
Message-ID: <20240715235212.GA628996@coredump.intra.peff.net>
References: <CADaTQqDZ_6wORXOFc2CE90aizgHJ116NDHZhNeY4Nx7NH8DHJw@mail.gmail.com>
 <xmqq8qy21k9f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8qy21k9f.fsf@gitster.g>

On Mon, Jul 15, 2024 at 01:18:52PM -0700, Junio C Hamano wrote:

> Even though the code path starting from start_command() is what
> run_credential_helper() does use, what is run is NOT a simple
> command "/bin/myhelper".  It will receive arguments, like
> 
> 	/bin/myhelper erase
> 	/bin/myhelper get
> 	/bin/myhelper store
> 
> etc., because the caller appends these operation verbs to the value
> of the configuration variable.  And as you found out, to tokenize them
> into two, we need shell.

It is also usually "git myhelper get", and so on (though you can
configure a shell command).

> We may be able to teach credential.c:credential_do() not to paste
> the operation verb to the command line so early.  Instead you could
> teach the function to send the command line and operation verb
> separately down to run_credential_helper() though.  That way, we
> might be able to avoid the shell in this particular case.  That is,
> if we can 
> 
>  * Have start_command() -> prepare_cmd() -> prepare_shell_cmd()
>    codepath to take the usual route _without_ the operation verb
>    tucked to the command line, we would get cmd->args.v[] that does
>    not rely on the shell;
> 
>  * Then before the prepared command is executed, if we can somehow
>    _append_ to cmd->args.v[] the operation verb (after all, that
>    wants to become the argv[1] to the spawned command) before
>    start_command() exec's it
> 
> then we are done.

Yes, I think this is reasonable. You'd also perhaps want to have it set
child->git_cmd as appropriate (though really, I do not think that does
anything except stick "git" into child.args[0], so we could just do that
ourselves).

I'm actually a little surprised it was not written this way in the first
place. In the non-!, non-absolute-path case we are pasting together a
string that will be passed to the shell, and it includes the "helper"
argument without further quoting. I don't think you could smuggle a
semicolon into there (due to our protocol restrictions), but it does
seem like a possible shell injection route.

I think it probably goes all the way back to my abca927dbe (introduce
credentials API, 2011-12-10).

> Having said that, I do not think you can avoid /bin/sh if your goal
> is "minimal image *to run git*", as there are many things we run,
> starting from the editor and the pager and end-user hooks.  The
> credential helper is probably the least of your problems.  What's a
> minimum /bin/dash image cost these days?

Right. The bigger issue to me is that the credential helper "!" syntax
is defined to the end user as running a shell (and ditto for all of
those other spots). So any platform where we can't run a shell would not
be fully compatible with git on other platforms.

That may be an OK limitation as long as it is advertised clearly, but
the use of a shell here is not just an implementation detail, but an
intentional user-facing design.

-Peff
