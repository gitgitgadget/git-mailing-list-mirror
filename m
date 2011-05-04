From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] git-send-email: Remember sources of Cc addresses
Date: Wed, 4 May 2011 17:35:35 -0400
Message-ID: <20110504213535.GB27779@sigill.intra.peff.net>
References: <20110415034251.GC19621@sigill.intra.peff.net>
 <4DA754A4.3090709@windriver.com>
 <20110414210913.GC6525@sigill.intra.peff.net>
 <4DA791A2.3010901@windriver.com>
 <1304525528-24757-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 23:35:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHjjS-0006iY-D9
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 23:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961Ab1EDVfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 17:35:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54622
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713Ab1EDVfh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 17:35:37 -0400
Received: (qmail 22548 invoked by uid 107); 4 May 2011 21:37:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 May 2011 17:37:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2011 17:35:35 -0400
Content-Disposition: inline
In-Reply-To: <1304525528-24757-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172771>

On Wed, May 04, 2011 at 06:12:08PM +0200, Jakub Narebski wrote:

> > Sure. Since you are actually doing SMTP, you have much more flexibility
> > in knowing what errors happen. Look in git-send-email.perl's
> > send_message, around line 1118. We use the Mail::SMTP module, but we
> > just feed it the whole recipient list and barf if any of them is
> > rejected. You could probably remember which recipients are "important"
> > (i.e., given on the command line) and which were pulled automatically
> > from the commit information, and then feed each recipient individually.
> > If important ones fail, abort the message. If an unimportant one fails,
> > send the message anyway, but remember the bad address and report the
> > error at the end.
> [...]
> This is an RFC patch preparing the way, so to speak, by remembering
> where each Cc address came from.  We could in the future treat
> $cc{'body'} / all_cc('body') differently from the rest of all_cc().
> 
> Is the approach taken here sane?

Yeah, from my cursory read, it looks like a good step forward, and I
didn't see any obvious bugs.

You'll need still more refactoring in send_message to treat them
differently at the SMTP level. We collapse all of the addresses down to
a single list via unique_email_list (and we obviously want to keep this
unique-ifying step), but that final list will have to remember where
each address came from.

> +sub all_cc {
> +	my @keys = @_;
> +	@keys = qw(initial from cc body cc-cmd) unless @keys;
> +	return map { ref($_) ? @$_ : () } @cc{@keys};
> +
> +	#return map { ref($_) ? @$_ : () } values %cc;
> +}

Nit: debugging cruft. :)

-Peff
