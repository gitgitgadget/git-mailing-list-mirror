From: Jeff King <peff@peff.net>
Subject: Re: git symbolic-ref vs. reflog (vs. rebase)
Date: Fri, 29 Apr 2011 23:58:20 -0400
Message-ID: <20110430035819.GA4673@sigill.intra.peff.net>
References: <ipek0o$l0v$1@dough.gmane.org>
 <7vk4edyqqn.fsf@alter.siamese.dyndns.org>
 <20110429224829.GC3434@sigill.intra.peff.net>
 <7vk4ecvf2c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Csaba Henk <csaba@lowlife.hu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 05:58:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QG1KL-0004mv-JV
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 05:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757243Ab1D3D6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 23:58:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51436
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755853Ab1D3D6X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 23:58:23 -0400
Received: (qmail 18602 invoked by uid 107); 30 Apr 2011 04:00:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 30 Apr 2011 00:00:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2011 23:58:20 -0400
Content-Disposition: inline
In-Reply-To: <7vk4ecvf2c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172515>

On Fri, Apr 29, 2011 at 04:00:11PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think every caller should be using "-m" these days.  I know we can't
> > _require_ it for historical reasons. But shouldn't symbolic-ref always
> > write a reflog entry? Even something like "we changed and I can't tell
> > you why" to cover older scripts that call symbolic-ref?
> 
> I think the particular instance Csaba saw in rebase may want to pass the
> reason why it flipped the HEAD.

Oh, definitely. I was thinking more for external scripts that we can't
fix.

> Flipping HEAD temporarily to another ref to do something, only to flip it
> back before giving the control back to the user, might be something a
> script may want to have a choice of not logging, so I am mildly negative
> on changing the command to unconditionally log empty entry without being
> told.

Yeah, that is a legitimate use case. But I suspect many scripts were
simply never updated after reflogs were introduced (or their authors)
were lazy, so they flip it once without a reflog, and then the next
well-behaved writer who comes along ends up writing a reflog entry that
shows a hole.

So it is a question of whether helping probably-broken users is worth
shutting off a legitimate use case. I also wonder how valuable that use
case is. As a user, I think I'd rather see _everything_ in the reflog,
even if the script-writer doesn't think it's important.

I don't know that it matters much in any case. We haven't had any bug
reports either way; and given the current behavior, one can always yell
at the script author to properly reflog.

> "update-ref" seems to write an empty entry even when not given an "-m"
> option, and we can view it as robbing a similar choice from the scripts.
> We might want to fix it.  I dunno.

I'm inclined to wait until somebody actually wants it. In the meantime
it helps users of old and/or broken scripts by providing an additional
checkpoint of state that might otherwise be missing.

-Peff
