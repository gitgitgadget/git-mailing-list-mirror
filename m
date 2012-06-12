From: Jeff King <peff@peff.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Tue, 12 Jun 2012 13:50:46 -0400
Message-ID: <20120612175046.GA16522@sigill.intra.peff.net>
References: <20120611183414.GD20134@sigill.intra.peff.net>
 <20120611211401.GA21775@thunk.org>
 <20120611213948.GB32061@sigill.intra.peff.net>
 <20120611221439.GE21775@thunk.org>
 <20120611222308.GA10476@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206112024110.23555@xanadu.home>
 <20120612171048.GB12706@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121326490.23555@xanadu.home>
 <20120612173214.GA16014@sigill.intra.peff.net>
 <CAJo=hJvMtfVhadYowvVE0zUhDpbViXqGsvkmHpJpuynySLwb3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>, Ted Ts'o <tytso@mit.edu>,
	Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 19:50:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeVEz-0004L4-JL
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 19:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372Ab2FLRut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 13:50:49 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:51209
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab2FLRus (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 13:50:48 -0400
Received: (qmail 23158 invoked by uid 107); 12 Jun 2012 17:50:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jun 2012 13:50:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jun 2012 13:50:46 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJvMtfVhadYowvVE0zUhDpbViXqGsvkmHpJpuynySLwb3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199820>

On Tue, Jun 12, 2012 at 10:45:22AM -0700, Shawn O. Pearce wrote:

> > Then those objects will remain in the cruft pack. Which is why, as I
> > said, it is not generally safe to just delete a cruft pack. However,
> > when you do a full repack, those objects will be copied into the new
> > pack (because they are referenced). Which is why I am claiming that it
> > is safe to remove cruft packs at that point.
> 
> But there is a race condition with a concurrent fetch and a concurrent
> repack. If that fetch needs those cruft objects, and sees them in the
> cruft pack, and the repack sees the references before the fetch, the
> repacker might delete things the fetch is about to reference and that
> will leave you with a corrupt repository.
> 
> I think we already have this race condition with loose unreachable
> objects whose mtimes are older than 2 weeks; they are removed by prune
> but may have just become reachable by a concurrent fetch that doesn't
> overwrite them because they already exist, and doesn't update the
> mtime because they aren't writable.

Correct. There is a race condition, but it is there already. I have
discussed this with other GitHub folks, because we prune fairly
aggressively (in our case it would be a push, not a fetch, of course).
So far we have not had any record of it actually happening in practice.

We could close it in both cases by tweaking the mtime of the file
containing the object when we decide not to write because the object
already exists.

-Peff
