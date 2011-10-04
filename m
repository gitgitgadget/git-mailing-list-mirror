From: Jeff King <peff@peff.net>
Subject: Re: Git ksshaskpass to play nice with https and kwallet
Date: Tue, 4 Oct 2011 06:50:08 -0400
Message-ID: <20111004105008.GA11789@sigill.intra.peff.net>
References: <4E8ADDCF.6090406@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 12:50:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB2Zu-0001Rd-FD
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 12:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756076Ab1JDKuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 06:50:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52104
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755895Ab1JDKuL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 06:50:11 -0400
Received: (qmail 7266 invoked by uid 107); 4 Oct 2011 10:55:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Oct 2011 06:55:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2011 06:50:08 -0400
Content-Disposition: inline
In-Reply-To: <4E8ADDCF.6090406@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182758>

On Tue, Oct 04, 2011 at 12:19:59PM +0200, Michael J Gruber wrote:

> But Git calls the askpass helper with a command line like
> /usr/bin/ksshaskpass Username for 'bitbucket.org':
> and once again with
> /usr/bin/ksshaskpass Password for 'bitbucket.org':
> So far so good.
> 
> But when asked to store the credentials in the KDE wallet, ksshaskpass
> tries (too) hard to guess a good key from that line. And for both
> invocations, it comes up with the same key (the URL), so that when the
> password info is needed, the username info from the wallet is returned.
> Authentication fails.
> Far from good.

Neat. I didn't know ksshaskpass would do that. I wondered for a minute
if all of the credential helper stuff could have gone through the
askpass interface. But I don't think so.

One problem is that the askpass interface only lets us ask for one thing
at a time. So even with your clever hack, it will end up storing two
separate keys: Username@host and Password@host. But it has no idea
they're connected. So if you store "user1 / pass1", then try to push to
"user2@host", we would silently use the password for user1.

On top of that, there isn't much contextual information. I guess they
assumed the guessing would be used for "ssh". But it means that a stored
ssh password could potentially be used for git, and vice versa. I guess
you could get around that by making the host field longer and more
descriptive (i.e., a full url).

-Peff
