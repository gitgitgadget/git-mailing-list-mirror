From: "David Jeske" <jeske@willowmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 20:29:15 -0000
Message-ID: <16460.6618382551$1214599182@news.gmane.org>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
	<willow-jeske-01l7H4tHFEDjCgPV-01l7H4sOFEDjCbyi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Robert Anderson" <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 22:39:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCKj1-0006V6-KC
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 22:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758154AbYF0UiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 16:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752683AbYF0UiX
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 16:38:23 -0400
Received: from w2.willowmail.com ([64.243.175.54]:33082 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756953AbYF0UiW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 16:38:22 -0400
Received: (qmail 28138 invoked by uid 90); 27 Jun 2008 20:38:17 -0000
X-Mailer: Willow v0.02
Received: from 72.14.229.81 at Fri, 27 Jun 2008 20:29:15 -0000
In-Reply-To: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86629>

Robert, I'm new to git, but I understand where you are going.

Why limit it only to working tree changes? For me, the stash machinery is of no
help here, because I commit super-often. What I end up with is 30 commits in a
topic branch, but where not every point passes 100% of tests. I want to go back
through and order them properly, and decide which points are sensible as
upstream committs. (especially as I read more about bisect).

git has all the concepts I want except one. However, it makes the process
pretty manual. Here is an idea about automating it. I'll talk about that one
new concept at the bottom.

I think of this as reorder/merge/split...

reorder: Picture that a list of commits on this branch opens in an editor. You
are free to rearrange the lines in any order you want, but you have to keep all
the lines. When you are done reordering the lines, the tool creates a new topic
branch and applies the changes (probably with cherrypick) to the new topic
branch. If there are no conflicts, you're done.

merge: Picture now that in your editor you can create groupings of those
individual commits that should make up separate topic-branches. The operation
can still be performed automatically, and at the end, it can compose those
topic branches into a single branch just like your original. At this point, you
can "isolate" any one of those topic branches and test/push that topic branch.

split: Picture now that you can list the same commit in more than one of the
topic-branches. This is a little more tricky, and there is no way to do it
automatically.. It drops you into an editor and asks you to select the lines of
the diff for the first topic. The remaining lines are put in the next topic.
This can continue for multiple topics.

This seems like something that could be assembled pretty easily on top of the
current git mechanisms, except for one thing.

If you use merge, the history will be a mess. If you use rebase, anyone else
who pulled your topic branch will be in a world of hurt.

I've been thinking about a solution for this I think of as "supercede".

Once you have completed the above reorder/merge/split, your new topic branch
should be EXACTLY the same as your old topic branch. (if it's not, it needs to
be trued up to be so). At that point, it is safe to ask for that new line of
commits to supercede the old line. Other people who have pulled in your older
ordered topic branch would then be able to pull/rebase/etc, and the merge
machinery would be able to back out their set of changes, and supercede them
with your new ordering.

This mechanism is intended to combine the benefits of rebase-clean-history and
the benefits of the dag-links for merging. I find it convenient to think of it
as stack push/pop for portions of the dag. Because of the supercede - the
history knows it can avoid showing you all the superceded dag nodes, however,
because those nodes are there, it can still use them to compute merges.

If this behaves the way I think, this has another powerful effect. You can pull
in a set of draft changes; you can build off them; you can periodically rebase
them, and if those draft changes end up in the mainline, because the
merge-history is still there, git can 'do the right thing' and remove those
changes from your topic branch. In fact, because of the SHA1 strong naming, it
doesn't even matter where you got them from. You could apply a patch from the
mailing list and as long as everyone applies that patch as only a single
commit, when the string of supercedes shows up on the main branch git will just
'do-the right thing' to remove them from your topic branch when you rebase (or
skip them during a merge down to your topic branch).
