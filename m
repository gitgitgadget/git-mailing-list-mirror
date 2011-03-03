From: Jeff King <peff@peff.net>
Subject: Re: Git changes permissions on directories when deleting files.
Date: Thu, 3 Mar 2011 10:16:09 -0500
Message-ID: <20110303151608.GD1074@sigill.intra.peff.net>
References: <AANLkTimx7s94wjPasgdY7O9eoyzXXmhWm6f+CB0_2sv3@mail.gmail.com>
 <AANLkTimBrUo_O6sjhSEf2sPKrYhjMcr24hwRe0kH4CgO@mail.gmail.com>
 <20110301194428.GD10082@sigill.intra.peff.net>
 <AANLkTimCzBwsz4TV=jEGeSEScVtgwmGEiDWOomaeTgWD@mail.gmail.com>
 <20110301200805.GA18587@sigill.intra.peff.net>
 <AANLkTint3PARNNN4cpic8XG6HsM3AAGuX5a+oeXfFNx=@mail.gmail.com>
 <vpqmxlea7w1.fsf@bauges.imag.fr>
 <AANLkTi=UX7VNH+biFgn0FQawP-ttCjW2D7SMf2n6XB6w@mail.gmail.com>
 <20110301210852.GB21429@sigill.intra.peff.net>
 <AANLkTi=nFMDHR5WL=TiFmshFkxLMF9N4dNEjqw+r7wyh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Computer Druid <computerdruid@gmail.com>, git@vger.kernel.org
To: Chad Joan <chadjoan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 16:16:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvAGH-0008JA-2L
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 16:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758190Ab1CCPQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 10:16:12 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57563 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756354Ab1CCPQL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 10:16:11 -0500
Received: (qmail 27816 invoked by uid 111); 3 Mar 2011 15:16:10 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 03 Mar 2011 15:16:10 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Mar 2011 10:16:09 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=nFMDHR5WL=TiFmshFkxLMF9N4dNEjqw+r7wyh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168396>

On Wed, Mar 02, 2011 at 10:48:00PM -0500, Chad Joan wrote:

> It seems to be working!  I've tried it with 'git rm' and when pulling
> deletions.

Great.

> I imagine that race condition can happen if files in the directory are
> being modified while git does an rmdir?  If that's the case then I'm
> not too worried.  There is only one other programmer that might be
> working with me at the same time on an infrequently used directory.

The race condition I mentioned earlier was for a different workaround.
Basically there are two strategies, each with a difference race:

  1. Don't rmdir on non-empty directories. This means we have to opendir
     the directory and look for entries before rmdir(). If there is file
     activity in the directory while we are looking we may think it is
     empty when it's not and rmdir(), screwing up the permissions.

  2. Before any rmdir, check permissions. Do the rmdir, and then restore
     the permissions if rmdir fails. The race here is if somebody is
     modifying the permissions on a non-empty directory, we may
     overwrite their changes.

Obviously the patch does (2), so there is still that race.

> diff -crB git-1.7.3.4/dir.c git-1.7.3.4-new/dir.c

Context diff? Eww. There is this awesome tool called "git" that can help
you with managing versions of software. :)

-Peff
