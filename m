From: Junio C Hamano <junkio@cox.net>
Subject: Re: git reset --hard not removing some files
Date: Fri, 02 Jun 2006 07:57:57 -0700
Message-ID: <7vhd33d2q2.fsf@assigned-by-dhcp.cox.net>
References: <20060601160052.GK14325@admingilde.org>
	<Pine.LNX.4.64.0606010918060.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Fri Jun 02 16:58:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmB6C-0003Hx-EF
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 16:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWFBO57 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 10:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWFBO57
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 10:57:59 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:5375 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751320AbWFBO56 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 10:57:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060602145758.XSQA554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Jun 2006 10:57:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606010918060.5498@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 1 Jun 2006 09:21:38 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21161>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 1 Jun 2006, Martin Waitz wrote:
>> 
>> I have the following problem:
>
> It's not a problem, it's a feature.
>...
> Those files were _never_ tracked.

I would agree in the reproduction recipe Martin gave there is no
problem but feature, but at the same time I suspect the recent
"reset --hard simplification" has introduced a true regression.

        $ mkdir test || exit
        $ cd test || exit
        $ git init-db
        defaulting to local storage area
        $ echo init >file0
        $ echo init >file1
        $ git add file0 file1
        $ git commit -m initial
        Committing initial tree de84dc367842fdbbb3acad3b3ed252f8c984296f
        $ git branch side
        $ rm -f file1
        $ echo second >file2
        $ git add file2
        $ git commit -a -m 'master adds file2 and deletes file1'
        $ git checkout side
        $ echo modified >file1
        $ git commit -a -m 'side edits file1'
        $ git checkout master
        $ ls
        file0  file2
        $ git pull . side
        Trying really trivial in-index merge...
        fatal: Merge requires file-level merging
        Nope.
        Merging HEAD with 7934c9c383f611cf2b9895a46cf95b815569beef
        Merging: 
        b684570dc1141552d0da950a18f2d84a3ffadbc1 master adds file2 and deletes file1 
        7934c9c383f611cf2b9895a46cf95b815569beef side edits file1 
        found 1 common ancestor(s): 
        598d6491f72b6057ca87683d43cf64b08d90ddaf initial 
        CONFLICT (delete/modify): file1 deleted in HEAD and modified in 7934c9c383f611cf2b9895a46cf95b815569beef. Version 7934c9c383f611cf2b9895a46cf95b815569beef of file1 left in tree. 

        Automatic merge failed; fix conflicts and then commit the result.
        $ git ls-files -u
        100644 b1b716105590454bfc4c0247f193a04088f39c7f 1	file1
        100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 3	file1
        $ ls
        file0  file1  file2
        $ git reset --hard
        $ ls
        file0  file1  file2

We used to remove file1 from the working tree in this case.  One
of the most important reason to use "git reset --hard" is to
recover from a conflicted, failed merge.  

Leaving file1 in the working tree around in this case has
unpleasant consequences.  After the above:

	$ git checkout side
	fatal: Untracked working tree file 'file1' would be overwritten by merge.
