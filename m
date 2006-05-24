From: Junio C Hamano <junkio@cox.net>
Subject: Re: Slow fetches of tags
Date: Wed, 24 May 2006 12:06:24 -0700
Message-ID: <7vhd3f6y4v.fsf@assigned-by-dhcp.cox.net>
References: <20060524131022.GA11449@linux-mips.org>
	<Pine.LNX.4.64.0605240931480.5623@g5.osdl.org>
	<Pine.LNX.4.64.0605240947580.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
X-From: git-owner@vger.kernel.org Wed May 24 21:06:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fiygf-00063a-KZ
	for gcvg-git@gmane.org; Wed, 24 May 2006 21:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWEXTG0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 15:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWEXTG0
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 15:06:26 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:62628 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751008AbWEXTG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 15:06:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060524190625.XTTI5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 May 2006 15:06:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605240947580.5623@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 24 May 2006 10:21:41 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20700>

Linus Torvalds <torvalds@osdl.org> writes:

> Junio? Any ideas? I didn't want to do that tag-auto-following, and while I 
> admit it's damn convenient, it's really quite broken, methinks. 

I think the current setup is broken on two counts.  If you fetch
without remote tracking branch, I suspect that we end up asking
for the tip of the remote again -- because there is no ref that
says "this commit is known to be complete -- we just fetched
from them successfully".

But I think what Ralf is seeing is a bit different.  The example
given:

  git fetch git://git.kernel.org/pub/scm/linux/kernel/git/stable/\
       linux-2.6.16.y.git master:v2.6.16-stable

does use a tracking branch, and when the tag following kicks in,
v2.6.16-stable head should have been updated.  I suspect it is
just its head commit is older than tips of other branches, and
purely date based sorting done by fetch-pack.c::get_rev() ends
up walking them before it gets to the tip of the branch we just
fetched.

I wonder if we can do a dirty hack to give bias to commits
coming from refs that are newer (on the local filesystem -- that
is, mtime of .git/refs/heads/v2.6.16-stable must be a lot newer
than .git/refs/heads/master in this case because we just fetched
it)...
