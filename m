From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/4] reworking git-rebase
Date: Tue, 15 Nov 2005 15:32:05 -0800
Message-ID: <7voe4lfpxm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 16 00:33:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcAHc-00042G-1F
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 00:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbVKOXcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 18:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbVKOXcI
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 18:32:08 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:45459 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932573AbVKOXcH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 18:32:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115233133.SCDR6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 18:31:33 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11965>

The current rebase implementation finds commits in our tree but
not in the upstream tree using git-cherry, and tries to apply
them using git-cherry-pick (i.e. always use 3-way) one by one.

Which is fine, but when some of the changes do not apply
cleanly, it punts, and punts badly.

Suppose you have commits A-B-C-D-E since you forked from the
upstream and submitted the changes for inclusion.  You fetch
from upstream head U and find that B has been picked up.  You
run git-rebase to update your branch, which tries to apply
changes contained in A-C-D-E, in this order, but replaying of C
fails, because the upstream got changes that touch the same area
from elsewhere.

Now what?

It notes that fact, and goes ahead to apply D and E, and at the
very end tells you to deal with C by hand.  Even if you somehow
managed to replay C on top of the result, you would now end up
with ...-B-...-U-A-D-E-C.

Breaking the order between B and others was the conscious
decision made by the upstream, so we would not worry about it,
and even if it were worrisome, it is too late for us to fix now.
What D and E do may well depend on having C applied before them,
which is a problem for us.

Here is a series requesting comments and testing.  I think this
change makes rebase easier to use when some of the changes do
not replay cleanly.  What it does is:

 - Instead of calling git-cherry-pick, it runs git-format-patch
   on the unmerged commits git-cherry found, and feeds the
   result to "git-am --3way".

 - To keep rebase working on a repository that manages binary
   files, it adds a very limited support to handle "binary
   diffs".

In the "unapplicable patch in the middle" case, this "rebase"
works like this:

 - A series of patches in e-mail form is created that records
   what A-C-D-E do, and is fed to git-am.  This is stored in
   .dotest/ directory, just like the case you tried to apply
   them from your mailbox.  Your branch is rewound to the tip of
   upstream U, and the original head is kept in .git/ORIG_HEAD,
   so you could "git reset --hard ORIG_HEAD" in case the end
   result is really messy.

 - Patch A applies cleanly.  This could either be a clean patch
   application on top of rewound head (i.e. same as upstream
   head), or git-am might have internally fell back on 3-way
   (i.e.  it would have done the same thing as git-cherry-pick).
   In either case, a rebased commit A is made on top of U.

 - Patch C does not apply.  git-am stops here, with conflicts to
   be resolved in the working tree.  Yet-to-be-applied D and E
   are still kept in .dotest/ directory at this point.  What the
   user does is exactly the same as fixing up unapplicable patch
   when running git-am:

   - Resolve conflict just like any merge conflicts. 

   - "git diff -p --full-index HEAD >.dotest/patch" to pretend
     as if you received a perfect, applicable patch.

   - "git reset --hard", to pretend you have not tried to apply
     that patch yet.

   [Side note] I think the latter two steps can and should be
   made into a short-hand to tell "git-am" that the conflicting
   patch is resolved.  "git-am --resolved", perhaps?

 - Continue with "git am --3way".  This applies the fixed-up
   patch so by definition it had better apply.  "git am" knows
   the patch after the fixed-up one is D and then E; it applies
   them, and you will get the changes from A-C-D-E commits on
   top of U, in this order.

I've been using this without noticing any problem, and as people
may know I do a lot of rebases.
