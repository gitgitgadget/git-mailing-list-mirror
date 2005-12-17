From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git tonight
Date: Sat, 17 Dec 2005 01:37:12 -0800
Message-ID: <7voe3g12uv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 17 10:37:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnYVG-0003kU-N7
	for gcvg-git@gmane.org; Sat, 17 Dec 2005 10:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVLQJhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Dec 2005 04:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVLQJhO
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Dec 2005 04:37:14 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:32740 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932261AbVLQJhN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2005 04:37:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051217093529.PWBQ17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Dec 2005 04:35:29 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13776>

Since 0.99.9n, there have been a couple of fixes and some
documentation updates.  One notable is that we do not allow '?',
'*' and '[' in ref names anymore --- this was done after the
list discussion with Pasky and friends.

Another notable is "We do not like HEAD branch" patch, but I've
been thinking seriously about reverting it and replace its
effect by also reverting the misguided attempt to disambiguate
branch names and tag names.  This patch with a commit message
will follow in a separate message; it currently lives in the
proposed updates branch.  One positive effect this change brings
is that it fixes a corner case bug/confusion Johannes mentioned
the other day while diagnosing the trouble Len had with his
repository (I do not think the problem has anything to do with
Len's trouble, though).  If you have a branch called "dead", and
you also have a tag called "dead", and if your repository has
only one object whose name begins with "dead"
(e.g. "deadbeef1234..."), "git rev-parse --verify dead" would
pick up the "deadbeef1234..."  object, not "dead" tag nor "dead"
head.  When no such object exists, "git rev-parse --verify dead"
fails, saying "dead" is ambiguous between heads and tags.  This
is just confused, and "reverting the misguided disambiguation"
change will make it pick up the "dead" tag in either case.  Most
likely I'll have it in "master" after further testing over the
weekend.

One important patch waiting in the proposed updates is to give
an option to git-fetch-pack to keep the downloaded pack without
unpacking it; this was primarily done to help Cogito, but I
haven't heard back about it from Pasky yet.  The primary
difference between this and the clone-pack change that is
already in the master branch, from the user's point of view, is
that git-fetch-pack can be efficiently used in an already
populated repository [*1*].  Imagine cloning "master" branch
from linux-2.6 repository of Linus, and then fetching ALL branch
from libata-dev repository of Jeff --- the difference is large
enough that you would want to keep the downloaded stuff packed,
while you do want to take advantage of the fact that you already
have objects from Linus.  Currently it saves exploding about a
~800K pack with 1100 objects in it.  Although I mentioned we are
supposed to be in deep feature freeze, I feel it is worth to
have this one in 1.0.


[Footnote]

*1* Theoretically we could deprecate git-clone-pack and use
git-fetch-pack exclusively, if we are willing to create refs
matching what the remote has in the wrapper script git-clone.
