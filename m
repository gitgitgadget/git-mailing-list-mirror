From: Junio C Hamano <junkio@cox.net>
Subject: Re: cg-clone, tag objects and cg-push/git-push don't play nice
Date: Wed, 19 Oct 2005 01:52:19 -0700
Message-ID: <7vbr1ldh30.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90510182338k6d3d52fbyc2057e9b775d5b14@mail.gmail.com>
	<7vzmp6dlii.fsf@assigned-by-dhcp.cox.net>
	<46a038f90510190110g53c90c5t419ad6065292269e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 10:54:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES9gw-0001ww-GK
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 10:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVJSIwV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 04:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbVJSIwV
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 04:52:21 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:6386 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932477AbVJSIwV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 04:52:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019085149.HBOR2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 04:51:49 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10276>

Martin Langhoff <martin.langhoff@gmail.com> writes:

>> That is expected.
>
> Hmmm. I was under the impression that if I call git-push naming a
> particular head, it could restrict itself to the stuff needed for that
> head only. Just to clarify, I'm running
>
>   git-push locke.catalyst.net.nz:/var/git/moodle-test.git master:mdl-topnz-prod

Yeah.  But the problem is that the repository on the other end
claims that it has everything reachable from those incomplete
tags.  Hearing that, git-push (the real name of it is send-pack)
decides not to send things that are already reachable from the
refs the other end claims to have.  So if an incomplete tag
refers to a commit that contains a blob that the remote actually
does not have, and if that blob is part of the head you are
pushing, send-pack would not (and should not) send that blob to
the remote.

>> I do not understand why removing .git/refs/tags/* did not help,
>> and that is the biggest thing that disturbs me in this whole
>> problem report
>
> I can't understand that either, but I manually removed all the
> refs/tags, and the only heads I have are origin and master. git-push
> won't let me do it until the exact point where I have removed the
> object from the repo. And that's only possible on unpacked repos.

Hmph.  It worries me even more.

This error message:

      error: unpack should have generated
    482d4b88aa482dfea7f7549470902049a050020a, but I can't find it!

comes from receive-pack that runs on the other repo (i.e. the
one with incomplete tags you just removed), so it means
send-pack decided it does not need to send that object --
meaning the other end claimed it already has it.  What to send
and what need not to be sent is determined solely based on what
send-pack hears from receive-pack in the initial handshake,
which is in receive-pack.c::write_head_info().  It scans
everything under ".git/refs" directory (not just .git/refs/heads
or .git/refs/tags; if you had ".git/refs/FOOBAR", it will cause
the remote end to claim it has everything reachable from it --
the only exceptions are things that starts with a dot '.', which
is probably why cg-fetch places a temporary heads in
refs/*/.$name-fetching) and sends them -- it does not look at
the object directory and magically claim it has something that
is not recorded in its .git/refs/ directory.
