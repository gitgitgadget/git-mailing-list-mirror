From: Jeff King <peff@peff.net>
Subject: Re: Push not writing to standard error
Date: Wed, 13 Oct 2010 13:45:44 -0400
Message-ID: <20101013174543.GA13752@sigill.intra.peff.net>
References: <AANLkTim6j7cXj2-1JnKdNLb8KFJK86F02tzeByDBskEa@mail.gmail.com>
 <20101012192117.GD16237@burratino>
 <20101012193204.GA8620@sigill.intra.peff.net>
 <20101012193830.GB8620@sigill.intra.peff.net>
 <7vzkuim1zx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 19:45:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P65OP-00070P-6U
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 19:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413Ab0JMRpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 13:45:25 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38423 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346Ab0JMRpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 13:45:25 -0400
Received: (qmail 468 invoked by uid 111); 13 Oct 2010 17:45:23 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.167)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 13 Oct 2010 17:45:23 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Oct 2010 13:45:44 -0400
Content-Disposition: inline
In-Reply-To: <7vzkuim1zx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158949>

On Wed, Oct 13, 2010 at 10:33:22AM -0700, Junio C Hamano wrote:

> > Here's a quick 5-minute patch. It works on my test case:
> >
> >   rm -rf parent child
> >   git init parent &&
> >   git clone parent child &&
> >   cd child &&
> >   echo content >file && git add file && git commit -m one &&
> >   git push --progress origin master:foo >foo.out 2>&1 &&
> >   cat foo.out
> 
> Does it still work with "git push" without --progress?  I didn't apply nor
> test, but just wondering as the manpage description suggests progress is
> implicitly set when standard error is terminal even when there is no
> command line --progress is given, and also interaction with -q option, but
> the patch does not seem to show such subtleties...

Yes, it works in both of those cases. The transport code already does
the right thing to set transport->progress (see the code at the end of
transport_set_verbosity). And we even pass that value on to remote
helpers, which presumably make use of it. But the internal
git_transport_push simply ignored it (probably because it predates the
rest of the transport code, but I didn't check).

What concerns me a bit is that "git push --no-progress" does not do what
I expected (turn off progress, but keep the status table which would
otherwise be suppressed by "-q"). Instead, --no-progress is silently
ignored. We should at least set it to NONEG to generate an error, but
ideally we would handle it properly.

However, that bug exists with or without my patch. The transport code
seems to only ever consider "force progress" or "default progress", but
never "no progress".

-Peff
