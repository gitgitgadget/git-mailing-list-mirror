From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [GSoC 2011] Git Sequencer
Date: Tue, 5 Apr 2011 14:24:46 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1104051354500.14365@iabervon.org>
References: <20110403172054.GA10220@kytes> <alpine.LNX.2.00.1104031407480.14365@iabervon.org> <20110404040610.GA30737@kytes> <20110404045437.GA2208@kytes> <alpine.LNX.2.00.1104041319570.14365@iabervon.org> <20110405175003.GA12159@kytes>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>, Stephen Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 20:24:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Avu-0005TR-Oh
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 20:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920Ab1DESYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 14:24:49 -0400
Received: from iabervon.org ([66.92.72.58]:37908 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753657Ab1DESYs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 14:24:48 -0400
Received: (qmail 28394 invoked by uid 1000); 5 Apr 2011 18:24:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Apr 2011 18:24:46 -0000
In-Reply-To: <20110405175003.GA12159@kytes>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170899>

On Tue, 5 Apr 2011, Ramkumar Ramachandra wrote:

> Hi Daniel,
> 
> Daniel Barkalow writes:
> > On Mon, 4 Apr 2011, Ramkumar Ramachandra wrote:
> > > Ramkumar Ramachandra writes:
> > > > Daniel Barkalow writes:
> > > > > I actually think that it would be a worthwhile feature for git's library 
> > > > > code to have a uniform mechanism for communicating that it is requesting 
> > > > > human intervention in the middle of a particular operation, where library 
> > > > > operations which conflict with being able to continue this operation are 
> > > > > either blocked or abort the operation, and the library is able to be told 
> > > > > in general that the human intervention is done and the library operation 
> > > > > should be finished now (or produce complaints about the user's work). That 
> > > > > is, a library-level, single-interrupted-step "sequencer". For that matter, 
> > > > > it should also apply to the common '"git merge" gets a conflict' case, and 
> > > > > it would be useful to get some representational uniformity between that 
> > > > > and cherry-pick getting a conflict.
> > > 
> > > [...]
> 
> Thanks for the detailed response- I've rearragned your response and
> added some comments.  I initially wanted to design it so that all
> state is persisted by the sequencer, but I can clearly see what's
> wrong with that approach now.
> 
> > I think, ultimately, that with this code structure in place, the 
> > am/rebase/rebase--interactive/sequencer details of how the multi-step 
> > process is recorded becomes less important. That way, your project can be 
> > successful even if you can't find a syntax for the sequencer file that 
> > meets the needs of all of these use cases. (Which is where I suspect 
> > you'll get bogged down.) If you can get all of the cases where git exits 
> > in order to get human intervention to share "everything that matters" and 
> > the core to "know what's in progress as far as anything else cares", I 
> > think that would be success, even if the various multi-step programs 
> > continue using their own state files.
> 
> Excellent.  The crux of the idea: The sequencer should serve as the
> entry/ exit point for Git when any operation requires user
> intervention to proceed.

I'm a bit surprised by the idea of calling that "the sequencer" (rather 
than having "the sequencer" be a command), but I actually think you're 
entirely right to do so. Be sure to be very explicit about that, though, 
because people will probably start with the wrong idea of what you're 
proposing otherwise.

> For this, it should have information about
> how we got to this point, and how to proceed after the user
> intervention is complete; this information is contained in:
> 
> > cherry_pick_conflict = { 
> >   "cherry-pick", APPLIES_TO_CURRENT_BRANCH | IN_MIDDLE_OF_COMMIT,
> >   cherry_pick_verify_resolution,
> >   cherry_pick_abort,
> >   cherry_pick_post_resolution
> > };
> 
> Wait -- isn't it missing a skip callback?

I think "skip" is actually: abort the lowest-level conflict and continue 
the next-level conflict. If you're doing a rebase, and the rebase is doing 
a "pick", and the pick got a conflict, --skip means that you abort the 
pick (to get back to the state where the earlier commits have been picked 
but this one hasn't been started, followed by having the rebase continue 
with what it was going to do after the pick completed.

So I don't think you need a "skip" callback, as long as you've untangled 
the levels cleanly and get the nesting support right.

> cherry_pick_conflict = { 
>   "cherry-pick", APPLIES_TO_CURRENT_BRANCH | IN_MIDDLE_OF_COMMIT,
>   cherry_pick_verify_resolution,
>   cherr_pick_skip,
>   cherry_pick_abort,
>   cherry_pick_post_resolution
> };
> 
> This information is passed to report_conflict(), which takes care of
> user intervention.  The user can do whatever she wants and then ask
> the sequencer to "continue", "skip" or "abort":

Right, although I think:

  $ git cheery-pick some-sha1
  Conflict needs to be fixed now!

  $ git skip

should give an error message about the current conflict not being a step 
of a larger process. That is, you can always "continue" or "abort", but 
you can only "skip" if there's something to skip to, even if it's only the 
higher-order sequence reporting that it's completed successfully.

> > Where the sequencer-level conflict nests around the cherry-pick-level 
> > conflict, and the generic "continue" completes things from the inside out.
> 
> Right.  And then the sequencer fires the appropriate callback and
> returns control to the parent command.  More notes:
> 
> >  - cherry-pick can save whatever it needs to in its state file; that's 
> >    its business, and the semantics here don't have to interact with other 
> >    commands, because report_conflict() has taken care of interaction with 
> >    other commands
> 
> At the end of a merge for example, the MERGE_MSG needs to be retrieved
> to create a new merge commit.  The sequencer des not need to know
> anything about this, since this is specific to 'merge'.

Right. And remove_branch_state() wouldn't even need to know about 
MERGE_MSG like it does now, because that would be handled by aborting any 
in-progress merge.

> >  - arbitrary code can determine that you're in the middle of resolving 
> >    some conflict, that the resolution of that conflict is about doing
> >    something to your current branch, and how to abort what you're doing,
> >    and how to finish it
> 
> Any arbitrary code simply has to ask the sequencer about the state of
> the intermediate files that report_conflict() uses.  They don't have
> to worry about command-specific intermediate files.

Right.

> >  - the same code gets run after the conflict has been resolved that would 
> >    have been run immediately if the merge went smoothly
> 
> Using these callbacks, there is no need for if-else ugliness inside
> the specific command to decide what to do next.
> 
> I suppose we can call this  idea a "generic conflict handler".  I like
> it very  much, and  I'll definitely  include this as  part of  my GSoC
> work.  Thanks for taking the time to explain it in such detail :)

You're welcome. Thanks for proposing to actually implement it. :)

	-Daniel
*This .sig left intentionally blank*
