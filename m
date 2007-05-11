From: Junio C Hamano <junkio@cox.net>
Subject: Re: git rebase chokes on directory -> symlink -> directory
Date: Fri, 11 May 2007 10:28:06 -0700
Message-ID: <7vfy63b789.fsf@assigned-by-dhcp.cox.net>
References: <463FCD7C.4020009@zytor.com> <20070508215009.GA2670@steel.home>
	<46413565.3090503@zytor.com>
	<81b0412b0705090050i644a18c2g12c74462ab88163a@mail.gmail.com>
	<4641FDAF.3090608@zytor.com> <20070509213902.GA2593@steel.home>
	<46424ECC.6030907@zytor.com> <7vmz0dmb2u.fsf@assigned-by-dhcp.cox.net>
	<20070510220418.GK3141@spearce.org>
	<7v8xbvew16.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0705110835230.3986@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 11 19:28:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmYua-000717-TJ
	for gcvg-git@gmane.org; Fri, 11 May 2007 19:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758519AbXEKR2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 13:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758915AbXEKR2J
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 13:28:09 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:61953 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758519AbXEKR2H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 13:28:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511172806.DMBC1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 13:28:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xtU61W00c1kojtg0000000; Fri, 11 May 2007 13:28:07 -0400
In-Reply-To: <alpine.LFD.0.98.0705110835230.3986@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 11 May 2007 08:56:24 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46970>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That said, wouldn't it potentially be quite easy in "unpack_trees_rec()" 
> to just notice when all the trees are identical, and just not recurse at 
> all in that case (or - alternatively - recurse, but on entry, just exit 
> quickly?)

In the threeway case, it should be able to notice that the trees
of the ancestor and the other match, which is the only case we
can safely say that the result will be our tree (aka HEAD) and
we won't mess with the index nor worry about local modifications
made only to the working tree.  The case in which all trees
match, regardless of the number of trees involved, should work
the same way.

However, in the threeway case, we still need to make sure that
the index matches the HEAD even when we know the result will be
taken from HEAD, as otherwise we would end up including the
local "git add" made earlier in the merge result.  We need to
make sure the index matches HEAD for such a subdirectory in that
case before skipping it.

What is troublesome is that kind of policy logic is not supposed
to happen in unpack_trees_rec() in the current code structure;
instead, that decision is to be made by o->fn().

So, I am not sure if it is that quite easy.
