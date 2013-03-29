From: Jeff King <peff@peff.net>
Subject: Re: Minor bug in git branch --set-upstream-to adding superfluous
 branch section to config
Date: Fri, 29 Mar 2013 13:23:07 -0400
Message-ID: <20130329172307.GA11099@sigill.intra.peff.net>
References: <CAD7mMPW=jr6PaAc50h-Wpf42-UPrn0A5KmisqXNXqqLv78AEgg@mail.gmail.com>
 <20130329170032.GA3552@sigill.intra.peff.net>
 <87ip4ayvfn.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phil Haack <haacked@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Mar 29 18:23:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULd1f-0005Zq-5D
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 18:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756371Ab3C2RXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 13:23:10 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48451 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756258Ab3C2RXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 13:23:09 -0400
Received: (qmail 7391 invoked by uid 107); 29 Mar 2013 17:24:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Mar 2013 13:24:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Mar 2013 13:23:07 -0400
Content-Disposition: inline
In-Reply-To: <87ip4ayvfn.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219511>

On Fri, Mar 29, 2013 at 06:20:28PM +0100, Thomas Rast wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think what happens is that the config editor runs
> > through the files linearly, munging whatever lines necessary for the
> > requested operation, and leaving everything else untouched (as it must,
> > to leave comments and whitespace intact). But it does not keep a
> > look-behind buffer to realize that a section name is now obsolete (which
> > we don't know until we get to the next section, or to EOF). In the worst
> > case, this buffer can grow arbitrarily large, like:
> >
> >   [foo]
> >   # the above section is now empty
> >   # but we have to read through all of
> >   # these comments to actually
> >   # realize it
> >   [bar]
> 
> If we treat this case as having a bunch of comments that make the
> section non-empty, then we both avoid needing an arbitrarily large
> lookbehind and deleting the user's precious comments...
> 
> I.e. the rule would be that we only delete the section if there is
> nothing but whitespace until the next section header.

I think that is sane. Technically it does not remove the need for the
buffer, unless we are also collapsing whitespace (which I think is
probably a sane thing to do, too). I'm looking at a patch now...

-Peff
