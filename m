From: Junio C Hamano <junkio@cox.net>
Subject: Re: Three-way merge with the index as one way
Date: Thu, 03 Nov 2005 13:21:27 -0800
Message-ID: <7v8xw5ctrc.fsf@assigned-by-dhcp.cox.net>
References: <20051015174103.GA2609@tumblerings.org>
	<7vu0fimzhn.fsf@assigned-by-dhcp.cox.net>
	<20051015192720.GA11364@tumblerings.org>
	<7v8xwummtm.fsf@assigned-by-dhcp.cox.net>
	<20051103003423.GH1431@pasky.or.cz>
	<7vy846ma65.fsf@assigned-by-dhcp.cox.net>
	<20051103202125.GK1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zack Brown <zbrown@tumblerings.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 22:23:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXmWb-0002aU-Io
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 22:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030491AbVKCVVa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 16:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030492AbVKCVVa
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 16:21:30 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:62155 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030491AbVKCVV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 16:21:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051103212110.XVXP16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Nov 2005 16:21:10 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051103202125.GK1431@pasky.or.cz> (Petr Baudis's message of
	"Thu, 3 Nov 2005 21:21:25 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11097>

Petr Baudis <pasky@suse.cz> writes:

>> git-am 3-way fallback logic constructs a sparse
>> temporary tree and uses it for running regular 3-way, and you
>> may be able to do something similar.
>
> I'm confused now - if the tree is sparse, how does git-read-tree -m know
> that the missing files from the other tree are not deletes?

The git-am 3-way fallback works like this:

    - the patch did not apply to our current head cleanly.

    - however, we have all the original blobs, recorded on
      'index xxxxxxx..xxxxxxx' line of the patch.

    - construct a temporary tree T0 that has only paths affected
      by that patch, with the original blobs.

    - apply the patch to T0 to construct another temporary tree
      T1.

    - 3-way merge our current head and T1, pretending as if T0
      is our common ancestor.  I.e. "read-tree -m -u T0 HEAD T1"

The paths that did not change by the patch (in your case, the
paths without local modification before tree-warp) are not
present in either T0 or T1, so the 3-way merge in the last step
would see that our current head added those paths while T0->T1
transition kept their absense intact --- which results in
added-in-one-side-only.

I think the problem you are solving would be solved by what I
suggested in the earlier message, but probably always doing that
may not be the optimum solution.

    - the working tree (and index) is derived from HEAD, but may
      not match HEAD (local modifications).

    - you want to tree-warp to T1, doing an equivalent of
      "read-tree -m -u HEAD T1" but preserving the local
      modifications.

You would want a merge between INDEX and T1 using HEAD as the
common ancestor (INDEX is a tree that your user would get if all
the local modification in the working tree were registered with
update-index and then git-write-tree were run).

	 INDEX
        /
    HEAD
        \
         T1

Two-tree form of read-tree -m -u should work as long as
differences between HEAD and INDEX do not interfere with
HEAD->T1 transition.  So you probably would first want to try
"read-tree -m -u HEAD T1", and use the 3-way fallback I
described earlier when it fails?

> But if they don't match, you'll get superfluous blobs for the original
> index versions which are almost certain to go away.

Another way of putting it is that I would not particularly worry
about those dangling blobs and trees -- that's what we have 'git
prune' for.
