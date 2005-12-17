From: Junio C Hamano <junkio@cox.net>
Subject: Re: git merge questions
Date: Fri, 16 Dec 2005 19:48:40 -0800
Message-ID: <7vbqzgbcyv.fsf@assigned-by-dhcp.cox.net>
References: <68948ca0512161205x3d5921bfm3bfcaa64f988eb99@mail.gmail.com>
	<7vacf0g4ga.fsf@assigned-by-dhcp.cox.net>
	<7vy82keo8p.fsf@assigned-by-dhcp.cox.net>
	<68948ca0512161335k50a3ec64lee6f73ea4f8ae23f@mail.gmail.com>
	<7voe3gd6ul.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512170056380.11000@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Don Zickus <dzickus@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 04:49:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnT4A-0004Es-8g
	for gcvg-git@gmane.org; Sat, 17 Dec 2005 04:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbVLQDso (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 22:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbVLQDso
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 22:48:44 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:55529 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751371AbVLQDsn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 22:48:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051217034750.MHKF6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Dec 2005 22:47:50 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512170056380.11000@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 17 Dec 2005 00:58:50 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13769>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> just a thought: maybe in this case -- git fails to recognize a rename -- 
> Pasky's idea would have some merit.

It is not as simple as that.  If you look at the output of the
following command, you would understand why.

	$ git rev-list ^$(git merge-base test test2) test2 -- \
          arch/powerpc/Kconfig arch/ppc64/Kconfig |
          git diff-tree --pretty -C -r --stdin --abbrev --name-status \
          arch/powerpc/Kconfig arch/ppc64/Kconfig

The transition happened over time with multiple commits.

First ppc64/Kconfig was somewhat stripped of its contents,
starting at this commit:

    diff-tree bcdd1ea... (from 5bfc826...)
    Author: Stephen Rothwell <sfr@canb.auug.org.au>
    Date:   Mon Sep 19 23:13:24 2005 +1000

        [PATCH] powerpc: Move arch/ppc*/oprofile/Kconfig to arch/powerpc

        These files are identical.

        Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
        Signed-off-by: Paul Mackerras <paulus@samba.org>

    M       arch/ppc64/Kconfig

and after a lot of hard work, powerpc/Kconfig gets
created.

    diff-tree 14cf11a... (from e5baa39...)
    Author: Paul Mackerras <paulus@samba.org>
    Date:   Mon Sep 26 16:04:21 2005 +1000

        powerpc: Merge enough to start building in arch/powerpc.

        This creates the directory structure under arch/powerpc and a bunch
        of Kconfig files...

    A       arch/powerpc/Kconfig

After that both continues to exist for some time, and finally
ppc64/Kconfig gets deleted with this one:

    diff-tree 7568cb4... (from c55377e...)
    Author: Paul Mackerras <paulus@samba.org>
    Date:   Mon Nov 14 17:30:17 2005 +1100

        powerpc: Move most remaining ppc64 files over to arch/powerpc

        Also deletes files in arch/ppc64 that are no longer used now that
        we don't compile with ARCH=ppc64 any more.

        Signed-off-by: Paul Mackerras <paulus@samba.org>

    M       arch/powerpc/Kconfig
    D       arch/ppc64/Kconfig


You cannot record "this is the rename" by attributing that
information to one particular commit.  Even looking at the
commit history one by one you cannot really say powerpc/Kconfig
is a rename of ppc64/Kconfig.  I suspect that it is not really a
rename --- from reading of the log messages, its original
contents were moved around and scattered over to other Kconfig
files in the tree, or along with other configuration pieces got
consolidated into powerpc/Kconfig, or perhaps both.
