From: Jeff King <peff@peff.net>
Subject: Re: tests do not work with gpg 2.1
Date: Tue, 2 Dec 2014 16:30:03 -0500
Message-ID: <20141202213002.GA25338@peff.net>
References: <xmqqr3wpo8yl.fsf@gitster.dls.corp.google.com>
 <20141127213224.GA27443@dispater.uplinklabs.net>
 <54784503.80108@drmicha.warpmail.net>
 <20141128165009.GA4728@peff.net>
 <547DB6C3.5010704@drmicha.warpmail.net>
 <20141202212133.GE23461@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Noonan <steven@uplinklabs.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 22:30:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvv1R-0002RZ-2b
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 22:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933038AbaLBVaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 16:30:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:47406 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932844AbaLBVaG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 16:30:06 -0500
Received: (qmail 31303 invoked by uid 102); 2 Dec 2014 21:30:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 15:30:01 -0600
Received: (qmail 18994 invoked by uid 107); 2 Dec 2014 21:30:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 16:30:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2014 16:30:03 -0500
Content-Disposition: inline
In-Reply-To: <20141202212133.GE23461@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260596>

On Tue, Dec 02, 2014 at 04:21:33PM -0500, Jeff King wrote:

> I'm not sure if the most expedient path is trying to convince gpg
> developers that it's a bug, or if there is some workaround (like
> "--passphrase-file /dev/null" or something).
> 
> I've been using the patch below to test, and am tempted to offer it for
> inclusion. But if we need to hack up the gpg command-line just for the
> tests, then lib-gpg.sh would end up setting gpg.program, and that would
> override what my patch is doing anyway.

So...I tried that. So many things went wrong. :)

For one thing, the build-time GPG_PATH patch I posted is not quite
enough. We would probably want to pass it down to the test scripts, too,
as they run "gpg --version" to figure out whether we have gpg or not.

Secondly, you cannot set gpg.program to "gpg2 --passphrase-file
/dev/null", because we do not use the shell to exec gpg.program. This is
unlike most of the rest of git-spawned programs, but of course changing
it has compatibility problems. We'd probably want gpg.command or
something as an alternative.

And finally, after convincing git to really use "--passphrase-file", I
find that it does not fix the problem at all. GPG still insists on
opening an agent window. Nor does "--batch" help.

So I dunno. Maybe there is some clever way to work around it, but I do
not know it.

-Peff
