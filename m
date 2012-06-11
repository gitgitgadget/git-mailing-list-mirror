From: Jeff King <peff@peff.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Mon, 11 Jun 2012 17:14:14 -0400
Message-ID: <20120611211414.GA32061@sigill.intra.peff.net>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
 <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch>
 <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
 <20120611172732.GB16086@thunk.org>
 <20120611183414.GD20134@sigill.intra.peff.net>
 <0450a24b1f53420f36a3d864c50536cb@ulrik.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ted Ts'o <tytso@mit.edu>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Mon Jun 11 23:14:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeBwM-0003a8-5g
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 23:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234Ab2FKVOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 17:14:18 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:50396
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110Ab2FKVOR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 17:14:17 -0400
Received: (qmail 9922 invoked by uid 107); 11 Jun 2012 21:14:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jun 2012 17:14:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2012 17:14:14 -0400
Content-Disposition: inline
In-Reply-To: <0450a24b1f53420f36a3d864c50536cb@ulrik.uio.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199733>

On Mon, Jun 11, 2012 at 10:44:39PM +0200, Hallvard Breien Furuseth wrote:

> >OK, so that 4.5 is at least a respectable percentage of the total
> >repo
> >size. I suspect it may be worse for small repos in that sense, (...)
> 
> 'git gc' gave a 3100% increase with my example:
> 
>     $ git clone --bare --branch linux-overhaul-20010122 \
>         git://git.savannah.gnu.org/config.git
>     $ cd config.git/
>     $ git tag -d `git tag`; git branch -D master
>     $ du -s objects
>     624     objects
>     $ git gc
>     $ du -s objects
>     19840   objects
> 
> Basically: Clone/fetch a repo, keep a small part of it, drop the
> rest, and gc.  Gc explodes all the objects you no longer want.

I would argue that this is not a very interesting case in the first
place, since the right thing to do is use "clone --single-branch"[1] to
void transferring all of those objects in the first place.

But there are plenty of variant cases, where you are not just deleting
all of the refs, but rather doing some manipulation of the branches,
diffing them to make sure it is safe to drop some bits, running
filter-branch, etc. And it would be nice to make those cases more
efficient.

-Peff

[1] It looks like "--single-branch" does not actually work, and still
    fetches master. I think this is a bug in the implementation of
    single-branch (it looks like it fetches HEAD unconditionally).
    +cc Duy.
