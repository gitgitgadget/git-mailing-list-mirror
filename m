From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git reflog show
Date: Tue, 26 Dec 2006 11:03:55 -0800
Message-ID: <7v64byfpic.fsf@assigned-by-dhcp.cox.net>
References: <20061223101956.GD9396@spearce.org>
	<7v4prmsxjl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612231552140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061224061151.GE7443@spearce.org>
	<Pine.LNX.4.63.0612241333280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v1wmpq83g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612251449140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vwt4fj1cs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612261654330.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 26 20:04:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzHal-00058K-7F
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 20:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbWLZTD5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 14:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932761AbWLZTD5
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 14:03:57 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:62590 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932754AbWLZTD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 14:03:56 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061226190356.UCGO19398.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Dec 2006 14:03:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3X481W00g1kojtg0000000; Tue, 26 Dec 2006 14:04:09 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612261654330.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 26 Dec 2006 17:14:06 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35426>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Shawn's code was about showing where the tip of the branch was,
>> and I think you are talking about something entirely different,
>> which I would address later.
>
> If I read Shawn's mail correctly, it is not only about the tip.

What I meant was that I did not see anything that mentions
"$ref@{ago}~47" and such; what was shown was only about the
transition between the tip.


>> The most valuable parts of the revision walking code are about ancestry 
>> traversal and history simplification with pathspec, neither of which 
>> makes much sense to use when "walking" reflog.
>
> Sorry to be a PITA here, but I think that it _would_ make sense. Quite 
> often I ask myself "That feature in this file used to work. When and how 
> was it changed?" Right now, I use git-log with path simplification, but 
> with reflog walking, I could ask in a more specific way!

When you put it that way, it sort of makes sense.  Right now,
get_revision() walks the chain of commits using the parent links
and the history simplification (try_to_simplify_commit) looks at
each commit and compares the tree with its parents' trees to
decide if the commit is worth considering.

If we _had_ an object type "reflog entry" which has one "parent
reflog entry" field and an associated "tip commit" object, just
like a commit object has zero or more "parent commit" field and
an associated "tree" object, the same algorithm could be taught
to follow the "parent reflog entry" chain while walking and look
at the tree associated with "tip commit" for the history
simplification purposes.

I am not proposing to introduce a new object type here, but
conceptually we could.  Maybe a quick hack would be to represent
each reflog entry as a phony "struct commit" in core,

 1. whose tree is taken from the tree of the tip commit,

 2. whose buffer is handcrafted by the true commit log message
    with data from reflog, and

 3. whose parent list points at another phony "commit" that
    represents ref@{N+1} reflog entry.

Then we would give a new populate_parent() member to "struct
revinfo" which is called instead of parse_object() to fill the
commit's parent list before traversal.  With 1. we do not have
to touch any code for history simplification, with 2. we do not
have to touch pretty-print-commit (the result would include
whatever reflog wants to add in the message automatically), and
with 3. plus populate_parent callback would give us the
traversal.

>> But it _also_ makes sense to use reflog when the primary thing we are 
>> interested in seeing is not how the tip jumped around, but seeing how 
>> the branch acquired commits, which I think is what you are suggesting.  
>> What we would want to have is a sort order different from the existing 
>> topo or date, which is "reflog order".
>
> I think it should not be a different sort order. As you pointed out 
> yourself, a "git reset --hard HEAD^" removes the assumption of the commit 
> list being a DAG.

I think I misunderstood your proposal and the misunderstanding
resulted in an unrelated useful enhancement ;-).  If HEAD@{0}
and HEAD@{2} points at the same commit, then obviously commits
reachable from that commit did not come into the branch no later
than HEAD@{2} time (what HEAD@{0} says becomes irrelevant), so
you can define an order that lists commits in the order the
earliest time they appeared on a branch.
