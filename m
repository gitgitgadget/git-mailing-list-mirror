From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: protect against disappearing packs
Date: Fri, 14 Oct 2011 09:07:03 -0400
Message-ID: <20111014130703.GB7808@sigill.intra.peff.net>
References: <20111014012320.GA4395@sigill.intra.peff.net>
 <4E97DF63.104@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, git-dev@github.com,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 15:07:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REhTr-0007kr-VC
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 15:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab1JNNHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 09:07:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60521
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899Ab1JNNHH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 09:07:07 -0400
Received: (qmail 8814 invoked by uid 107); 14 Oct 2011 13:07:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Oct 2011 09:07:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Oct 2011 09:07:03 -0400
Content-Disposition: inline
In-Reply-To: <4E97DF63.104@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183571>

On Fri, Oct 14, 2011 at 09:06:11AM +0200, Johannes Sixt wrote:

> Am 10/14/2011 3:23, schrieb Jeff King:
> > In practice, however, adding this check still has value, for
> > three reasons.
> > 
> >   1. If you have a reasonable number of packs and/or a
> >      reasonable file descriptor limit, you can keep all of
> >      your packs open simultaneously. If this is the case,
> >      then the race is impossible to trigger.
> 
> On Windows, we cannot remove files that are open. If I understand
> correctly, this patch keeps more files open for a longer time. Is there
> any chance that packfiles remain now open until an unlink() call?
> 
> I am not worried about parallel processes (we already have a problem
> there), but that this can now happen within a single process, i.e., that a
> single git-repack -a -d -f would now try to unlink a pack file that it
> opened itself and did not close timely.
> 
> I'll test your patch later this weekend to see whether the test suite
> finds something. But perhaps you know the answer already?

With two parallel processes, this will definitely increase the
likelihood of a deleted file being open. That is the point. :)

Within a single process, I don't think so. This change impacts only
pack-objects, which always runs as a separate process, and never deletes
packs itself. The most likely problematic code path would be "git
repack -d", but it waits for pack-objects to complete successfully
before removing any packs.

-Peff
