From: Junio C Hamano <junkio@cox.net>
Subject: Re: clone: I'm only doing a max of 256 requests
Date: Wed, 05 Oct 2005 16:45:49 -0700
Message-ID: <7vek6zedea.fsf@assigned-by-dhcp.cox.net>
References: <20051005191300.GC17475@hexapodia.org>
	<Pine.LNX.4.64.0510051541300.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 01:47:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENIxN-0005kJ-VM
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 01:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbVJEXpv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 19:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbVJEXpv
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 19:45:51 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:56031 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030447AbVJEXpu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 19:45:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051005234537.OXRO2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Oct 2005 19:45:37 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510051541300.31407@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 5 Oct 2005 15:45:15 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9749>

Linus Torvalds <torvalds@osdl.org> writes:

> No, just change the "MAX_NEEDS" define from 256 to some larger value.
>
> There's no real reason for the limit, except that maybe we should have 
> some dynamic allocation for this.

If somebody is asking for more than say 20 refs, even if the
repository is mature and has 1000 point releases tagged, it
might not make that much of a difference if we ship everything
back instead of being selective, especially when the downloader
said "I do not have anything", i.e. initial cloning.

So after the 'rev-list --all' patch, I was actually going to
suggest reducing MAX_NEEDS, to say 47 (another arbitrary
number), and maybe making MAX_HAS side dynamic to hold more refs
for the stop list.

Also it may be worthwhile to teach upload-pack.c::got_sha1() to
notice when the other side says he has one object and we know
that object is reachable from another object he already said he
has, and choose not to use the older object on the has_sha1[]
list.  The "have" list from fetch-pack tends to come from newer
to older, so this would save has_sha1[] array entries from being
consumed by older commits when we know about the commits he has
near the tip of the same branch.
