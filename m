From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rebase: Allow merge strategies to be used when rebasing
Date: Sun, 18 Jun 2006 02:08:04 -0700
Message-ID: <7vd5d63k7f.fsf@assigned-by-dhcp.cox.net>
References: <1150599735483-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 11:08:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrtGR-0003vm-Ql
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 11:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWFRJIH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 05:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWFRJIG
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 05:08:06 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:58270 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932175AbWFRJIG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 05:08:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060618090805.FGJN5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Jun 2006 05:08:05 -0400
To: Eric Wong <normalperson@yhbt.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22064>

Eric Wong <normalperson@yhbt.net> writes:

> This solves the problem of rebasing local commits against an
> upstream that has renamed files.

I think leveraging the merge strategy to perform rebase is
sound, but the selection of merge base for this purpose is quite
different from the regular merge, and I think unfortunately this
patch is probably wrong in letting git-merge choose the merge
base.

But let's mention other things as well.

 - You kept the original "format-patch piped to am" workflow
   optionally working.

 - You check if merge or patch was used for failed rebase and
   follow the appropriate codepath while resuming, which is
   good.

 - The list of commits you generate with tac seem to include
   merge commit -- you may want to give --no-merges to
   rev-list.

 - I do not think we use "tac" elsewhere -- is it portable
   enough?

 - Exiting with success unconditionally after "git am" feels
   wrong.  I would do "exit $?" instead of "exit 0" there.

Suppose you have this commit ancestry graph:

----------------------------------------------------------------
Example:       git-rebase --onto master A topic

        A---B---C topic                       B'--C' topic
       /                   -->               /
  D---E---F---G master          D---E---F---G master
----------------------------------------------------------------

This is slightly different from the one at the beginning of the
script.  The idea is A turned out to be not so cool, and we
would want to drop it.

> +call_merge () {
> +	cmt="$(cat $dotest/`printf %0${prec}d $1`)"
> +	echo "$cmt" > "$dotest/current"
> +	git-merge $strategy_args "rebase-merge: $cmt" HEAD "$cmt" \
> +			|| die "$MRESOLVEMSG"
> +}

call_merge is first called with B in cmt, and HEAD is pointing
at G.  But the merge in this function makes a merge between B
and G, taking the effect of E->A.

I think the three-way merge you would want here is not between B
and G using E as the pivot, but between B and G using A as the
pivot.  That's how cherry-pick and revert works.  I would
leverage the interface that is one level lower for this -- the
strategy modules themselves.

	git-merge-$strategy $cmt^ -- HEAD $cmt

The strategy modules take merge base(s), double-dash as the
separator, our head and the other head.  They do not make commit
themselves (instead they leave working tree and index in
committable state) and signal the results with their exit
status:

	0 -- success
        1 -- conflicts
        2 -- did not handle the merge at all
