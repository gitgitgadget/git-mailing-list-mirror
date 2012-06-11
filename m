From: Jeff King <peff@peff.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Mon, 11 Jun 2012 13:46:28 -0400
Message-ID: <20120611174628.GA20134@sigill.intra.peff.net>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
 <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch>
 <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206111249270.23555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ted Ts'o <tytso@mit.edu>, Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 19:46:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se8hG-0006bk-NU
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 19:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412Ab2FKRqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 13:46:32 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:50177
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738Ab2FKRqb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 13:46:31 -0400
Received: (qmail 6142 invoked by uid 107); 11 Jun 2012 17:46:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jun 2012 13:46:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2012 13:46:28 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1206111249270.23555@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199683>

On Mon, Jun 11, 2012 at 01:04:07PM -0400, Nicolas Pitre wrote:

> IIRC, the 2 weeks number was instored when there wasn't any reflog on 
> HEAD and the only way to salvage lost commits was to use 'git fsck 
> --lost-found'.  These days, this is used only as a safety measure 
> because there is always a tiny window during which objects are dangling 
> before they're finally all referenced as you say.  But someone would 
> have to work hard to hit that race even if the delay was only 30 
> seconds.  So realistically this could even be set to 1 hour.

Nope, the HEAD reflog dates back to bd104db (enable separate reflog for
HEAD, 2007-01-26), whereas the discussion leading to gc.pruneExpire was
in 2008. See this sub-thread for the discussion on the time limit:

  http://thread.gmane.org/gmane.comp.version-control.git/76899/focus=76943

The interesting points from that thread are:

  1. You might care about object prune times if your session is
     interrupted. So imagine you are working on something, do not
     commit, go home for the weekend, and then come back.

     I think we are OK with most in-progress operations, because any
     blobs added to the index will of course be considered reachable and
     not pruned. What would hurt most is that you could do:

       $ hack hack hack
       $ git add foo
       $ hack hack hack
       $ git add foo
       $ hack hack hack
       [oops! I realized I really wanted the initial version of foo!]
       $ git fsck --lost-found

     If your session is interrupted during the third "hack hack hack"
     bit, a short prune might lose the initial version. Of course,
     that's _if_ a gc is run in the middle. So I find it possible, but
     somewhat unlikely.

  2. If a branch is deleted, all of its reflogs go away immediately. A
     short expiration time would mean that the objects will probably go
     away at the next "gc".

     In many cases, you will be saved by the HEAD reflog, which stays
     around until the real expiration is reached. But not always (e.g.,
     server-side reflogs).

     I'd much rather address this in the general case by saving
     deleted-branch reflogs, though I know you and I have disagreed on
     that in the past.

One issue not brought up in that thread is that of bare repositories,
which do not have reflogs enabled by default. In that case, the 2-week
prune window is really doing something.

I really wonder if there is a good reason not to turn on reflogs for all
repositories, bare included. We have them on for all of the server-side
repositories at github, and they have been invaluable for resolving
many support tickets from people who forced a push without realizing
what they were doing.

-Peff
