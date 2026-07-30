Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4743D3FF1B5
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785412475; cv=none; b=EaYSNEkiLa/vnouAhfEOqimTKd1F4M8T/HCL5cL+H9hAA42Rb69sfz4RHX9FcpHBhR1GS0qvnjFrgszzmNf+UR5qXTAi+Z6SaZfc5mJIJZG9wdPCjpCGfj2kRz1tC6jfk0Gah+bFIn27y+MOPyIkHKMRjWOZ699mmObV/0tVMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785412475; c=relaxed/simple;
	bh=8HtaXV15Xk6HVASSjbVpTgXBLZ5cpYMgp6Rti54+utI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsRa5tN9DVkMsr1hi32XTP/ehrzTVXhCuJMlub8i8w8jh/57pgFvg+nnEUuOVy0kyU6+/FTynzrBIKbYn1Ln1YsGQ+WrmKqxQc5rDi1SWnZXzKNxI+7c5aLYTn5nNY5FOHSfy6h7hwg6sxYgYte87jGegTXeOAD0R1LKfJB12eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XMO6uHE+; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XMO6uHE+"
Received: (qmail 10892 invoked by uid 106); 30 Jul 2026 11:54:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8HtaXV15Xk6HVASSjbVpTgXBLZ5cpYMgp6Rti54+utI=; b=XMO6uHE+FW3lF/She3hPU3e/l2cAy2ZmxT0Jxg1Hr4eogP3YlpTZ5UipZXd2+VtLZfsXzosLEcbXTV9Sks7g+CfUodZGxea4hABnHKgbf73ZPVM48rDhtr6Lzn+y0+va9xW83x7IXELG4pDcBzBIFo6xIFUFhpfi6Cfz5dL3NgfNs2w0GTv12qtjdHnb12qkPpOjekFuQUOG6VL6LazEzwqlKqYTF6Zr9fuPuLVdu4mezii4z12dTYbr39fy2+hGsYapq1qskTu50phveR3zQu17SpWVW2f99N9ABS9empbH9whGo2FbJi33YNrcFRVLFStKcA9sAMV2Tzu/nu26hQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Jul 2026 11:54:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19202 invoked by uid 111); 30 Jul 2026 11:54:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jul 2026 07:54:25 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 30 Jul 2026 07:54:25 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: read configuration earlier
Message-ID: <20260730115425.GA1871609@coredump.intra.peff.net>
References: <20260728135532.GA11894@coredump.intra.peff.net>
 <20260729225944.1364947-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729225944.1364947-1-sandals@crustytoothpaste.net>

On Wed, Jul 29, 2026 at 10:59:44PM +0000, brian m. carlson wrote:

> When building with WITH_BREAKING_CHANGES, we need that option set before
> we generate the list of binaries to build, since it affects whether
> git-whatchanged is built.  That in turn, affects whether t1517 passes,
> since it does not if we are in breaking-changes mode and git-whatchanged
> or git-pack-redundant exist.  Load the configuration settings earlier in
> the Makefile so that we properly honor this value when building.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> I noticed that Peff's patches didn't quite fix the problem for me and I
> think we need this on top to make the tests pass properly.

Yeah, I didn't touch anything with t1517, as I couldn't reproduce the
problem here. I'm still a bit puzzled.

There is definitely a problem here, which is that WITH_BREAKING_CHANGES
is not respected correctly from the config.mak inclusion. I think you
already know most of this, but just to demonstrate the breakage:

  1. A normal build is fine. If we delete whatchanged and rebuild it,
     that works, and it is present in the commands list.

       $ make
       [copious output]

       $ rm -f git-whatchanged
       $ make git-whatchanged
           BUILTIN git-whatchanged

       $ ./git --list-cmds=main | grep whatchanged
       whatchanged

  2. If we specify WITH_BREAKING_CHANGES on the command line, that is
     used by the whole Makefile and everything works. We can't rebuild
     the command (it is not even a target!) and it is not present in the
     builtin commands list.

       $ make WITH_BREAKING_CHANGES=1
       [copious output]

       $ rm -f git-whatchanged
       $ make WITH_BREAKING_CHANGES=1 git-whatchanged
       make: *** No rule to make target 'git-whatchanged'.  Stop.

       $ ./git --list-cmds=main | grep whatchanged
       [no output]

  3. And now using config.mak, we _do_ still build it (because the
     conditional around BUILT_INS comes earlier than the config.mak
     inclusion), but it is not present in the commands list (because the
     -D logic to pass to the program comes later).

      $ echo WITH_BREAKING_CHANGES=1 >>config.mak
      $ make
      [copious output]

      $ rm -f git-whatchanged
      $ make git-whatchanged
          BUILTIN git-whatchanged

      $ ./git --list-cmds=main | grep whatchanged
      [no output]

So we've half-respected it; we built the file (really the hardlink) but
the code doesn't know its there. But the part that puzzles me is why
t1517 would be unhappy with that. It uses --list-cmds=main to get the
list of commands to check. So it will not know about whatchanged at all,
and it doesn't care if the hardlink is there or not (whether from this
bug, or from a previous build).

What would be catastrophic is going the _other_ way. If we failed to
build but included it in the commands list, then t1517 would barf.  But
I can't see a way for that to happen.

So I do think there's a bug here that we should fix, but I'm just
confused how it has any visible effects (at least for t1517; it would
have triggered the alias problems in t0014 I think).

As for the solution:

> --- a/Makefile
> +++ b/Makefile
> @@ -781,6 +781,10 @@ clean-perl-script:
>  clean-python-script:
>  	$(RM) $(SCRIPT_PYTHON_GEN)
>  
> +include config.mak.uname
> +-include config.mak.autogen
> +-include config.mak
> +

I think this is much too early to include those files. Just as a
concrete example, try this:

  echo "CFLAGS = --break-the-build" >>config.mak
  make

Before your patch, we'd use those CFLAGS and the build will immediately
fail. But after, we do not respect it at all! We need those inclusions
to come after we set up default values, so the last-one-wins behavior
can kick in. And many of those default values come after the BUILT_INS
setup we care about.

I think the simplest solution is just to pull the "whatchanged" line out
from the main BUILT_INS setup and handle it conditionally below. There's
already precedence for that (e.g., the way we conditionally add
http-fetch and http-push to PROGRAMS/PROGRAM_OBJS later on).

-Peff
