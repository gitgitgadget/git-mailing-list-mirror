From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] "git push": tellme-more protocol extension
Date: Thu, 20 Mar 2008 22:33:03 -0400
Message-ID: <20080321023303.GE1613@coredump.intra.peff.net>
References: <7vd4ppyggv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 03:33:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcX4n-0005jH-8T
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 03:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119AbYCUCdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 22:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbYCUCdI
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 22:33:08 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3110 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984AbYCUCdH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 22:33:07 -0400
Received: (qmail 16171 invoked by uid 111); 21 Mar 2008 02:33:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 20 Mar 2008 22:33:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2008 22:33:03 -0400
Content-Disposition: inline
In-Reply-To: <7vd4ppyggv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77699>

On Thu, Mar 20, 2008 at 12:58:24AM -0700, Junio C Hamano wrote:

> When both ends support this extension, the receiving end first says "I
> support tellme-more, and here are my refs".  The sending side, when it
> sees commits that it does not know about (e.g. "B" in the above example),
> can then ask "I do not know about B, but it probably is related to what I
> already have, so tell me more about it".
> 
> The receiving end then responds with list of commits that are ancestors of
> "B", and in the above example, the sender will find out that the recieving
> end also has "A".  After this exchange, the sending end can build a pack
> that contains objects between A..C, instead of having to send the full
> history leading to "C".

Hrm. It seems like we are sending a lot more data than we need. The
sender doesn't actually _care_ about A..B, which can be arbitrarily
long; he only cares about finding A.

I wonder if there's a way to for the _sender_ to claim "I have up to A",
and the receiver to send back an "OK, just send A..C." If the receiver
is currently at "B", then the sender can't figure it out from the refs
the receiver shows. But he might he might optimistically suggest it if
he has other refs pointing to "A" (like remotes/origin/master).

IOW, something like:

  [S connects to R]
  R: master is at B
  [S realizes he doesn't have B, so he shows his refs, without names]
  S: I have optimistically interesting commits: A, C
  R: I have A
  S: OK, here's C ^A

In the case that the receiver doesn't have any of those refs, then we
fall back to the old behavior. So basically rather than enumerating
the ancestors, we optimistically assume that things that are in refs are
likely to be of interest.

Two disadvantages I can think of:

  1. S actually "leaks" some knowledge about which commits he has to R
     (not refnames, but actual SHA1s). I don't know if we care about
     that or not.

  2. This can actually be _more_ network intensive than your proposal.
     It trades off sending all of the ancestors A..B for sending the tip
     of all of the refs. So if A..B is short, but you have a ton of
     local refs, it's a lose. You could maybe be smarter about the
     optimistic choice (e.g., "I'm talking with origin, therefore
     consider only refs/remotes/origin/*"). That also alleviates the
     "leak" problem since you are saying "I have this commit that I got
     from you before." But it doesn't kick in if you usually talk to one
     remote, but now are talking to a different, related one.

-Peff
