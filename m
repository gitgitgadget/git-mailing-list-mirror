From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git reflog show
Date: Mon, 25 Dec 2006 10:07:31 -0800
Message-ID: <7vwt4fj1cs.fsf@assigned-by-dhcp.cox.net>
References: <20061223101956.GD9396@spearce.org>
	<7v4prmsxjl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612231552140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061224061151.GE7443@spearce.org>
	<Pine.LNX.4.63.0612241333280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v1wmpq83g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612251449140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 25 19:07:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyuEp-0006v2-1H
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 19:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWLYSHd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 13:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWLYSHd
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 13:07:33 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:53054 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbWLYSHc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 13:07:32 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061225180732.FRQZ15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Mon, 25 Dec 2006 13:07:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 366o1W0071kojtg0000000; Mon, 25 Dec 2006 13:06:48 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612251449140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 25 Dec 2006 15:01:54 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35392>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Also I highly doubt visualization based on parents information rewritten 
>> to match the reflog order is of _any_ use.  By rewriting the parenthood, 
>> you are losing the topology and your visualization is no better than 
>> what "tac .git/logs/$ref" would give.
>
> Okay, but if they are _not_ rewritten, we can reuse the log machinery to 
> show the revisions in "upstream..master@{2.hours.ago}", but in the order 
> they came into the local repository.

Shawn's code was about showing where the tip of the branch was,
and I think you are talking about something entirely different,
which I would address later.

A sensible way to reuse existing code to implement Shawn's one
is to add the revisions to rev.pending, and iterate over that
array like "git show" does.  This does not need to touch the
existing revision walking code at all.  The most valuable parts
of the revision walking code are about ancestry traversal and
history simplification with pathspec, neither of which makes
much sense to use when "walking" reflog.  Reflog walking might
want to use the filtering by commit_match() but then it is only
the matter of renaming the function to a bit more specific name
and exporting it.

You can largely reuse the display side of the code that way, and
I think you should be able to hook into the code without making
it too specific to the reflog (perhaps using object->util and/or
a callback) if you need to give extra information (e.g. comments
and commit information from the log).

But it _also_ makes sense to use reflog when the primary thing
we are interested in seeing is not how the tip jumped around,
but seeing how the branch acquired commits, which I think is
what you are suggesting.  What we would want to have is a sort
order different from the existing topo or date, which is "reflog
order".  While I think it makes sense, a naive implementation
would be somewhat expensive.  Instead of sorting topologically
at the end of prepare_revision_walk (you would need to limit the
list if you do this), for each commit, you binary search the
reflog entries to find the earliest one that is the ancestor of
the commit, and use the reflog entry's timestamp as the age of
the commit (it's the first time the branch saw that commit), and
sort commits using that.
