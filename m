From: Jeff King <peff@peff.net>
Subject: Re: BUG in git diff-index
Date: Thu, 31 Mar 2016 10:05:15 -0400
Message-ID: <20160331140515.GA31116@sigill.intra.peff.net>
References: <loom.20160331T143733-916@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andy Lowry <andy.work@nglowry.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 16:05:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aldDw-0003ex-BT
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 16:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419AbcCaOFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 10:05:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:41470 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753163AbcCaOFS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 10:05:18 -0400
Received: (qmail 19160 invoked by uid 102); 31 Mar 2016 14:05:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 10:05:17 -0400
Received: (qmail 12780 invoked by uid 107); 31 Mar 2016 14:05:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 10:05:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2016 10:05:15 -0400
Content-Disposition: inline
In-Reply-To: <loom.20160331T143733-916@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290384>

On Thu, Mar 31, 2016 at 12:39:23PM +0000, Andy Lowry wrote:

> Following transcript illustrates what I believe to be a bug in git diff-
> index. The session used a git built from latest source, located in 
> /tmp/git/git.
> 
> 1. New repo, create empty file A, commit changes.
> 2. touch A
> 3. git diff-index reports A has changed, and reports bogus destination 
> SHA
> 4. This is stable behavior until next step
> 5. git diff correctly reports no changes
> 6. git diff-index now also reports nothing
> 
> My understanding is that git diff-index should care only about content 
> and file mode, not modification time.

This is working as designed (though I agree it is a little confusing).
From "git help diff-index":

       These commands all compare two sets of things; what is compared differs:

       git-diff-index <tree-ish>
           compares the <tree-ish> and the files on the filesystem.

       git-diff-index --cached <tree-ish>
           compares the <tree-ish> and the index.

       git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]
           compares the trees named by the two arguments.

       git-diff-files [<pattern>...]
           compares the index and the files on the filesystem.

Your invocation triggers the first, though it is not a true comparison
of what is on the filesystem, but rather a tree/index comparison, taking
into account the filesystem values. The all-zeroes sha1 indicates that
the index entry is not up to date with what is in the filesystem, but we
don't actually read the file contents to refresh the entry.

Back when diff-index was written, it was generally assumed that scripts
would refresh the index as their first operation, and then proceed to do
one or more operations like diff-index, which would rely on the refresh
from the first step.

Running the porcelain "git diff" does refresh the index, which is why
your step 6 shows no diff.

If you want a pure tree-to-index comparison, use --cached (this will
also be slightly faster, as it does not have to stat the working tree at
all).

-Peff
