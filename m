From: Junio C Hamano <junkio@cox.net>
Subject: Re: User-relative paths
Date: Sun, 23 Oct 2005 15:57:34 -0700
Message-ID: <7vd5lvx2n5.fsf@assigned-by-dhcp.cox.net>
References: <435ABB99.5020908@op5.se>
	<7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se>
	<7v1x2cyplw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510231427230.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 00:58:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETomb-0001KI-83
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 00:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbVJWW5h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 18:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbVJWW5h
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 18:57:37 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:57263 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750821AbVJWW5g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2005 18:57:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051023225721.MHEG1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Oct 2005 18:57:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510231427230.10477@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 23 Oct 2005 14:30:45 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10512>

Linus Torvalds <torvalds@osdl.org> writes:

>> But it is orthogonal to what you are doing in this patch.
>
> Well, not necessarily.
>
> It's quite arguable that sanity testing might be per-user and could be 
> done by the shell. I'm not at all sure that srvside_chdir() should do any 
> extra testing: if you have real ssh access, the user has the right to do 
> anything he damn well pleases.

The point of the patch, unless I am mistaken, is to add ~user/
expansion to the pathname grokking, so that a remote user does
not have to know exactly where on the server each user's home
directory is.

I agree 100% with you that srvside_chdir() is not the place to
do policy checking.  In order to avoid the aliasing problem
(which motivated HPA to add --strict option), the receiving end,
be it git-daemon driving upload-pack or git-shell driving
receive-pack or upload-pack, can do ~user/ expansion first, then
run their policy checking on the canonicalized path before
spawning the lower level programs using the already
canonicalized path.

To also support the case where upload-pack and receive-pack are
started directly from the ssh connection, these programs need to
apply ~user/ expansion to the incoming path themselves by
default.  In order to avoid double expansion, git-daemon and
git-shell should pass --no-user-expansion flag to the lower
level programs when it starts them if we do this.

A common library that takes the path supplied from the other end
and does ~user/ expansion would be useful for the above; we can
lift that logic from Andreas' srvside_chdir().
