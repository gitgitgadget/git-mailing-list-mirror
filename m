From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] upload-pack: fix timeout in create_pack_file
Date: Mon, 24 Jul 2006 09:10:12 +0200
Message-ID: <E1G4uZw-0006vZ-VO@moooo.ath.cx>
References: <E1G2t9n-0005PW-72@moooo.ath.cx> <7vd5bvh67p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 24 09:10:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4ua6-0003T2-4r
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 09:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWGXHKS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 03:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWGXHKS
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 03:10:18 -0400
Received: from moooo.ath.cx ([85.116.203.178]:6531 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751429AbWGXHKQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jul 2006 03:10:16 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vd5bvh67p.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24130>

Junio C Hamano <junkio@cox.net> wrote:
> > This does not help for low timeouts with slow clients.  If a client is
> > slow enough so the server is blocked for more time than specified by
> > timeout the connection will be closed too (e.g. 15kb/s with a timeout
> > of 30 (git adds 10 extra) is not enough).
> 
> Where do we add 10 extra?
Oops, never mind, I misread the source.

> > We should either add a
> > warning to the man page or try to fix this.  I don't know if this can
> > be fixed not using non-blocking sockets.
> 
> I think the intent of "timeout" was to protect us from funny
> clients by avoiding talking with the ones that take too much
> time doing something that should not take too long.  When we are
> in create_pack_file(), we are already committed to the heaviest
> operation anyway, so one possibility might be to stop doing
> timeout at that point.  I am not sure if that is acceptable,
> though -- it opens up the daemon to even easier DoS than it
> currently is.
> 
> My gut feeling is that your patch would be fine as is (have you
> tried and confirmed that it helps cases other than slow
> clients?)
What else?  The problem solved by this patch is the missing
reset_timeout while downloading pack files and this affects all
clients that are too slow (cannot download the packfile within
--timeout seconds).  I tried a server with --timeout=600 and a client
that cannot download the whole pack file in 10 minutes.  Without the
patch the server closes the connection, with this patch it works.
Additionally I tried it with a client reading so slow that the server
was blocked for more than --timeout seconds, then the server closes
the connection too (this is more or less the DoS case).

> > Perhaps support for resume would be quite useful too but I've no idea
> > how hard this is to implement.
> 
> That would be _very_ hard.
I don't know how much demand there is for resuming but there is always rsync
(at least on kernel.org and other repositories that need it can install it too)
to get the new objects with support for resuming.
