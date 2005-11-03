From: Junio C Hamano <junkio@cox.net>
Subject: Re: Three-way merge with the index as one way
Date: Thu, 03 Nov 2005 00:02:10 -0800
Message-ID: <7vy846ma65.fsf@assigned-by-dhcp.cox.net>
References: <20051015174103.GA2609@tumblerings.org>
	<7vu0fimzhn.fsf@assigned-by-dhcp.cox.net>
	<20051015192720.GA11364@tumblerings.org>
	<7v8xwummtm.fsf@assigned-by-dhcp.cox.net>
	<20051103003423.GH1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zack Brown <zbrown@tumblerings.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 09:03:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXa3J-0008VX-QT
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 09:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVKCICM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 03:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVKCICM
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 03:02:12 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:54715 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750800AbVKCICM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 03:02:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051103080123.LBMV11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Nov 2005 03:01:23 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051103003423.GH1431@pasky.or.cz> (Petr Baudis's message of
	"Thu, 3 Nov 2005 01:34:23 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11067>

Petr Baudis <pasky@suse.cz> writes:

> One approach is to take the working tree, construct a tree object from
> it and then run the regular three-way merge on that. But that is a waste
> of time and pollutes the database with nonsensical objects. The
> advantage is that I can reuse the per-file merge resolution script
> without any changes.

For a large tree, constructing a full tree just to merge a
couple of potentially conflicting paths might turn out be a
waste of time, but I suspect that is something you could
optimize later.  git-am 3-way fallback logic constructs a sparse
temporary tree and uses it for running regular 3-way, and you
may be able to do something similar.  Right now git-am takes an
e-mail patch and when it runs all the way it creates a commit,
but the core logic that applies patch and falls back to 3-way
could be separated out for your application.  Then you could:
(1) 'git diff HEAD' before tree-warp to preserve the user
changes, (2) clean up the working tree to match HEAD, (3) warp
to the other tree, and (4) fed the user change perserved to
git-am core logic.  That might give you something near optimum.

About "nonsensical" objects, I am not so sure how nonsensical
those objects you would record from the working tree
(intermediate state) are.  If you find two trees match on a path
that has changed in the working tree, there won't be any
conflict on that paths so it is like the user did an extra
git-update-index on that path when no merge or warp is involved,
from object database pollution POV; I do not personally think
that is such a bad thing.
