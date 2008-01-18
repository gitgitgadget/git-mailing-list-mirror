From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email.perl: check for lines longer than 998
	characters
Date: Fri, 18 Jan 2008 16:30:51 -0500
Message-ID: <20080118213051.GA21321@coredump.intra.peff.net>
References: <20080117153252.GD2816@coredump.intra.peff.net> <1200642458-3280-1-git-send-email-ediap@users.sourceforge.net> <47905F70.5090003@viscovery.net> <4790746D.1000502@users.sourceforge.net> <47907914.6000105@viscovery.net> <7v1w8fh2ef.fsf@gitster.siamese.dyndns.org> <20080118141638.GA14928@coredump.intra.peff.net> <7v8x2mdf7e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Piatyszek <ediap@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 22:32:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFyof-0006Y9-Fw
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 22:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765499AbYARVay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 16:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765486AbYARVay
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 16:30:54 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1637 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759945AbYARVax (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 16:30:53 -0500
Received: (qmail 20776 invoked by uid 111); 18 Jan 2008 21:30:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 18 Jan 2008 16:30:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Jan 2008 16:30:51 -0500
Content-Disposition: inline
In-Reply-To: <7v8x2mdf7e.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71067>

On Fri, Jan 18, 2008 at 12:57:41PM -0800, Junio C Hamano wrote:

> >   2/3: send-email: validate patches before sending anything
> >
> >        The actual up front long-lines check.
> 
> I wonder what the performance implication of this approach would
> be, though.  I am tempted to say that it would be negligible --
> scanning text in Perl is fast enough.

We now open and do one conditional per line for each file (in addition
to already going through each file a separate time and doing more
complex processing).  Doing that over the entirety of "git log
--pretty=email -p" on git.git takes about 1 second on my machine for
11402 patches.  Obviously there's slightly more syscall overhead as you
have to open() each patch, but I think think it is clear that the
parsing overhead is negligible.

> I suspect that taking this "Safe against SMTP line length limit"
> topic all the way ("all the way" is post 1.5.4, I am inclined to
> agree that this may be a good fix to an existing bug) would
> require that git-format-patch --attach to learn to apply QP on
> patch text to avoid producing very long lines to root-cause the
> issue [*1*].

Perhaps. If such things are sufficiently rare, one could simply attach
the patch in their MUA. I think the most important thing is for git to
at least stop and warn the user that it might not be sending something
valid. But implementing N different fixes that haven't even been
requested by users seems like a waste of time.

-Peff
