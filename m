From: Jeff King <peff@peff.net>
Subject: Re: Merging split files
Date: Tue, 29 Mar 2011 14:15:13 -0400
Message-ID: <20110329181513.GA20784@sigill.intra.peff.net>
References: <20110329151623.GD10771@sigill.intra.peff.net>
 <3752347.282743.1301416397164.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:15:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4dRx-0000qA-H9
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 20:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab1C2SPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 14:15:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37379
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752444Ab1C2SPU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 14:15:20 -0400
Received: (qmail 31175 invoked by uid 107); 29 Mar 2011 18:15:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 14:15:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 14:15:13 -0400
Content-Disposition: inline
In-Reply-To: <3752347.282743.1301416397164.JavaMail.root@mail.hq.genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170296>

On Tue, Mar 29, 2011 at 12:33:17PM -0400, Stephen Bash wrote:

> > The problem is that the closest merge-recursive gets to understanding
> > content movement is that it considers whole file renames. ...
> > 
> > So I think the most flexible thing is to forget file renames at all.
> 
> I agree that would be the best solution long term. ("Git doesn't track
> files, Git tracks content".  Think I heard that somewhere before...)

Exactly. :) I think that is a tricky project, though, and in the
meantime, I wouldn't be opposed to a more file-based solution if it
generates good results.

> That being said, the back seat drivers in the office here (i.e. me and
> everyone else that knows almost nothing about the internals of merge
> recursive!) thought maybe a middle ground is teach merge recursive to
> do copy detection along with rename detection.  Then the algorithm
> would have a (relatively small?) list of candidate files to check for
> hunks.  You still have to deal with the similarity score in some
> corner cases, but hopefully since all we want is candidate files the
> process is relatively insensitive to the similarity threshold.

This was something I gave some thought to recently in this other thread:

  http://thread.gmane.org/gmane.comp.version-control.git/169944

though I came to the conclusion in that case that break-rewriting was a
much better match for that particular case. Namely, we see that content
has been renamed, so we make sure to merge changes to the "original"
content with each other, no matter whether the changes happened in the
renamed path or the original. And similarly, we merge changes left over
from any "new" content that has replaced the original (which, in the
pure rename case, is just empty, but with break-rewriting we might have
some dissimilar content at the old path). We know that the "new" content
can't be related to the "old" content, because to find a rename, we
would have to have triggered the "break" by finding that the content is
dissimilar.

Copy detection has to deal with that, but harder. :) I see two major
challenges:

  1. One source file may go to multiple destinations. So instead of
     saying "oops, I should be doing the merge with this other, renamed
     content", you have to pick a best one (either through heuristic, or
     even per-hunk by trying each hunk in turn). And this means you're
     interacting deeply with the content-level 3-way merger. I haven't
     looked at that code at all, so I don't know how feasible that is.

     And you have to accept that you may pick wrong, or even that there
     may be no right answer. If I do "cp foo bar; cp foo baz; rm foo",
     and then modify "foo" on another branch, the choice of merging
     changes to "bar" versus "baz" is going to be arbitrary.

  2. Because it's a copy and not a rename, your source file may still
     exist and be a candidate for applying content to. And that violates
     the break-rewrite rename logic I mentioned above, which is that old
     content goes with old content and new content goes with new
     content. We're not sure which the source file is for a given hunk.

     I think that may not be a big deal, though. We already have to deal
     with the hard part in (1), which is finding _which_ copy is the
     right place for a given bit of content. So this may just simplify
     to adding the source file (if it still exists) as another possible
     place to merge changes to, and it is another case of (1) (though
     obviously we should prefer merging to the original pathname if it
     is still there, rather than a copy).

> Am I way off the deep end now?  I'm not lying when I say I know
> *nothing* about the merge implementations.

No, I don't think you're off the deep end. But then, I don't know that
much about the merge code, either. :)

-Peff
