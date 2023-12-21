Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1B5768EF
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 28319 invoked by uid 109); 21 Dec 2023 21:45:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Dec 2023 21:45:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28217 invoked by uid 111); 21 Dec 2023 21:45:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Dec 2023 16:45:50 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Dec 2023 16:45:50 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH/RFC] sparse-checkout: take care of "--end-of-options" in
 set/add
Message-ID: <20231221214550.GD1446091@coredump.intra.peff.net>
References: <xmqqbkakqx6s.fsf@gitster.g>
 <ZYN-5H-2NNoRRpf-@google.com>
 <xmqqplz0p90k.fsf@gitster.g>
 <20231221084011.GB545870@coredump.intra.peff.net>
 <xmqqsf3vmqug.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsf3vmqug.fsf@gitster.g>

On Thu, Dec 21, 2023 at 09:02:15AM -0800, Junio C Hamano wrote:

> > Yeah. I think it is in the same boat as the other two, in that I believe
> > that the KEEP_UNKNOWN_OPT flag is counter-productive and should just be
> > dropped.
> 
> If we dropped KEEP_UNKNOWN_OPT, however, the pattern that is
> currently accepted will stop working, e.g.,
> 
>  $ git sparse-checkout [add/set] --[no-]cone --foo bar
> 
> as we would barf with "--foo: unknown option", and the users who are
> used to this sloppy command line parsing we had for the past few
> years must now write "--end-of-options" before "--foo".  After all,
> the reason why the original authors of this code used KEEP_UNKNOWN
> is likely to deal with path patterns that begin with dashes.

Right, that is the "gotcha" I mentioned in my other email. Though that
is the way it has behaved historically, my argument is that users are
unreasonable to expect it to work:

  1. It is not consistent with the rest of Git commands.

  2. It is inconsistent with respect to existing options (and is an
     accident waiting to happen when new options are added).

So I'd consider it a bug-fix.

> The patch in the message that started this thread may not be
> correct, either, I am afraid.  For either of these:
> 
>  $ git sparse-checkout [add/set] --[no-]cone foo --end-of-options bar
>  $ git sparse-checkout [add/set] --[no-]cone --foo --end-of-options bar
> 
> we would see that "foo" (or "--foo") is not "--end-of-options", and
> we end up using three patterns "foo" (or "--foo"),
> "--end-of-options", and "bar", I suspect.  I wonder if we should
> notice the "foo" or "--foo" that were not understood and error out,
> instead.

Yes, I agree that "--foo --end-of-options" should barf. And of course
that happens naturally if you just let parse-options do its job by not
passing the KEEP_UNKNOWN_OPT flag. ;)

I'm not sure about "foo". We do allow out-of-order options/args, so
isn't it correct to keep it as a non-option argument?

> But after all, it is not absolutely necessary to notice and barf.
> The ONLY practical use of the "--end-of-options" mechanism is to
> allow us to write (this applies to any git subcommand):
> 
>  #!/bin/sh
>  git cmd --hard --coded --options --end-of-options "$@"
> 
> in scripts to protect the intended operation from mistaking the
> end-user input as options.  And with a script written carefully to
> do so, all the args that appear before "--end-of-options" would be
> recognizable by the command line parser.

Yes, but if you misspell "--otpions", it magically becomes a parameter
rather than having the command barf and complain. That is not the end of
the world, but it is unfriendly and inconsistent with the rest of Git.

-Peff
