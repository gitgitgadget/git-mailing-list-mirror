From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFCv2/FYI] git-sequencer.txt
Date: Thu, 12 Jun 2008 19:07:15 +0200
Message-ID: <20080612170715.GC6848@leksak.fem-net>
References: <20080607220101.GM31040@leksak.fem-net> <20080612002258.GC7200@leksak.fem-net> <7vabhr9qru.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 19:08:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6qHZ-0001HS-Dr
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 19:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbYFLRHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 13:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbYFLRHW
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 13:07:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:42271 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753420AbYFLRHU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 13:07:20 -0400
Received: (qmail invoked by alias); 12 Jun 2008 17:07:18 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp034) with SMTP; 12 Jun 2008 19:07:18 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+qSE1I3Z6qYEMrM9Lz80sHXcScqpK9wXiemjTYAp
	j37E1MoJ987+w3
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K6qGZ-0000A1-OO; Thu, 12 Jun 2008 19:07:15 +0200
Content-Disposition: inline
In-Reply-To: <7vabhr9qru.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84766>

Hi,

Junio C Hamano wrote:
> > Note that the sanity check fails, if you use this option
> > and an instruction like `edit` or `pause`.
> >
> > --onto=<base>::
> > 	Checkout given commit or branch before sequencing.
> > 	If you provide a branch, sequencer will make the provided
> > 	changes on the branch, i.e. the branch will be changed.
> 
> I think you called this --onto by modeling after rebase, but I am not sure
> if that is a good generic naming.

First it was called --branch=<branch>, but I considered this to be wrong, 
because it's also possible to work on a detached tree.

Then I thought, that the rebase name is somehow right.

> Worse, "a branch that is not the current one that is rebased" in rebase is
> not specified with "--onto" but with the extra argument.
> 
> Is checking out that <base> branch considered as part of the sequencing
> operation, or it is something that happens before the sequencing?  In
> other words, if a sequencing stops and the user says "sequencer --abort",
> where does it take the user back to?  The state the <base> is checked out,
> or the state before that checkout happened?  Can't the front-end emit an
> insn to checkout or detach as the first insn?

Using git-sequencer --onto you specify the commit (or branch) where
the TODO insns are executed on.
(If you provide a branch, the branch ref points to the result of the 
sequencing process. If not, the sequencer process finishes on a detached
HEAD, just as it started.)

If you are on master and do
	git sequencer --onto foo todo-file
and later do a
	git sequencer --abort
then you are back on master "as if nothing happened".

If the process finishes successfully, you are on "foo".

I think this is quite handy and intuitive.

Btw, I didn't include the --onto stuff into the test suite of
my prototype branch yet, so the only thing that currently tests
this is git-rebase --interactive, that does a
	git-sequencer --onto "$ONTO" "$TODO"
and this works well.

I didn't include it yet, because the questions you addressed were
somehow still open to me.


If you don't provide --onto, it works on the current HEAD,
may it be a branch or detached HEAD.

> By the way, is it specified if sequencer will always work by:

Currently nothing of that is *specified*, but I can tell what the
prototype currently does.

> 
>  (1) remember the initial branch;

It saves the initial branch and commit, yes.

>  (2) detach the HEAD;

It currently does not detach the HEAD if a branch is given in --onto.
Imho this is a bug -- thanks -- but the fix is easy ;-)

>  (3) run the operation;
> 
>  (4) and finally (unless the user says --abort) reattaching the original
>      branch to the resulting HEAD?

