From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/12] tests: add initial bash completion tests
Date: Sun, 8 Apr 2012 04:12:45 -0400
Message-ID: <20120408081245.GA18407@sigill.intra.peff.net>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
 <1333854479-23260-2-git-send-email-felipe.contreras@gmail.com>
 <7vpqbiyhmu.fsf@alter.siamese.dyndns.org>
 <20120408044825.GA4296@sigill.intra.peff.net>
 <7v62daye43.fsf@alter.siamese.dyndns.org>
 <20120408054251.GA8100@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 10:13:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGnFg-0002Jh-Td
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 10:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393Ab2DHIMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 04:12:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54350
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854Ab2DHIMu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 04:12:50 -0400
Received: (qmail 1032 invoked by uid 107); 8 Apr 2012 08:12:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Apr 2012 04:12:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Apr 2012 04:12:45 -0400
Content-Disposition: inline
In-Reply-To: <20120408054251.GA8100@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194985>

On Sun, Apr 08, 2012 at 01:42:51AM -0400, Jeff King wrote:

> > Yes, but the check needs to be careful to make sure the shell that is
> > running the check is indeed bash, so that it will explicitly exec bash for
> > somebody who is running dash but exports POSIXLY_CORRECT to make GNU
> > programs (other than bash) behave more standard compliant way.
> 
> Sorry, I thought that was obvious. Yes, this:
> 
> > In other words,
> > 
> > 	if test -n "$POSIXLY_CORRECT" && test -n "$BASH"
> > 	then
> >         	: we are running bash under posix mode
> > 	elif ...
> > 
> > or somesuch.
> 
> is what I meant. Replace the "does it end in /bash" bit with
> "POSIXLY_CORRECT" but, keep the $BASH check.

BTW, if you intend to exec bash when we see a posix bash, I think you
would want to unset POSIXLY_CORRECT in case it is exported. Otherwise,
doing this:

 POSIXLY_CORRECT=1 bash ./t9902-*

would loop forever, trying to restart bash, but ending up in the POSIX
version each time. So all together:

  if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
          : we are in full-on bash mode. Great.
  elif type bash >/dev/null 2>&1; then
          # We are not bash, or are in posix mode. Run a new bash,
          # making sure not to let any posix environment variable
          # propagate.
          unset POSIXLY_CORRECT
          exec bash "$0" "$@"
  else
          echo '1..0 # SKIP skipping bash completion tests; bash not available'
          exit 0
  fi

-Peff

PS I wondered if we can continue past the "exec" in the second branch if
   it fails, and if we should be exiting explicitly. POSIX specifies
   that "exec" with a command never returns, and that is what dash does.
   Bash will continue after a failed exec. I expected it not to do so
   in posix mode, but it seems to. Which is perhaps a bug in bash, but
   one we might want to deal with. Granted, the likelihood of "type"
   succeeding but the exec failing is low, so it may not be worth caring
   about.
