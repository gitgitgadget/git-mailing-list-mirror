From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [GSoC 2011] Git Sequencer
Date: Mon, 4 Apr 2011 14:59:59 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1104041319570.14365@iabervon.org>
References: <20110403172054.GA10220@kytes> <alpine.LNX.2.00.1104031407480.14365@iabervon.org> <20110404040610.GA30737@kytes> <20110404045437.GA2208@kytes>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>, Stephen Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 21:00:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6p0T-0005NR-Vs
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 21:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019Ab1DDTAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 15:00:01 -0400
Received: from iabervon.org ([66.92.72.58]:60347 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753276Ab1DDTAA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 15:00:00 -0400
Received: (qmail 20229 invoked by uid 1000); 4 Apr 2011 18:59:59 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Apr 2011 18:59:59 -0000
In-Reply-To: <20110404045437.GA2208@kytes>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170834>

On Mon, 4 Apr 2011, Ramkumar Ramachandra wrote:

> Hi Daniel,
> 
> Ramkumar Ramachandra writes:
> > Daniel Barkalow writes:
> > > I actually think that it would be a worthwhile feature for git's library 
> > > code to have a uniform mechanism for communicating that it is requesting 
> > > human intervention in the middle of a particular operation, where library 
> > > operations which conflict with being able to continue this operation are 
> > > either blocked or abort the operation, and the library is able to be told 
> > > in general that the human intervention is done and the library operation 
> > > should be finished now (or produce complaints about the user's work). That 
> > > is, a library-level, single-interrupted-step "sequencer". For that matter, 
> > > it should also apply to the common '"git merge" gets a conflict' case, and 
> > > it would be useful to get some representational uniformity between that 
> > > and cherry-pick getting a conflict.
> 
> [...]
> 
> > int sequencer_handle_conflict(); /* Returns ABORT (1) or RESOLVED (0) */
> > 
> > /**
> >  * The sequencer_handle_conflict function essentially starts with a
> >  * working tree with unmerged files and results in either a working
> >  * tree without unmerged files (in which case it returns 0), or simply
> >  * returns 1.  Advantage: Consistency. Each individual script will not
> >  * have to maintain its own temporary files.
> >  */
> 
> Uh, no.  I wrote this part in too quickly.  Clearly needs more
> thought.

Here's how I'm thinking about a single step:

The non-conflict case is:

  $ git cherry-pick ...
  figure out what we're asked to do
  make the change to the working directory and index
  make the commit with info from the commit we're cherry-picking

The conflict case should be:

  $ git cherry-pick ...
  figure out what we're asked to do
  make the change to the working directory and index
  discover problem, set up for human assistance, tweak info to say that we 
    needed help
  $ fix stuff
  $ git continue
  check that everything is how it should be
  make the commit with info from the commit we're cherry-picking

That is, the code that cherry-picks one commit can quit in the middle and 
resume after the user finishes helping, and the main entry point to git 
can resume that operation.

So, my thought was that you'd have something like:

cherry_pick_conflict = { 
  "cherry-pick", APPLIES_TO_CURRENT_BRANCH | IN_MIDDLE_OF_COMMIT,
  cherry_pick_verify_resolution,
  cherry_pick_abort,
  cherry_pick_post_resolution
};

int cherry_pick(struct commit *item)
{
  save info on the commit, flags, etc needed to understand what we're doing

  try to apply diff...
  if (!rejected)
    return cherry_pick_post_resolution();
  try to use merge recursive...
  if (!conflict)
    return cherry_pick_post_resolution();
  return report_conflict(cherry_pick_conflict);
}

int cherry_pick_verify_resolution(void)
{
  if (still unmerged files) {
    describe work still needed
    return 1;
  }
  return 0;
}

int cherry_pick_abort(void)
{
  restore info on what we'd started and delete state

  clean up the working directory, index, etc

  return 0;
}

int cherry_pick_post_resolution(void)
{
  restore info on what we'd started and delete state

  make the commit

  return 0;
}

The important things are:

 - arbitrary code can determine that you're in the middle of resolving 
   some conflict, that the resolution of that conflict is about doing
   something to your current branch, and how to abort what you're doing,
   and how to finish it

 - the same code gets run after the conflict has been resolved that would 
   have been run immediately if the merge went smoothly

 - cherry-pick can save whatever it needs to in its state file; that's 
   its business, and the semantics here don't have to interact with other 
   commands, because report_conflict() has taken care of interaction with 
   other commands

The next step is to be able to have:

int sequencer()
{
  save the list of steps, with no in-progress step
  return sequencer_post_resolution();
}

int sequencer_post_resolution()
{
  finish any in-progress step
  get the next step
  if (no steps left)
    return 0;
  attempt step
  if (!got_conflict)
    return sequencer_post_resolution();
  return report_conflict(sequencer_conflict);
}

Where the sequencer-level conflict nests around the cherry-pick-level 
conflict, and the generic "continue" completes things from the inside out.

I think, ultimately, that with this code structure in place, the 
am/rebase/rebase--interactive/sequencer details of how the multi-step 
process is recorded becomes less important. That way, your project can be 
successful even if you can't find a syntax for the sequencer file that 
meets the needs of all of these use cases. (Which is where I suspect 
you'll get bogged down.) If you can get all of the cases where git exits 
in order to get human intervention to share "everything that matters" and 
the core to "know what's in progress as far as anything else cares", I 
think that would be success, even if the various multi-step programs 
continue using their own state files.

	-Daniel
*This .sig left intentionally blank*
