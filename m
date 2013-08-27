From: Jeff King <peff@peff.net>
Subject: Re: contrib/credential/netrc/git-credential-netrc: Use of
 uninitialized value in string
Date: Tue, 27 Aug 2013 16:05:51 -0400
Message-ID: <20130827200550.GA17443@sigill.intra.peff.net>
References: <CALWbr2ynAvevTxFd3duAfFzgv0DCGTDxFUaniW-8hM+eoLiOEw@mail.gmail.com>
 <xmqqr4dfhjmg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>,
	Ted Zlatanov <tzz@lifelogs.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 22:06:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEPWk-0002lB-GB
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 22:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075Ab3H0UF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 16:05:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:49074 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753847Ab3H0UFz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 16:05:55 -0400
Received: (qmail 2111 invoked by uid 102); 27 Aug 2013 20:05:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Aug 2013 15:05:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Aug 2013 16:05:51 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr4dfhjmg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233155>

On Mon, Aug 26, 2013 at 08:56:23PM -0700, Junio C Hamano wrote:

> Antoine Pelisse <apelisse@gmail.com> writes:
> 
> > I've tried to use the netrc credential with git-send-email
> > (v1.8.4-rc2), and I've had the following log (running with -d -v):
> 
> Peff what do you think?  From credential layer's point of view, I
> think we make it totally up to the helper to decide if a request
> matches what it supports, and if a particular helper wants to make
> sure it is asked for a specific protocol, that is an OK thing to do,
> but it feels unnecessarily unfriendly and treating missing proto
> specification as a wildcard to talk to the specified host over any
> protocol may not hurt, I would think.

Right. It is up to the credential helper to map git's request into
whatever storage it has. So I think the right answer is whatever is
normal and expected for netrc.

Unfortunately that is not really a standardized format. The original
netrc was ftp-only, and did not have a port or protocol field at all.
Programs like curl extend it automatically to http, and just googling
around seems to show other programs using it for imap and smtp. So I
think there is some precedence in simply treating a missing "port" field
as "match any port/protocol" on the machine.

The upside is that it is convenient for the user. The downside is that
we might accidentally send a password to a service that the user does
not expect, which could compromise security. It would at least be on the
matching host, but the protocol might not be as secure as the one the
user intended (e.g., smtp without starttls, when the password was meant
to only go over imap-over-ssl).

So I'm on the fence. It is very unlikely to be a bad thing, but if it
is, it may expose user passwords in cleartext. If we are going to keep
the current behavior, it probably needs to be documented, and certainly:

> > Use of uninitialized value $_[2] in printf at
> > /home/antoine/code/git/contrib/credential/netrc/git-credential-netrc
> > line 419.
> > compare protocol [] to [smtp] (entry: password=secret,
> > username=apelisse@gmail.com, host=smtp.gmail.com:587)
> > Use of uninitialized value in string eq at
> > /home/antoine/code/git/contrib/credential/netrc/git-credential-netrc
> > line 378.

...these should more cleanly handle the missing field.

-Peff
