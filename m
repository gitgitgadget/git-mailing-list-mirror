From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Mon, 7 Mar 2011 18:39:02 -0500
Message-ID: <20110307233902.GA20447@sigill.intra.peff.net>
References: <20110225133056.GA1026@sigill.intra.peff.net>
 <201102251658.22678.johan@herland.net>
 <20110301215907.GA23945@sigill.intra.peff.net>
 <201103020121.54690.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 00:39:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwk1E-0005JI-4r
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 00:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595Ab1CGXjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 18:39:10 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57121 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989Ab1CGXjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 18:39:09 -0500
Received: (qmail 9646 invoked by uid 111); 7 Mar 2011 23:39:07 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Mar 2011 23:39:07 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Mar 2011 18:39:02 -0500
Content-Disposition: inline
In-Reply-To: <201103020121.54690.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168620>

On Wed, Mar 02, 2011 at 01:21:54AM +0100, Johan Herland wrote:

> Just grepping through a "git log" from git.git master, I can find one 
> almost-false-positive in b6b84d1 ("---" appears slightly indented), and 
> grepping through linux-2.6 master, I find plenty potential for false 
> positives:
> 
>   a2d49358ba9bc93204dc001d5568c5bdb299b77d (almost false positive)
>   20cbd3e120a0c20bebe420e1fed0e816730bb988 (almost false positive)
>   68845cb2c82275efd7390026bba70c320ca6ef86 (false positive)
>   5e553110f27ff77591ec7305c6216ad6949f7a95 (false positive)
>   9638d89a75776abc614c29cdeece0cc874ea2a4c (false positive)

There is actually one false positive in git.git (1dfcfbc), but it looks
like a broken commit message in the first place (IOW, "---" _was_
special here, and it got broken during application). It appears many
times in linux-2.6, but in most I examined it looks like a similar case:
it _should_ have been removed during git-am or equivalent, but for some
reason was not, and the result is "---" cruft at the bottom of the
message, or sometimes a bunch of irrelevant patch text stuck in the
message.

The ones you mentioned are indeed false positives. I wonder if linux-2.6
is really a good repo to look at, though. Screwups aside, many patch
applications are happening using "git am", so of course we wouldn't see
the true number of false positives, as they were already mangled before
they made it into the repo.

> Remember that developers sometimes cut-n-paste output from other programs 
> (debug sessions, performance benchmarks, etc.) into their commit message, 
> and that makes a false positive a lot more likely to slip through.

Yeah, that's my biggest concern. I just really foresee myself getting
annoyed by typing "--- nOtes ---", or "-- Notes ---". It's just a few
characters shorter, but "---" is really less error prone.

> > Or maybe the divider should be configurable and default to something
> > long. But clueful people can set it to "---". That kind of seems like
> > overkill, though.
> 
> Not sure that would help. I consider myself "clueful" enough that I'd likely 
> set it to "---", but I also know myself well enough that if I pasted some 
> debug/performance output into a commit message, and that output happened to 
> contain a "---", it would likely slip through...

I think you're arguing both sides here. Making it "---" is too
error-prone that we should make the decision on behalf of everyone to
choose something else. Yet if given the opportunity to make the
decision, you would choose "---"?  :)

I am really leaning towards configurability. Somebody else pointed out
that we would probably want it translatable anyway, so we will have to
deal with an arbitrary string anyway.

> I find myself using -v every now and then, to just have the diff handy while 
> I construct the commit message. Makes it easier to refer to function names, 
> etc. in the commit message.

My new tests cover this (and --cleanup=verbatim leaving both intact).

> Indeed, the notes rewrite does not depend on the post-rewrite hook at all.

Yeah, I was thinking of the config you have to setup, which I had not
done before. The original patch actually did OK with it, but we created
useless extra "notes copy" commits on the notes ref which got
superseded. The new version just avoids the rewrite if we are doing an
edit.

So here's my new version. Still some work to be done, as noted in the
cover letter for 2/2.

  [1/2]: notes: make expand_notes_ref globally accessible
  [2/2]: commit: allow editing notes in commit message editor

-Peff
