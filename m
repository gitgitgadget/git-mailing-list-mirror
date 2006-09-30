From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] fetch: Clean output
Date: Sat, 30 Sep 2006 03:37:44 -0700
Message-ID: <7vr6xtej2f.fsf@assigned-by-dhcp.cox.net>
References: <87r6xu1rci.fsf@gmail.com> <8764f61r74.fsf@gmail.com>
	<7vpsdehzcs.fsf@assigned-by-dhcp.cox.net>
	<8aa486160609300242i6f52ee90o235e668a5d865fb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 30 12:37:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTcEA-0006qW-8T
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 12:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWI3Khq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 06:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWI3Khq
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 06:37:46 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:61324 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750796AbWI3Khp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 06:37:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060930103745.TWOJ6711.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Sat, 30 Sep 2006 06:37:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Uadn1V0081kojtg0000000
	Sat, 30 Sep 2006 06:37:47 -0400
To: Santi <sbejar@gmail.com>
In-Reply-To: <8aa486160609300242i6f52ee90o235e668a5d865fb7@mail.gmail.com>
	(sbejar@gmail.com's message of "Sat, 30 Sep 2006 11:42:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28144>

Santi <sbejar@gmail.com> writes:

> So at the end, something like this output?
>
> $ git fetch -v   # the committish lines for the -v.
> * refs/heads/origin: fast forward to remote branch 'master' of ../git/
> old..new: 1ad7a06..bc1a580
> * refs/heads/pu: does not fast forward to remote branch 'pu' of ../git/
> old...new: 7c733a8...5faa935
> forcing update.
> * refs/heads/next: same as remote branch 'origin/next' of ../git/
> committish: ce47b9f
> ...
> * refs/tags/v1.4.2-rc4: storing tag 'v1.4.2-rc4' of ../git/
> committish: 8c7a107
>
> $ git fetch -v origin refs/heads/master
> * committish: 695dffe
> branch 'master' of ../git/

For the last one, the second and third line feel backwards.

Most cases in your summary (i.e. storing on a tracking branch or
tag) in general look like:

        * <local ref name>: <what happened and where it came from>
	<label>: <object names>

where <label> (e.g. old..new) describes what <object names>
mean.  So to be consistent, the <label> for "same as" case
(i.e. storing what is fetched in a local ref, but it was already
the same) and "storing anew" case, we might want to say their
true object types, not "committish".

Also we probably would want to "s/remote branch/branch" in the
"where from" part, since we always say "remote" in fetch anyway.

Then the last case where we do not use local tracking branch
would simply be something like:

	* fetched branch 'master' of ../git
        commit: 695dffe

How about this?  Essentially the same as the above but with
minor tweaks.

1. the ones we store in our local ref (either branches or tags):

 1a) fast-forward

  * refs/heads/origin: fast forward to branch 'master' of ../git/
    old..new: 1ad7a06..bc1a580

 1b) same (only shown under -v)

  * refs/heads/next: same as branch 'origin/next' of ../git/
    commit: ce47b9f

 1c) non-fast-forward, forced

  * refs/heads/pu: forcing update to branch 'pu' of ../git/
    old...new: 7c733a8...5faa935

 1d) non-fast-forward, did not update because not forced

  * refs/heads/po: does not fast-forward to branch 'po' of ../git/
    old...new: 7c733a8...5faa935

 1e) creating a new local ref to store

  * refs/tags/v1.4.2-rc4: storing tag 'v1.4.2-rc4' of ../git/
    tag: 8c7a107

2. the ones we do not store in our local ref (only shown under -v):

  * fetched branch 'master' of ../git
    commit: 695dffe

I think we should reword the "what happened" for 1d to clarify
that we did not touch refs/heads/po, but other than that I am
reasonably happy about how they look consistent.

But please don't take the above too seriously.  As everybody
should be very well aware by now, I am very bad at UI designs.
