From: Junio C Hamano <junkio@cox.net>
Subject: Re: git merge questions
Date: Fri, 16 Dec 2005 13:16:54 -0800
Message-ID: <7vy82keo8p.fsf@assigned-by-dhcp.cox.net>
References: <68948ca0512161205x3d5921bfm3bfcaa64f988eb99@mail.gmail.com>
	<7vacf0g4ga.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 22:19:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnMwm-0001AO-BJ
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 22:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVLPVQ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 16:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVLPVQ5
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 16:16:57 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:17625 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932428AbVLPVQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 16:16:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051216211559.EFVO20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Dec 2005 16:15:59 -0500
To: Don Zickus <dzickus@gmail.com>
In-Reply-To: <7vacf0g4ga.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 16 Dec 2005 12:41:25 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13753>

Junio C Hamano <junkio@cox.net> writes:

> What puzzles me is that I think it is supposed to have done all
> the above for you.  Namely:
>
> 	$ ls -l arch/ppc64/Kconfig <1>
> 	$ git ls-files -s arch/ppc64/Kconfig <2>
>         $ ls -l arch/powerpc/Kconfig arch/powerpc/Kconfig~* <3>
>         $ git ls-files -s arch/powerpc/Kconfig <4>
>
> <1> should not remain --- recursive merge could have notied that
> the file was moved.
> <2> ditto.
> <3> arch/powerpc/Kconfig should be there with possibly merge
> conflict markers.
> <4> stage1 with merge base version (possibly renamed), stage2
> with test2 version, stage3 with your test version (definitely
> renamed).

I know what happened.  That Kconfig file was modified between
v2.6.14 and v2.6.15-rc4 beyond recognition, and the rename
detection did not think it was renamed.

The merge has this message:

    CONFLICT (delete/modify): arch/ppc64/Kconfig deleted in HEAD and
    modified in e14ee1ed34e25df6ea93b0bfb1bc4138cd26bea2. Version
    e14ee1ed34e25df6ea93b0bfb1bc4138cd26bea2 of arch/ppc64/Kconfig
    left in tree.

and then, the digging I suggested yields these:

$ ls -l arch/{ppc64,powerpc}/Kconfig
-rw-rw-r--  1 junio src 24279 Dec 16 12:55 arch/powerpc/Kconfig
-rw-rw-r--  1 junio src 11027 Dec 16 12:58 arch/ppc64/Kconfig
$ git ls-files -s arch/ppc64/Kconfig arch/powerpc/Kconfig
100644 bb2efdd566a9d590d64184b10b097e4b7ed17e95 0       arch/powerpc/Kconfig
100644 c658650af429672267409508b02b38754c11a40f 1       arch/ppc64/Kconfig
100644 8abf1118ebbd59954d098d87679114ffda0e75cb 3       arch/ppc64/Kconfig
$ ls arch/{powerpc,ppc64}/Kconfig~*
ls: arch/powerpc/Kconfig~*: No such file or directory
ls: arch/ppc64/Kconfig~*: No such file or directory
$ git diff --theirs arch/ppc64/Kconfig
* Unmerged path arch/ppc64/Kconfig
diff --git a/arch/ppc64/Kconfig b/arch/ppc64/Kconfig

The merge algorithm thought your branch (that is, test2 which is
v2.6.15-rc4) removed the old ppc64/Kconfig path, but the other
branch (test1 which has diff between v2.6.14 and v2.6.14.4) made
updates to that file.  For the other path, it simply thought
your branch added a new file arch/powerpc/Kconfig while the
other branch did not do anything to that path between v2.6.14
and v2.6.14.4, so it merged it already.

The result you want in this case is to merge changes between
c65865 (stage1 of old path) and 8abf11 (stage3 of old path) into
bb2efd (the latest contents of the new path) and register it as
the result of merge for arch/powerpc/Kconfig, and remove
arch/ppc64/Kconfig.  So the sequence would be:

$ orig=$(git unpack-file c65865)
$ from_test=$(git unpack-file 8abf11)
$ merge $from_test $orig arch/powerpc/Kconfig
merge: warning: conflicts during merge

After resolving the conflict in $from_test file, and other conflicts:

$ ed $from_test
$ cat $from_tset >arch/ppc64/Kconfig
$ rm arch/powerpc/Kconfig
$ rm $orig $from_test
$ git update-index --add --remove arch/ppc64/Kconfig arch/powerpc/Kconfig
# also mark paths you hand-resolved such as Makefile, drivers/pcmcia/i82365.c
# etc. with "git update-index" here.
$ git commit

would commit the result of the merge.
