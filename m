From: Jeff King <peff@peff.net>
Subject: Re: Possible bug: "git log" ignores "--encoding=UTF-8" option if
	--pretty=format:%e%n%s%n is used
Date: Thu, 13 Nov 2008 00:48:51 -0500
Message-ID: <20081113054850.GB5343@coredump.intra.peff.net>
References: <85647ef50811111112o5449c12elfc571e46e607cfd0@mail.gmail.com> <20081112104318.GA20120@coredump.intra.peff.net> <85647ef50811120311q7bc5451x7c084fd2a7864177@mail.gmail.com> <20081112112654.GA20640@coredump.intra.peff.net> <85647ef50811120508j5074f892p1e2a95acfae8c0a8@mail.gmail.com> <7vvdusjtg8.fsf@gitster.siamese.dyndns.org> <20081113043454.GA5048@coredump.intra.peff.net> <7vod0ki531.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 06:50:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0V5k-0006YW-Rl
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 06:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbYKMFsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 00:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbYKMFsy
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 00:48:54 -0500
Received: from peff.net ([208.65.91.99]:2177 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089AbYKMFsx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 00:48:53 -0500
Received: (qmail 24918 invoked by uid 111); 13 Nov 2008 05:48:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Nov 2008 00:48:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2008 00:48:51 -0500
Content-Disposition: inline
In-Reply-To: <7vod0ki531.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100854>

On Wed, Nov 12, 2008 at 09:10:26PM -0800, Junio C Hamano wrote:

> > What about "git rev-list --pretty=raw"? Is that also porcelain?
> 
> Does it re-encode?  I didn't check, but ideally it shouldn't (but I do not
> care too much either way, to be honest).

Yes, it uses the same pretty_print_commit routine as the "log".

> > I would be curious to hear your take on our failure to respect
> > --encoding for --pretty=format. Is it a bug to be fixed, or a historical
> > behavior to be maintained?
> 
> I think the fix you outlined was quite reasonable.

One thing I just realized that makes it even more reasonable: we
properly munge the encoding header when we _do_ re-encode. So whether we
re-encode or not, you will always get the correct encoding for what is
being output via "%e". Which means that a tool which handles the current
"broken" behavior by re-encoding themselves will trivially handle the
new version: the output will just always be in the --encoding specified
instead of whatever the original encoding was.

And if there are tools that are not looking at the output encoding (and
blindly assuming --encoding works), then they are already broken by the
current behavior, and we will be fixing them.

So I think it is safe to "fix" it as I described.

-Peff
