From: Jeff King <peff@peff.net>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Fri, 12 Apr 2013 00:35:01 -0400
Message-ID: <20130412043501.GA12942@sigill.intra.peff.net>
References: <7vwqs9jd0t.fsf@alter.siamese.dyndns.org>
 <20130411172424.GC1255@sigill.intra.peff.net>
 <20130411181103.GJ27070@google.com>
 <20130411181439.GA2820@sigill.intra.peff.net>
 <7vwqs8hmh1.fsf@alter.siamese.dyndns.org>
 <20130411200330.GA15667@odin.tremily.us>
 <7vip3shfpd.fsf@alter.siamese.dyndns.org>
 <20130411222301.GA11283@sigill.intra.peff.net>
 <20130412005748.GA17116@odin.tremily.us>
 <7vvc7sfkwn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "W. Trevor King" <wking@tremily.us>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 06:35:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQVhu-00058z-Ln
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 06:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370Ab3DLEfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 00:35:06 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41194 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267Ab3DLEfF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 00:35:05 -0400
Received: (qmail 23043 invoked by uid 107); 12 Apr 2013 04:36:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Apr 2013 00:36:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Apr 2013 00:35:01 -0400
Content-Disposition: inline
In-Reply-To: <7vvc7sfkwn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220950>

On Thu, Apr 11, 2013 at 09:11:20PM -0700, Junio C Hamano wrote:

> The --user option to git-daemon would be a good place to do that, I
> think.  Depending on what other "setuid to less privileged before
> running" programs do (I do not know offhand), we can say something
> like this perhaps?

That's a good question. I looked at (just sampling a few off the top of
my head):

  xinetd
  openbsd-inetd
  inetutils-inetd
  postfix
  dovecot
  courier

and none of them sets HOME when dropping privileges. Admittedly some of
them do not drop privileges immediately in the same way (e.g., the imap
servers need to remain root so that they can switch to the right user to
read mail). Postfix does set HOME, but only when actually "becoming" the
user to do deliveries, not at startup.

I could also be wrong on one or more of those, as that is from some
quick grepping, but I think it's clear that the norm is not to set HOME
alongside setuid (of all of them, I would say git-daemon behaves most
like the inetd utils, as it does not ever "become" users at all).

>     --user::
> 	... current description ...
>     +
>     (Like|Unlike) many programs that let you run programs as
>     specified user, the daemon does not reset environment variables
>     such as $HOME when it runs git programs like upload-pack and
>     receive-pack. Set and export HOME to point at the home directory
>     of the user you specify with this option before you start the
>     daemon, and make sure the Git configuration files in that
>     directory is readable by that user.

So choosing "Like" here, I think this makes sense.

-Peff
