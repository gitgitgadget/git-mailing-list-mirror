From: Jeff King <peff@peff.net>
Subject: [PATCHv2 0/10] pkt-line and remote-curl cleanups server
Date: Mon, 18 Feb 2013 04:12:03 -0500
Message-ID: <20130218091203.GB17003@sigill.intra.peff.net>
References: <20130216064455.GA27063@sigill.intra.peff.net>
 <20130216064929.GC22626@sigill.intra.peff.net>
 <20130217110533.GF6759@elie.Belkin>
 <20130217192830.GB25096@sigill.intra.peff.net>
 <20130218014113.GC3221@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:12:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Mm1-0005Qd-HA
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844Ab3BRJMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 04:12:08 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51647 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753642Ab3BRJMG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 04:12:06 -0500
Received: (qmail 17488 invoked by uid 107); 18 Feb 2013 09:13:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 04:13:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 04:12:03 -0500
Content-Disposition: inline
In-Reply-To: <20130218014113.GC3221@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216445>

On Sun, Feb 17, 2013 at 05:41:13PM -0800, Jonathan Nieder wrote:

> > I don't think so. Don't ERR lines appear inside their own packets?
> 
> Yes, I misread get_remote_heads for some reason.  Thanks for checking.

Thanks for bringing it up. I had not even thought about ERR at all. So
it was luck rather than skill that I was right. :)

> I'm not sure whether servers are expected to send a flush after an
> ERR packet.  The only codepath I know of in git itself that sends
> such packets is git-daemon, which does not flush after the error (but
> is not used in the stateless-rpc case).  http-backend uses HTTP error
> codes for its errors.

I just checked, and GitHub also does not send flush packets after ERR.
Which makes sense; ERR is supposed to end the conversation. I can change
GitHub, of course, but who knows what other implementations exist (e.g.,
I do not know off-hand whether gitolite has custom ERR responses). So it
seems pretty clear that just checking for a flush packet is not the
right thing, and we need to actually parse the packet contents (at least
to some degree).

> If I am reading get_remote_heads correctly, calling it with the
> following tweak should work ok.  The extra thread is just to feed a
> string into a fd-based interface and could be avoided for "list", too,
> if it costs too much.

Yeah, your patch does work, though we miss out on some of the refname
checks.  I think what I'd rather do is just teach get_remote_heads to
read from a buffer (to avoid the extra thread and pipe), and then just
run (and cache) the ref parsing unconditionally once we've read from the
server.  It shouldn't make a difference in the normal case, as we would
usually do a "list" anyway (and by caching, "list" can just feed out the
cached copy).

While looking into this, I noticed a bunch of other possible cleanups.
Patches to follow:

  [01/10]: pkt-line: move a misplaced comment
  [02/10]: pkt-line: drop safe_write function
  [03/10]: pkt-line: clean up "gentle" reading function
  [04/10]: pkt-line: change error message for oversized packet
  [05/10]: pkt-line: rename s/packet_read_line/packet_read/

These are all just cleanups I noticed while looking at pkt-line. Any of
them can be dropped, though there would be some textual conflicts for
the later patches.

  [06/10]: pkt-line: share buffer/descriptor reading implementation
  [07/10]: teach get_remote_heads to read from a memory buffer
  [08/10]: remote-curl: pass buffer straight to get_remote_heads

These all build on each other to get rid of the extra thread/pipe, which
I think is worth doing even without the rest of the series.

  [09/10]: remote-curl: move ref-parsing code up in file
  [10/10]: remote-curl: always parse incoming refs

And these ones actually fix the problem I noticed.

-Peff
