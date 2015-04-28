From: Jeff King <peff@peff.net>
Subject: Re: Question about how git determines the minimum packfile for a
 push.
Date: Tue, 28 Apr 2015 01:33:32 -0400
Message-ID: <20150428053332.GH24580@peff.net>
References: <E51394554A503C4E852F9BEE46B03E8D01E4E784@TI-ODIN.tasernet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Brad Litterell <brad@evidence.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 07:33:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymy9N-0005Tt-66
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 07:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbbD1Fdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 01:33:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:50972 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752648AbbD1Fde (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 01:33:34 -0400
Received: (qmail 18386 invoked by uid 102); 28 Apr 2015 05:33:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 00:33:34 -0500
Received: (qmail 11764 invoked by uid 107); 28 Apr 2015 05:34:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 01:34:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2015 01:33:32 -0400
Content-Disposition: inline
In-Reply-To: <E51394554A503C4E852F9BEE46B03E8D01E4E784@TI-ODIN.tasernet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267897>

On Mon, Apr 27, 2015 at 12:41:28AM +0000, Brad Litterell wrote:

> Is it possible git is not computing the delta correctly?  Or does git
> only look at the top-level commit objects to figure out what to
> include in the push packfile?

It's the latter. Junio mentioned that "push" is not as thorough about
finding common ancestors as "fetch", but I think even "fetch" would have
the same problem.

If we know that the other side has commit X, we know that it also has
X~3, and we also know that it has every tree and blob mentioned by X~3.
But it's much too expensive to open up every tree to generate the full
set of reachable objects; for the Linux kernel, that is something like 45
seconds of CPU time, just to find out "oh, we only need to send 5
objects".

This works pretty well in practice, because trees and blobs from older
history don't tend to resurface verbatim. But as you noticed, there are
certain cases where it does happen, and the number of objects affected
can be quite large (to the point that sending the extra objects is much
more expensive than the cost of doing the extra tree traversal).
Unfortunately there is no "look harder" option you can give to
"git push" when you, as the user, realize this is happening.

If you have pack reachability bitmaps, they do produce a more thorough
answer. So probably:

  git repack -adb
  git push

on the client would make this work as you expect.

> Will it upload the larger pack only to have the server correctly handle the duplicates?

Yes, the receiving side should correctly handle the duplicates.

-Peff
