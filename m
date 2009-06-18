From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: rebase -i: auto-squash commits
Date: Wed, 17 Jun 2009 22:07:23 -0700
Message-ID: <7v8wjq2kqc.fsf@alter.siamese.dyndns.org>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	<43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	<7vvdmurfao.fsf@alter.siamese.dyndns.org>
	<20090618063348.6117@nanako3.lavabit.com>
	<alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
	<20090618001111.GB12954@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Jun 18 07:28:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHAAu-0003bu-Ec
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 07:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbZFRF21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 01:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbZFRF20
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 01:28:26 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:41718 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbZFRF2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 01:28:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090618050724.QKDJ2915.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 18 Jun 2009 01:07:24 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5H7P1c00C4aMwMQ03H7PCm; Thu, 18 Jun 2009 01:07:23 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=BJRVbhqwWo4A:10 a=_uP_Iqg30GIjq1NubOwA:9
 a=BqyHAmeXtXRxnyB8-OwA:7 a=IWsvc-7lpfT48Vf7KI9b7HjDtn4A:4
X-CM-Score: 0.00
In-Reply-To: <20090618001111.GB12954@vidovic> (Nicolas Sebrecht's message of "Thu\, 18 Jun 2009 02\:11\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121793>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> The 18/06/09, Johannes Schindelin wrote:
>
>> > When the commit log message begins with "squash to ...", and there
>> 
>> I do not like this at all.  It assumes that you never have valid commit 
>> messages starting with "squash to".
>
> Plus, a commit message should not be anything else that a message about
> a commit. Please, don't make the Git's behavior depends on the commit
> message itself.
>
> If we need a program to have various behaviours, we have:
> - the compilation options;
> - the command line options;
> - the configuration files.

Sorry, but I have to disagree to such a dogmatic statement.

We do want our commands to be able to act intelligently and/or differently
depending on what commit says in some cases.  It is does not make sense to
insist that the command line or configuration mechanism must be used.

A really trivial example.  "git log -p" shows the patch text for non-merge
commits but not for merge commits.  "git log --grep=foo" shows only
commits that says "foo" and "git log --author=Nicolas" shows only commits
written by you.  We used to leave an explicit note in the message part of
cherry-picked commits where they were cherry-picked from; "git merge"
and/or "git rebase" could have paid attention to it to act differently
(i.e. "ah, even though that commit is not in the ancestry, the moral
equivalent patch is already applied").

Besides, if you as the end user want to tell this and that commit are
special among other commits that are being rebased to the command, which
is the scenario Nana's patch is about, how would you do that from the
command line option?  "rebase -i --move=4-to-2 --squash=2"?

I do not necessarily think the behaviour suggested by the patch should be
the default, but as an optional feature, it makes perfect sense for a
command to pay attention to commit messages when deciding what to do.

IOW, I understand Dscho's objection that there is a risk that this feature
may trigger when not wanted (but more on this later), and I'd be fine if
it can fire only with an extra option, e.g. "git rebase -i --autosquash".

But from the workflow point of view, I think what the patch tries to do (I
haven't studied the actual implementation carefully, so it may not be what
it actually _does_) makes perfect sense, and it matches what I often do
very well.  Accumulate changes as a series of basically sound commits,
queue some small "fix this breakage in that commit" commits on top of them
while proofreading, and finish the series with "rebase -i" to reorder,
squash and typofix.

Now, I initially had the same reaction as Dscho.  What happens if I really
want to write a commit message that begins with "squash to "?

But after thinking about it a bit more, I do not think it is as bad as it
sounds anymore.

The commit not only must begin with "squash to " but also there has to be
a matching commit whose message begins with the remainder of the title of
the "squash to" commit _in the range you are rebasing INTERACTIVELY_.

In addition, the resulting rebase insn is presented in the editor, and in
a rare case where you do have such a commit, you can rearrange it back.
