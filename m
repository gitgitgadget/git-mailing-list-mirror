From: Jeff King <peff@peff.net>
Subject: Re: cloning a namespace downloads all the objects
Date: Fri, 16 Nov 2012 09:34:18 -0800
Message-ID: <20121116173416.GA13268@sigill.intra.peff.net>
References: <CAMK1S_hdsgXoPcSn__htpGCpmCsAGb9j+m+SvxtO_69eqC92gA@mail.gmail.com>
 <7vvcd57b32.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Josh Triplett <josh@joshtriplett.org>,
	Git Mailing List <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 18:34:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZPoV-00073w-1J
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 18:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621Ab2KPRe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 12:34:28 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50502 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981Ab2KPReZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 12:34:25 -0500
Received: (qmail 29023 invoked by uid 107); 16 Nov 2012 17:35:14 -0000
Received: from mcb0536d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.5.203)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Nov 2012 12:35:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Nov 2012 09:34:18 -0800
Content-Disposition: inline
In-Reply-To: <7vvcd57b32.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209887>

On Fri, Nov 16, 2012 at 08:43:13AM -0800, Junio C Hamano wrote:

> > I have a repo on a server, which contains, as namespaces, the contents
> > of several different repos of varying sizes.  When I run a clone
> > command for the smallest of the namespaces (I have a script that
> > intercepts the clone and sets GIT_NAMESPACE appropriately), I get the
> > correct set of refs, but *all* the objects from *all* the namespaces.
> >
> > And since no refs from the other namespaces have come down, a 'git gc
> > --prune=now', run immediately after, reduces the size of
> > ".git/objects" to the size I would expect for just that small
> > namespace.
> >
> > In effect, it is bringing down data that is not reachable and will be
> > wiped out on the next gc.
> >
> > Is this expected?
> 
> I do not think so.
> 
> This was done with a series between a1bea2c (ref namespaces:
> infrastructure, 2011-07-05) and bf7930c (ref namespaces: tests,
> 2011-07-21); Josh, care to comment on and to look into it?

I'd guess that the "create_full_pack" logic in create_pack_file is to
blame. The client asked for everything we advertised, so we pass "--all"
to pack-objects rather than giving it the specific list of tips.

We'd have to either fix that logic, or teach the pack-objects subprocess
to respect GIT_NAMESPACE when processing --all.

-Peff