Yes. (Currently the reattaching is done "automagically" because of the
bug it doesn't detach the head.)

> That would mean the sequencer would essentially munge only one branch
> (unless started from a detached HEAD state).  I think this is a reasonable
> design decision (and a limitation) for the currently expected front-ends,
> but I think this is a perfectly sane backend for filter-branch (without
> any tree or content munging), and this limitation might later come back
> and bite us.

Sorry, I currently don't understand you. ;-)
I've never used filter-branch so I'm a bit out of background here.

I currently wonder if it's better to remove --onto and let the 
sequencer users do that.
So that, for example, the rebase-i has to checkout the detached $ONTO
and then just call git-sequencer "$TODO".
(If we do it this way... Daniel, you were right *grin*)

What do you think?

> > --skip::
> > 	Restart the sequencing process by skipping the current patch.
> 
> "patch"?

"instruction". Thanks.

> What is the set of insn that can possibly give control back and give
> you a chance to say "--skip"?
> 
>  - pick can conflict and --skip would mean "reset to the tree before the
>    pick and continue on to the next insn";

Right.

>  - Same goes for merge and patch (the semantics of "squash <commit>" is
>    fuzzy to me);

Right.

I've already considered squash, I c&p a comment from the prototype:
 # Hm, somehow I don't think --skip on a conflicting squash
 # may be useful, but if someone wants to do it, it should 
 # do the obvious: skip what squash would do.

This means, if you do
	squash --up-to :1
it will just not squash all the commits from :1 to HEAD.
If you do
	squash <commit>
it will not pick <commit> and squash it with the last.

>  - pause can give control back to you.  What should --skip do?  I guess
>    "no-op" is the right answer.

Right. In other words: --skip equals --continue.
I've already considered this and when in "pause", git --status does not
tell the user that he can do --skip, although he can.

> > --status::
> > 	Show the current status of git-sequencer and what
> > 	operations can be done to change that status.
> 
> Meaning "what insns have we done, what insn were we in the middle of
> executing, and what insns are still remaining"?

If sequencer is paused somewhere:
 - what insns have we done
 - are we in a conflict or pause?
 - what insns are still remaining
 - what options does sequencer run with?
   (The only option that can be reported is currently
    --verbose)
 - what can the user run to abort/continue/skip?

And "Sequencer not running" if sequencer is not started
or has finished or whatever.

> > merge [<options>] <commit-ish1> <commit-ish2> ... <commit-ishN>::
> > 	Merge commits into HEAD.
> > +
> > A commit can also be given by a mark, if prefixed with a colon.
> > +
> > If you do not provide a commit message (using `-F`, `-m`, `--reference` 
> > or `--standard`), an editor will be invoked.
> > +
> > See the following list and 'GENERAL OPTIONS' for values of `<option>`:
> >
> > 	--standard;;
> > 		Generates a commit message like 'Merge ... into HEAD'.
> > 		See also linkgit:git-fmt-merge-msg[1].
> 
> It seems you are assuming (and I am not saying it is a bad assumption)
> that sequencer first detached the HEAD and operates on that state until it
> is done.  Perhaps we would want to reword "into HEAD" somehow?

I'd also prefer something different, but currently this is what
git-fmt-merge-msg provides in the way I use it.

> If we are rebasing branch "main", even if sequencer internally detaches the HEAD to
> carry out individual steps, we would want to see the resulting history to
> say "into main", wouldn't we?

Yes, that's right. (Well, I wouldn't even care if the "into ..." is
omitted at all because in a graph log you usually can see what is merged
into what.)

I currently keep this.
But I'm open for code suggestions to solve this when I have posted the
prototype.

> > patch [<options>] <file>::
> > 	If file `<file>` is a pure (diff) patch, then apply the patch.
> > 	If no `--message` option is given, an editor will
> > 	be invoked to enter a commit message.
> 
> Hmm.  Are there cases where you might want to feed more than one patches
> and then finally make the commit?  You could emulate it with
> 
> 	mark :1
> 	patch --message=dummy file1
>         patch --message=dummy file2
> 	squash --upto :1
> 
> but it might make sense to allow more than one files for this use case,
> like
> 
> 	patch file1 file2
> 
> Although that would introduce another issue, which is what to do if file1
> is a naked diff and file2 is a mbox (with possibly more than one patches),
> or vice versa.

Or what to do if file1 introduces a conflict.

We've (my mentors and me) started such a discussion several times and
always said "Ok, let's keep this for later.". Now that we have the
squash --up-to solution, I think we should stick with it. 
And when we have the code base, we can add features. 

> >...
> > 	-u;;
> > 		Pass `-u` flag to `git-mailinfo` (see linkgit:git-mailinfo[1]).
> >...
> > This was optional in prior versions of git, but now it is the
> > default. You could use `-n` to override this.
> 
> I personally do not think it is worth supporting this b/c compatibility
> option in a new command "sequencer".

