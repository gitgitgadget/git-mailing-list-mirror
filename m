From: Jeff King <peff@peff.net>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Mon, 28 Mar 2011 10:21:21 -0400
Message-ID: <20110328142121.GB14763@sigill.intra.peff.net>
References: <201103260141.20798.robert.david.public@gmail.com>
 <20110326021435.GA2352@elie>
 <20110326133939.GB2859@sigill.intra.peff.net>
 <201103281055.23578.robert.david.public@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Robert David <robert.david.public@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 16:21:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4DJz-0006xj-6v
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 16:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521Ab1C1OVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 10:21:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43122
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754084Ab1C1OVY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 10:21:24 -0400
Received: (qmail 10374 invoked by uid 107); 28 Mar 2011 14:22:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Mar 2011 10:22:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Mar 2011 10:21:21 -0400
Content-Disposition: inline
In-Reply-To: <201103281055.23578.robert.david.public@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170130>

On Mon, Mar 28, 2011 at 10:55:22AM +0200, Robert David wrote:

> > If I were considering cleaning up and porting add--interactive to C, I
> > think I would probably start with just porting the "-p" patch loop
> > first. I think it's the part that most people use, and most callers
> > don't support a generic "-i" but just the "-p" interface (e.g., you can
> > do "git add -i" or "git add -p", but only "git checkout -p"). And that
> > cuts down the size of the task somewhat.
> 
> I have read all the code in git-add--interactive. If I understand that 
> correct, you mean to separate -i and -p int two different commands.
> And make the -p option more like the -i (but just only for patching).
> 
> And consequently port them to C. 

Sort of. The approach I would take would be:

  1. write patch loop code in C (i.e., the code that is going to replace
     the --patch code path from git-add--interactive.perl), and make it
     call-able from within other C programs

  2. write a new command, "git-add--interactive-patch", that behaves
     like "git-add--interactive --patch", but is based on your new C
     code.

  3. Port C callers of "git-add--interactive --patch" to the new
     interface from (1). This should be "add -p", "checkout -p", and
     "reset -p".

  4. Port non-C callers of "git-add--interactive --patch" to the new
     command from (2). This should be git-add--interactive.perl and
     git-stash.sh.

  5. Remove the perl patch code in git-add--interactive.perl; you can
     replace it with a call to git-add--interactive-patch.

But that doesn't mean that's the way it has to be done. Just what I
would do. :)

> > As far as cleanup versus features, I think Thomas would have to comment
> > on that. He is the one who did the most work on patch-mode, and
> > therefore the one who most thinks it needs cleaned up. :)
> 
> Is Thomas going to be a mentor in this task?

I hope so. I can also co-mentor if it helps.

-Peff
