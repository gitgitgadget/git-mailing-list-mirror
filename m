From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Files different for me
Date: Wed, 25 Feb 2009 12:04:13 -0800
Message-ID: <7vocwq1dxe.fsf@gitster.siamese.dyndns.org>
References: <450196A1AAAE4B42A00A8B27A59278E709E047DE@EXCHANGE.trad.tradestation.com>
 <alpine.LFD.2.00.0902250957260.3111@localhost.localdomain>
 <7v4oyi2vvf.fsf@gitster.siamese.dyndns.org>
 <450196A1AAAE4B42A00A8B27A59278E709E048CB@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	<git@vger.kernel.org>
To: "John Dlugosz" <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 21:06:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcQ0z-0007ne-Ij
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 21:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758934AbZBYUEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 15:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758782AbZBYUEZ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 15:04:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59531 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758710AbZBYUEX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 15:04:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 96E979C6F1;
	Wed, 25 Feb 2009 15:04:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CBF059C6EF; Wed,
 25 Feb 2009 15:04:15 -0500 (EST)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E709E048CB@EXCHANGE.trad.tradestation.com>
 (John Dlugosz's message of "Wed, 25 Feb 2009 14:23:29 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7D4DD1AE-0377-11DE-A614-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111492>

"John Dlugosz" <JDlugosz@TradeStation.com> writes:

> You will be left with:
>
>  - Paths that have local changes (index matches HEAD but work tree does
>    not match the index --- like your Makefile);
>
>  - Paths cleanly merged (index and HEAD are different but work tree
>    already matches the index);
>
>  - Unmerged paths (index has higher stage entries with <<</===/>>> files
>    in the work tree);
>
> You, I and experienced users know what to do.  Deal *only* with the last
> kind, mark them with "git add" after you are done with each of them, and
> make sure you do not say "-a" when committing the result, to exclude the
> first kind from the merge result.
>
> I've been wondering if we can make this safer for others.
>
> ===end===
>
> I've gone over that carefully and I understand (I think) what you are
> saying.  The first two are things that were not committed, and should
> stay that way (added or not) if they did not conflict.  But they can get
> in the way if a merge (on other files) is needed.

No, the latter two *should* be committed.  The first one *must* be
excluded.

"merge" (and "git am" with or without "-3" for patch application) are
carefully written in such a way that:

 (1) They do not tolerate a dirty index.  They stop without touching
     anything if you have *any* staged changes.

 (2) As long as your index is clean, i.e. matches HEAD, there are two
     cases.

     (2-a) They add cleanly merged paths to the index and write the result
           out in the work tree.

     (2-b) They leave unclean merges as unmerged entries in the index and
           write the conflicted merge result in the work tree.

     (2-c) If all paths cleanly merge, then the index is written out as a
           tree and a merge commit is created.

     However, neither of the above happens when you have local changes to
     the paths they need to do so.

     Your local changes to the paths that "merge" (and "git am") does not
     have to touch are tolerated.

Unlike CVS/SVN, you do not merge when you are in the middle of doing
something, potentially risking a huge merge conflict that you are unable
to resolve and redo, and (1) and "However" in (2) are both safety against
such "Merge conflicts between my HEAD and the other branch are intermixed
with my still uncommitted changes, and I am lost" disaster.  You get a
chance to finish what you started working with your index first before
continuing with the merge.

We were discussing something very different.

In the case (2) where your local changes do not interact with the merge,
the merge as the whole can fail due to conflicts in some paths.  If you
ran "git add" before starting this merge, you wouldn't have come this far
but would have been dealt with by the safety of (1).

Now, in such a case, you have:

 - Files you had modifications before starting this merge.  Because we are
   talking about case (2), by definition, you haven't done "git add" to
   them.  The index entries are at stage 0 and match HEAD for these paths.

 - Files cleanly merged.  In the index, they are at stage 0 and may be
   different from HEAD.  The difference from HEAD comes from the changes
   in the branch being merged (or in the case of "am -3", the change the
   patch introduces).  It can never come from your local changes, because
   we are talking about case (2), and you couldn't have done "git add"
   them before you started this merge.

 - Files with conflicts.  These conflict come from changes committed to
   your HEAD and the branch being merged (or in the case of "am -3", the
   change the patch introduces).  You can never have had local changes to
   these paths (see "However" in (2) above).

That means:

 - The paths at stage 0 in the index can and should be committed without
   any further "git add" when recording this merge.  Doing "git add" for
   paths in the first category among the three will include your unrelated
   local changes in the result which is not what you want.  And doing "git
   add" for the paths in the second category is unnecessary; "merge" (and
   "git am") have already updated the index with the merge result.

 - The paths at higher stages (i.e. unmerged) come from the merge, and you
   must resolve them (either in vi or mergetool) and "git add" them.

So the short rule is "resolve and 'git add' to mark the resolution only
for paths with conflicts.  Never 'git add' anything else before making
your commit.  And do not say 'git commit -a' because that is part of the
previous rule."

> In an effort to "wonder" out loud, can you explain how to handle that
> with "mergetool"?  For a dumb user like me, it just fixes some files
> itself (I guess kdiff is smarter than the normal merge logic) and
> presents me with a GUI for things I need to specify.  This should
> naturally only go through files with conflicts because of those
> "<<</===/>>>" files present.
>
> So, what should I know/do?  "Don't use -a"?  If the idea is to commit
> the merged stuff but preserve the status of what I've added but don't
> want to commit yet,

You do not have to worry about that, because you don't "merge" (or "am")
when you already have changes that are "git add"ed to the index.  These
tools correctly detect this case that you are in the middle of something
and refuse to touch neither your index nor your work tree(see (1) above).
