From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when
	cherry-picking an empty commit
Date: Tue, 10 Mar 2009 14:17:30 -0400
Message-ID: <20090310181730.GD26351@sigill.intra.peff.net>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com> <20090308144240.GA30794@coredump.intra.peff.net> <7v8wnflrws.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Chris Johnsen <chris_johnsen@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 19:19:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh6Xy-0005Gw-2A
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 19:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012AbZCJSRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 14:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753822AbZCJSRd
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 14:17:33 -0400
Received: from peff.net ([208.65.91.99]:56219 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178AbZCJSRd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 14:17:33 -0400
Received: (qmail 12957 invoked by uid 107); 10 Mar 2009 18:17:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 10 Mar 2009 14:17:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Mar 2009 14:17:30 -0400
Content-Disposition: inline
In-Reply-To: <7v8wnflrws.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112839>

On Sun, Mar 08, 2009 at 12:45:55PM -0700, Junio C Hamano wrote:

> If this part from your analysis is true for a shell:
> 
> > eval 'false
> >
> > '
> > echo status is $?
> >
> > generates:
> > ...
> >   status is 0
> 
> I would be very tempted to declare that shell is unfit for any serious
> use, not just for test suite.  Removing the empty line at the end of a
> scriptlet that such a broken shell misinterprets as an empty command
> that is equivalent to ":" (or "true") might hide breakages in the test
> suite, but
> 
>  (1) eval "$string" is used outside of test suite, most notably "am" and
>      "bisect".  I think "am"'s use is safe, but I wouldn't be surprised if
>      the scriptlet "bisect" internally creates has empty lines if only for
>      debuggability; and more importantly
> 
>  (2) who knows what _other_ things may be broken in such a shell?

OK, good points. I was just hoping not to cause people on FreeBSD undue
pain. What is the best way to make such a declaration? I can think of:

  1. A mention in the release notes.

  2. A test in the Makefile similar to the $(:) test.

  3. Getting in touch with the freebsd ports maintainer for git and
     suggesting a dependency on bash (and/or seeing if he wants to push
     through a fix for /bin/sh).

     I don't know if the same problem exists on other BSD-influenced systems,
     or how closely they share the ports collection (it's been quite a
     while since I've really admin'd a freebsd box). For that matter, I
     wonder if this is also a problem on OS X. Can somebody with an OS X
     box try:

       $ /bin/sh
       $ eval 'false

         '
       $ echo $?

     It should print '1'; if it prints '0', the shell is broken.

-Peff
