From: Jeff King <peff@peff.net>
Subject: Re: How to merge from newer branch to older branches?
Date: Wed, 22 Apr 2009 16:15:41 -0400
Message-ID: <20090422201541.GC14146@coredump.intra.peff.net>
References: <2729632a0904211224x6e2621caxf6c169d90b760530@mail.gmail.com> <20090421193615.GB7832@coredump.intra.peff.net> <7vmya946fg.fsf@gitster.siamese.dyndns.org> <2729632a0904221044q20e6cabau7dd06b3020a8ce49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 22 22:17:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwish-0001U5-Lw
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 22:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbZDVUPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 16:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbZDVUPq
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 16:15:46 -0400
Received: from peff.net ([208.65.91.99]:53449 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbZDVUPp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 16:15:45 -0400
Received: (qmail 18061 invoked by uid 107); 22 Apr 2009 20:15:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 22 Apr 2009 16:15:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2009 16:15:41 -0400
Content-Disposition: inline
In-Reply-To: <2729632a0904221044q20e6cabau7dd06b3020a8ce49@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117251>

On Wed, Apr 22, 2009 at 10:44:06AM -0700, skillzero@gmail.com wrote:

> Then I rebased feature:
> 
> git rebase --onto merge-base-of-1.1-and-master feature-before-first feature
>
> [...]
> 
> I can merge 'feature' into 1.1, 1.2, etc. then theoretically, I should
> be able to apply bug fixes to 'feature' later and re-merge into 1.1,
> 1.2, etc. to pick up just the bug fixes, right?

Exactly.

> It seems like this merge conflict is going to cause problems if I try
> to re-merge to pick up a bug fix to 'feature' in the future. Looking
> at the documentation, it sounds like 'git rerere' can help by
> re-applying the manual conflict resolution I did?

It shouldn't. Remember that your merges into 1.1, 1.2, etc, created a
new merge base. So when you have bug fixes to make to this topic, you
don't put them on the "feature" branch, but onto this topic branch. Then
you re-merge the topic branch into 1.1., 1.2, feature, etc, and it will
look only at the new bugfix.

> BTW...Is there a way to find the first commit of a branch? I had to
> just look at the log manually to see what I remembered to be the first
> commit.

Sort of. Branches in git are really just refs pointing to the tip of the
branch. So once the tip advances, the ref no longer remembers "oh, this
is where I branched from". If there are other commits along the thing
you branched off of, you can calculate the merge-base of the thing you
branched from, and your branch.

However, the first entry in the reflog for that branch ref should
indicate branch creation (unless it is so old that it has expired).
Something like:

  $ git branch foo origin/master
  $ git reflog show foo
  0be9bc0 foo@{0}: branch: Created from origin/master

So 0be9bc0 would be the creation point in this case. But you might have
totally rewritten the branch after that point, so 0be9bc0 might not be a
useful value anymore.

-Peff
