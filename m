From: Jeff King <peff@peff.net>
Subject: Re: Git pack - repo size doubled
Date: Thu, 24 Feb 2011 03:31:38 -0500
Message-ID: <20110224083138.GA26439@sigill.intra.peff.net>
References: <ik549p$pq8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Thu Feb 24 09:31:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsWbt-0007Ct-M9
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 09:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615Ab1BXIbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 03:31:37 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48250 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753773Ab1BXIbg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 03:31:36 -0500
Received: (qmail 20852 invoked by uid 111); 24 Feb 2011 08:31:35 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 08:31:35 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 03:31:38 -0500
Content-Disposition: inline
In-Reply-To: <ik549p$pq8$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167783>

On Thu, Feb 24, 2011 at 09:19:06AM +0100, Maaartin wrote:

> I'm using git version 1.7.3.3 under cygwin (W XP64). When I tried
> 
> git repack -A -d --depth=255 --window=255 --window-memory=4g
> 
> I've got the message
> 
> rm: cannot remove `pack-c75642be5314b1a98ddfcf0d51ac838db4af75ad.pack':
> Device or resource busy

Presumably some git process still has the pack open, and Windows can't
delete open files. The process which removes the old pack is different
from the one that creates the new pack, so there shouldn't be conflict
there. Were you running any other git programs at the time?

> It seems like the file hadn't got closed. The non-deletion of the file
> roughly doubles the repo size (134070 KiB instead of 67470 KiB).
> 
> - Can I manually remove the file?

Probably. Move it (and its associated .idx file) out of the pack
directory, and then run "git fsck" to make sure all is well.

> - If I do it, does "git fsck" suffice to make sure, everything's all right?

As a general rule, almost certainly, but there is one corner case. "git
fsck" will proceed from your refs and reflogs and check that nothing is
missing.

But it's possible that you had unreferenced objects in the old pack
which will now be lost. In practice, this doesn't really matter much.
Due to reflogs, things don't tend to be unreferenced. And even if they
are, they are probably worthless old cruft that was expired from the
reflog.

In your case, it is even more certain. Since you used "-A", unreachable
objects in the original pack were exploded into loose objects. So
assuming that process worked correctly, then everything in that pack is
duplicated.

> - Would creating of multiple packs work better? What "--max-pack-size"
> would you recommend?

It shouldn't make a difference. This is about removing the old pack; it
shouldn't matter how many new packs you've made, unless there is some
bug.

-Peff
