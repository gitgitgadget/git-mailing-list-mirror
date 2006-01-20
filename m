From: Junio C Hamano <junkio@cox.net>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Fri, 20 Jan 2006 09:59:53 -0800
Message-ID: <7v4q3ybx0m.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com>
	<cda58cb80601170932o6f955469y@mail.gmail.com>
	<7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net>
	<7virsf7lb9.fsf@assigned-by-dhcp.cox.net>
	<cda58cb80601200207g7c3495ddx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 20 19:00:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F00YI-0004AV-Ua
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 19:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWATR74 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 12:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWATR74
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 12:59:56 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:22211 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751123AbWATR74 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 12:59:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060120175840.CUSK6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 Jan 2006 12:58:40 -0500
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80601200207g7c3495ddx@mail.gmail.com>
	(vagabon.xyz@gmail.com's message of "Fri, 20 Jan 2006 11:07:09 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14972>

Franck <vagabon.xyz@gmail.com> writes:

> 2006/1/20, Junio C Hamano <junkio@cox.net>:
>
>>         $ git clone git.git junk
>>         $ cd junk ;# I am not brave enough to risk the real thing ;-)
>>         $ git rev-parse master~4 >.git/refs/info/grafts

Typo: 	's|.git/refs/info/grafts|.git/info/grafts|'

BTW the above exact sequence will not work with my "master"
today, since I merged up bunch of things last night.  You have
to cauterize all the paths that lead to earlier history.  For
example, if I have this:

   ---o---o---x---o---o---o---o (master)
       \         /
        o---o---o

cauterizing at master~4 ('x') will still leak history via the
side branch, if you follow the history from the tip and go
backwards.  I have to also cauterize the merge commit after that
to remove the side branch, or cauterize the leftmost branch
point and live with a bit deeper history.  The choice depends on
how much real history I want to keep in the pruned history.

For example, to pretend the history was like this:

   ---o---o   x---o---o---o---o (master)
       \         
        o---o---o

	$ git rev-parse master~4 >.git/info/grafts ;# 'x'
        $ git rev-parse master~3 master~4 >.git/info/grafts

The second line says master~3 (the one that comes after 'x') has
only a single parent, which is master~4, in order to throw the
side branch away [*1*].

Back to the original example...

>>         $ cd ..
>>         $ mkdir cloned
>>         $ cd cloned
>>         $ git init-db
>>         $ cp ../junk/.git/info/grafts .git/info/
>>         $ git clone-pack ../baz

There are a couple of typos here and that was the reason your
experiment did not work.  Sorry.  The "clone-pack" should have
been like this:

        $ git clone-pack ../junk master
        Packing 471 objects
        e7555785f4edcf4988c53305349e3f525216e2cb refs/heads/master
	$ git-rev-parse e7555785f >.git/refs/heads/master

This 'cloned' is the lightweight one.

> does the git protocol is really needed in your example ? or can rsync
> work fine too since "franck.git" repo is cautorized so every objects
> of this repo shouldn't be part of old history, so they should be
> usefull, no ?

rsync may for the initial clone but its use afterwards is
frowned upon for other reasons these days.


[Footnote]

*1* There still is an anomaly if you look at "git log" after
pruning side branch this way; master~3 commit is still shown as
"merge".  I think you could call it a bug, but I am not sure it
is worth fixing.
