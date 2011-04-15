From: Jeff King <peff@peff.net>
Subject: Re: RFC: git send-email and error handling
Date: Thu, 14 Apr 2011 23:42:51 -0400
Message-ID: <20110415034251.GC19621@sigill.intra.peff.net>
References: <4DA754A4.3090709@windriver.com>
 <20110414210913.GC6525@sigill.intra.peff.net>
 <4DA791A2.3010901@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 05:43:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAZvv-0003UL-Rw
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 05:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453Ab1DODmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 23:42:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49709
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755350Ab1DODmy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 23:42:54 -0400
Received: (qmail 6236 invoked by uid 107); 15 Apr 2011 03:43:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Apr 2011 23:43:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2011 23:42:51 -0400
Content-Disposition: inline
In-Reply-To: <4DA791A2.3010901@windriver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171585>

On Thu, Apr 14, 2011 at 08:30:26PM -0400, Paul Gortmaker wrote:

> > Your setup seems different; it looks like your sendmail (or the SMTP
> > server you connect to) actually routes the mail without queueing at all,
> > and you synchronously get the final word on whether it can be delivered.
> > Or maybe it just connects to the recipient site and checks that "RCPT
> > TO" works before actually queueing. It's hard to say from the snippet
> > above. What's your MTA?
> 
> Yes, the above is true -- I'm not queuing anything locally or involving
> a local MTA.  I've set sendemail.smtpserver in my ~/.gitconfig to the
> hostname of an infrastructural server running sendmail (telnet 25 doesnt
> show me what version, but I'm told it is sendmail).

Ah. I'm not up on my sendmail config, but googling around, there are
apparently milters that will do this kind of "call-ahead" rcpt checking.

> This configuration gives me the most portability to run on any random
> machine within our org without having to wonder if it has a locally
> installed and correctly configured MTA -- it works so well, I've even
> abused git send-email to dispatch random (non-patch) mails from ad-hoc
> scripts on occasions, simply because I know everyone has git installed
> somewhere in $PATH.

Yeah, I think submitting to a central server is a very sane config if
you don't have reliably local delivery.

> > It's a little tricky, because send-email may not know the details of
> > what happened, especially if this behavior comes from a sendmail
> > wrapper rather than SMTP. We dump the message and a list of recipients
> > to an external program, and then get back a "yes it was sent" or "no it
> > was not" code. So we can't do anything clever, like say "Well, it was
> > sent, but not to one particular address, but that's OK because that
> > address was auto-harvested from a signed-off-by line".
> 
> True.  I wonder if there is some flexibility in what we do, depending
> on whether the setting is a local binary like /usr/bin/sendmail, vs.
> a hostname of a server, like it was in my case...

Sure. Since you are actually doing SMTP, you have much more flexibility
in knowing what errors happen. Look in git-send-email.perl's
send_message, around line 1118. We use the Mail::SMTP module, but we
just feed it the whole recipient list and barf if any of them is
rejected. You could probably remember which recipients are "important"
(i.e., given on the command line) and which were pulled automatically
from the commit information, and then feed each recipient individually.
If important ones fail, abort the message. If an unimportant one fails,
send the message anyway, but remember the bad address and report the
error at the end.

That wouldn't help people using a sendmail binary, but there's nothing
we can do. That transport simply doesn't supply as much information, so
it can't take advantage of the new feature. But it will be no worse off
for you adding the feature for SMTP users.

-Peff
