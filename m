From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Makefile: suppress false positive warnings of empty
 format string.
Date: Mon, 30 Sep 2013 16:14:29 -0400
Message-ID: <20130930201429.GA14433@sigill.intra.peff.net>
References: <7vfvvkpt2k.fsf@alter.siamese.dyndns.org>
 <1380456534-7582-1-git-send-email-stefanbeller@googlemail.com>
 <20130929190017.GA2482@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 30 22:14:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQjrZ-0005VK-DZ
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 22:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183Ab3I3UOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 16:14:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:58204 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932180Ab3I3UOb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 16:14:31 -0400
Received: (qmail 29225 invoked by uid 102); 30 Sep 2013 20:14:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Sep 2013 15:14:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Sep 2013 16:14:29 -0400
Content-Disposition: inline
In-Reply-To: <20130929190017.GA2482@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235625>

On Sun, Sep 29, 2013 at 12:00:17PM -0700, Jonathan Nieder wrote:

> > --- a/Makefile
> > +++ b/Makefile
> > @@ -349,7 +349,7 @@ GIT-VERSION-FILE: FORCE
> >  
> >  # CFLAGS and LDFLAGS are for the users to override from the command line.
> >  
> > -CFLAGS = -g -O2 -Wall
> > +CFLAGS = -g -O2 -Wall -Wno-format-zero-length
> 
> Thanks for taking this on.  Two thoughts:
> 
>  1) As Felipe mentioned, this isn't portable.  Would it make sense to
>     make it conditional on the value of $(CC) or the output of
>     "$(CC) --version"?

I'm not sure checking just "$(CC)" would help. Our default is "cc",
which encompasses quite a wide variety of compilers, gcc and otherwise.

To be honest, I'm surprised that "-Wall" doesn't create problems for
older "cc" implementations. We've had patches for compiling with
antique SUNWspro and MIPSpro compilers, and I sort of assumed that those
don't handle "-Wall". But maybe they do. Or maybe people doing that just
set CFLAGS themselves.

I think the original discussion ended with "well, maybe it's not too bad
for people to just turn on -Wno-format-zero-length". But if it is
creating a cognitive burden on people (it's not hard to do, but you have
to figure out that you need to do it), and especially if we are looking
at workarounds like version-detecting gcc, I think we'd be better off to
simply mark up the few callsites. Workarounds are here:

  http://article.gmane.org/gmane.comp.version-control.git/230026

and here:

  http://article.gmane.org/gmane.comp.version-control.git/230027

>  2) I don't understand the value of -Wformat-zero-length at all.  What
>     bug is it meant to prevent?  Do you know if anyone has asked the
>     GCC maintainers to disable it from the default set of warnings in
>     -Wall, which would give us a bug number to point to?

I don't think there is an open bug anywhere.  When this came up
initially, I searched for other reports, but mostly found a handful of
other people running into the same situation and adding
-Wno-format-zero-length to their projects.

As for the value of it, I think it is basically to detect that:

  printf("");

is a dead-code noop (bearing in mind that the "" may also be non-obvious
when reading the code due to preprocessing), and may indicate some kind
of logic error.  That's reasonable to warn about; the compiler knows
that stdio formatting functions with an empty format are noops.

But where we run into trouble is that the warning assumes that other
formatting functions are also noops in that case, which is not
necessarily true. They might have side effects, or the empty string
might be formatted with extra decoration (adding a newline, wrapping the
empty string in quotes, etc).

So I do not think the correct solution (from gcc's perspective) would be
to turn off -Wformat-zero-length by default. It would rather be to
enhance the annotation for the format attribute to separate the two
cases, and to annotate printf() and friends with some kind of
"pure-format" attribute.

>  3) Since we don't enable -Werror by default (which is really good ---
>     use of -Werror can be a fine development tool but is a terrible
>     default), the warning does not actually do much harm.

Yeah, I think the world is a better place if every developer of git
should compiles with -Werror, but it is a terrible default for consumers
of the code.

>     becomes harmful is when someone turns on -Werror for static
>     analysis purposes and is unable to move forward from there.  Do we
>     document suggested pedantic compiler flags anywhere other than the
>     todo:Make script?  Should we?

It should probably be somewhere in the actual git.git history, as very
few people look at the todo branch. I guess INSTALL or CodingGuidelines
would be the most appropriate place.

-Peff
