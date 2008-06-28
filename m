From: Junio C Hamano <gitster@pobox.com>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 14:53:06 -0700
Message-ID: <7vprq1kz0d.fsf@gitster.siamese.dyndns.org>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
 <alpine.DEB.1.00.0806271408290.9925@racer>
 <7vprq2rbfz.fsf@gitster.siamese.dyndns.org>
 <20080628050317.GE9451@sigill.intra.peff.net>
 <9af502e50806280003p59d00444hd1914a28a3a71d7e@mail.gmail.com>
 <20080628085359.GA29619@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Anderson <rwa000@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 28 23:54:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCiNW-0000HQ-RF
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 23:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbYF1VxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 17:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbYF1VxV
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 17:53:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbYF1VxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 17:53:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C4D1113811;
	Sat, 28 Jun 2008 17:53:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BB4F91380C; Sat, 28 Jun 2008 17:53:13 -0400 (EDT)
In-Reply-To: <20080628085359.GA29619@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 28 Jun 2008 04:53:59 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9E687922-455C-11DD-87D5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86745>

Jeff King <peff@peff.net> writes:

> Actually, I oversimplified a little bit in my "buckets" description.
> Stash actually stashes two things: the current index and the current
> worktree. So in that sense, it is not just another bucket as I
> described. For the purposes of the workflow we're discussing, I think
> that is how we want it to function. But the implementation will be a bit
> trickier than it might otherwise be because of this. I just didn't want
> to have to introduce another, slightly different type of stash.

You do *not* have to use stash that has different index and work tree
components and then your buckets description makes sense.

The index is to hold good changes verified to be fine to make commits, the
work tree is to test and verify outstanding changes, and the stash is to
hold the remainder (i.e. further changes that does not belong to what you
are currently looking at in your work tree).

When your workflow is to "verify and immediately commit", then the need
for buckets to your particular workflow can degenerate to a one that does
not need the index.  That is essentially Robert's workflow (but it does
not mean it is the only valid one).

What I do these days is this:

 * Fork a new topic from the commit I pushed out the last time to the
   public ("git checkout -b jc/topic ko/master").

 * Think, hack, commit, think, hack, commit, lather, rinse, repeat.

 * Make sure everything is worthy for the final state.  There can be (and
   need to be to use the current set of tools) some uncommitted changes.
   Make a stash, so that the work tree component records the final tree,
   and mentally name it the "commit goal".

 * I have never grew comfortable operating "edit" insn in "rebase -i", so
   the workflow from this point does not use it.  Instead, I detech the
   HEAD to the root of the series ("git checkout ko/master^0") at this
   point.  Now, none of my change is in the work tree.

 * Repeat the following:

   * Recreate the work tree state for the next round to be built on HEAD
     and make a commit, after verifying what I have in the commit is good.

     Examples of the tools at my disposal are:

     * "cherry-pick jc/topic~$N" to get the necessary changes from my
       earlier "snapshots", which can possibly be followed by a "git
       commit --amend".  This "going forward" is easiest especially in the
       early part of the sequence.

       "format-patch --stdout jc/topic~$N..jc/topic~$M | git am" is a
       slight variant of the above when I already had a good logical
       sequence (someday we probably will have "cherry-pick A..B").

     * "read-tree -m -u stash" to read the final state of the tree,
       selectively _remove_ the parts I do not want in this round, and
       make a commit ("git add -i && git commit && git reset --hard").
       This "going backward" is easier near the end of the sequence than
       other method that goes forward.

   * If I find some issues to be fixed in the state that was stashed
     (which I earlier thought was perfect) during the above:

    * "read-tree -m -u stash" to read the (previous) final state, fix it
      up, "stash drop" and "stash save" to update our "commit goal".

   The above is repeated until "git diff HEAD stash" does not have
   anything I need in the final series.

   The lower-level "read-tree -m -u" probably can be replaced with "stash
   apply" in real life, but I tend to try to ask for the final tree
   explicitly, because there is no reason to perform three-way merge dance
   "stash apply" does for these steps.

 * Final re-review:

   * "git diff jc/topic HEAD" to see if I did not miss anything (and review
     the "oops, the earlier commit goal was faulty" fixes).

   * "git log --reverse -p ko/master.." to see the final shape of the
     series.

 * "git branch -f jc/topic" to finish it off.

The commits from the session are merely convenient snapshot points that I
can use during the clean-up phase for series of cherry-picks to prepare
bulk of each of the logical change in the final series.  If somebody
subscribes to a dogma not to make commits of unproven changes, that is
fine, and such a person may not have any commits during "think, hack,
lather, rinse, repeat" phase, and that is fine.  But fortunately I don't.
