From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bottlenecks in git merge
Date: Tue, 31 Jan 2006 15:06:57 -0800
Message-ID: <7vk6cgq9ny.fsf@assigned-by-dhcp.cox.net>
References: <20060131213314.GA32131@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 00:07:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F44aV-0000mp-OR
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 00:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWAaXG7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 18:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWAaXG7
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 18:06:59 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:19124 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750933AbWAaXG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 18:06:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060131230354.HNKD20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 Jan 2006 18:03:54 -0500
To: "Peter Eriksen" <s022018@student.dtu.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15360>

"Peter Eriksen" <s022018@student.dtu.dk> writes:

> Recursive (default):  4m22.282s
> Resolve (-s resolve): 3m23.548s
>
> What is taking so long?

I am actually surprised that recursive is not much slower than
resolve.  I expected to see bigger difference for a merge like
this.

> git checkout -b test v2.6.12
> change_readme
> git commit -a -m "Work, work, work"
> time git merge $STRATEGY "Merging happily." HEAD v2.6.15

You are merging a variant of v2.6.12 and v2.6.15.  Each of these
two official revisions has roughly 18,000 files, and they differ
at 10,723 files among them.

With an up-to-date index that has small changes from v2.6.12,
merging these two revisions using read-tree -m to do the trivial
merge (the part that comes before recursive/resolve) leaves
about 850 files to be resolved in the working tree.  For these
files, you need to do an equivalent of merge-one-file to merge
the differences (in this particular case, most of them are
"removed in one but unchanged in the other" kind).  In addition,
you have to checkout the result of the merge, which means you
need to update at least 10,723 files.

I suspect that it might make things quite faster if we resolved
case 8 and 10 (see either Documentation/technical/trivial-merge
or t/t1000) in index for this particular case, but it has
correctness issues.  A merge strategy may want to say "This file
was removed by the other branch while it stayed on our branch;
but this is not a remove but actually a rename", and do
something different from what merge-one-file does, and resolving
these cases in index closes the door for that possibility.
