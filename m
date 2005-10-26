From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fetch-pack: avoid packing reachable objects.
Date: Tue, 25 Oct 2005 22:07:11 -0700
Message-ID: <7v7jc0c1ds.fsf@assigned-by-dhcp.cox.net>
References: <20051026042632.GA3059@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Oct 26 07:16:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUdVh-0005l1-3A
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 07:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVJZFHQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 01:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVJZFHQ
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 01:07:16 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:50361 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932541AbVJZFHO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 01:07:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051026050659.WQFD16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Oct 2005 01:06:59 -0400
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: git@vger.kernel.org
In-Reply-To: <20051026042632.GA3059@delft.aura.cs.cmu.edu> (Jan Harkes's
	message of "Wed, 26 Oct 2005 00:26:32 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10646>

Jan Harkes <jaharkes@cs.cmu.edu> writes:

> Mark remote commits that were found in the alternate repository as
> COMPLETE and avoid unnecessary packing of already available objects.

Sorry, this is wrong (we made this mistake twice already).  The
mere existence of that object in the local repository does not
necessarily mean we have everything that is reachable from it.

The rule is that we only trust local refs.  Anything that are
reachable from them are known to be complete.  And after a
successful fetch, we update local refs.  The existence of an
object is a strong _hint_ that it _might_ be complete, but
nothing more.

Think of a case where you tried to fetch via commit walker and
got things reachable from the then-current ref, and the 
object you are marking as COMPLETE (maybe in pack) is a remnant
of that failed fetch, which was killed before completing.  You
might have complete history starting from the then-current
commit back to that commit, but there is no guarantee that you
can further tangle the history back and find everything needed.
