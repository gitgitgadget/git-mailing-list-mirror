From: Jeff King <peff@peff.net>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Thu, 4 Jun 2009 12:01:52 -0400
Message-ID: <20090604160152.GA13984@sigill.intra.peff.net>
References: <20090602174229.GA14455@infidigm.net> <m3vdnda9f7.fsf@localhost.localdomain> <7vmy8p8947.fsf@alter.siamese.dyndns.org> <20090603191050.GB29564@coredump.intra.peff.net> <20090603191555.GL3355@spearce.org> <be6fef0d0906040545j7bd754e0j2c60af833e2ac4a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, sparse@infidigm.net,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 18:03:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCFPL-0002lH-TW
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 18:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756149AbZFDQBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 12:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757639AbZFDQBx
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 12:01:53 -0400
Received: from peff.net ([208.65.91.99]:48885 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756782AbZFDQBw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 12:01:52 -0400
Received: (qmail 31998 invoked by uid 107); 4 Jun 2009 16:02:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 04 Jun 2009 12:02:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Jun 2009 12:01:52 -0400
Content-Disposition: inline
In-Reply-To: <be6fef0d0906040545j7bd754e0j2c60af833e2ac4a4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120700>

On Thu, Jun 04, 2009 at 08:45:28PM +0800, Tay Ray Chuan wrote:

> I have a branch 'http-progress-indicators' at my repo
> git://github.com/rctay/git.git. It contains a patch on walker.c that
> updates the object total as the fetch goes along. The progress
> indicator says "Processing targets:..." for lack of a better name; I'm
> all for suggestions.

Thanks, I took a look at starting on a progress meter yesterday, but I
do think it makes sense to integrate with the work you are doing.

I tried your http-progress-indicators branch. A few comments:

  1. You still end up with a lot of lines of output. Some of those are
     "Getting pack $x" which we can probably get rid of in non-verbose
     mode. But we still get a different progress indicator line for each
     fetched item, which can add up to quite a lot. I was thinking of
     something like

        Fetching %s (got %d packs, %d loose): (%d/%d)

     with the substitutions:

       %s = "pack", "index", or "loose object"
       %d packs, %d loose = a running count of how much we've gotten
       %d/%d = current and total byte counts for what we are getting now

     and then you could keep everything on a single line. I don't think
     is possible with the current progress code (it doesn't let you
     restart the counter), but it should be easy with some tweaking.

  2. The current progress code can also do throughput display, which
     would be nice (see display_throughput in progress.[ch]).

  3. Your implementation calls your get_http_file_size, which does a
     separate HEAD request to get the content-length. Instead, do
     a "curl_easy_setopt(slot->curl, CURLOPT_PROGRESSFUNCTION, ...)"
     to set up a progress callback. Curl will call it with the total
     number of bytes (from the content-length header of the actual GET
     request) and the number of bytes currently downloaded.

-Peff
