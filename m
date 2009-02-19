From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge --abort
Date: Thu, 19 Feb 2009 02:58:03 -0800
Message-ID: <7v63j6n16s.fsf@gitster.siamese.dyndns.org>
References: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 11:59:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La6d3-0002fk-RB
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 11:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbZBSK6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 05:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752740AbZBSK6L
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 05:58:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbZBSK6K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 05:58:10 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5C7AF2B742;
	Thu, 19 Feb 2009 05:58:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4B5F92B72B; Thu,
 19 Feb 2009 05:58:05 -0500 (EST)
In-Reply-To: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com>
 (John Tapsell's message of "Thu, 19 Feb 2009 10:05:57 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 31A6577E-FE74-11DD-BF29-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110671>

John Tapsell <johnflux@gmail.com> writes:

>   It's not obvious how to abort a merge between two trees.  Would
> aliasing  "git merge --abort"  to "git reset --hard"  be sensible?

Not at all.  Especially when you have local changes.

There are two classes of users who would get themselves into a conflicted
merge while they have local changes.  One is people who know what they are
doing (like Linus) run "git pull" while having small set of disposable
local changes they do not mind losing, and they know how to recover.  The
other is recent CVS/SVN migrants who learned (incorrectly) that "git pull"
is similar to "cvs update" from wrong sources that say "it is a way to get
changes made by other people while you have a half-baked mess that is
still not ready to be committed in your work tree" (which is not) [*1*].

"git reset --hard" is the last thing you would want to suggest to the
latter class of people.

Immediately after a merge result in conflicts, there should be two kinds
of paths that are different from HEAD:

 * The ones you had local modifications before you started the failed
   merge.  They should be left intact after "merge --abort".

 * The ones you did not have local modifications, but merge could not
   automatically resolve.  There may be files with conflicted marker in
   the work tree, or there may be not.

If you had local modifications to a path that would be involved in the
merge, the merge *ought to* stop before even touching the index nor the
work tree [*2*].  Merge would not start if you had any staged changes in
the index.  So the recovery strategy for "merge --abort" needs to only
worry about the above two cases.  The correct implementation would be
roughly:

 - If the index does not have any unmerged entries, stop.  The merge did
   not do anything, and there is nothing to abort.

 - For each path that has unmerged entries in the index:

   - If the path does not exist in HEAD, drop the unmerged index entries
     for the path, without touching the work tree (if a file exists there,
     it must have existed as an untracked file before the merge started);

   - If the path does exist in HEAD, discard the unmerged index entries, 
     reset the path in the index from HEAD, and write that out to the work
     tree.

 - For each path whose entry is stage #0 in the index, if it is different
   from HEAD:

   - If it does not exist in HEAD, drop it from the index and remove the
     file from the work tree.  It is a file added by the failed merge and
     couldn't have existed as an untracked file before the merge started.

   - If it does exist in HEAD, reset the path in the index from HEAD, and
     write that out to the work tree.

But the above would be correct *only* immediately after a failed merge.
The user could be giving up after having done any random things after a
failed merge in an attempt to resolve, and at that point we cannot trust
the state of the index nor the work tree.  The simplest example to
illustrate:

    $ edit goodbye.c ;# without "git add"
    $ git merge other
    Conflict in hello.c
    $ git add goodbye.c
    $ git merge --abort ;# ???

The user's "git add goodbye.c" will make the state of the index unusable
for the above outlined algorithm to tell what was changed by the merge and
what were already different before the merge.

So in general, even "merge --abort" implemented according to the above
outline cannot be sold as "a safe procedure to recover to where you were
before you started the last failed merge".  There is no such thing, unless
you really educate the user not to expect miracle.

If you mistakenly run "git merge" while your index is already unmerged
(iow, after a failed merge before you resolved it nor resetted the index),
the command aborts without touching the index nor the work tree.  If you
implement "merge --abort" as outlined above, it will try to abort the
previous conflicted merge, not this round which did not do anything, but
again, the user could have done any other random things in addition to the
attempt to run the second "git merge".

Having said all that, I suspect

	$ git reset --merge HEAD

may do the right thing, if your git already has the option ;-)


[Footnote]

*1* CVS/SVN want to linearize so even if your local changes want to go
directy on top of what you checked out, "cvs update" tries to replay your
uncommitted changes on top of what comes as the latest from the central
server, which could result in conflicts.  With git, you do not have to
risk losing your local changes that way.  Instead, you can commit your
local changes and then "git pull" will try to merge.  The merge can
conflict and leave the same mess as "cvs update" would leave when it tries
to replay your uncommitted changes, but a _huge_ difference here is that
you get only one chance to resolve that conflict with CVS/SVN (because
nothing records your local changes before the "update") and if you screw
that up, you are out of luck.  With git, you have the local commit that
records the changes you did on top of the old tip of the branch, and you
can redo the merge.

*2* I say *ought to*, and I am reasonably sure resolve strategy works
correctly, but I wouldn't be surprised if recursive strategy which is the
default these days still have corner case bugs when the merge involves
renames and/or D/F conflicts).
