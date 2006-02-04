From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] read-tree --aggressive
Date: Sat, 04 Feb 2006 04:56:01 -0800
Message-ID: <7v4q3fxoym.fsf@assigned-by-dhcp.cox.net>
References: <20060131213314.GA32131@ebar091.ebar.dtu.dk>
	<7v8xsr60n2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Feb 04 13:56:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5Mxe-0001ui-BH
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 13:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWBDM4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 07:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWBDM4F
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 07:56:05 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:44160 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751397AbWBDM4E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 07:56:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060204125447.TGKR20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Feb 2006 07:54:47 -0500
To: git@vger.kernel.org
In-Reply-To: <7v8xsr60n2.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 03 Feb 2006 23:31:13 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15593>

Junio C Hamano <junkio@cox.net> writes:

> This patch would not help recursive strategy, though.  Calling
> read-tree with --aggressive flag essentially disables the
> benefit we would expect to get from it -- rename detection.

I think we could fairly easily tweak this by trying at least
half of the rename detection inside read-tree.  That would make
it usable by merge-recursive as well.

Instead of doing "aggressive" in the threeway_merge function
first, we can process the stages without it in the first pass,
and run an equivalent of diff-stages -M internally between stage
#2 and stage #3, and keep the matched paths unmerged (we need to
mark these paths somehow).  After that, we can do "aggressive"
collapsing to reduce the amount of trivial merges that recursive
does not have to look at for renaming merges.

If we are ambitious, we could go further.  We could actually
move the stages around after running the rename detection diff
between stages #2 and #3, along with working tree files as
needed.  Then merge-resolve would be able to do the renaming
merge similar to merge-recursive.