Thanks!

The same for --binary?  Oh, I haven't even included it... :)

> > pause::
> > 	Pauses the sequencer process to let you manually make changes.
> > 	For example, you can re-edit the done commit, fix bugs or typos,
> > 	or you can make further commits on top of HEAD before continuing.
> > +
> > After you have finished your changes and added them to the index,
> > invoke `git-sequencer --continue`.
> > If you only want to edit the last commit message with an editor,
> > run `git commit --amend` (see linkgit:git-commit[1]) before.
> 
> before "saying --continue"?

Is it really not clear? (What else?)
Ok, I add it.

Perhaps it's also better to announce the `-e/--edit` option here (see 
Paolo's reply) for users who just want to change the commit message.

> > reset <commit-ish>::
> > 	Go back (see linkgit:git-reset[1] `--hard`) to commit `<commit-ish>`.
> > 	`<commit-ish>` can also be given by a mark, if prefixed with a colon.
> >
> > squash [<options>] <commit>::
> > 	Add the changes introduced by `<commit>` to the last commit.
> 
> Just like you explained "edit <commit>" in terms of "pick" and "pause", we
> might want to explain that this is "pick" and "squash --up-to HEAD^" (or
> is it HEAD^^"?).

It is HEAD^^, but squash --up-to does only accept marks, so:

	This is a short form for `mark :10`, `pick <commit> and
	`squash --up-to :10` on separate lines.

would be more accurate, but isn't really true, since no mark is
generated, the --skip behavior is a different, etc.
I think I don't like to include such a note.

> > squash [<options>] --up-to <mark>::
> > 	Squash all commits up to the given mark into one commit.
> > 	There must not be any merge commits in between.
> 
> "In between" in "inclusive" sense, that is, neither <mark> nor HEAD cannot
> be a merge?

Assuming that <mark> is a mark for HEAD~N, then
HEAD~0, HEAD~1, HEAD~2, ..., HEAD~(N+1) must not be a merge commit.

Example:
	merge ...
	mark :3
	pick ...
	patch ...
	squash --up-to :3
works.
This will result in a merge and a squashed pick/patch commit.

See a perhaps better description below.

> Also --up-to feels somewhat wrong.  It is more like down-to
> but perhaps "from" would be a better wording.

Should we also use --from instead of --up-to then?
I have no "feeling" about that, because "to squash" is a new word in my
English vocabulary since I've first used git-rebase -i ;)

squash [<options>] --from <mark>::
	Squash all commits from the given mark into one commit.
	There must not be any `merge` instructions between the
	`mark` instruction and this `squash --from` instruction.

Does this make more sense to you?

> > 	--include-merges;;
> > 		Sanity check does not fail if you have merges
> > 		between HEAD and <mark>.
> 
> And what gets recorded?  A squashed merge?

Well, I have a test case for that but haven't yet looked what the result
is. (It just checks, that it works.) ;-)
For me, such an operation does not make sense (since I currently don't
know every detail of git), but if there is somebody who wants that,
he or she should get it.

> A "squash --up-to <mark>" (modulo off-by-one I can never get straight X-<)
> essentially:
> 
> 	log --reverse <mark>.. >msg
> 	reset --soft <mark>
>         commit --amend -F msg
> 
> so recording this result, when there is a merge in between, is like
> running "merge --squash".

Aha.

> > tag <tag>::
> > 	Set tag `<tag>` to the current HEAD,
> > 	see also linkgit:git-tag[1].
> > 	If another commit is tagged `<tag>`, it will lose this tag,
> > 	i.e. the tag will be reset to HEAD.
> 
> Hmm.  It is hard to judge this without seeing how the front-ends use it.

Right :)

> It might make sense to give lower-level access to update-ref instead, so
> that more than one branches can be updated as well, but I am not sure.

Like
 ref refs/heads/new_branch
or
 ref refs/tags/foo

That sounds like a good idea. (And is written to the todo list.)
How should the insn be called? "ref"?

> How would this interact with "--abort"?

Nice question.
Currently all tags are kept on --abort.
Sequencer could keep a list of generated tags (refs) and remove it 
on --abort (or tell the user to remove them if she likes.)

But... I think I currently just keep it.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
