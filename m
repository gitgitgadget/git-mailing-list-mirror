From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pull/merge --no-commit
Date: Wed, 06 Jun 2007 22:24:47 -0700
Message-ID: <7vfy54qqu8.fsf@assigned-by-dhcp.cox.net>
References: <46678909.10608@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kurt_p_lloyd <kplloyd@alcatel-lucent.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 07:25:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwAUS-0002oo-FV
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 07:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910AbXFGFYt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 01:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756277AbXFGFYt
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 01:24:49 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:64650 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910AbXFGFYt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 01:24:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070607052447.LDVL14072.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 7 Jun 2007 01:24:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8VQn1X00e1kojtg0000000; Thu, 07 Jun 2007 01:24:48 -0400
In-Reply-To: <46678909.10608@alcatel-lucent.com> (kurt p. lloyd's message of
	"Thu, 07 Jun 2007 00:26:49 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49354>

kurt_p_lloyd <kplloyd@alcatel-lucent.com> writes:

> I run:      git pull --no-commit ssh://<blah blah blah>
>
> then I run: git status
>
> it says:    nothing to commit (working directory clean)
>
> then I run: git log
>
> it shows the commit message from the other user below a
> commit sha1, and the change I pulled was indeed merged to
> my file.
>
> Does this seem to be a bug, or am I doing something wrong?

No bug, no user error.

I suspect you did not have _ANY_ of your own development.  If
that is the case, then it worked as you told it to.  You asked
no merge commit to be made, and it did not create a new merge
commit.

Illustration.  Earlier you had (probably your git-clone created
this) this history:

 ---A---B---C---D
                ^ HEAD

and your tip of the branch (and HEAD) was at commit D.  You did
not do any of your own development yourself, and then you
pulled.

In the meantime, the other repository had been busily working
and has a few more commits:

 ---A---B---C---D---E---F---G---H
                ^               ^
                Your HEAD       The tip of the branch you
                was here.       pulled is here.

In this case, because you do not have anything new to add to the
history (remember, git history is a global DAG -- you and the
other repository are building it by pushing and pulling), we
move your HEAD to H (the tip of the branch you are pulling).
There is no need to create a new merge commit, with or without
the --no-commit option.  This is called "fast forward".

In a more interesting case, you will see a different behaviour.
Let's suppose you started from the same state (i.e. cloned up to
D), and built your own changes on top of it:

                          Your HEAD
                          v
                  X---Y---Z
                 / 
 ---A---B---C---D

while the other repository had the same E...H development line.
You pull from them.  Remember, pull is a fetch followed by a
merge.  After the fetch, you get this:

                          Your HEAD
                          v
                  X---Y---Z
                 /
 ---A---B---C---D---E---F---G---H
                                ^
                                The tip of the branch you
                                pulled is here.

This is not a "fast forward" situation and "git pull" would need
a new merge commit, like this:

                          Your HEAD used to be here
                          v
                  X---Y---Z-------M <- A new merge commit
                 /               /     becomes HEAD
 ---A---B---C---D---E---F---G---H
                                ^
                                The tip of the branch you
                                pulled is here.

What --no-commit does is to prepare a tree to be used to create
the merge commit "M", without actually creating a commit.  So if
you did "git pull --no-commit", your HEAD would stay at Z and
your index and working tree is prepared to create the tree
suitable to be committed as "M".  After that, you have a chance
to make further changes to your working tree before creating a
commit with "git commit", to affect what is recorded in the
resulting merge commit "M".

In the case of "fast forward", --no-commit still moves the HEAD,
and this is deliberate.  Imagine if we did not move the head.
Because the merge is "fast forward" in reality, what is left in
the index and the working tree to be committed should exactly
match what is in H.  You may futz with the working tree further
before actually creating the commit, and the next "git commit"
would give you this graph:

                  .---------------M
                 /               / 
 ---A---B---C---D---E---F---G---H
                ^               ^
                Your HEAD       The tip of the branch you
                is still here.  pulled is here.

The difference between H and M is strictly what you did to the
index and the working tree between "pull --no-commit" and
"commit".

That is insane.  Why?  Because what you really did was to start
from the tree of H, did your own development (i.e. "diff H M"),
and made a commit.  This is the reason why --no-commit does not
do anything special when the pull is a fast forward.

The resulting history should not be the above merge, but just
like this:

 ---A---B---C---D---E---F---G---H---M

You did a "fast forward", and did your own development to make a
single commit, which is what this history should look like.
There was no merge performed.  Just a straight line of
development on top of what you got from the other side.
