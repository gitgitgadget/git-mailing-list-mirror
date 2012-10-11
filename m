From: dirson@bertin.fr
Subject: Re: [BUG] "git commit" after "cherry-pick -n" conflict clobbers
 .git/COMMIT_EDITMSG
Date: Thu, 11 Oct 2012 22:50:35 +0200
Message-ID: <20121011205035.GB9783@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 22:51:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMPjA-0006pJ-UF
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 22:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255Ab2JKUvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 16:51:22 -0400
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:46597 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030216Ab2JKUvS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 16:51:18 -0400
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id A39F0D1B029
	for <git@vger.kernel.org>; Thu, 11 Oct 2012 22:51:14 +0200 (CEST)
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 95784D480AD;
	Thu, 11 Oct 2012 22:50:36 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.80)
	(envelope-from <dirson@bertin.fr>)
	id 1TMPiF-0000vr-BL; Thu, 11 Oct 2012 22:50:35 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207512>

> > ~/softs/linux$ echo foo > .git/COMMIT_EDITMSG
>
> Why are you mucking with such an internal implementation detail in
> the first place?

I only tried to make it terse for the bugreport, I hit this while I
was resolving conflicts during a merge.  I aknowledge that using
"cherry-pick -n" to bring some contents to resolve a conflict is not
really nominal - my use case involves re-merging an updated "upstream"
branch, and bringing in fixups to the original merge.

> > ~/softs/linux$ git cherry-pick -n b55f3d92cd
> > error: could not apply b55f3d9... Linux 2.6.32.26
> > hint: after resolving the conflicts, mark the corrected paths
> > hint: with 'git add ' or 'git rm '
> > ~/softs/linux$ cat .git/COMMIT_EDITMSG
> > foo
> >
> > So far, so good. But then "git commit" brings me the message
> from the
> > cherry-picked commit plus the list of conflicted files, and I
> can verify that
> > it is now the contents of .git/COMMIT_EDITMSG.
>
> You verified that "what" is now in .git/COMMIT_EDITMSG? The commit
> log message for you to edit to record the result of the cherry-pick?

Precisely

> If that is the case, what is the problem?

I used "-n" precisely because I did not want to make a standalone
commit, and the message from the cherry-picked source has no value to
me.  If it had, I would instead have used cherry-pick without -n, and
amended the commit afterwards.

In the general case, I only ever use -n when I'm squashing changes
and similar tasks.  Are there use cases out there, where it makes
sense to keep that source message, when we don't want the commit to be
created right away ?


> If anything you had in .git/COMMIT_EDITMSG before you started
> "'cherry-pick -n', edit further to adjust, and then 'commit'"
> sequence were to appear in the editor to edit the commit log,
> it would be a bug, I would think.

Well, seems to depend on use case - I find it a bug when the merge message,
notably containing the list of conflicting files, gets clobbered.

Also, I have not checked how git gui reacts, but I would assume that
when carefully and iteratively composing a commit message from there,
which is IIRC managed using .git/COMMIT_EDITMSG, it would not be
desired to get this content clobbered the same way.

To me it looks like the problem is that the commit message in
preparation is not considered precious information, when there are at
least some cases where it indeed should be.  I'm not sure however how
that should be done:

* suddenly claiming it is precious (and require some form of -f to
  clobber it) when it was mostly not is likely to break a number of
  use cases
* looking at the context (are we resolving a merge or similar ?) to
  consider it precious is likely to miss some cases
* declaring a new official location (or API/command ?) to store
  considered-precious message being composed may bring its own lot of
  semantic difficulties
