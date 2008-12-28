From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
	file
Date: Mon, 29 Dec 2008 00:53:17 +0100
Message-ID: <20081228235317.GA32714@localhost>
References: <20081210201259.GA12928@localhost> <20081215004651.GA16205@localhost> <7v63lm1c76.fsf@gitster.siamese.dyndns.org> <7vmyeyyuuh.fsf@gitster.siamese.dyndns.org> <20081215095949.GA7403@localhost> <7vskopwxej.fsf@gitster.siamese.dyndns.org> <20081228114445.GA8511@localhost> <7v3ag89c0b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, raa.lkml@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 00:54:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LH5T4-0002QQ-T8
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 00:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333AbYL1XxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 18:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbYL1XxU
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 18:53:20 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:8550 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbYL1XxT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 18:53:19 -0500
Received: from darc.dyndns.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Dec 2008 00:53:17 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LH5Rd-0000uN-Hg; Mon, 29 Dec 2008 00:53:17 +0100
Content-Disposition: inline
In-Reply-To: <7v3ag89c0b.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 28 Dec 2008 23:53:17.0928 (UTC) FILETIME=[74C2AE80:01C96947]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104063>

On Sun, Dec 28, 2008 at 02:21:40PM -0800, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > I've been giving this some thought and I would like to propose the following
> > solution:
> >
> > 1. Save index state.
> > 2. Merge using whichever strategy, in index only, ignoring work tree.
> >    This step includes rename detection.
> > 3. Check that work tree files match original index, if index does not match
> >    HEAD. Otherwise abort, restore index and leave everything unchanged.
> > 4. Checkout index, overwriting work tree files, and removing files which are
> >    in HEAD, but not in the index.
> > 5. If the merge was clean, commit.
> >
> > AFAICS, this is largely the behavior right now, except that steps 3 and 4
> > are intermingled with step 2, which makes it impossible to abort the merge
> > if an untracked file is in the way after rename detection.
> 
> The description of step 3 above may be a bit too sketchy and simplistic,
> but I agree, provided if you are talking about what merge-recursive
> backend does, that is how it ought to do things.  The strategy should
> instead:

Actually, I was hoping to find a solution that's independent of the merge
strategy. I think the merge strategy should not have to concern itself with
the work tree at all.

Regarding my description of step 3, I worded it carefully to cover all
cases. My assumption at this stage is that the merge strategy took care not
to overwrite any staged changes, unless the merge is trivial. It is
therefore safe to overwrite the work tree file if it matches either the
original index, or HEAD.

>  - have trivial merge done inside the index, likely leveraging
>    unpack_trees() three-way merge mechanism we already have, and it will
>    allow you to notice and abort upon seeing local modifications in the
>    work tree at this stage, except for renamed paths;

Right, but why would we want to do it this early? Is there a performance
issue? If not, I argue that we don't care about the work tree at this stage.
Only the end result matters.

>  - notice renames for the unmerged ones and deal with them inside the
>    index, still without resolving.  E.g. in a merge between A and B, if
>    side A deleted "path1" and created a "path2" that is similar to deleted
>    "path1", have the ancestor version at stage #1 of "path2", hoist
>    "path2" of side A to stage #2, and move the version of "path1" from
>    side B and have it at stage #3 of "path2", which would result in an
>    index without "path1" in any stage, and "path2" in three stages.

Right. So in this case we do not abort if "path1" had unstaged
changes, because "path1" of B was moved to "path2" anyways. Conversely, if
"path2" had unstaged changes, we do abort, because it would be overwritten
by the merge (or conflict resolution). All this can be decided without any
knowledge about detected renames or the merge strategy used.

>    If the other side's rename causes a path to be moved, you can/should
>    check and notice local modifications to it at this stage.
> 
>    You can also notice D/F conflict at this phase (e.g. side B in the
>    above example may have created a new path "path2/file1" and the index
>    may have stage #3 entry without any other stages for "path2/file1") and
>    abort.
> 
>  - try to resolve unmerged paths inside the index.
> 
>    Because you matched up possible renames and and adjusted the entries,
>    you can resolve aggressively, e.g. a path with identical stage #1 and
>    #3 but missing stage #2 results in delete, a path with missing stage #1
>    and #2 but with stage #3 results in create, etc.

This should be done before checking for D/F conflicts. If a file ends up
getting removed, the D/F conflict is avoided.

>  - notice the paths that need to be written out to the work tree.  Paths
>    with local changes should have been noticed already in the above, but
>    while debugging your new algorithm, you may want to have a logic to
>    double check so that you won't miss any.  Abort if you find any local
>    change that can be clobbered.
> 
>  - Then, finally, you commit to writing the results out, both the index
>    and the work tree.  The changes to the work tree may be cleanly merged,
>    or an unmerged results with three-way conflict markers.
>
> This way, you will never have "merge stops in halfway because it notices
> it will clobber a local change too late after it has already written a
> partial merge results to the work tree" problem, I think.

Right. So all we have to do is keep unpack_trees() and process_entry() in
merge_trees() from writing to the work tree and delay until after
try_merge_strategy() has completed. Then we check for D/F conflicts and
dirty work tree files before finally checking out the merge result.

Thinking about this now, I wonder what happens if recursive merge has a D/F
conflict in one of its recursions. There is nothing smart it can do, so it
could continue with a D/F conflict in the index, hoping that it goes away in
the final result. So again, D/F conflicts should not matter for the merge
strategy.

> > git merge <branch>
> > # Conflicts? I don't have time for that now.
> > git reset --hard HEAD
> >
> > under all circumstances, without touching any untracked files.
> 
> Even though I agree the above without the second line is a good thing to
> have, I think your description is a wrong way to present the desirable
> goal.
[...]
> The issue is about "Crap, if merge has to abort in the middle because it
> has to refrain from writing out a half-merged state out, not to overwrite
> my local changes, it shouldn't have written out anything else to the work
> tree at all.  Don't abort in the middle but abort upfront without touching
> my work tree!".

Point taken.
