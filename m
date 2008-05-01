From: Jeff King <peff@peff.net>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 1 May 2008 12:48:29 -0400
Message-ID: <20080501164829.GA11636@sigill.intra.peff.net>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com> <32541b130805010827r22169651s37c707071f3448f2@mail.gmail.com> <20080501153457.GB11469@sigill.intra.peff.net> <32541b130805010850q165fe1d6me05e670ca93b0892@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 18:49:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrbyA-0007L3-0J
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 18:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758486AbYEAQsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 12:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757447AbYEAQsa
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 12:48:30 -0400
Received: from peff.net ([208.65.91.99]:4645 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756142AbYEAQs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 12:48:29 -0400
Received: (qmail 19190 invoked by uid 111); 1 May 2008 16:48:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 01 May 2008 12:48:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2008 12:48:29 -0400
Content-Disposition: inline
In-Reply-To: <32541b130805010850q165fe1d6me05e670ca93b0892@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80929>

On Thu, May 01, 2008 at 11:50:31AM -0400, Avery Pennarun wrote:

> I would argue that this is a sort of "directory splitting" operation.
> That is, all anyone ever did was add some files to a subdir/ that
> already existed [1], *or* move all the files from subdir/ to a
> previously-empty bettername/ [2], *or* create a new subdir/ and add
> files to it [3]. In each case, no merge operation was necessary and it
> is completely obvious by comparing "before and after" trees which case
> it was.

I don't see it. I think the steps are exactly the same as in your
example. Consider:

  1. You have some files in src/
  2. All of the files from src/ get moved away
  3. You merge in somebody else's work which adds a file in src/, but
     their work is based on a commit which predates 2.

The question is: if they had seen 2., would they have put the file into
src/, or into the new location? I think the answer depends on the
semantics of the file. If it is semantically an addition to the source
code that got moved, then yes. If it is a _replacement_ for the
source code that got moved, then no.

> I guess my argument here is just that it should be *possible* to
> deduce and implement both cases at merge time just fine using git's
> existing storage model.  It just hasn't been implemented yet.  (And
> incidentally, I think that's totally awesome and I'd never want to go
> back to an explicit rename tracking model.)

I think you lack information to decide automatically between the two
cases listed above. But I think in most cases it would be sufficient for
the tool to say "this directory seems to have moved, but this new file
was added in it" and let the user decide which makes sense.

> I should shut up now because the actual merge machinery scares me and
> I'm not willing to volunteer to write a patch for this one :)

It would probably start not with merge machinery, but with diff
machinery to detect "directory has moved". But that is also scary. :)

You could also do this totally _outside_ of git, similar to
git-mergetool. Wait until you get a conflict, and then run a script
which looks at the two endpoints and the merge base and says "Oh, maybe
this is a good way of resolving."

-Peff
