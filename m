From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] trace: refactor to support multiple env variables
Date: Thu, 24 Feb 2011 14:02:58 -0500
Message-ID: <20110224190258.GA4318@sigill.intra.peff.net>
References: <20110224142308.GA15356@sigill.intra.peff.net>
 <20110224142841.GD15477@sigill.intra.peff.net>
 <7vsjvd1e9r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 20:03:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsgSz-00061z-Bl
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 20:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab1BXTDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 14:03:04 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:53351 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753482Ab1BXTDC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 14:03:02 -0500
Received: (qmail 26808 invoked by uid 111); 24 Feb 2011 19:03:00 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 19:03:00 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 14:02:58 -0500
Content-Disposition: inline
In-Reply-To: <7vsjvd1e9r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167847>

On Thu, Feb 24, 2011 at 10:25:04AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Right now you turn all tracing off and on with GIT_TRACE. To
> > support new types of tracing without forcing the user to see
> > all of them, we will soon support turning each tracing area
> > on with GIT_TRACE_*.
> >
> > This patch lays the groundwork by providing an interface
> > which does not assume GIT_TRACE. However, we still maintain
> > the trace_printf interface so that existing callers do not
> > need to be refactored.
> 
> One thing I found missing in the patch description is a statement of the
> overall design and expected usage.  It appears to me that the design is
> built around the idea to give each named/namable area to be traceable its
> own trace output file descriptor, so that different kinds of trace events
> are sent to different files.

The intent was that you _can_ do that if you want, but you can also just
dump them all to the same fd (or the same file). Each trace statement is
totally independent and written via write(), so there is no problem
pushing them all to the same place. They'll arrive in chronological
order.

> I however expect that majority of "trace only areas A and B" users would
> want to see logs of events from these two areas in the same stream to see
> them in the order they happened.

Right. And you can do GIT_TRACE_A=1 GIT_TRACE_B=1 if you want that (or
put them both to fd 5, or /tmp/foo.out, or whatever).

> Perhaps you are envisioning that these users would use redirection
> from the command line to send GIT_TRACE_A and GIT_TRACE_B to the same
> place; that probably needs to be spelled out more explicitly somewhere
> in the documentation, as that would be a more common thing to do.

Yeah, sorry. There is no documentation at all with this series yet. For
this round I was mainly trying to see how people felt about expanding
the trace functions at all.

> I think your [7/8] is kind of strange when viewed in that light.  Imagine
> what would happen if you gave separate GIT_TRACE_* to each packet class,
> instead of giving them a single umbrella variable GIT_TRACE_PACKET.  If
> the user wants to see them all in a single stream, the same redirection
> you would use to unify GIT_TRACE_A and GIT_TRACE_B can be used.

Yeah, you could break it down by packet type, though I don't know why
anyone would want to (unless perhaps dumping the whole pack to some
alternate location than the rest of it).

> Instead, you have packet class prefix in the output so that later the
> different kinds of packet events can be sifted out from the unified
> output, even though they are forced to go to the same output stream.  In a
> sense, you have two-tier classification system for traceable events (the
> top layer that can be separated or merged at the file descriptor level,
> and the bottom layer that can only be separated by looking at the prefix).
> 
> Is this necessarily a good thing (not a rhetorical question)?

I don't see it as a problem. As a developer, I want to throw in some
trace statements that are logically related to me. So I give them a name
and put in the trace statements. The user can now have those statements
turned on or off, and if on, can tell them where to go. No, they can't
say "I want statement X but not statement Y" or "I want packet X and not
packet Y". But what is the right degree of resolution? Too coarse, and
they get a few traces they don't want. Too fine, and the syntax for
addressing each individual trace statement gets cumbersome.  At some
point, you trust the developer's notion of a logical unit to be
sensible.

So I guess I'm not sure what your complaint is. You don't like the
GIT_TRACE_FOO versus GIT_TRACE_BAR syntax?  Or you disagree with the
logical unit I chose for packet traces? If the latter, then I welcome
improvement patches.

> To put it another and opposite way, I wonder if it would be better to
> instead use a single output stream named by GIT_TRACE and add trace event
> class prefix to the output for classes like SETUP and PACKET (again, not a
> rhetorical question).

That was actually my original design (that I didn't submit to the list).
But I rejected it because:

  1. Even though you generally want to see several trace types in
     chronological order, you might want the flexibility of putting
     different traces in different locations. The current packet code
     doesn't dump the pack at all, assuming it is uninteresting binary
     goo (because for my purposes, the logical unit was the
     negotiation). But let's say for example that you _do_ want to dump
     the pack. If I have (just making up names):

        GIT_TRACE=/tmp/foo
        GIT_TRACE_CLASS=packet,incoming-packfile

     then you get everything in /tmp/foo, and you are stuck sorting the
     trace lines from the binary goo yourself. It's more natural to do:

       GIT_TRACE_PACKET=1 ;# send to stderr
       GIT_TRACE_INCOMING_PACKFILE=/tmp/dump.pack

  2. Multiple variables made invoking a little more cumbersome. If the
     trace variables are reasonable logical units, you probably only want
     to see one at a time. If you're interested in debugging packet
     traces, you probably don't care about seeing the exec-tracing. It's
     useless cruft. So you do:

       GIT_TRACE_PACKET=<whatever> git ...

     which to my mind is much simpler than

       GIT_TRACE=<whatever> GIT_TRACE_CLASS=packet git ...

     It's less typing, and conceptually simpler. And I say this not just
     hypothetically, but because I had originally implemented it the
     other way and found it annoying.

     Now I do recognize that I am optimizing for one case I envision as
     the common case, and it's a trade-off. If your <whatever> is long,
     then putting multiple facilities to the same place is more
     cumbersome:

       GIT_TRACE_FOO=<whatever> GIT_TRACE_BAR=<whatever>

     but in my experience, <whatever> was usually "1".

You could do some hybrid like:

  GIT_TRACE=packet,exec:/path/to/dumpfile

but I didn't see any point in getting very complex with parsing.

> Also instead of wasting environment variable names, it might be a more
> compact design from the user's point of view if we took a list of trace
> event classes in a single environment variable, e.g.
> 
> 	GIT_TRACE_CLASS=setup,packet \
>         GIT_TRACE=/tmp/tr \
>         git push
> 
> I dunno.

I think I covered that pretty well above, but you lose the flexibility
of pushing different trace types to different places if you want to.

-Peff
