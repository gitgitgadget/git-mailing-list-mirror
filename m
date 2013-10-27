From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes:
 line
Date: Sun, 27 Oct 2013 07:14:07 +0000
Message-ID: <20131027071407.GA11683@leaf>
References: <20131024122255.GI9378@mwanda>
 <20131024122512.GB9534@mwanda>
 <20131026181709.GB10488@kroah.com>
 <20131027013402.GA7146@leaf>
 <526CA7D4.1070904@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: linux-kernel-owner@vger.kernel.org Sun Oct 27 08:14:27 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1VaKYJ-0007w4-0l
	for glk-linux-kernel-3@plane.gmane.org; Sun, 27 Oct 2013 08:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400Ab3J0HOP (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 27 Oct 2013 03:14:15 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:45485 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469Ab3J0HOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Oct 2013 03:14:14 -0400
Received: from mfilter11-d.gandi.net (mfilter11-d.gandi.net [217.70.178.131])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id 6C96F41C051;
	Sun, 27 Oct 2013 08:14:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter11-d.gandi.net
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
	by mfilter11-d.gandi.net (mfilter11-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id kJuXWx4-FvZY; Sun, 27 Oct 2013 08:14:09 +0100 (CET)
X-Originating-IP: 77.221.165.106
Received: from leaf (ip-77-221-165-106.dsl.twang.net [77.221.165.106])
	(Authenticated sender: josh@joshtriplett.org)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id B85F241C04B;
	Sun, 27 Oct 2013 08:14:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <526CA7D4.1070904@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236790>

On Sun, Oct 27, 2013 at 06:42:44AM +0100, Michael Haggerty wrote:
> On 10/27/2013 02:34 AM, Josh Triplett wrote:
> > Linux Kernel Summit 2013 decided on a commit message convention to
> > identify commits containing bugs fixed by a commit: a "Fixes:" line,
> > included in the standard commit footer (along with "Signed-off-by:" if
> > present), containing an abbreviated commit hash (at least 12 characters
> > to keep it valid for a long time) and the subject of the commit (for
> > human readers).  This helps people (or automated tools) determine how
> > far to backport a commit.
> > 
> > Add a command line option for git commit to automatically construct the
> > "Fixes:" line for a commit.  This avoids the need to manually construct
> > that line by copy-pasting the commit hash and subject.
> > 
> > Also works with --amend to modify an existing commit's message.  To add
> > a Fixes line to an earlier commit in a series, use rebase -i and add the
> > following line after the existing commit:
> > x git commit --amend --no-edit -f $commit_containing_bug
> > 
> > Generalize append_signoff to support appending arbitrary extra lines to
> > a commit in the signoff block; this avoids duplicating the logic to find
> > or construct that block.
> 
> I have a few comments and questions about the design of this feature:
> 
> First of all, let me show my ignorance.  How formalized is the use of
> metadata lines at the end of a commit message?  I don't remember seeing
> documentation about such lines in general (as opposed to documentation
> about particular types of lines).  Is the format defined well enough
> that tools that don't know about a particular line could nonetheless
> preserve it correctly?  Is there/should there be a standard recommended
> order of metadata lines?  (For example, should "Fixes:" lines always
> appear before "Signed-off-by" lines, or vice versa?)  If so, is it
> documented somewhere and preserved by tools when such lines are
> added/modified?  Should there be support for querying such lines?

While it isn't very well documented in git itself, metadata lines are
quite standardized.  See Documentation/SubmittingPatches and
Documentation/development-process/5.Posting in the Linux kernel, for an
explanation of "Reported-by:", "Tested-by:", "Reviewed-by:",
"Suggested-by:", and "Acked-by:".  And git itself looks for a very
specific format; the has_conforming_footer function looks for a footer
consisting exclusively of rfc2822-style (email-style) header lines to
decide whether to append "Signed-off-by:" (and now "Fixes:") directly to
that block or to create a new block.

I do think there should be additional support for such lines in git,
such as a git commit option to add "Cc:" lines (via a --cc-cmd
like get_maintainer.pl run at commit time), or fast options in rebase -i
to append arbitrary footer lines to a commit.

> Too bad your proposed new option sounds so similar to --fixup, which
> does something conceptually similar albeit very different in effect.
> This will likely lead to confusion.

Given that the line is named "Fixes:", I don't think the name of the
option will extend the confusion any further. :)

> I wonder if the two features could
> be combined in some way?
> 
> The main difference between the two features is how they are intended to
> be used: --fixup is to fix a commit that hasn't been pushed yet (where
> the user intends to squash the commits together), whereas --fixes is to
> mark a commit as a fix to a commit that has already been pushed (where
> the commits will remain separate).  But there seems to be a common
> concept here.
> 
> For example, what happens if a --fixes commit is "rebase -i"ed at the
> same time as the commit that it fixes?  It might make sense to do the
> autosquash thing just like with a --fixup/--squash commit.  (Otherwise
> the SHA-1 in the "Fixes:" line will become invalid anyway.)

