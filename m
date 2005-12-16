From: Junio C Hamano <junkio@cox.net>
Subject: Re: git merge questions
Date: Fri, 16 Dec 2005 12:41:25 -0800
Message-ID: <7vacf0g4ga.fsf@assigned-by-dhcp.cox.net>
References: <68948ca0512161205x3d5921bfm3bfcaa64f988eb99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 21:43:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnMOQ-0004ZK-8U
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 21:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVLPUl1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 15:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVLPUl1
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 15:41:27 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:13975 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932404AbVLPUl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 15:41:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051216203928.XULH20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Dec 2005 15:39:28 -0500
To: Don Zickus <dzickus@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13747>

Don Zickus <dzickus@gmail.com> writes:

> Now over the course of 2.6.15 the arch/ppc64 was renamed to
> arch/powerpc.  Fine. The merge algorithms handled all the unchanged
> files properly.  However arch/ppc64/Kconfig was modified and the
> merging was left unresolved.  In fact there is no file no merge
> against (because it moved).  So 'git-ls-files -u' only shows stage 1+3
> (no stage 2, of course).
>
> How do I merge those changes?  I don't know enough about all the git
> commands to figure this out, especially how to take advantage of the
> stage 1, 2, and 3 files.

I do not work on the kernel myself so I'll probably get the
details wrong, but I am guessing here is what you have:

 - 2.6.14.z has arch/ppc64/Kconfig;

 - Your "test" branch has arch/ppc64/Kconfig.  You may or may
   not have changes since 2.6.14.z on that file;

 - "test2" branch has 2.6.15-rc4, which has the file at
   arch/powerpc/Kconfig;

Then, with the current branch being "test2", you pulled "test"
into it.

 - Untouched [by whom???] files from arch/{ppc64,powerpc}/ were
   merged correctly and you find the result of merge under
   arch/powerpc --- after all you are applying changes on top of
   2.6.15-rc4 and you want them under arch/powerpc as the
   upstream has;

 - arch/ppc64/Kconfig was modified [by whom???] and merge was
   left unresolved.

I suspect these:

	ls -l arch/ppc64/Kconfig <1>
	git ls-files -s arch/ppc64/Kconfig <2>
        ls -l arch/powerpc/Kconfig arch/powerpc/Kconfig~* <3>
        git ls-files -s arch/powerpc/Kconfig <4>

<1> has the file from your "test" branch based on 2.6.14z;
<2> shows that same file;
<3> may show the three variants (I am not sure about this);
<4> has 2.6.15-rc4 version at stage 3 and merge base version at
    stage 1 (I am not absolutely certain what stage 1 has, and
    also am puzzled why stage 2 is not there --- if the
    recursive strategy figured out renames it should have the
    contents of arch/ppc64/Kconfig from test branch there).

The safest (however most primitive) way I can think of to go
from here is:

1. figure out the merge-base Kconfig file's contents.

        $ mb=$(git merge-base refs/heads/test refs/heads/test2)
        $ git ls-tree $(mb) arch/powerpc/Kconfig arch/ppc/Kconfig

   I do not know which path the merge base has, but it should
   have either one of those.  Note the blob object name (call it
   $oSHA1).

2. extract three versions.

	$ git ls-tree refs/heads/test2 arch/powerpc/Kconfig
        $ git ls-tree refs/heads/test arch/powerpc/Kconfig

   Note the blob object name from these two as well (call them
   $aSHA1, and $bSHA1).

3. merge those three.

	$ git cat-file blob $oSHA1 >orig
        $ git cat-file blob $aSHA1 >from-test2
        $ git cat-file blob $bSHA1 >from-test
        $ merge from-test2 orig from-test

With luck from-test2 would contain a clean automerge result, or
you will get <<< === >>> conflict markers.  Resolve them in the
file, and then:

4. resolve the index and remove cruft.

	$ cat from-test2 >arch/powerpc/Kconfig
        $ rm -f arch/ppc64/Kconfig orig from-test2 from-test
        $ git update-index --add --remove \
        	arch/ppc64/Kconfig arch/powerpc/Kconfig

5. if there is no other merge cruft, commit.

	$ git commit

What puzzles me is that I think it is supposed to have done all
the above for you.  Namely:

	$ ls -l arch/ppc64/Kconfig <1>
	$ git ls-files -s arch/ppc64/Kconfig <2>
        $ ls -l arch/powerpc/Kconfig arch/powerpc/Kconfig~* <3>
        $ git ls-files -s arch/powerpc/Kconfig <4>

<1> should not remain --- recursive merge could have notied that
the file was moved.
<2> ditto.
<3> arch/powerpc/Kconfig should be there with possibly merge
conflict markers.
<4> stage1 with merge base version (possibly renamed), stage2
with test2 version, stage3 with your test version (definitely
renamed).

and after editing arch/powerpc/Kconfig to resolve conflicts, you
should be able to just say:

	$ git update-index arch/powerpc/Kconfig
	$ git commit
