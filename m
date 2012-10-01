From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitk: refresh the index before running diff-files
Date: Mon, 1 Oct 2012 18:32:37 -0400
Message-ID: <20121001223237.GC12496@sigill.intra.peff.net>
References: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com>
 <20120928202330.GA5770@sigill.intra.peff.net>
 <20120928205054.GA5985@sigill.intra.peff.net>
 <20120930000527.GB4852@bloggs.ozlabs.ibm.com>
 <20120930014203.GA10664@sigill.intra.peff.net>
 <20120930203458.GA31365@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Mackerras <paulus@samba.org>,
	Scott Batchelor <scott.batchelor@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 00:33:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIoXj-0006yo-4w
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 00:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab2JAWcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 18:32:41 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37524 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136Ab2JAWck (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 18:32:40 -0400
Received: (qmail 24123 invoked by uid 107); 1 Oct 2012 22:33:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Oct 2012 18:33:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Oct 2012 18:32:37 -0400
Content-Disposition: inline
In-Reply-To: <20120930203458.GA31365@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206775>

On Sun, Sep 30, 2012 at 01:34:58PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> > On Sun, Sep 30, 2012 at 10:05:27AM +1000, Paul Mackerras wrote:
> 
> >> Unfortunately this will wait for the git update-index command to
> >> complete, making the GUI unresponsive while it executes, and that can
> >> take minutes on a large repository (e.g. the linux kernel) on a
> >> machine with a slow disk and a cold disk cache.  We will need to make
> >> the git update-index execute asynchronously.
> >
> > Good point. We're getting out of my very limited tcl cargo-culting
> > skills now, so I'll let somebody more clueful do that fix.
> 
> You might find the following patch and discussion entertaining:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/144182
> 
> Not my itch, but it was fun to write back then. ;-)

Not really my itch either, which is why I'm trying to dump the tcl work
on somebody else. :) For what it's worth, your patch from that thread
looks like a sane approach.

I don't buy the "gitk should be read-only" argument from that thread. I
think we decided a while back[1] that the stat cache is not really a
user-visible modification; you're not updating the index in any
meaningful way that impacts the user's workflow, but merely refreshing
our cache of what is in the filesystem.  That may have performance
implications (which is why we do not do it in all commands by default),
but it really is a cache, and updating it should be no different than
updating gitk.cache (i.e., do it if we can, but do not complain if we
are in a read-only repository).

-Peff

[1] I did not track down the threads, but I consider this resolved by
    all of the discussion that led to "git diff" refreshing (and saving)
    the index rather than printing patch-less stat-dirty entries. The
    original argument against refreshing was that the stat-dirtiness was
    somehow interesting to users, but I think experience has shown that
    people are happy to have it happen magically behind the scenes.
