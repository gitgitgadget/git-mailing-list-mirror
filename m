Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A53230F97
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CFAA9
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 12:16:57 -0800 (PST)
Received: (qmail 7287 invoked by uid 109); 7 Nov 2023 20:16:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Nov 2023 20:16:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16669 invoked by uid 111); 7 Nov 2023 20:16:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Nov 2023 15:16:57 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Nov 2023 15:16:55 -0500
From: Jeff King <peff@peff.net>
To: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)
Message-ID: <20231107201655.GA507701@coredump.intra.peff.net>
References: <ZUocFhmPHstwKCkZ@devuan>
 <20231107174803.GA507007@coredump.intra.peff.net>
 <ZUqDwnmu9d1dD1tb@devuan>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUqDwnmu9d1dD1tb@devuan>

On Tue, Nov 07, 2023 at 07:36:44PM +0100, Alejandro Colomar wrote:

> > I assume what you want out of send-email here is the actual generation
> > of patch emails. But under the hood that is all done by git-format-patch
> > anyway. So for example if you do:
> 
> Yeah, most of it is done by format-patch.  There are few things I
> actually need from send-email.  One of them is generating the Cc from
> the sign-offs and other tags found in the patch.
> 
> I had been thinking these days that it would be useful to have
> format-patch generate those.  How about adding a --signed-off-by-cc to
> format-patch?

That seems like a reasonable feature. Probably it should be
--cc-from-trailer=signed-off-by, and then you could do the same with
other trailers.

It feels like you could _almost_ do it with the existing
--format='%(trailers)' functionality, but there's no way to say "do the
regular --format=email output, but also stick this extra format in the
headers section". Plus there are probably some niceties you'd get from
Git knowing that you're adding headers (like de-duping addresses).

That feature might end up somewhat hairy, though, as then you get into
questions of parsing address lists, etc. We do all that now in perl with
send-email, where we can lean on some parsing libraries. So I dunno.

> > If you're sending a long series, it's helpful to pre-populate various
> > headers in the format-patch command with "--to", etc. I usually do so by
> > sending the cover letter directly via mutt, and then using some perl
> > hackery to convert those headers into format-patch args. The script I
> 
> Indeed, that hackery is what send-email already does, so how about
> moving those features a bit upstream so that format-patch can do them
> too?

Yeah, if they existed in format-patch I might be able to reuse them. I
am hesitant, though, just because handling all the corner cases on
parsing is going to be a bit of new C code.

> Although then, maybe it's simpler to teach send-email to learn to use
> mutt(1) under the hood for the actual send.

I think you will find some corner cases in trying to make mutt act just
like an mta accepting delivery. Two I can think of:

  1. It will take a body on stdin, but not a whole message. We can hack
     around that with some postponed-folder magic, though.

  2. Bcc headers are stripped before sendmail sees the message (but
     those addresses appear on the command-line). Converting that back
     to bcc so that mutt can then re-strip them would be annoying but
     possible. If you don't use bcc, it probably makes sense to just
     punt on this.

So maybe a script like this:

-- >8 --
#!/bin/sh

# ignore arguments; mutt will parse them itself
# from to/cc headers. Note that we'll miss bcc this
# way, but handling that would probably be kind of
# tricky; we'd need to re-add those recipients as actual
# bcc headers so that mutt knows how to handle them.

# spool the message to a fake mbox; we need to add
# a "From" line to make it look legit
trap 'rm -f to-send' 0 &&
{
  echo "From whatever Mon Sep 17 00:00:00 2001" &&
  cat
} >to-send &&

# and then have mutt "resume" it. We have to redirect
# stdin back from the terminal, since ours is a pipe
# with the message contents.
mutt -p \
  -e 'set postponed=to-send' \
  -e 'set edit_headers=yes' \
  </dev/tty
-- 8< --

and then in your git config:

  [sendemail]
  sendmailcmd = /path/to/mutt-as-mta.sh

There are mutt-specific bits there that I don't think send-email should
have to know about. Perhaps there are generic options that send-email
could learn, but it really feels like you'd do better teaching mutt to
be more ready to handle this (like taking a whole message on stdin,
headers and all, rather than just a body).

-Peff
