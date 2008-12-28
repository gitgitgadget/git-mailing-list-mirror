From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
 file
Date: Sun, 28 Dec 2008 14:21:40 -0800
Message-ID: <7v3ag89c0b.fsf@gitster.siamese.dyndns.org>
References: <20081210201259.GA12928@localhost>
 <20081215004651.GA16205@localhost>
 <7v63lm1c76.fsf@gitster.siamese.dyndns.org>
 <7vmyeyyuuh.fsf@gitster.siamese.dyndns.org> <20081215095949.GA7403@localhost>
 <7vskopwxej.fsf@gitster.siamese.dyndns.org> <20081228114445.GA8511@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, raa.lkml@gmail.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Dec 28 23:23:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LH42R-0000Gx-24
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 23:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756750AbYL1WVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 17:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756747AbYL1WVw
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 17:21:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756745AbYL1WVw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 17:21:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 60A5D1B40A;
	Sun, 28 Dec 2008 17:21:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 59A7A1B409; Sun,
 28 Dec 2008 17:21:42 -0500 (EST)
In-Reply-To: <20081228114445.GA8511@localhost> (Clemens Buchacher's message
 of "Sun, 28 Dec 2008 12:44:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EC309264-D52D-11DD-A807-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104061>

Clemens Buchacher <drizzd@aon.at> writes:

> I've been giving this some thought and I would like to propose the following
> solution:
>
> 1. Save index state.
> 2. Merge using whichever strategy, in index only, ignoring work tree.
>    This step includes rename detection.
> 3. Check that work tree files match original index, if index does not match
>    HEAD. Otherwise abort, restore index and leave everything unchanged.
> 4. Checkout index, overwriting work tree files, and removing files which are
>    in HEAD, but not in the index.
> 5. If the merge was clean, commit.
>
> AFAICS, this is largely the behavior right now, except that steps 3 and 4
> are intermingled with step 2, which makes it impossible to abort the merge
> if an untracked file is in the way after rename detection.

The description of step 3 above may be a bit too sketchy and simplistic,
but I agree, provided if you are talking about what merge-recursive
backend does, that is how it ought to do things.  The strategy should
instead:

 - have trivial merge done inside the index, likely leveraging
   unpack_trees() three-way merge mechanism we already have, and it will
   allow you to notice and abort upon seeing local modifications in the
   work tree at this stage, except for renamed paths;

 - notice renames for the unmerged ones and deal with them inside the
   index, still without resolving.  E.g. in a merge between A and B, if
   side A deleted "path1" and created a "path2" that is similar to deleted
   "path1", have the ancestor version at stage #1 of "path2", hoist
   "path2" of side A to stage #2, and move the version of "path1" from
   side B and have it at stage #3 of "path2", which would result in an
   index without "path1" in any stage, and "path2" in three stages.

   If the other side's rename causes a path to be moved, you can/should
   check and notice local modifications to it at this stage.

   You can also notice D/F conflict at this phase (e.g. side B in the
   above example may have created a new path "path2/file1" and the index
   may have stage #3 entry without any other stages for "path2/file1") and
   abort.

 - try to resolve unmerged paths inside the index.

   Because you matched up possible renames and and adjusted the entries,
   you can resolve aggressively, e.g. a path with identical stage #1 and
   #3 but missing stage #2 results in delete, a path with missing stage #1
   and #2 but with stage #3 results in create, etc.

 - notice the paths that need to be written out to the work tree.  Paths
   with local changes should have been noticed already in the above, but
   while debugging your new algorithm, you may want to have a logic to
   double check so that you won't miss any.  Abort if you find any local
   change that can be clobbered.

 - Then, finally, you commit to writing the results out, both the index
   and the work tree.  The changes to the work tree may be cleanly merged,
   or an unmerged results with three-way conflict markers.

This way, you will never have "merge stops in halfway because it notices
it will clobber a local change too late after it has already written a
partial merge results to the work tree" problem, I think.

> git merge <branch>
> # Conflicts? I don't have time for that now.
> git reset --hard HEAD
>
> under all circumstances, without touching any untracked files.

Even though I agree the above without the second line is a good thing to
have, I think your description is a wrong way to present the desirable
goal.

"Conflicts?" is an indication that you had a lot of other things going on
inside your work tree as set of local changes that you "don't have time
for that now", and "reset --hard" is a sure way to lose them.  You
shouldn't train your users to say "--hard" lightly.

The issue of unreliable D/F conflict detection and local change detection
the current merge-recursive has at its corner case is not about
"Conflicts? I don't have time for that now" at all.  It is not about " I
had something precious in my work tree, but the merge turned out to be
unmanageable for me", either.

The issue is about "Crap, if merge has to abort in the middle because it
has to refrain from writing out a half-merged state out, not to overwrite
my local changes, it shouldn't have written out anything else to the work
tree at all.  Don't abort in the middle but abort upfront without touching
my work tree!".

I think the correct statement of the goal is:

	$ git merge ..
        # Ah, I have "path2" locally modified so it cannot proceed?
        # I did not lose anything, nor it did anything to my index nor
        # work tree.  Good.

By this, you realize that you should wrap up what you have been doing
first, because the above is an indication that other end has made some
overlapping changes.  You can either (1) decide not to merge at this point
because you are not ready, keep working on what you were doing first and
later merge, or (2) stash away what you have been doing and do the merge
first, and then unstash.
