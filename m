From: Jeff King <peff@peff.net>
Subject: Re: git auto-repack is broken...
Date: Wed, 7 Dec 2011 19:45:15 -0500
Message-ID: <20111208004515.GA23015@sigill.intra.peff.net>
References: <CA+55aFznj49hx6Ce6NhJ1rRd2nvNyOERseyyrC6SNcW-z9dyfg@mail.gmail.com>
 <CACBZZX7Q5qb1r_Oh0QfMiWh9UAM1c6QWBn4abv-xHpFBaKuyKg@mail.gmail.com>
 <CA+55aFyq28vmo9dk-5mVm+nNn86qSjNT6VJGc09iaJo=+OP1Sg@mail.gmail.com>
 <20111202171017.GB23447@sigill.intra.peff.net>
 <7vobvqoozr.fsf@alter.siamese.dyndns.org>
 <20111202174546.GA24093@sigill.intra.peff.net>
 <CA+sFfMdeVoz8XU5j4hNn1qCHHzaiDi0Bw=QbbuU3cwT9mMPZOA@mail.gmail.com>
 <alpine.LFD.2.02.1112071709250.2907@xanadu.home>
 <20111207225318.GA21852@sigill.intra.peff.net>
 <alpine.LFD.2.02.1112071912570.2907@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Dec 08 01:45:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYS71-0002rq-Ro
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 01:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756936Ab1LHApS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 19:45:18 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42979
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754300Ab1LHApR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 19:45:17 -0500
Received: (qmail 22074 invoked by uid 107); 8 Dec 2011 00:51:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Dec 2011 19:51:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Dec 2011 19:45:15 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1112071912570.2907@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186523>

On Wed, Dec 07, 2011 at 07:18:13PM -0500, Nicolas Pitre wrote:

> > > Maybe  FETCH_HEAD should have a reflog too?
> > 
> > That might be nice. However, there is a complication, in that FETCH_HEAD
> > may contain many sha1s, but each reflog entry only has room for a single
> > sha1 transition. You could obviously encode it as a series of reflog
> > entries, but then "git show FETCH_HEAD@{1}" is not very meaningful.
> 
> What does "git show FETCH_HEAD" do now?  If it shows only one
> (presumably the first) SHA1 then its reflog doesn't have to be
> smarter, which would properly cover most cases already.

Are you proposing that it only store the first ref in the reflog, or
that we accept that a single fetch may write lots of reflog entries?

If the former, then you are missing the expiration/connectivity
properties.

If the latter, then it is not just "we only show the first one for
FETCH_HEAD@{1}", but also "the thing that used to be FETCH_HEAD@{1} does
not graduate to FETCH_HEAD@{2}, but rather FETCH_HEAD@{n} for some
unknown n". That may be an acceptable limitation; I just wanted to
mention it in case somebody can think of some clever solution.

> I certainly never did a multi-ref fetch myself.

Not consciously, perhaps, but you do it all the time without realizing
it:

  $ git clone git://git.kernel.org/pub/scm/git/git.git
  $ cd git
  $ git fetch -v origin
   = [up to date]      maint      -> origin/maint
   = [up to date]      master     -> origin/master
   = [up to date]      next       -> origin/next
   = [up to date]      pu         -> origin/pu
   = [up to date]      todo       -> origin/todo
  $ cat .git/FETCH_HEAD
  b1af9630d758e1728fc0008b3f18d90d8f87f4c5        not-for-merge   branch 'maint' of git://git.kernel.org/pub/scm/git/git
  4cb5d10b14dcbe0155bed9c45ccb94e83bd4c599                branch 'master' of git://git.kernel.org/pub/scm/git/git
  03e5527c5df33d4550ccc1446d861c0aa5689d58        not-for-merge   branch 'next' of git://git.kernel.org/pub/scm/git/git
  cc4e3f01fc6a5e09ae5bbdc464965981fae4cf39        not-for-merge   branch 'pu' of git://git.kernel.org/pub/scm/git/git
  7a02dba15bd28826344f9c14a5e2b5c57eeb7e50        not-for-merge   branch 'todo' of git://git.kernel.org/pub/scm/git/git

-Peff
