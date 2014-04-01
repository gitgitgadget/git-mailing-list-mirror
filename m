From: Jeff King <peff@peff.net>
Subject: Re: fast-import deltas
Date: Tue, 1 Apr 2014 09:15:12 -0400
Message-ID: <20140401131512.GA19321@sigill.intra.peff.net>
References: <20140401102554.GA32231@glandium.org>
 <20140401114502.GA15549@sigill.intra.peff.net>
 <20140401130703.GA1479@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Apr 01 15:15:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUyXD-0004DG-0a
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 15:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbaDANPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 09:15:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:51712 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751255AbaDANPO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 09:15:14 -0400
Received: (qmail 30816 invoked by uid 102); 1 Apr 2014 13:15:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 08:15:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 09:15:12 -0400
Content-Disposition: inline
In-Reply-To: <20140401130703.GA1479@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245588>

On Tue, Apr 01, 2014 at 10:07:03PM +0900, Mike Hommey wrote:

> > For my own curiosity, how does this differ from what is in
> > contrib/remote-helpers/git-remote-hg?
> 
> contrib/remote-helpers/git-remote-hg does a local mercurial clone before
> doing the git conversion. While this is not really a problem for most
> mercurial projects, it tends to be slow with big ones, like the firefox
> source code. What I'm aiming at is something that can talk directly to a
> remote mercurial server.

Ah, that makes sense. Thanks for explaining.

> >   2. Git does not store on-disk deltas between objects that are not in
> >      the same packfile. So you'd only be able to delta against an object
> >      that came in the same stream (or you'd have to "fix" the packfile
> >      on disk by adding an extra copy of the delta base, but that
> >      probably eliminates any savings).
> 
> Arguably, this would make the most difference on initial clone of big
> projects, or large incremental updates (like, after a few weeks), which
> would use a single pack anyways.

Yeah. The nice thing is that this can be an opportunistic optimization.
If the delta base is part of the same output stream, then send the
delta. Otherwise, you can always fall back to reconstructing and sending
the full object yourself.

> It seems to me fast-import keeps a kind of human readable format for its
> protocol, i wonder if xdelta format would fit the bill. That being said,
> I also wonder if i shouldn't just try to write a pack on my own...

The fast-import commands are human readable, but the blob contents are
included inline. I don't see how sending a binary delta is any worse
than sending a literal binary blob over the stream.

-Peff
