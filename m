From: Jeff King <peff@peff.net>
Subject: Re: repo consistency under crashes and power failures?
Date: Fri, 26 Jul 2013 23:10:17 -0400
Message-ID: <20130727031017.GA20207@sigill.intra.peff.net>
References: <rmiy597iujc.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 05:10:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2utk-0005mN-TD
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 05:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758348Ab3G0DKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 23:10:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:34804 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993Ab3G0DKT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 23:10:19 -0400
Received: (qmail 937 invoked by uid 102); 27 Jul 2013 03:10:19 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Jul 2013 22:10:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jul 2013 23:10:17 -0400
Content-Disposition: inline
In-Reply-To: <rmiy597iujc.fsf@fnord.ir.bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231225>

On Mon, Jul 15, 2013 at 01:48:23PM -0400, Greg Troxel wrote:

> I am curious if anyone has actual experiences to share, either
> 
>   a report of corruption after a crash (where corruption means that
>   either 1) git fsck reports worse than dangling objects or 2) some ref
>   did not either point to the old place or the new place)
> 
>   experiments intended to provoke corruption, like dropping power during
>   pushes, or forced panics in the kernel due to timers, etc.

I have quite a bit of experience with this, as I investigate all repo
corruption that we see on github.com, and have run experiments to try to
reproduce such corruption.

Our backend git systems are ext3 with journaling and data=ordered. We
run that on top of drbd, with two redundant machines sharing the block
device. If one dies, we fail over to the spare. Writes to the block
device are not considered committed until they are written to both
machines.

Git's scheme is to write objects (both loose and when receiving packs
over the wire) via tempfile, with an atomic link-into-place after close.
We do not fsync object files by default, but we do fsync packs. However,
it shouldn't matter as long as your filesystem orders data and metadata
writes (if it doesn't, you probably want to turn on object fsyncing).
So for our data=ordered filesystems, that's fine.

Ref writes have a similar fsync situation to loose object files. We
write the new ref to a tempfile, close, and then rename into place. If
the data and metadata writes are out of order, one could have problems
(but again, not a problem with data=ordered).

Most of the corruption we have seen at GitHub has been one of:

  1. Buggy non-core-git implementations that do not properly use
     tempfiles to create objects (Grit used to have this problem, but it
     is now fixed).

  2. Race conditions in examining ref state that can cause refs to be
     missed when determining reachability (thus you might prune objects
     that should be left). The worst of these is fixed in the current
     "master" and will be part of git v1.8.4. There are still ways that
     we can prune too much, but they are reasonably unlikely unless you
     are pruning constantly.

We did once experience some lost objects after a server failover.  After
much experimentation, we finally found out that the machine in question
had a RAID card with bad memory which would drop some writes which it
claimed to have committed after a power failure (so even fsync did not
help).

So for ordered data and metadata writes, in my experience git is quite
solid against power failures and crashes. For systems without that
guarantee, you should turn on core.fsyncobjectfiles, but I suspect you
could also see some ref corruption (and possibly index corruption, too,
as it does not fsync either).

-Peff
