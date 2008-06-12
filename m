From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv2/FYI] git-sequencer.txt
Date: Wed, 11 Jun 2008 22:16:37 -0700
Message-ID: <7vabhr9qru.fsf@gitster.siamese.dyndns.org>
References: <20080607220101.GM31040@leksak.fem-net>
 <20080612002258.GC7200@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 07:17:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6fC0-0000NE-B0
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 07:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbYFLFQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 01:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbYFLFQx
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 01:16:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53215 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbYFLFQv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 01:16:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EDF235724;
	Thu, 12 Jun 2008 01:16:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7980E5722; Thu, 12 Jun 2008 01:16:39 -0400 (EDT)
In-Reply-To: <20080612002258.GC7200@leksak.fem-net> (Stephan Beyer's message
 of "Thu, 12 Jun 2008 02:22:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C24839C0-383E-11DD-BE79-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84701>

Stephan Beyer <s-beyer@gmx.net> writes:

> Note that the sanity check fails, if you use this option
> and an instruction like `edit` or `pause`.
>
> --onto=<base>::
> 	Checkout given commit or branch before sequencing.
> 	If you provide a branch, sequencer will make the provided
> 	changes on the branch, i.e. the branch will be changed.

I think you called this --onto by modeling after rebase, but I am not sure
if that is a good generic naming.  Worse, "a branch that is not the
current one that is rebased" in rebase is not specified with "--onto" but
with the extra argument.

Is checking out that <base> branch considered as part of the sequencing
operation, or it is something that happens before the sequencing?  In
other words, if a sequencing stops and the user says "sequencer --abort",
where does it take the user back to?  The state the <base> is checked out,
or the state before that checkout happened?  Can't the front-end emit an
insn to checkout or detach as the first insn?

By the way, is it specified if sequencer will always work by:

 (1) remember the initial branch;

 (2) detach the HEAD;

 (3) run the operation;

 (4) and finally (unless the user says --abort) reattaching the original
     branch to the resulting HEAD?

That would mean the sequencer would essentially munge only one branch
(unless started from a detached HEAD state).  I think this is a reasonable
design decision (and a limitation) for the currently expected front-ends,
but I think this is a perfectly sane backend for filter-branch (without
any tree or content munging), and this limitation might later come back
and bite us.

> --skip::
> 	Restart the sequencing process by skipping the current patch.

"patch"?

What is the set of insn that can possibly give control back and give
you a chance to say "--skip"?

 - pick can conflict and --skip would mean "reset to the tree before the
   pick and continue on to the next insn";

 - Same goes for merge and patch (the semantics of "squash <commit>" is
   fuzzy to me);

 - pause can give control back to you.  What should --skip do?  I guess
   "no-op" is the right answer.

> --status::
> 	Show the current status of git-sequencer and what
> 	operations can be done to change that status.

Meaning "what insns have we done, what insn were we in the middle of
executing, and what insns are still remaining"?

> merge [<options>] <commit-ish1> <commit-ish2> ... <commit-ishN>::
> 	Merge commits into HEAD.
> +
> A commit can also be given by a mark, if prefixed with a colon.
> +
> If you do not provide a commit message (using `-F`, `-m`, `--reference` 
> or `--standard`), an editor will be invoked.
> +
> See the following list and 'GENERAL OPTIONS' for values of `<option>`:
>
> 	--standard;;
> 		Generates a commit message like 'Merge ... into HEAD'.
> 		See also linkgit:git-fmt-merge-msg[1].

It seems you are assuming (and I am not saying it is a bad assumption)
that sequencer first detached the HEAD and operates on that state until it
is done.  Perhaps we would want to reword "into HEAD" somehow?  If we are
rebasing branch "main", even if sequencer internally detaches the HEAD to
carry out individual steps, we would want to see the resulting history to
say "into main", wouldn't we?

> patch [<options>] <file>::
> 	If file `<file>` is a pure (diff) patch, then apply the patch.
> 	If no `--message` option is given, an editor will
> 	be invoked to enter a commit message.

Hmm.  Are there cases where you might want to feed more than one patches
and then finally make the commit?  You could emulate it with

	mark :1
	patch --message=dummy file1
        patch --message=dummy file2
	squash --upto :1

but it might make sense to allow more than one files for this use case,
like

	patch file1 file2

Although that would introduce another issue, which is what to do if file1
is a naked diff and file2 is a mbox (with possibly more than one patches),
or vice versa.

>...
> 	-u;;
> 		Pass `-u` flag to `git-mailinfo` (see linkgit:git-mailinfo[1]).
>...
> This was optional in prior versions of git, but now it is the
> default. You could use `-n` to override this.

I personally do not think it is worth supporting this b/c compatibility
option in a new command "sequencer".

> pause::
> 	Pauses the sequencer process to let you manually make changes.
> 	For example, you can re-edit the done commit, fix bugs or typos,
> 	or you can make further commits on top of HEAD before continuing.
> +
> After you have finished your changes and added them to the index,
> invoke `git-sequencer --continue`.
> If you only want to edit the last commit message with an editor,
> run `git commit --amend` (see linkgit:git-commit[1]) before.

before "saying --continue"?

> reset <commit-ish>::
> 	Go back (see linkgit:git-reset[1] `--hard`) to commit `<commit-ish>`.
> 	`<commit-ish>` can also be given by a mark, if prefixed with a colon.
>
> squash [<options>] <commit>::
> 	Add the changes introduced by `<commit>` to the last commit.

Just like you explained "edit <commit>" in terms of "pick" and "pause", we
might want to explain that this is "pick" and "squash --up-to HEAD^" (or
is it HEAD^^"?).

> +
> See 'GENERAL OPTIONS' for values of `<option>`.
>
> squash [<options>] --up-to <mark>::
> 	Squash all commits up to the given mark into one commit.
> 	There must not be any merge commits in between.

"In between" in "inclusive" sense, that is, neither <mark> nor HEAD cannot
be a merge?  Also --up-to feels somewhat wrong.  It is more like down-to
but perhaps "from" would be a better wording.

> 	--include-merges;;
> 		Sanity check does not fail if you have merges
> 		between HEAD and <mark>.

And what gets recorded?  A squashed merge?

A "squash --up-to <mark>" (modulo off-by-one I can never get straight X-<)
essentially:

	log --reverse <mark>.. >msg
	reset --soft <mark>
        commit --amend -F msg

so recording this result, when there is a merge in between, is like
running "merge --squash".

> tag <tag>::
> 	Set tag `<tag>` to the current HEAD,
> 	see also linkgit:git-tag[1].
> 	If another commit is tagged `<tag>`, it will lose this tag,
> 	i.e. the tag will be reset to HEAD.

Hmm.  It is hard to judge this without seeing how the front-ends use it.
It might make sense to give lower-level access to update-ref instead, so
that more than one branches can be updated as well, but I am not sure.
How would this interact with "--abort"?
