From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 01:48:40 -0400
Message-ID: <20080613054840.GA27122@sigill.intra.peff.net>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <co7kgJpJNdIs2f8n_PwYKAS7MwV9t1G_P3BPr1eXTZ4ytUHcsPvVaw@cipher.nrlssc.navy.mil> <20080612041847.GB24868@sigill.intra.peff.net> <u5dYyGz0Q8KNQXnvGOEGmG2BTfT-vJCEFeSUa2I_99Q@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Wincent Colaiuta <win@wincent.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jun 13 07:49:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K72AM-00060p-K7
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 07:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbYFMFso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 01:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752288AbYFMFso
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 01:48:44 -0400
Received: from peff.net ([208.65.91.99]:1740 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555AbYFMFso (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 01:48:44 -0400
Received: (qmail 27550 invoked by uid 111); 13 Jun 2008 05:48:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 13 Jun 2008 01:48:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2008 01:48:40 -0400
Content-Disposition: inline
In-Reply-To: <u5dYyGz0Q8KNQXnvGOEGmG2BTfT-vJCEFeSUa2I_99Q@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84835>

On Thu, Jun 12, 2008 at 11:46:34AM -0500, Brandon Casey wrote:

> > stash list" and "git pull"). Not to mention that you actually _care_
> > about the stash 90 days later.
> 
> Wouldn't it usually be 30 days? Wouldn't stash objects generally be
> unreachable?

Yes, sorry, I was looking at the wrong config value.

> Also, the sequence above would not have to be performed _exactly_ at the
> expiration date. The listing of the stashes i.e. git-log, does not perform
> reflog expiration AFAIK. So the initial 'stash list' and the 'git pull' do
> not have to straddle the expiration date, they can all be performed any time
> after the expiration point to produce the above behavior.

No, but it would have to be performed _after_ the expiration, but
_before_ any auto-gc happened. So it is a smaller window than "anytime
after expiration" but not as small as a particular 30-second window.

> from reflogs even though stashes are implemented using reflogs. The big
> difference is that reflogs are created automatically and stashes are created
> by explicit user action. Automatically deleting something that git creates
> automatically is ok and desirable, doing so for something the user explicitly
> created is not necessarily so.

Wincent made this same argument. I don't really agree with it. It is
predicated on the assumption that stashing something _is_ asking for git
to remember it. My mental model of stashing is that it hasn't been saved
at all, but is rather a convenient way of naming and storing a set of
changes for a second while I do something else.  I think of it in the
same way as a register in vi: I can yank text into it for pasting
after a few commands. But I don't expect yanked text to be stored in the
register a month later.

So I think we are disagreeing not on how stashes should expire, but
rather on what a stash _is_, and what it is useful for. And I am open to
arguments that stashes are useful for longer-term storage. But I also
find the expiration behavior useful (I seem to have accumulated some
cruft in my stash list, and I expect git to clean it out during a gc,
rather than me having to clean it manually). So personally, I would not
be in favor of removing the expiration unless I saw evidence that the
utility of keeping stashes long-term outweighed the benefit of cleaning.

And that evidence is probably "here is a workflow I find useful, and
here is why it is better than any other way of doing it in git" (and
maybe the "better" is simply "new users are going to jump on this way of
using stash, even though it was not as intended").

-Peff
