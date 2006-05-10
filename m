From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Tue, 09 May 2006 22:05:10 -0700
Message-ID: <7v64kezczd.fsf@assigned-by-dhcp.cox.net>
References: <7viroezi8s.fsf@assigned-by-dhcp.cox.net>
	<864pzyh4x0.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 07:05:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fdgsx-0004C8-LP
	for gcvg-git@gmane.org; Wed, 10 May 2006 07:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWEJFFP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 01:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWEJFFO
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 01:05:14 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:18624 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964807AbWEJFFM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 May 2006 01:05:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060510050511.KGSR24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 10 May 2006 01:05:11 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <864pzyh4x0.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "09 May 2006 21:36:43 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19877>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
>
> Junio> This week's "What's in" is a day early, since I do not expect to
> Junio> be able to do much gitting for the rest of the week.
>
> I just got this with the latest, on the git archive, using git-repack -a:
>
> Generating pack...
> Done counting 19151 objects.
> Deltifying 19151 objects.
> Segmentation fault (core dumped)
>
> This is on OpenBSD.  Is there a secret sabotage afoot?  This is repeatable.
> Is there anything I can try differently?

Tonight's latest (f7a3276) merged Nico's delta patches that was
in "next" branch for some time, so that is what I would suspect
first.

    commit 06a9f9203570d21f9ef5fe219cdde527dcdf0990
    Author: Nicolas Pitre <nico@cam.org>

        improve diff-delta with sparse and/or repetitive data

    commit 2d08e5dd730680f7f8645a6326ec653435e032df
    Author: Nicolas Pitre <nico@cam.org>

        tiny optimization to diff-delta

    commit 3dc5a9e4cdcc7124c665a050547d1285d86a421f
    Author: Nicolas Pitre <nico@cam.org>

        replace adler32 with Rabin's polynomial in diff-delta

    commit f6c7081aa97aa67baa06390a1ef36088c33bf010
    Author: Nicolas Pitre <nico@cam.org>

        use delta index data when finding best delta matches

    commit 08abe669c05521499149dbf84fedefb04a8fa34d
    Author: Nicolas Pitre <nico@cam.org>

        split the diff-delta interface

Could you revert them (i.e. run "git revert 06a9f9", "git revert
2d08e5", ...) to see where it starts behaving again?

Alternatively, you could bisect between 2fc240a (before merging
np/delta branch) and master (f7a3276).

(1) Reverting recipe.

	$ git checkout -b testfix master
        $ make
        $ GIT_EXEC_PATH=. PATH=.:$PATH \
          ./git-repack -a ;# you already know this fails.
        $ EDITOR=: git revert 06a9f92
        $ make
        $ GIT_EXEC_PATH=. PATH=.:$PATH ./git-repack -a ;# does it?
        $ EDITOR=: git revert 2d08e5d
        $ make
        $ GIT_EXEC_PATH=. PATH=.:$PATH ./git-repack -a ;# does it?
        $ EDITOR=: git revert 3dc5a9e
        $ make
        $ GIT_EXEC_PATH=. PATH=.:$PATH ./git-repack -a ;# does it?
        ...

(2) Bisecting recipe.

	$ git checkout -b testfix master
	$ make
        $ GIT_EXEC_PATH=. PATH=.:$PATH \
          ./git-repack -a ;# you already know this fails.
        $ git reset --hard 2fc240a
	$ make
        $ GIT_EXEC_PATH=. PATH=.:$PATH \
          ./git-repack -a ;# before merging np/delta,
                           # should hopefully work
        $ git bisect start
        $ git bisect good 2fc240a
        $ git bisect bad master
        Bisecting: 10 revisions left to test after this
        [143f4d94c6e2188a6bedfdfa268e66b579e3fbf9] Merge branch 'jc/again'
	$ make
        $ GIT_EXEC_PATH=. PATH=.:$PATH ./git-repack -a ;# does this work?

        $ git bisect good ;# if it works, or
        $ git bisect bad  ;# otherwise
	Bisecting: 7 revisions left to test after this
	...

	
