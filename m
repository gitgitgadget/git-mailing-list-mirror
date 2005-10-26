From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/4] git-init-db should error out with a message
Date: Wed, 26 Oct 2005 13:27:00 -0700
Message-ID: <7v3bmoc9d7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510260139000.30576@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051026194520.GC8030@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 22:27:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUrrX-00018G-Dr
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 22:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbVJZU1D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 16:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbVJZU1D
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 16:27:03 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:27123 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964901AbVJZU1B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 16:27:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051026202641.NRXA9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Oct 2005 16:26:41 -0400
To: Alex Riesen <fork0@users.sourceforge.net>
In-Reply-To: <20051026194520.GC8030@steel.home> (Alex Riesen's message of
	"Wed, 26 Oct 2005 21:45:20 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10692>

Alex Riesen <fork0@users.sourceforge.net> writes:

> Not just that. It would be interesting to give the user an option to
> use the file references ("ref: refs/heads/master").

Actually, the users should not have to care how HEAD reference
is implemented.  It might make sense to use regular file symref
regardless of platforms (i.e. never define USE_SYMLINK_HEAD on
any platform).

We support reading from either kind of symref, so if we did
that, the only case that *could* matter form compatibility point
of view is that repositories touched by the updated git is
unusable for an ancient git that does not understand regular
file symref.  From performance and simplicity point of view,
however, using symlink when possible is better, and that is what
Johannes' patch does.

HOWEVER, I think "falling back" (both in Johannes' patch which
is in the "master" branch, and your version) has a funny failure
mode.  What happens when two processes try redirecting .git/HEAD
simultaneously, possibly to different branch heads?  Both of
them unlink(), one successfully does symlink(), and the other
gets EEXIST and falls back to create regular file symref.

Which is probably not so wrong; if this race matters, then you
have bigger problem -- the user is doing 'git checkout' of
different branches at the same time, or something silly like
that.  But it does not feel quite right, either.
