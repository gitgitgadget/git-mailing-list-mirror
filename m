From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 02 Oct 2007 00:21:31 -0700
Message-ID: <7vlkamm16s.fsf@gitster.siamese.dyndns.org>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
	<7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
	<7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
	<7v3awunjup.fsf@gitster.siamese.dyndns.org>
	<49137EAF-BB73-40DC-973C-E60C14B3FA7F@zib.de>
	<vpq641qroae.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 09:21:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icc4j-0001Lx-68
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 09:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbXJBHVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 03:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbXJBHVl
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 03:21:41 -0400
Received: from rune.pobox.com ([208.210.124.79]:40145 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbXJBHVk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 03:21:40 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 879D8140089;
	Tue,  2 Oct 2007 03:22:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 9D1B9140099;
	Tue,  2 Oct 2007 03:21:55 -0400 (EDT)
In-Reply-To: <vpq641qroae.fsf@bauges.imag.fr> (Matthieu Moy's message of "Tue,
	02 Oct 2007 09:03:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59669>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> I'm also concerned about the possibility of stash/unstash to fail:
> that means the user has to deal with two kinds of conflicts (rebase
> can conflict, unstash can also), which can be confusing.

Unstash should be invoked automatically _only_ after rebase
completes, so I do not forsee such confusion.

But the trouble I have with the auto unstashing is more at the
conceptual and workflow level.  You start rebasing a branch, and
your work tree is dirty.  What branch should the local
modification belong to?

Logically, it is with the branch you were on when you typed "git
rebase" command.

But when "rebase" successfully concludes (either with or without
manual fix-ups), you can be either on your original branch (if
you said "git rebase base") or something totally unrelated (if
you said "git rebase base other").  Currently we auto-unstash in
both cases.  I _think_ the former case should auto-unstash, but
the latter shouldn't.

However, this auto-stash uses the new "git stash create" command
that does not update the reflog for "refs/stash", specifically
so that the auto-stashing does _not_ interfere with the normal
stash the end user uses.  Which means that it is a bit
cumbersome to give the autostashed state back to the user if we
do _not_ unstash upon completion of rebase.

Perhaps a good compromise would be to

 * not to do the autostash, but fail as we have always done,
   when "git rebase base other" form was used, first instructing
   rebase to switch to another branch;

 * autostash when "git rebase base" form was used, and auto
   unstash upon completion.

> But the current behavior can be greatly improved by just making the
> error message better. Currently, I have this:
>
> $ git rebase branch
> foo.txt: needs update
> $ _
>
> I'd prefer something like
>
> $ git rebase branch
> cannot rebase: the working tree is not clean.
> foo.txt: Changed but not updated
> Commit your changes, or put them appart with "git stash" and retry.
> $ _

You forgot 'needs merge' case, so that would not fly very well,
but something like this might be a good starting point.

---
 git-rebase.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 058fcac..4f8aeb9 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -252,7 +252,10 @@ else
 fi
 
 # The tree must be really really clean.
-git update-index --refresh || exit
+o=$(git update-index -q --refresh) || {
+	printf "cannot rebase: the work tree is not clean.\n%s\n" "$o"
+	exit 1
+}
 diff=$(git diff-index --cached --name-status -r HEAD)
 case "$diff" in
 ?*)	echo "cannot rebase: your index is not up-to-date"
