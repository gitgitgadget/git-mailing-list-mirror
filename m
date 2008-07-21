From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Ensure that SSH runs in non-interactive mode
Date: Sun, 20 Jul 2008 20:14:22 -0400
Message-ID: <20080721001422.GB12454@sigill.intra.peff.net>
References: <1216487215-6927-1-git-send-email-fredrik@dolda2000.com> <1216490252.10694.58.camel@koto.keithp.com> <1216491512.3911.9.camel@pc7.dolda2000.com> <alpine.DEB.1.00.0807201214060.3305@eeepc-johanness> <7v63r0bejy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Fredrik Tolf <fredrik@dolda2000.com>,
	Keith Packard <keithp@keithp.com>, git@vger.kernel.org,
	"Edward Z. Yang" <edwardzyang@thewritingpot.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 02:15:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKj3m-0007yz-0X
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 02:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926AbYGUAO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 20:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755950AbYGUAOZ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 20:14:25 -0400
Received: from peff.net ([208.65.91.99]:1529 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754372AbYGUAOY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 20:14:24 -0400
Received: (qmail 6881 invoked by uid 111); 21 Jul 2008 00:14:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 20 Jul 2008 20:14:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Jul 2008 20:14:22 -0400
Content-Disposition: inline
In-Reply-To: <7v63r0bejy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89274>

On Sun, Jul 20, 2008 at 11:23:13AM -0700, Junio C Hamano wrote:

> I think that is a very sensible approach, but just like we have a few
> "built-in" function-header regexps with customization possibilities for
> the user, we might want to:
> 
>  * Have that "-x", "-T" in the command line we generate for OpenSSH;

I am slightly negative on this, because we are setting OpenSSH
preferences behind the user's back that they would not normally expect
git to be tampering with.

I think the expectation for this is that it impacts only the ssh session
used by git.  But because OpenSSH supports the concept of "master" and
"slave" sessions (i.e., it can multiplex many sessions over a single ssh
session, avoiding authentication and thus reducing latency until the
start of the session), what you do in one session can impact other
sessions. In particular, if the 'master' does not have x11 forwarding
(because it happens to be started by git), then slave connections do not
get it. So a user with X11Forwarding and ControlMaster set in his config
would usually have everything work, but bad timing with the
git-initiated session as the master would unexpectedly break his
X11Forwarding for other sessions.

I don't know how commonly the ControlMaster option for openssh is used.
I also don't know if this should simply be considered a bug in openssh,
since it silently ignores the request for X forwarding.  Personally, I
will not be affected because I don't do X forwarding by default, anyway.
But I thought I would raise the point.

-Peff