Most definitely not, no, at least not without an explicit option to
enable that.  Consider the case of backporting a series of patches and
preserving the relative history of those patches, to make it easier to
match up a set of patches.  At most, it might be a good idea for
cherry-pick or similar to provide an updated Fixes tag for the new hash
of the older commit.  Personally, I'd argue against doing this even with
--autosquash.  I could see the argument for an --autosquash-fixes, but I
can't think of a real-world scenario where what would come up.

Generally, if history is still editable, you should just squash in the
fix to the original commit, and if history is no longer editable (which
is the use case for "Fixes:" lines), the squash case simply won't come
up, offering little point to adding special support for that case.

> Conversely, I suppose one could ask whether there should be some way to
> prevent "fixup!" or "squash!" commits from being pushed, at least
> without some kind of --force option.  This could of course be enforced
> by a hook but it might be nice to have some protection by default.

That's a good idea, but unrelated to this patch.  And yes, a hook seems
like the right answer there.

> I see that there a consistency check that the --fixes argument is a
> valid commit.  But is there/should there be a check that it is an
> ancestor of the commit being created?  Is there/should there be a check
> that both of these facts remain true if the the commit containing it is
> rebased, cherry-picked, etc?

That sounds like a nice future enhancement, sure.  I don't have any plans to
add such a check myself, though.  Also note that --fixup and --squash
don't have such a check either; if you want to add one, you should add
it for all three options at once.

> In workflows that make more use of cherry-picking, it could be that the
> original buggy commit was cherry-picked to a different branch.  In this
> case the user would probably want to cherry-pick the fixing commit to
> the other branch, too.  But then the commit that it would be fixing
> would have a different SHA-1 than it did on the original branch.  A
> check that the "Fixes:" line refers to an ancestor of the current commit
> could warn against such errors.  (In some cases it might be possible to
> use cherry-pick's "-x" lines to figure out how to rewrite the "Fixes:"
> line, but I doubt that would work often enough to be worthwhile.)

That also sounds like a plausible future enhancement. :)  I do like the
idea of warning when a cherry-pick grabs a subsequently-fixed commit and
not the fix; that seems quite useful.

> > Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> > ---
> >  Documentation/git-commit.txt | 12 ++++++++++--
> >  builtin/commit.c             | 29 +++++++++++++++++++++++++++--
> >  sequencer.c                  | 31 +++++++++++++++++++++++--------
> >  sequencer.h                  |  3 +++
> >  t/t7502-commit.sh            | 39 ++++++++++++++++++++++++++++++++++++++-
> >  5 files changed, 101 insertions(+), 13 deletions(-)
> > 
> > diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> > index 1a7616c..fcc6ed2 100644
> > --- a/Documentation/git-commit.txt
> > +++ b/Documentation/git-commit.txt
> > @@ -8,8 +8,8 @@ git-commit - Record changes to the repository
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
> > -	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
> > +'git commit' [-a | --interactive | --patch] [-s] [-f <commit>] [-v] [-u<mode>]
> > +	   [--amend] [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
> 
> You mention only "-f", not "--fixes" here.

-u also has --untracked-files, and -e has --edit; synopsis lines like
these normally show the shortest version of each option.

> But I don't think that this feature should be given the "-f" short
> option, as (a) -f often means "force"; (b) it will increase the
> confusion with --fixup; (c) it just doesn't strike me as being likely to
> be such a frequently-used option (though if this changes over time the
> "-f" option could always be granted to it later).

(a) -n often means --dry-run, but for commit it means --no-verify.
Different commands have different options, and commit doesn't have a
--force to abbreviate as -f.

(b) If anything, I think the existence of a short option will make the
distinction more obvious, since -f and --fixup are much less similar
than --fixes and --fixup.  Most users will never type --fixes, making
confusion unlikely.

(c) Short option letters tend to be first-come first-serve unless
there's a strong reason to do otherwise.  Why reserve 'f' for some
hypothetical future option that doesn't exist yet?

> >  	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
> >  	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
> >  	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
> > @@ -156,6 +156,14 @@ OPTIONS
> >  	Add Signed-off-by line by the committer at the end of the commit
> >  	log message.
> >  
> > +-f <commit>::
> > +--fixes=<commit>::
> > +	Add Fixes line for the specified commit at the end of the commit
> > +	log message.  This line includes an abbreviated commit hash for
> > +	the specified commit; the `core.abbrev` option determines the
> > +	length of the abbreviated commit hash used, with a minimum length
> > +	of 12 hex digits.
> > +
> 
> You might also mention that the "Fixes:" line includes the old commit's
> subject line.

I only mentioned the abbreviated commit hash because it was necessary to
explain the factors affecting hash length.  -s, above, doesn't mention
that the Signed-off-by line includes the name and email address of the
committer.

- Josh Triplett
