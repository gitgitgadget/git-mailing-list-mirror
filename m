From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] upload-pack: fix timeout in create_pack_file
Date: Sun, 23 Jul 2006 23:23:06 -0700
Message-ID: <7vd5bvh67p.fsf@assigned-by-dhcp.cox.net>
References: <E1G2t9n-0005PW-72@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 24 08:24:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4tr8-0003vg-J1
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 08:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWGXGXP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 02:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWGXGXP
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 02:23:15 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:23260 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751406AbWGXGXO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jul 2006 02:23:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060724062314.WVGM6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Jul 2006 02:23:14 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1G2t9n-0005PW-72@moooo.ath.cx> (Matthias Lederhofer's message
	of "Tue, 18 Jul 2006 19:14:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24116>

Matthias Lederhofer <matled@gmx.net> writes:

> Signed-off-by: Matthias Lederhofer <matled@gmx.net>
> ---
> <yacc> fatal: packfile '../linux-2.6/.git/objects/pack/tmp-7iPJo5'
>        SHA1 mismatch
> <yacc> error: git-fetch-pack: unable to read from git-index-pack
> <yacc> error: git-index-pack died with error code 128
> <yacc> Any idea what this means?
> This happens after ~12 minutes.  The problem is that the loop in
> upload-pack.c actually sending the pack does not reset the timeout.
> I'd guess --timeout is 600 or a bit more on git.kernel.org :)
>
> This does not help for low timeouts with slow clients.  If a client is
> slow enough so the server is blocked for more time than specified by
> timeout the connection will be closed too (e.g. 15kb/s with a timeout
> of 30 (git adds 10 extra) is not enough).

Where do we add 10 extra?

> We should either add a
> warning to the man page or try to fix this.  I don't know if this can
> be fixed not using non-blocking sockets.

I think the intent of "timeout" was to protect us from funny
clients by avoiding talking with the ones that take too much
time doing something that should not take too long.  When we are
in create_pack_file(), we are already committed to the heaviest
operation anyway, so one possibility might be to stop doing
timeout at that point.  I am not sure if that is acceptable,
though -- it opens up the daemon to even easier DoS than it
currently is.

My gut feeling is that your patch would be fine as is (have you
tried and confirmed that it helps cases other than slow
clients?)

> Perhaps support for resume would be quite useful too but I've no idea
> how hard this is to implement.

That would be _very_ hard.
