From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 14/14] clone: give advice on how to resume a failed clone
Date: Fri, 11 Nov 2011 15:52:56 -0500
Message-ID: <20111111205256.GB20515@sigill.intra.peff.net>
References: <20111110074330.GA27925@sigill.intra.peff.net>
 <20111110075654.GN27950@sigill.intra.peff.net>
 <7vvcqrsmfx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 21:53:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROy5x-0006mT-2P
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 21:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757333Ab1KKUw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 15:52:59 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39711
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755214Ab1KKUw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 15:52:58 -0500
Received: (qmail 6104 invoked by uid 107); 11 Nov 2011 20:53:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Nov 2011 15:53:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Nov 2011 15:52:56 -0500
Content-Disposition: inline
In-Reply-To: <7vvcqrsmfx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185282>

On Thu, Nov 10, 2011 at 01:21:38PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We could make "git clone ..." automatically resume, but I'm a little
> > nervous about that. I wrote a patch that did so, and it did work, but
> > there are a lot of little hiccups as we violate the assumption that the
> > directory didn't already exist (e.g., it writes multiple fetch refspec
> > lines to the config).
> 
> Sorry, but I do not think the worry is quite justified.
> 
> The "assumption that directory didn't already exist" becomes an issue only
> if you implement your "git clone" that automatically resumes as a thin
> wrapper around the current "git clone" in the form of
> 
>     until git clone ...
>     do
> 	echo retrying...
>     done

That was sort of what my patch looked like. It didn't do the wrapper
bit; you would have to run "git clone" again to resume. I.e.:

  $ git clone http://...
  Downloading bundle: ...
  ^C
  $ git clone http://...
  Resuming bundle: ...

and the implementation was very minimal. Basically, instead of checking
that the directory exists and dying, it said "the directory exists, but
there is a resumable bundle in it, so let's keep going anyway".

You _could_ do that right, with clone saying "I got to the fetch stage",
and picking up there. But that means picking apart clone into its
various stages, and not repeating earlier stages (or making sure they're
idempotent).  And making sure that internally, later stages don't depend
on in-memory actions from the earlier stages.

And then what happens when you have different parameters? If I say "git
clone foo", and then resume with "git clone --mirror foo", what should
happen?

None of these problems are insurmountable. But it means looking over the
clone code carefully, figuring out what should happen, and then probably
breaking apart the various stages to see where we can resume from.

I wanted to start simply, and just tell the user "this is approximately
what clone would have done from here". And then the fancier automatic
bits can come later.

> Stepping back a bit, I think there are two different situations where
> resumable clone is beneficial. The "git clone" process died either by the
> machine crashing or the user hitting a \C-c, or the connection between the
> server and the "git clone" got severed for some reason.
> 
> Right now, the "got disconnected" case results in "git clone" voluntarily
> dying and as the result of this, the symptom appears the same.  But it
> does not have to be that way.  If we know the underlying transport is
> resumable, e.g. when you are fetching a prepared bundle over the wire.
>
> I have this suspicion that in practice the "got disconnected" case is the
> majority. If "git clone" does not die upon disconnect while fetching a
> bundle, but instead the fetching of the bundle is resumed internally by
> reconnecting to the server and requesting a range transfer, there is no
> risk of "writes multiple fetch refspec lines" etc, no?

I don't think it is the majority. And there are even variants of "git
disconnected" that don't work. Here are just a few cases it wouldn't
handle that I think are common:

  1. the client machine crashes or loses power; you'd like to resume
     after rebooting.

  2. the network or server goes out, but is not immediately available.
     The followup attempt to fetch fails, but you could succeed if you
     restarted the fetch a few minutes (or hours, or days) later.

  3. the user hits ^C not because they want to abort the clone entirely,
     but because they know they cannot complete the clone right now
     (e.g., they are taking their laptop off the network, or it is
     consuming too much bandwidth, or they would rather wait until later
     when they are on a faster network).

All of those mean we have to have some on-disk state that shows how far
we got, and that a totally separate process can figure out from the
state where to resume.

> Of course, it is _also_ beneficial if we made "git clone" resumable after
> you purposefully kill it (maybe you thought it will clone within minutes,
> but it turns out that it may take hours and you have to turn off the
> machine in the next five minutes before leaving the work, or something).
> A solution for that case _could_ be used for the "got disconnected" case
> by letting it voluntarily die as we currently do, but I do not think that
> is an optimal solution to the "got disconnected" case.

I see the "got disconnected, and we can immediately resume" as a
minority subset of the larger problem. If we really want to, we can
implement that while waiting for a larger solution, but I don't think it
will serve most people's needs, and then will eventually become obsolete
anyway.

-Peff
