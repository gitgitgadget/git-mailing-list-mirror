From: Jeff King <peff@peff.net>
Subject: Re: Diagnosing stray/stale .keep files -- explore what is in a pack?
Date: Wed, 15 Jan 2014 04:12:20 -0500
Message-ID: <20140115091220.GB14335@sigill.intra.peff.net>
References: <CACPiFCLa3X-Xt5GwrHHA-PFj-Bi9_sW+=y2xidZ7tDbFfM26rA@mail.gmail.com>
 <CACPiFCJVx0dkkPQ=LosbAAKq7CvK6_yQL5QDHMYr5oJAS6wb6Q@mail.gmail.com>
 <201401141236.44393.mfick@codeaurora.org>
 <CACPiFCLxiCOqv=wLeq9LxisWn5T62hk8xDYwXmeFRNT05HY0iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 10:12:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3MWU-00051J-2K
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 10:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbaAOJMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 04:12:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:60960 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751362AbaAOJMW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 04:12:22 -0500
Received: (qmail 11184 invoked by uid 102); 15 Jan 2014 09:12:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jan 2014 03:12:22 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 04:12:20 -0500
Content-Disposition: inline
In-Reply-To: <CACPiFCLxiCOqv=wLeq9LxisWn5T62hk8xDYwXmeFRNT05HY0iQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240445>

On Tue, Jan 14, 2014 at 02:42:09PM -0500, Martin Langhoff wrote:

>  On Tue, Jan 14, 2014 at 2:36 PM, Martin Fick <mfick@codeaurora.org> wrote:
> > Perhaps the receiving process is dying hard and leaving
> > stuff behind?  Out-of-memory, out of disk space?
> 
> Yes, that's my guess as well. This server had gc misconfigured, so it
> hit ENOSPC a few weeks ago.
> 
> It is likely that the .lock files were left behind back then, and
> since then the clients pushing to these refs were transferring their
> whole history and still failing to update the ref, leading to rapid
> repo growth.

We see these occasionally at GitHub, too. I haven't yet figured out a
definite cause, though whatever it is, it's relatively rare.

I think the ".keep" files and the ".lock" files are in two separate
boats, though.

pack-objects creates the .keep files as a "lock" between the time it
moves them into place and when receive-pack updates the refs (so that a
simultaneous prune does not think they should be removed). Receive-pack
then updates the refs and removes the ".keep" file. However, in the
interim code, we are just updating the refs, and are careful to return
any errors rather than calling die() (so if ENOSPC prevented ref write,
that would not cause this). So for us to leave a .keep there, it is
probably one of:

  1. A few generic library functions, like xmalloc, can cause us to die.
     This should be very rare, though.

  2. We tried to unlink the keep-file, but couldn't (could ENOSPC
     prevent a deletion? I suspect it depends on the filesystem).

  3. We were killed by signal (or system crash).

Fetch-pack also will create .keep files, and it is much less careful
during the time the file exists.  However, busy servers tend to be
receiving pushes, not initiating fetches.

Actual ".lock" files are added to a signal/atexit handle that cleans
them up automatically on program exit. So those really should be caused
by system crash (or "kill -9"), and that has generally been our
experience at GitHub. But again, if ENOSPC could prevent deletion on
your filesystem, it could be related. But there is not much git can do
to clean up if unlink() fails us.

-Peff
