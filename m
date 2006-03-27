From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-explode-packs
Date: Sun, 26 Mar 2006 19:53:31 -0800
Message-ID: <7vd5g8pmpw.fsf@assigned-by-dhcp.cox.net>
References: <11432881443149-git-send-email-matlads@dsmagic.com>
	<7vwtehpwdd.fsf@assigned-by-dhcp.cox.net>
	<20060326125450.GT31387@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 27 05:53:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNina-0002Vw-7F
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 05:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWC0Dxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 22:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWC0Dxe
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 22:53:34 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:9913 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751586AbWC0Dxe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Mar 2006 22:53:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060327035333.XFAF3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Mar 2006 22:53:33 -0500
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20060326125450.GT31387@lug-owl.de> (Jan-Benedict Glaw's message
	of "Sun, 26 Mar 2006 14:54:50 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18070>

Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:

> On Sat, 2006-03-25 22:12:46 -0800, Junio C Hamano <junkio@cox.net> wrote:
>> The script seems to do what it claims to, but now why would one
>> need to use this?  In other words what's the situation one would
>> find this useful?
>
> It's possibly useful if you oftenly access old objects with
> git-cat-file or git-ls-tree.

Benchmarks?

I created two cloned repositories from git.git.  victim03
repository is fully packed with the default pack parameter of
depth and window set both to 10. victim04 repository has the
same set of objects and refs but the pack is expanded (16232
loose objects).

Now in victim03 repository, 657 blobs have depth 10 (i.e. you
need to inflate and apply delta 10 times to get to the object).
So I made the list of these "expensive to access" objects and
run this:

	$ cd victim03
	$ /usr/bin/time sh -c '
            while read sha1; do git cat-file blob $sha1;
            done >/dev/null <list
	'

3.43user 3.36system 0:07.17elapsed 94%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+364561minor)pagefaults 0swaps
3.51user 3.33system 0:07.10elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+364499minor)pagefaults 0swaps
3.76user 2.99system 0:07.28elapsed 92%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+365155minor)pagefaults 0swaps

With the same file list, in victim04 repository that has 16232
loose objects:

	$ cd victim04
	$ /usr/bin/time sh -c '
            while read sha1; do git cat-file blob $sha1;
            done >/dev/null <../victim03/list
	'

3.29user 2.98system 0:06.33elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+348786minor)pagefaults 0swaps
3.26user 2.88system 0:06.63elapsed 92%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+347512minor)pagefaults 0swaps
3.16user 2.98system 0:06.20elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+347489minor)pagefaults 0swaps

So you are getting slight performance gain out of this by
exploding the pack, but on the other hand you are taxing the
buffer cache quite heavily by reading the loose objects (in both
of the experiments above, I discarded numbers from the very
first run).  The size of object databases in these cases are:

        $ du -sh victim0[34]/.git/objects
        6.2M    victim03/.git/objects
        84M     victim04/.git/objects

So I am still not convinced it would be useful in general.  It
used to be that exploding everything and repacking was the only
way to clean out garbage from packs, but after "repack -a -d"
was invented by Frank Sorenson that became more convenient way.
Especially with the recent "delta reusing" pack-objects, doing
"repack -a -d" has become quite cheap, so...
