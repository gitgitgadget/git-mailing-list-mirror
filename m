From: Jeff King <peff@peff.net>
Subject: Re: GSoC - Some questions on the idea of
Date: Thu, 10 May 2012 18:39:16 -0400
Message-ID: <20120510223916.GB31116@sigill.intra.peff.net>
References: <4F76E430.6020605@gmail.com>
 <4F772E48.3030708@gmail.com>
 <20120402210708.GA28926@sigill.intra.peff.net>
 <4F84DD60.20903@gmail.com>
 <20120411213522.GA28199@sigill.intra.peff.net>
 <4F872D24.8010609@gmail.com>
 <20120412210315.GC21018@sigill.intra.peff.net>
 <4F8A2EBD.1070407@gmail.com>
 <20120415021550.GA24102@sigill.intra.peff.net>
 <4FAC367E.8070006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 00:39:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSc17-0000ev-9Q
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 00:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761727Ab2EJWjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 18:39:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39242
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761578Ab2EJWjT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 18:39:19 -0400
Received: (qmail 3887 invoked by uid 107); 10 May 2012 22:39:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 May 2012 18:39:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2012 18:39:16 -0400
Content-Disposition: inline
In-Reply-To: <4FAC367E.8070006@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197647>

On Thu, May 10, 2012 at 04:43:26PM -0500, Neal Kreitzinger wrote:

> >Yes. The on-the-wire format is a packfile. We create a new packfile on
> >the fly, so we may find new deltas (e.g., between objects that were
> >stored on disk in two different packs), but we will mostly be reusing
> >deltas from the existing packs.
> >
> >So any time you improve the on-disk representation, you are also
> >improving the network bandwidth utilization.
> >
> The git-clone manpage says you can use the rsync protocol for the
> url.  If you use rsync:// as your url for your remote does that get
> you the rsync delta-transfer algorithm efficiency for the network
> bandwidth utilization part (as opposed to the on-disk representation
> part)?  (I'm new to rsync.)

Well, yes. If you use the rsync transport, it literally runs rsync,
which will use the regular rsync algorithm. But it won't be better than
the git protocol (and in fact will be much worse) for a few reasons:

  1. The object db files are all named after the sha1 of their content
     (the object sha1 for loose objects, and the sha1 of the whole pack
     for packfiles). Rsync will not run its comparison algorithm between
     files with different names. It will not re-transfer existing loose
     objects, but it will delete obsolete packfiles and retransfer new
     ones in their entirety. So it's like re-cloning over again for any
     fetch after an upstream repack.

  2. Even if you could use the rsync delta algorithm, it will never be
     as efficient as git. Git understands the structure of the packfile
     and can tell the other side "Hey, I have these objects". Whereas
     rsync must guess from the bytes in the packfiles. Which is much
     less efficient to compute, and can be wrong if the representation
     has changed (e.g., something used to be a whole object, but is now
     stored as a delta).

  3. Even if you could get the exact right set of objects to transfer,
     and then use the rsync delta algorithm on them, git would still do
     better. Git's job is much easier: one side has both sets of
     objects (those to be sent and those not), and is generating and
     sending efficient deltas for the other side to apply to their
     objects. Rsync assumes a harder job: you have one set, and
     the remote side has the other set, and you must agree on a delta by
     comparing checksums. So it will fundamentally never do as well.

-Peff
