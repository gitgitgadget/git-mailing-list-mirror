X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [RFD] making separate-remote layout easier to use
Date: Sat, 25 Nov 2006 13:53:07 -0800
Message-ID: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 21:53:26 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32305>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go5SW-0001cz-EN for gcvg-git@gmane.org; Sat, 25 Nov
 2006 22:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967231AbWKYVxJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 16:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967232AbWKYVxJ
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 16:53:09 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:45199 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S967231AbWKYVxI
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 16:53:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061125215307.NOXJ5465.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Sat, 25
 Nov 2006 16:53:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id r9sc1V00K1kojtg0000000; Sat, 25 Nov 2006
 16:52:36 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Now separate-remote layout is the default for newly cloned
repositories, I think it is a good time to make further effort
to make things easier to use.  Here are some of the ideas off
the top of my head.

* Do not change what branch the sole local branch is named.

In the current implementation, we find out what branch the
remote HEAD points at, and match the name of the sole local
branch to it.  HEAD of most central distribution point
repositories that use git with the default configuration have
HEAD pointing at refs/heads/master and a cloned repository would
continue to use refs/heads/master as the sole local branch when
it starts as before, but some projects may use alternate
wordings such as 'main', and a new repository would have
refs/heads/main branch when cloned from such a repository
instead.  I think this behaviour is a reasonable default, so
let's keep this.

Distribution point repositories are of interest here, because
that is what most people clone from, and this message is about
making the default easier to use by those casual cloners.

* Change the default contents of $GIT_DIR/remotes/origin

Currently we list all the remote branches that exist when the
clone is made, making sure that the branch pointed at by HEAD at
the remote is listed first.  The intent is to track every branch
at the remote but merge in the "primary" branch to us.

Two issues that have been raised about this is:

 - the intent to track every branch is good, but the current
   implementation means we would not notice new branches at the
   remote.

 - merging the "primary" branch is good only when the user is on
   the corresponding "primary" branch.  It is usually a wrong
   thing to do when on another branch.

The first issue can be solved, with the help of recent "glob
pattern refspec in fetch" from Andy.  I am thinking about making
the default contents of $GIT_DIR/remotes/origin to be:

	URL: <url of the cloned repository>
	Pull: +refs/heads/<primary>:refs/remotes/<origin>/<primary>
	Pull: +refs/heads/*:refs/remotes/<origin>/*

to address this issue.

	Side note: <primary> is what HEAD pointed at at the
        remote when the clone was made, and <origin> is usually
        'origin' but "git clone -o $origin" can override it.

Forcing with '+' is debatable, but with separate-remote layout,
remotes/*/ hierarchy is to track what the remote has, and you
cannot do much else other than noticing and warning when the
remote end does funny things to its refs anyway, so I think
having '+' might be a better default.

The right thing to do to address the second issue is less clear.
If the "upstream" has two more-or-less equally prominent
branches, say 'main' and 'test', it may make sense to use
corresponding two branches on the local side and merge 'main'
from the remote when on local 'main' and merge 'test' when on
local 'test'.  Even when dealing with a specific topic branch,
that would hold true for most of the time.  A topic branch
refs/heads/bug#2073 to work on the bug 2073 can be published at
the central distribution point.  The proposed updates to
$GIT_DIR/remotes/origin file would track it with
refs/remotes/origin/bug#2073 and interested people can create a
local branch refs/heads/bug#2073 from it and work on it, which
makes it easy to polish a topic branch in a collaborative way.

I am not sure if 'merge in corresponding branch' is the only
valid workflow, however. I am reluctant to make the system
automatically do so if the solution makes other workflows more
painful to follow.  Automatically merging remotes/origin/$foo
when on $foo branch is not good enough, in other words (also,
there may be a hierarchy under remotes/ other than origin).  It
might make sense to introduce "Merge: " in remotes/ file and if
they are present use "Pull: " only to decide what are fetched
and use "Merge: " to decide what is merged (if we were doing the
system from scratch, the former would have been named "Fetch: "
but it is too late now).
