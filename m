From: Junio C Hamano <gitster@pobox.com>
Subject: Re: can't commit files that have been git add'ed because "fatal: you need to resolve your current index first"
Date: Wed, 28 Nov 2007 12:08:40 -0800
Message-ID: <7v63zm5e0n.fsf@gitster.siamese.dyndns.org>
References: <820179.5481.qm@web55002.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Priest <priestwilliaml@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 21:09:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxTDZ-0003mN-CF
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 21:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258AbXK1UIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 15:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754712AbXK1UIs
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 15:08:48 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57345 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755258AbXK1UIr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 15:08:47 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id EA6C92F0;
	Wed, 28 Nov 2007 15:09:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 10D6D998DB;
	Wed, 28 Nov 2007 15:09:03 -0500 (EST)
In-Reply-To: <820179.5481.qm@web55002.mail.re4.yahoo.com> (Bill Priest's
	message of "Wed, 28 Nov 2007 07:48:27 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66418>

Bill Priest <priestwilliaml@yahoo.com> writes:

>   I merged from one branch to another and had lots of
> conflicts.  I've resolved a set of files from the
> conflicts (in a directory) and did a git-add on this
> set of files.  I wasn't able to commit these files. 
> On IRC I was told that all files must be resolved
> before I can commit any of them.  This seems pretty
> limiting.

You have two parallel development lines that lead to A and B and trying
to come up with a "merge" M:

         o---o---A
        /         \
    ---o---o---B---M

What property should the merge commit "M" have?  It must keep the
changes made on the upper line to make it better than B, and it must
keep the changes made on the lower line to make it better than A.

Let's say both upper and lower lines of development touched files frotz
and xyzzy in overlapping, different ways.  You try to merge A while you
are at B and see conflicts in these two files.

Let's say you resolved frotz; the contents in frotz is in a desired
shape, i.e you have the changes you want from the line led to A and the
other line led to B.  But you haven't resolved xyzzy yet.

You seem to want to make this half-resolved state as a commit.  First
question: what contents would you want to commit for xyzzy?

If you commit the contents from B (because you started from it), then it
should not be recorded as a proper merge.  If you did so, merging that
back to A would obliterate all the work done up to A to file xyzzy:

         o---o---A...X
        /         \ .
    ---o---o---B---*
 
because merge base of A and * (I am marking it differently because such
an incomplete merge should not be made) is A, so the result (X) will be
the half-merge * itself (fast forward).  That's not a merge as it is not
better than A -- you discarded improvements made to xyzzy by people who
built up to A.

This is inherent to what a merge is.  With proper understanding of what
a merge is, you would not feel this limiting at all.

Having said that, I think something like the following _could_ be done,
although I do not know if it makes much sense.

(1) Try merge, see it conflict, resolve only a part of it, and record
    the result as "WIP to merge in A".  Do not record it as a merge, as
    it is not.  diff between B and M will contain a squash merge of A on
    top of B minus the changes to the path xyzzy.

         o---o---A
        /         
    ---o---o---B---M

(2) Fix up the conflicts in xyzzy to resolve the conflicts fully, and
    record the result as "Final merge of A into B".  This should be
    recorded as a merge, as the result is "keeping changes done on both
    branches to come up with something better than either of them."

         o---o---A---,
        /             \
    ---o---o---B---M---N

If you look at the topology a bit differently, the above actually makes
some sense:

         .---o---o---A
        /             \
    ---o---o---B---M---N

That is, instead of merging A into B, you made "preparatory changes" to
branch B in order to make it easier to merge A.  That's what the commit
M is about.

Then you merge A on top of M.  In reality, because the difference
between B to M contains most of the squash merge of A into B, such a
merge N will contain many accidental clean merges.  But in git,
accidental clean merges are not a problem (people can apply the same
patch to their trees and later their branches can be merged).

But "git commit" after a conflicted merge will always create a merge,
and there is no canned option to do multi-step merge like the above.

You can still do that by hand, by doing something like:

	$ git merge --squash A
        $ resolve only partly
        $ git commit -m 'Prepare to merge A'
        $ git reset --hard
        $ git merge A
	$ resolve the rest
        $ git commit -m 'Fully merged A'

For such a multi-step merge to make sense, the change between B---M
should make sense by itself for people who have to read such a history
later.  Such a half-a-squash-merge may probably not make sense by itself
in most cases, so I suspect the above workflow would not be useful in
general.
