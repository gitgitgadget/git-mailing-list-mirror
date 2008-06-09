From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] git-add--interactive: manual hunk editing mode
Date: Mon, 9 Jun 2008 16:17:34 -0400
Message-ID: <20080609201734.GA15662@sigill.intra.peff.net>
References: <200805232221.45406.trast@student.ethz.ch> <200806090746.22512.johan@herland.net> <20080609122938.GA12210@sigill.intra.peff.net> <200806091931.51221.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 09 22:18:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5np5-0000aT-9l
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 22:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbYFIURi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 16:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754863AbYFIURh
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 16:17:37 -0400
Received: from peff.net ([208.65.91.99]:3996 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758706AbYFIURh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 16:17:37 -0400
Received: (qmail 7106 invoked by uid 111); 9 Jun 2008 20:17:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 09 Jun 2008 16:17:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jun 2008 16:17:34 -0400
Content-Disposition: inline
In-Reply-To: <200806091931.51221.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84418>

On Mon, Jun 09, 2008 at 07:31:51PM +0200, Johan Herland wrote:

> > His work is about fixing up the hunk header as we apply the patch, but a
> > working "e" command in the hunk selection should probably not actually
> > apply, but simply split into two hunks for the loop.
> 
> By "split into two hunks", you mean splitting the original "index -> 
> worktree" hunk (#0) into one hunk that represents "index -> edited" (#1), 
> and another hunk that represents "edited -> worktree" (#2)?

I mean splitting the original "index -> worktree" hunk into two other
hunks, each of which is "index -> worktree" but which can be staged
separately. I.e., what the 's'plit command does, but with finer-grained
control.

But I think that is what you are trying to say...

> From a technical POV this might make sense, but AFAICS, users would always 
> want to answer 'y' to #1, and 'n' to #2 (see [1]), so from a user POV, 
> git-add--interactive should simply stage #1, and drop #2.

Yes. I assumed we wanted to maintain the separate splitting operation,
since that parallels the existing split (so the interface is consistent)
and it logically separates the two parts (you split, and then you choose
the part you want).

But honestly, I don't really see a use case that isn't covered by
"manually edit the diff and apply the hunk". And the rationale in your
"side note" indicates that you think the same way.

So now I wonder if we _can_ leverage Dscho's work here. I.e., can we
simply send the edited hunk to "git apply --recount --cached" (instead
of doing a "git apply --check")?

The main problem I see at this point is that it screws up the line
numbering for _every other hunk_, so later hunks in that file might not
apply (IIRC, we usually save up all of the "yes" hunks and apply at the
end). So it might be needed to do a --recount --check, and then actually
apply at the end.

I'll try to play around with that.

-Peff
