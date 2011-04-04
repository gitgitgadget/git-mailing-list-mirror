From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC 2011] Git Sequencer
Date: Mon, 4 Apr 2011 06:43:35 +0200
Message-ID: <201104040643.35583.chriscool@tuxfamily.org>
References: <20110403172054.GA10220@kytes>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Stephen Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 06:44:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6bdy-0006aj-Bf
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 06:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872Ab1DDEnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 00:43:45 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:38390 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab1DDEnp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 00:43:45 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 200CEA6306;
	Mon,  4 Apr 2011 06:43:36 +0200 (CEST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-22-generic; KDE/4.5.1; x86_64; ; )
In-Reply-To: <20110403172054.GA10220@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170786>

On Sunday 03 April 2011 19:20:56 Ramkumar Ramachandra wrote:
> Hi,
> 
> I'd like to re-apply this year as a student because I really want to
> see (among other things), a sequencer in git.git.  Also, since I
> worked on areas related to fast-import and remote helpers last year, I
> thought I should work on something completely orthogonal this year.
> 
> I now have a draft of my proposal ready, and I'd really appreciate
> feedback.  Also, could someone mentor me?

Yeah! I would be happy to mentor you (or co-mentor you if someone else want to 
be involved)!

> ======================================================================
> Project Proposal: Git Sequencer
> Student: Ramkumar Ramachandra
> Mentor: ?
> 
> == The Objective ==
> 
> To write git-sequencer, a new builtin command, and implement existing
> commands on top of that.  This should give the commands more
> functionality, improve their error handling, and make them faster.

You should first talk about extending git cherry-pick with --continue, --abort 
and --skip, because it can be very valuable already if done properly with many 
tests and if it's merged of course.

> The project can only be considered successful if all (or most) of the
> code written gets merged into upstream.

Yeah, just say "most of the code". It is definitely good enough.

> The Git Sequencer was a 2008 GSoC project as well; unfortunately most
> of the code did not get merged into git.git.  The learning from all
> that work should serve as a huge headstart this year.
> 
> === The Plan ===
> 
> 1. Extend 'cherry-pick' with '--continue', '--abort', and '--skip'
> features, so that it works like (a subset of) the current
> 'git-rebase--interactive.sh'.  This will require patching
> 'builtin/revert.c' in place, and merging it immediately.  I plan to
> roughly follow the road laid out by Christian's 2010 series [1].

Yeah, the first step should be 'cherry-pick' with '--continue', '--abort', and 
'--skip' merged.

> 1.1. Factor out all calls to 'die' with 'return error' so so that we
> can pause the entire process when a commit doesn't apply
> automatically.
> 
> 1.2. Create and populate TODO and DONE files, similar to the one that
> 'git-rebase--interactive.sh' creates.  For now, it should simply give
> us information about why a 'cherry-pick' failed.  Use these files with
> 'git-rebase--interactive.sh' to resume.

I am not sure it's a good thing to use 'git-rebase--interactive.sh' to resume 
the cherry-pick. The parsing code already exists, is not very big, is in C and 
has been reviewed and tested, so I think it's better to use.

> 1.3. Port selective tests from the current 't3404' to make sure that
> TODO and DONE are populated correctly; "stop on conflicting pick" is a
> good candidate.
> 
> 1.4. Decouple the 'revert' functionality from the 'cherry-pick'
> functionality in 'revert.c'.  Implement '--abort' for 'cherry-pick'
> and port "abort" test from 't3404'.

I am not sure decoupling revert and cherry-pick functionnalities is really 
needed, or I don't know what you mean exactly.

> 1.5. Implement parsing the TODO and DONE files into suitable data
> structures.  Derive inspiration from the code written in 2008 to do
> this.

Yeah, you can use this patch:

http://article.gmane.org/gmane.comp.version-control.git/162198

> 1.6. Implement '--continue' and '--skip', and write suitable tests.
> Merge into upstream.

Great!

> 2. Factor out the 'cherry-pick' code from 'revert.c' into a new
> 'builtin/sequencer.c', and expose a simple cherry-picking API in
> 'sequencer.h'.

Yeah!

> 3. Implement a fresh 'cherry-pick.c' as a simple API call to the
> sequencer, and make sure that all the existing tests pass.  After
> this, cherry-pick will not be a builtin command anymore*.  Merge into
> upstream.

Yeah, it is closely linked with the previous point. So maybe this can be 2.2 
and the previous one can be 2.1. And this way we know that at the end of 1) 
and at the end of 2) everything should be merged upstream.

> 4. Extend the sequncer to parse commands like 'execute', 'reword',
> 'squash', and 'fixup' that are specific to interactive rebasing.
> Carefully implement the functionality for each of these keywords in a
> step-wise manner, making sure that it inter-operates with 'rebase -i'
> seamlessly.

Great!

> 5. Port the entire testsuite from 'rebase -i', and rewrite
> 'git-rebase.sh', 'git-rebase--interactive.sh' to call the sequncer.
> The script should essentially build to a list of TODO instructions and
> pass it to the 'git-sequencer' binary.  Merge into upstream.

Great! But as it is closely llinked with the previous point, maybe these 2 
points should be 3.1 and 3.2.

> 6. [Optional] Lib'ify the sequncer: modify the sequencer API to
> include rebase-related functionality.  Write 'rebase.c' as a bunch of
> API calls to the sequencer.  Make sure that the existing tests pass.
> Merge into upstream.
> 
> 7. [Optional] Re-implement 'git-am.sh' as a thin wrapper over the
> sequncer: 'am.c'.  Bulk of this should be mbox parsing code.  Make sure
> that all existing tests pass.  Merge into upstream.
> 
> * Is this a good change? 

I think it is a good proposal.

> Are there any forseeable issues?

I don't see anything that others didn't told you about.

> ** [Optional] should be read as "If time permits"
> 
> == Timeline ===
> 
> Deriving from last year's experience, I've decided not to present a
> tight timeline.  Instead, I simply have an outline: Get the extended
> cherry-pick functionality merged before mid-term evaluations, and the
> rest before the final evaluations.

I agree, but still you could perhaps state something like this:

- before mid june:
	some patch series for everything in 1) should have been sent to the list
- before midterm evaluation:
	everything in 1) should be merged upstream
	some patch series for everything in 2) and 3) (or 2.1 and 2.2 if you use 
the numbering I suggest) should have been sent to the list
- before the end of July:
	everything in 2) and 3) should be merged upstream
	some patch series for everything in 4) and 5) (or 3.1 and 3.2 if you use 
the numbering I suggest) should have been sent to the list
- before final evaluation:
	everything should be merged

I think it is better to have more details like the above because this way we 
can realize early that there is not a lot of time after the midterm 
evaluation.

> == Who am I? ==
> 
> I'm Ramkumar Ramachandra, and I first started contributing to git.git
> in January 2010.  Apart from doing fast-import and remote helper
> related work last year, I also authored and merged svnrdump into
> Subversion trunk in the same period.
> 
> == Notes ==
> 
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/162183
> ======================================================================
> 
> Thanks for reading.

Thanks for applying,
Christian.
