From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Fri, 20 Jul 2012 11:50:32 -0400
Message-ID: <20120720155032.GC2862@sigill.intra.peff.net>
References: <20120719213225.GA20311@sigill.intra.peff.net>
 <20120719213311.GA20385@sigill.intra.peff.net>
 <7vy5mftm3q.fsf@alter.siamese.dyndns.org>
 <20120720144337.GA31946@sigill.intra.peff.net>
 <7vliietp4u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Alexey Muranov <alexey.muranov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 17:50:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsFTU-0003Ye-1j
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 17:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263Ab2GTPuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 11:50:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56569 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753179Ab2GTPue (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 11:50:34 -0400
Received: (qmail 11923 invoked by uid 107); 20 Jul 2012 15:50:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Jul 2012 11:50:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jul 2012 11:50:32 -0400
Content-Disposition: inline
In-Reply-To: <7vliietp4u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201782>

On Fri, Jul 20, 2012 at 08:42:57AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But it would mean that you cannot naively run
> >
> >   echo $sha1 >.git/refs/heads/foo
> >
> > anymore. I suspect that the packed-refs conversion rooted out many
> > scripts that did not use update-ref and rev-parse to access refs, but
> > the above does still work today. So I suspect there would be some
> > fallout. Not to mention that older versions of git would be completely
> > broken, which would mean we need a lengthy deprecation period while
> > everybody upgrades to versions of git that support the reading side.
> 
> We have that "core.repositoryversion" thing, so we could treat it
> just like "update-index --index-version 4" to make it a "flag day
> event for each repository, on the day of end-user's choice".

True. The code to handle both cases would be pretty nasty, though,
mostly because we do not isolate the filesystem calls at all right now
(i.e., there are a lot of calls to git_path("logs/%s", refname) in the
code. Which is probably not too bad, but there are a lot of implicit
reverse-conversions (e.g., walking the hierarchy and assuming that the
path you find is a refname).

If we are seriously considering doing this for the full refs namespace
anytime soon, then I'd be tempted to hold off the reflog graveyard until
then.  The code would be a lot simpler and less error-prone if we
didn't have to convert between the namespaces (you would simply not get
the reflog retention behavior in the old repositoryformatversion).

-Peff
