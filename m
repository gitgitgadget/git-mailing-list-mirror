From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to change merge message ("weenie commits")
Date: Thu, 25 Jan 2007 14:54:15 -0800
Message-ID: <7v1wli90q0.fsf@assigned-by-dhcp.cox.net>
References: <17848.54065.631799.755255@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Jan 25 23:54:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HADU4-0006wh-57
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 23:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965567AbXAYWyR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 17:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965576AbXAYWyR
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 17:54:17 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:52795 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965567AbXAYWyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 17:54:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070125225416.MCXE20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Thu, 25 Jan 2007 17:54:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FatJ1W00Q1kojtg0000000; Thu, 25 Jan 2007 17:53:19 -0500
In-Reply-To: <17848.54065.631799.755255@lisa.zopyra.com> (Bill Lear's message
	of "Thu, 25 Jan 2007 09:56:33 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37773>

Bill Lear <rael@zopyra.com> writes:

> I have developed a habit of using my SCM to provide local backup of my
> daily (hourly) work.  I often will work to a stopping point and commit
> my work, without any real coherence to the commit --- a sort of
> checkpoint.  These I call "weenie commits" because they are weenie-ish,
> unimportant in the larger scheme of things.
>
> When developing with others, I would like to be able to work in this
> way, tidily keeping my stuff tucked away in my SCM system, and then
> when I am ready to share, to convey to my peers what they need to
> know about my work, and not the 10,000 weenie commit messages that
> may be associated with my work.
>
> So, when I merge my topic branch onto master, for example, I'd like
> the commit message to be something more thoughtful than the
> "checkpoint 1", "checkpoint 2", "fix typo", "redo sort algorithm",
> etc., etc., and be more like a short set of release notes, a summary
> of what all has been accomplished.

Your message is titled as if it is about changing "merge
message", but to clean-up history you would want to fix the
commit boundary as well if your commits are "without any real
coherence".

Which means that you need to first rebuild the topic branch to
make it presentable before merging.

If all the work done in the weenie commits chain is really a
single logical change in the bigger picture, then the answer is
very simple: "git merge --squash".  It's not a merge, but is to
prepare your working tree to create a single commit for public
consumption, and after committing you can (and probably should,
in order to avoid confusing yourself) discard the branch with
weenie commits.

Otherwise, what I often do myself is to export them as format-patch
output, sift and reorder bits to make them coherent chunks and
rebuild the series.  It would go something like this:

	$ git checkout topic
	$ git format-patch master
	0001-snapshot-1.patch
	0002-snapshot-2.patch
	0003-snapshot-3.patch
	$ edit 00??-*.patch
	..	I come up with a fixed series which most likely
        ..	have different number of patch files.
        $ git checkout -b rebuilt topic~3 ;# go back to where I forked
        $ git am 0*-.patch.fixed
	$ git diff topic
        ..	This should match where I started, except I
	..	might have made small fix-ups while coming up
	..	with the *-patch.fixed series which should show up.
	$ test test test

        $ git branch -f topic
	$ git branch -d rebuilt
	..	Now the topic is cleaned-up so it is ready to be merged.
	..	we do not need the 'rebuilt' branch anymore.

        $ git checkout master
        $ git merge topic

I would also do "git rebase master" while on the "rebuilt"
branch, because it is not a significant fact that I started my
work on 'topic' at a particular commit in the past.
