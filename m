From: tytso@mit.edu
Subject: Re: Why is "git tag --contains" so slow?
Date: Fri, 2 Jul 2010 15:26:12 -0400
Message-ID: <20100702192612.GM1333@thunk.org>
References: <E1OU82h-0001xY-3b@closure.thunk.org>
 <AANLkTikkLIKm3soF9agXnN34P7Xnq4AiVqGU_qFaaRmZ@mail.gmail.com>
 <20100701121711.GF1333@thunk.org>
 <20100701150331.GA12851@sigill.intra.peff.net>
 <20100701153842.GA15466@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 02 21:26:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUlsU-000109-4Q
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 21:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759493Ab0GBT0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 15:26:16 -0400
Received: from THUNK.ORG ([69.25.196.29]:49273 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758773Ab0GBT0P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 15:26:15 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1OUlsL-0000Az-JY; Fri, 02 Jul 2010 15:26:13 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1OUlsL-0003qz-0o; Fri, 02 Jul 2010 15:26:13 -0400
Content-Disposition: inline
In-Reply-To: <20100701153842.GA15466@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150156>

On Thu, Jul 01, 2010 at 11:38:42AM -0400, Jeff King wrote:
> 
> Here is a quick and dirty patch to implement what I suggested. With it,
> I get the same results as above, but it runs between 3 and 4 times as
> fast:
> 
>   real    0m0.621s
>   user    0m0.588s
>   sys     0m0.032s

I just tried your patch, and with a large number of tags (198 tags,
from v2.6.11 to v2.6.34 with all of the -rc releases of the linux
kernel), it is indeed faster: 8.5 seconds without the patch versus 2.3
seconds with the patch.

However, if I remove a large number of tags (since I know this is
something that was introduced since 2.6.33, so I made a shared clone
of the repository but then I removed all of the tags from 2.6.11
through 2.6.33, so there was only 19 tags in play), the time to
execute the git tag --contains became 1.3 seconds without the patch,
versus 2.9 seconds without the patch.

So with the oldest tags removed, your patch actually made things run
*slower* (2.3 vs 2.9 seconds, which was counter-intuitive to me), and
fastest way to speed things up was to restrict the tags that would be
searched.

Which gives me the technique I should use to solve my immediate
problem, but if the user knows that the patch was merged into mainline
within the last 4 months, maybe what would be better is either a way
to specify a regexp (or list) of tags that the user finds
"interesting" as --contains candidate, or a "--since=4 months"
argument.

	   	      	   	      	      - Ted
