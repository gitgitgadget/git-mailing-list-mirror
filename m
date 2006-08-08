From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-annotate bug report
Date: Tue, 08 Aug 2006 01:49:42 -0700
Message-ID: <7vvep3wr15.fsf@assigned-by-dhcp.cox.net>
References: <20060803203848.GA15121@coredump.intra.peff.net>
	<20060807115000.GC15477@h4x0r5.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 08 10:50:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GANHX-0002n0-ST
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 10:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbWHHIto (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 04:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWHHIto
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 04:49:44 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:38904 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932544AbWHHIto (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 04:49:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060808084943.UZAF12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Aug 2006 04:49:43 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20060807115000.GC15477@h4x0r5.com> (Ryan Anderson's message of
	"Mon, 7 Aug 2006 04:50:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25061>

Ryan Anderson <ryan@michonline.com> writes:

> Second, one I don't know how to fix, at the moment:
>
> git annotate uses the automatic tree simplification that git rev-list
> does.  So, when it sees a commit with 1 parent, it assumes that it
> really only has one parent.  git diff-tree -c doesn't know about this
> same tree simplification, and, in the case of a merge commit, will still
> output the -c format patch.

When a merge M between A and B is simplified to have only A as a
parent, that means the file in question are identical in M and
A.  So you can just pass all the remaining blame on to A without
letting M taking any blame for itself.  So you do not need to do
any diff at all for a simplified merge.

> There is, unfortunately, another situation, that of an octopus merge.
> In the case of read-tree.c (after the rename is followed), the commit
> 7bd1527d2d8c80a6e9a0f8583082a5aee5428c68 is problematic.  In it we have
> a 4-way merge, yet only 3 paths affected read-tree.c.  The diff-parsing
> in annotate constructs a regular expression to find the diff header and
> read out the line number to work on, and also to construct some regular
> expressions from which to tell which lines affect which parents.

If a merge is not simplified, and if you end up reading from
--cc or -c -p, then:

> For example, it looks for a line like:
> + ++Line added in 3 parents
> with dynamically generated regular expressions.

the merge needs to claim responsibility only for lines that have
all pluses (i.e. evil merge), which you are already doing, I
think.  Any line without a minus that has at least one space can
be blamed on the parent that corresponds to the space (and if
there are more than one space, pick the first one).

Your particular "octopus" case, I think, is the same story.

$ git diff-tree --pretty=short -p -c 7bd1527 -- read-tree.c builtin-read-tree.c

would give you a combined diff, none of which has $allparentplus
(so nothing should be attributed to this merge), and the header
would tell you which parent to pass the blame on from that
point.
