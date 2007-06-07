From: kurt_p_lloyd <kplloyd@alcatel-lucent.com>
Subject: Re: pull/merge --no-commit
Date: Thu, 07 Jun 2007 14:31:25 -0400
Message-ID: <46684EFD.1080804@alcatel-lucent.com>
References: <46678909.10608@alcatel-lucent.com> <7vfy54qqu8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 20:32:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwMmG-0003dQ-3k
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 20:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761257AbXFGScF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 14:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761368AbXFGScF
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 14:32:05 -0400
Received: from ihemail4.lucent.com ([135.245.0.39]:52894 "EHLO
	ihemail4.lucent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761257AbXFGScE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 14:32:04 -0400
Received: from homail.ho.lucent.com (h135-17-192-10.lucent.com [135.17.192.10])
	by ihemail4.lucent.com (8.13.8/IER-o) with ESMTP id l57IVVso007996;
	Thu, 7 Jun 2007 13:31:32 -0500 (CDT)
Received: from cde1806.inse.lucent.com (cde1806.inse.lucent.com [152.148.202.141])
	by homail.ho.lucent.com (8.11.7p1+Sun/8.12.11) with ESMTP id l57IVPI17629;
	Thu, 7 Jun 2007 14:31:31 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.0 (X11/20070425)
In-Reply-To: <7vfy54qqu8.fsf@assigned-by-dhcp.cox.net>
X-Scanned-By: MIMEDefang 2.57 on 135.245.2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49377>

comments intermixed below

Junio C Hamano wrote:
 > kurt_p_lloyd <kplloyd@alcatel-lucent.com> writes:
 >
 >> I run:      git pull --no-commit ssh://<blah blah blah>
 >>
 >> then I run: git status
 >>
 >> it says:    nothing to commit (working directory clean)
 >>
 >> then I run: git log
 >>
 >> it shows the commit message from the other user below a
 >> commit sha1, and the change I pulled was indeed merged to
 >> my file.
 >>
 >> Does this seem to be a bug, or am I doing something wrong?
 >
 > No bug, no user error.
 >
 > I suspect you did not have _ANY_ of your own development.

Spot on :)

 > If that is the case, then it worked as you told it to.  You asked
 > no merge commit to be made, and it did not create a new merge
 > commit.

Ah, the difference in terminology biting me here .... I'm used to
ClearCase, where the term "merge" includes so-called "trivial merges",
where a change is merely copied from one branch to another,
with no parallel changes on the receiving branch.

 > Illustration.  Earlier you had (probably your git-clone created
 > this) this history:
 >
 >  ---A---B---C---D
 >                 ^ HEAD
 >
 > and your tip of the branch (and HEAD) was at commit D.  You did
 > not do any of your own development yourself, and then you pulled.
 >
 > In the meantime, the other repository had been busily working
 > and has a few more commits:
 >
 >  ---A---B---C---D---E---F---G---H
 >                 ^               ^
 >                 Your HEAD       The tip of the branch you
 >                 was here.       pulled is here.
 >
 > In this case, because you do not have anything new to add to the
 > history (remember, git history is a global DAG -- you and the
 > other repository are building it by pushing and pulling), we
 > move your HEAD to H (the tip of the branch you are pulling).
 > There is no need to create a new merge commit, with or without
 > the --no-commit option.  This is called "fast forward".

Except here's the model that I am trying to follow....
It seems that 'pull' can be partitioned into 3 separate responsibilities:

   1. Retrieve changes from the remote user's replica (without modifying
      any /local/ branches).
   2. Bring changes from "remote" into a local branch (without commit).
   3. Commit.

My thoughts are that if I could have these be 3 different, sequential steps,
after step 1 I could peruse the "database" to see what "remote" changed, and
whether or not I may like such changes, and would want to /consider/ "taking"
them.  If no then I do nothing.  If yes then I do step 2.
After step 2 I may find that I don't really like those changes after all.
I only commit if I really do like those changes.

I don't want to overdo it here on the ClearCase stuff, but this
scenario is one which is very natural in that system:

   1. multisite syncreplica
   2. cleartool merge  # even for "trivial merges"
   3. cleartool checkin (or cleartool uncheckout if I don't like the changes)

more way below

 > In a more interesting case, you will see a different behaviour.
 > Let's suppose you started from the same state (i.e. cloned up to
 > D), and built your own changes on top of it:
 >
 >                           Your HEAD
 >                           v
 >                   X---Y---Z
 >                  /
 >  ---A---B---C---D
 >
 > while the other repository had the same E...H development line.
 > You pull from them.  Remember, pull is a fetch followed by a
 > merge.  After the fetch, you get this:
 >
 >                           Your HEAD
 >                           v
 >                   X---Y---Z
 >                  /
 >  ---A---B---C---D---E---F---G---H
 >                                 ^
 >                                 The tip of the branch you
 >                                 pulled is here.
 >
 > This is not a "fast forward" situation and "git pull" would need
 > a new merge commit, like this:
 >
 >                           Your HEAD used to be here
 >                           v
 >                   X---Y---Z-------M <- A new merge commit
 >                  /               /     becomes HEAD
 >  ---A---B---C---D---E---F---G---H
 >                                 ^
 >                                 The tip of the branch you
 >                                 pulled is here.
 >
 > What --no-commit does is to prepare a tree to be used to create
 > the merge commit "M", without actually creating a commit.  So if
 > you did "git pull --no-commit", your HEAD would stay at Z and
 > your index and working tree is prepared to create the tree
 > suitable to be committed as "M".  After that, you have a chance
 > to make further changes to your working tree before creating a
 > commit with "git commit", to affect what is recorded in the
 > resulting merge commit "M".
 >
 > In the case of "fast forward", --no-commit still moves the HEAD,
 > and this is deliberate.  Imagine if we did not move the head.
 > Because the merge is "fast forward" in reality, what is left in
 > the index and the working tree to be committed should exactly
 > match what is in H.  You may futz with the working tree further
 > before actually creating the commit, and the next "git commit"
 > would give you this graph:
 >
 >                   .---------------M
 >                  /               /
 >  ---A---B---C---D---E---F---G---H
 >                 ^               ^
 >                 Your HEAD       The tip of the branch you
 >                 is still here.  pulled is here.
 >
 > The difference between H and M is strictly what you did to the
 > index and the working tree between "pull --no-commit" and
 > "commit".
 >
 > That is insane.  Why?  Because what you really did was to start
 > from the tree of H, did your own development (i.e. "diff H M"),
 > and made a commit.  This is the reason why --no-commit does not
 > do anything special when the pull is a fast forward.
 >
 > The resulting history should not be the above merge, but just
 > like this:
 >
 >  ---A---B---C---D---E---F---G---H---M
 >
 > You did a "fast forward", and did your own development to make a
 > single commit, which is what this history should look like.
 > There was no merge performed.  Just a straight line of
 > development on top of what you got from the other side.

I must compliment you on your excellent communication.
Maybe there is a different workflow to effectively achieve what
I want via steps 1, 2, and 3 (way above).  In other words, OK I do
a 'pull', and all 3 steps occur together.  Then suppose that I
contemplate the changes that got committed, and that I disapprove
of either a majority or all of those changes.  I'd like to be able
to cleanly and easily recover from this with no related commits and
"revert commits" in git log.  I'll add my own deliberate commits if
and when I decide that I really /would/ like some or all of those
changes eventually, in which case I would still like the proper
context to exist in the "database" for me to bring the selective
remote changes into my local branch in a natural way.
Are there git commands to best cover this scenario?

Kind regards,
-Kurt
