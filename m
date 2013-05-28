From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] fix segfault with git log -c --follow
Date: Wed, 29 May 2013 00:54:54 +0200
Message-ID: <20130528225453.GA9820@ecki>
References: <20130527224957.GA7492@ecki>
 <7vk3mj10l2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 00:55:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhSo2-0006lx-VD
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 00:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758133Ab3E1Wzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 18:55:47 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:60756 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757097Ab3E1Wzq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 18:55:46 -0400
X-Greylist: delayed 86696 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 May 2013 18:55:46 EDT
Received: from [127.0.0.1] (p5B22CF5E.dip0.t-ipconnect.de [91.34.207.94])
	by bsmtp.bon.at (Postfix) with ESMTP id 7C79310019;
	Wed, 29 May 2013 00:55:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vk3mj10l2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225696>

On Tue, May 28, 2013 at 10:22:17AM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > In diff_tree_combined we make a copy of diffopts. In
> > try_to_follow_renames, called via diff_tree_sha1, we free and
> > re-initialize diffopts->pathspec->items. Since we did not make a deep
> > copy of diffopts in diff_tree_combined, the original diffopts does not
> > get the update. By the time we return from diff_tree_combined,
> > rev->diffopt->pathspec->items points to an invalid memory address. We
> > get a segfault next time we try to access that pathspec.
> 
> I am not quite sure if I follow.  Do you mean
> 
> 	diff_tree_combined()
>         - makes a shallow copy of rev->diffopt
>         - calls diff_tree_sha1()
>           diff_tree_sha1()
>           - tries to follow rename and clobbers diffopt

Right.

>         - tries to use the shallow copy of original rev->diffopt
>           that no longer is valid, which is a problem

diff_tree_combined does not try to use it right away. It does return,
but rev->diffopt is now invalid and the next time we do any kind of diff
with it, we have a problem.

> I wonder, just like we force recursive and disable external on the
> copy before we use it to call diff_tree_sha1(), if we should disable
> follow-renames on it.  "--follow" is an option that is given to the
> history traversal part and it should not play any role in getting the
> pairwise diff with all parents diff_tree_combined() does.

Can't parse that last sentence.

In any case, I don't think disabling diff_tree_sha1 is a solution. The
bug is in diff_tree_sha1 and its subfunctions, because they manipulate a
data structures such that it becomes corrupt. And they do so in an
obfuscated and clearly unintentional manner. So we should not blame the
user for calling diff_tree_sha1 in such a way that it causes corruption.

> Besides,
> 
>  - "--follow" hack lets us keep track of only one path; and

Ok. Good to know it is considered a hack. The code is quite strange
indeed.

>  - "-c" and "--cc" make sense only when dealing with a merge commit
>    and the path in the child may have come from different path in
>    parents,

Sorry, I don't get it.

> so I am not sure if allowing combination of "--follow -c/--cc" makes
> much sense in the first place.

My use-case is came up with this history:

1. Code gets added to file A.
2. File A gets renamed to B in a different branch.
3. The branches get merged, and code from (1) is removed in the merge.

Later I wonder why code from (1) is gone from B even though I felt
certain it had been added before. I also remember that B was renamed at
some point. So I do git log -p --follow B, and it nicely shows that diff
where the code was added, but no diff where the code is removed.

The reason is of course, that the code was removed in the merge and that
diff is not shown. And -c is usually what I do to enable showing diffs
in merge commits.

And if the pairwise diff can also deal with file renames, I think it
absolutely does make sense to show also a three-way diff.

I can't tell far away the code is from supporting anything like that.

Cheers,
Clemens
