From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git log -p -m: Document, honor --first-parent
Date: Wed, 10 Feb 2010 03:12:10 +0100
Message-ID: <20100210021148.GT9553@machine.or.cz>
References: <46d6db661002091545j74f625ffr74ca70a0474948fc@mail.gmail.com>
 <20100209235707.GQ9553@machine.or.cz>
 <7v1vguuf8h.fsf@alter.siamese.dyndns.org>
 <20100210011149.GR9553@machine.or.cz>
 <7vpr4dop1m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian MICHON <christian.michon@gmail.com>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 03:13:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf24b-0005nB-0h
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 03:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755339Ab0BJCMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 21:12:53 -0500
Received: from w241.dkm.cz ([62.24.88.241]:47984 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755122Ab0BJCMw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 21:12:52 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 9418E86209D; Wed, 10 Feb 2010 03:12:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vpr4dop1m.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139473>

On Tue, Feb 09, 2010 at 05:30:29PM -0800, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> > index 0e39bb6..a2a2d04 100644
> > --- a/Documentation/git-log.txt
> > +++ b/Documentation/git-log.txt
> > @@ -118,6 +118,15 @@ git log master --not --remotes=*/master::
> >  	Shows all commits that are in local master but not in any remote
> >  	repository master branches.
> >  
> > +git log -p -m --first-parent::
> > +
> > +	Shows the history including change diffs, but only from the
> > +	"main branch" perspective, skipping commits that come only from
> > +	merges, and showing full diffs of changes introduced by the merges.
> > +	This makes sense only when following a strict policy of merging all
> > +	topic branches when staying on a single integration branch and
> > +	making sure the merges are not fast-forwards.
> 
> I think the tone of the last three lines is too strong.
> 
> Why is it necessary to make a merge with a single commit side branch when
> fast-forward would do?  And if the side branch is actually two or more
> commits, it will show the broken-down changes in more detail, but the fact
> that it was made on the "primary" history would also have some
> significance (e.g. trivial and obvious fixes made directly on 'master',
> other branches merged from topic after cooking).

Ok, so what about "...the merges are not fast-forwards if the branch
histories are non-trivial"? Since there are two cases:

* The branch was created on top of HEAD, the commits were made and now
the branch is merged back, that's an "ok fastforward".

* The branch was created long ago, but has merged latest changes of the
top of HEAD in, and now the branch is merged back, that's a "bad
fastforward" since that flips the perspective of main-vs-topic branch.

I feel that it's important to point out this caveat.

> It is Ok to elaborate on the "policy" issues in the Discussion section,
> but otherwise, I would rather see you spend the same number of lines to
> clarify "showing full diffs of changes introduced by the merges" a bit
> better (e.g. it is unclear if you are showing diff from each parents or
> just from the first parent).  Perhaps "s/introduced /& to the first-parent
> ancestry /" may suffice.

I really dislike the "first-parent ancestry" wording, I think it muds
down the whole issue.  It would seem to me that the basic idea is clear
from the description (which might even now be excessively verbose) and
if anyone is still confused, they can quickly peek at -m description or
actually try the command out.

> > diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> > index 6e9baf8..d7d0dee 100644
> > --- a/Documentation/rev-list-options.txt
> > +++ b/Documentation/rev-list-options.txt
> > @@ -108,8 +108,8 @@ options may be given. See linkgit:git-diff-files[1] for more options.
> >  
> >  -c::
> >  
> > -	This flag changes the way a merge commit is displayed.  It shows
> > -	the differences from each of the parents to the merge result
> > +	This flag forces the default way a merge commit is displayed.  It
> > +	shows the differences from each of the parents to the merge result
> >  	simultaneously instead of showing pairwise diff between a parent
> 
> Sorry, I don't understand this change; "forces the default?"  Any option
> "forces" the command to behave differently.  At least the original is
> understandable "Ah, without it it shows one way but with this it shows in
> a different way", even though that does not carry much useful information
> (i.e. what are the two ways?  ah, I need to read further down).

At some point when making this change, I was in the state of believing
that combined diffs are always the default. :-) That is not true, so
I will drop this change again.

> > diff --git a/log-tree.c b/log-tree.c
> > index 27afcf6..fb990a1 100644
> > --- a/log-tree.c
> > +++ b/log-tree.c
> > @@ -514,6 +514,14 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
> >  			return 0;
> >  		else if (opt->combine_merges)
> >  			return do_diff_combined(opt, commit);
> > +		else if (opt->first_parent_only) {
> > +			/* Generate merge log entry only for the first
> > +			 * parent, showing summary diff of the others
> > +			 * we merged _in_. */
> 
> Style?

What's wrong? There should be an empty line at the comment beginning?
I have a faint memory of getting some-such undocumented comment ugliness
requirement wrong before. ;-)

> Don't we use --cc as default for "show" (and possibly "log"---I don't
> remember the details)?

Ah, that must be it! Turning that off in -m code makes it work for show
as well.

> > +			diff_tree_sha1(parents->item->object.sha1, sha1, "", &opt->diffopt);
> > +			log_tree_diff_flush(opt);
> > +			return !opt->loginfo;
> > +		}
> 
> This needs some tests but I think it is a good first step in the right
> direction.

Thanks. Hrmh, testsuites... ;-)

-- 
				Petr "Pasky" Baudis
If you can't see the value in jet powered ants you should turn in
your nerd card. -- Dunbal (464142)
