From: linux@horizon.com
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
Date: 29 Apr 2006 12:51:51 -0400
Message-ID: <20060429165151.2570.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Sat Apr 29 18:51:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZsfj-0005fb-Ud
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 18:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWD2Qvw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 12:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWD2Qvw
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 12:51:52 -0400
Received: from science.horizon.com ([192.35.100.1]:34617 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750758AbWD2Qvw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Apr 2006 12:51:52 -0400
Received: (qmail 2571 invoked by uid 1000); 29 Apr 2006 12:51:51 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19308>

Boy, this is an interesting discussion!
On the one hand, it seems "obvious" to me that extra links might be
useful.  But Linus's minimalist points have a lot of merit.

I have to agree, it's important to think of a single practical use before
adding the feature.  So let's do a little brainstorming...


For just referring to another commit, there's no problem putting
it in the body.  A sensible porcelain GUI will, when it seems something
that looks like an object identifier in a comment, and that object
identifier exists, make it a clickable link.  So a comment like:

"This fixes the same problem as <commit>, but is a cleaner
(albeit more invasive) fix."

Would do the right thing: the user reading it could easily jump
to the other comment.  A "header" link as opposed to a "comment"
link just has the property of being unambiguous.  No heuristic
will guess that a link should exist when there isn't.

So, what is that property useful for?


Now, one thing that porcelains provide, in addition to "parent" links,
is "child" links.  Useful.  But it could be done with commit comment
links as well, and it's not clear that having the link in the commit
header as opposed to the comment would help much.  You still have to
find and uncompress part of each commit to generate the history
tree.  Does uncompressing the rest of it and running a heuristic
over the text for really cost that much?

I'm not convinced it's needed for that feature.  (I'd sooner argue for
never compressing commit objects in packs on the grounds that the
repeated uncompression while browsing is worth saving more than the
relatively minor disk space.)


So to be valuable, and inadvisable to express with a specially
formatted comment, it has to be something that would be Very Bad
to get wrong.  What qualifies?

Maybe some merge algorithm information?  If the merge could be told that
this change "is the same" as that change, so it can be skipped when
cherry-picking that branch, and the information was wrong, that could
cause lots of problems.

But given that git-cherry already uses (imperfect) heuristics to
detect already-merged patches, and they seem to work well enough, is
that a strong enough argument?  Is there some other merge application
where it would help?


Now, the "this other object should exist in the repository, and it's an
error if you can't fetch it" link obviously needs to be unambiguously
distinguished from, say, a reference to the (Linux kernel) dodecapus merge
in a git tree checkin comment.  But, as Linus says, what reason is there
for including it?  What do you need the commit in the repository for?

Well, the only reason that you need ANY commit in the repository is
because it's part of history, and comparing it with other versions is
meaningful.  So what trees, not already in the ancestry graph of a
given commit, are useful to compare to?  In particular, useful for some
automated process; manual comparisons can always be done manually.


Nothing's jumping out at me.  Any suggestions?
