From: Junio C Hamano <junkio@cox.net>
Subject: Re: Effective difference between git-rebase and git-resolve
Date: Fri, 24 Mar 2006 23:15:57 -0800
Message-ID: <7vacbfxadu.fsf@assigned-by-dhcp.cox.net>
References: <20060325035423.GB31504@buici.com>
	<Pine.LNX.4.64.0603242014160.15714@g5.osdl.org>
	<7v64m3ys3a.fsf@assigned-by-dhcp.cox.net>
	<20060325063225.GA13791@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 25 08:16:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN30G-0005O4-O6
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 08:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWCYHQB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 02:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWCYHQA
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 02:16:00 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:19701 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750824AbWCYHQA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 02:16:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060325071559.KAVY25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Mar 2006 02:15:59 -0500
To: Marc Singer <elf@buici.com>
In-Reply-To: <20060325063225.GA13791@buici.com> (Marc Singer's message of
	"Fri, 24 Mar 2006 22:32:25 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17960>

Marc Singer <elf@buici.com> writes:

[I'm shuffling this part to the top]

> Moreover, it isn't clear to me if git-rebase is better than git-merge.

Merge preserves commit ancestry, so if you are hoping it to
clean up your history, that is not the tool to do it.  Both
rebase and cherry-pick are to help you create a cleaner,
alternate history.  So none is better than the other.  They
serve different purposes.

> On Fri, Mar 24, 2006 at 10:08:09PM -0800, Junio C Hamano wrote:
>> > Junio, is there some magic to restart a rebase after you've fixed up the 
>> > conflicts?
>> 
>> The modern rebase is essentially git-format-patch piped to
>> git-am (with -3 flag to allow falling back to three-way merge),
>> and all the familiar "the patch did not apply -- what now?"
>> techniques can be employed.
>...
> By modern do you mean newer than 1.2.4?  I comprehend what you're
> layin' down here, but I don't know if I need to do something
> different.

By modern, I meant v0.99.9-g7f59dbb.

diff-tree 7f59dbb... (from f9039f3...)
Author: Junio C Hamano <junkio@cox.net>
Date:   Mon Nov 14 00:41:53 2005 -0800

    Rewrite rebase to use git-format-patch piped to git-am.
    
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
    
    This rewrites rebase to use git-format-patch piped to git-am,
    and when the patch does not apply, have git-am fall back on
    3-way merge.  The updated diff/patch pair knows how to apply
    trivial binary patches as long as the pre- and post-images are
    locally available, so this should work on a repository with
    binary files as well.
    
    The primary benefit of this change is that it makes rebase
    easier to use when some of the changes do not replay cleanly.
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
       - "git am --resolved --3way" to continue applying the patches.
    
     - This applies the fixed-up patch so by definition it had
       better apply.  "git am" knows the patch after the fixed-up
       one is D and then E; it applies them, and you will get the
       changes from A-C-D-E commits on top of U, in this order.
    
    I've been using this without noticing any problem, and as people
    may know I do a lot of rebases.
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>
