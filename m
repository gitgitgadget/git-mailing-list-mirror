From: Jeff King <peff@peff.net>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Wed, 3 Jun 2009 15:10:50 -0400
Message-ID: <20090603191050.GB29564@coredump.intra.peff.net>
References: <20090602174229.GA14455@infidigm.net> <m3vdnda9f7.fsf@localhost.localdomain> <7vmy8p8947.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, sparse@infidigm.net,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 21:11:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBvrf-00004v-8i
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 21:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbZFCTK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 15:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbZFCTK5
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 15:10:57 -0400
Received: from peff.net ([208.65.91.99]:53296 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752594AbZFCTK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 15:10:56 -0400
Received: (qmail 25227 invoked by uid 107); 3 Jun 2009 19:11:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 03 Jun 2009 15:11:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2009 15:10:50 -0400
Content-Disposition: inline
In-Reply-To: <7vmy8p8947.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120628>

On Wed, Jun 03, 2009 at 11:28:40AM -0700, Junio C Hamano wrote:

> You _could_ do something like this patch.  Instead of showing "walk %s"
> and "got %s" lines, with occasional "Getting pack %s\n which contains %s",
> it shows and recycles a single line that shows the number of packs, walk
> actions and got actions.
> 
> This is a toy patch; it hiccups for too long while getting each pack, and
> it does not cleanly restore the display after it finishes, but I'll leave
> it to interested readers as an exercise to properly do this using the
> progress API.

This is much better, and I had roughly the same thought when I saw the
original "stop http from spewing" patch. The output is confusing, but we
need _some_ progress indicator.

Unfortunately, I don't think it's possible to give a "percent complete"
because we are fetching as we walk, meaning we don't know where the end
is until we get there (but I might be wrong, as I have never looked too
closely at the http fetch code).

So I think the best we could do is probably:

  1. summarize what we have fetched (N packs, N loose objects)
  2. show what we are currently fetching (object or pack)
  3. show the number of bytes retrieved for the current item
  4. if the server provides content-length, show the percentage
     completed for this object
  5. show the current throughput

That should give the user some eye candy to show something is happening,
and for a mostly packed repo, should come close to being an overall
progress indicator (since most of the time will be spent on one big
pack, that will be most of what the user sees, and its progress
indicator will dominate the overall time).

I suspect items 3-5 could mostly re-use the existing progress code, too.

-Peff
