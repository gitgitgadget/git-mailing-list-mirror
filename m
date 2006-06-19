From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] rebase: Allow merge strategies to be used when rebasing
Date: Mon, 19 Jun 2006 14:39:51 -0700
Message-ID: <20060619213951.GA6987@hand.yhbt.net>
References: <1150599735483-git-send-email-normalperson@yhbt.net> <7vd5d63k7f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 19 23:40:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsRTP-0001lL-Tx
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 23:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWFSVjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 17:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWFSVjx
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 17:39:53 -0400
Received: from hand.yhbt.net ([66.150.188.102]:4749 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964904AbWFSVjw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 17:39:52 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 6053B7DC022; Mon, 19 Jun 2006 14:39:51 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5d63k7f.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22140>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > This solves the problem of rebasing local commits against an
> > upstream that has renamed files.
> 
> I think leveraging the merge strategy to perform rebase is
> sound, but the selection of merge base for this purpose is quite
> different from the regular merge, and I think unfortunately this
> patch is probably wrong in letting git-merge choose the merge
> base.
> 
> But let's mention other things as well.
> 
>  - You kept the original "format-patch piped to am" workflow
>    optionally working.

I left it as the default, too.  I figured that it's best not
to change the default (and most likely faster) behavior of
something people rely on.

>  - You check if merge or patch was used for failed rebase and
>    follow the appropriate codepath while resuming, which is
>    good.
> 
>  - The list of commits you generate with tac seem to include
>    merge commit -- you may want to give --no-merges to
>    rev-list.

Good point, I'll change it.

>  - I do not think we use "tac" elsewhere -- is it portable
>    enough?

Nope.  perl -e 'print reverse <>' is equivalent and we already use
plenty of perl.

>  - Exiting with success unconditionally after "git am" feels
>    wrong.  I would do "exit $?" instead of "exit 0" there.

Oops, I'll change that, too.

> Suppose you have this commit ancestry graph:
> 
> ----------------------------------------------------------------
> Example:       git-rebase --onto master A topic
> 
>         A---B---C topic                       B'--C' topic
>        /                   -->               /
>   D---E---F---G master          D---E---F---G master
> ----------------------------------------------------------------
> 
> This is slightly different from the one at the beginning of the
> script.  The idea is A turned out to be not so cool, and we
> would want to drop it.
> 
> > +call_merge () {
> > +	cmt="$(cat $dotest/`printf %0${prec}d $1`)"
> > +	echo "$cmt" > "$dotest/current"
> > +	git-merge $strategy_args "rebase-merge: $cmt" HEAD "$cmt" \
> > +			|| die "$MRESOLVEMSG"
> > +}
> 
> call_merge is first called with B in cmt, and HEAD is pointing
> at G.  But the merge in this function makes a merge between B
> and G, taking the effect of E->A.
> 
> I think the three-way merge you would want here is not between B
> and G using E as the pivot, but between B and G using A as the
> pivot.  That's how cherry-pick and revert works.  I would
> leverage the interface that is one level lower for this -- the
> strategy modules themselves.
> 
> 	git-merge-$strategy $cmt^ -- HEAD $cmt

Changing the 'git-merge $strategy_args "rebase-merge: $cmt" HEAD "$cmt"'
line in call_merge() to this seems to have broken more tests.

I'm not an expert at merging strategies by any measure, I've just
trusted merge-recursive to Do The Right Thing(TM) more often than not,
and use rerere to avoid repeating work.

I'm not entirely sure I want (or fully understand how) to support
cherry-picking/revert with this, as I've already dropped --skip when
--merge was in use.

I'll think about this some more when I'm less distracted.

> The strategy modules take merge base(s), double-dash as the
> separator, our head and the other head.  They do not make commit
> themselves (instead they leave working tree and index in
> committable state) and signal the results with their exit
> status:
> 
> 	0 -- success
>         1 -- conflicts
>         2 -- did not handle the merge at all

Cool, that's good.

-- 
Eric Wong
