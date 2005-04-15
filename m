From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 12:57:34 -0700
Message-ID: <7vr7hbhky9.fsf@assigned-by-dhcp.cox.net>
References: <20050414002902.GU25711@pasky.ji.cz>
	<20050413212546.GA17236@64m.dyndns.org>
	<20050414004504.GW25711@pasky.ji.cz>
	<Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
	<7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Christopher Li <git@chrisli.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 21:54:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMWtI-0007ck-1a
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 21:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVDOT5o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 15:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVDOT5o
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 15:57:44 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:39652 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261946AbVDOT5j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 15:57:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050415195736.MYLM7956.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Apr 2005 15:57:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 14 Apr 2005 01:06:56 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> In the meantime I wrote a very stupid "merge-tree" which
LT> does things slightly differently, but I really think your
LT> approach (aka my original approach) is actually a lot
LT> faster. I was just starting to worry that the ball didn't
LT> start, so I wrote an even hackier one.

LT> ... This "one directory at a time with very explicit output"
LT> thing is much more down-to-earth, but it's also likely
LT> slower because it will need script help more often.

I was looking at merge-tree.c last night to add recursive
behaviour (my favorite these days ;-) to it [*1*].

But then I started thinking.

LT> ... For each entry in the directory it says either
LT> 	select <mode> <sha1> path
LT> or
LT> 	merge <mode>-><mode>,<mode> <sha1>-><sha1>,<sha1> path
LT> depending on whether it could directly select the right object or not.

Given that the case you are primarily interested in is the one
that affects only small parts of a huge tree (i.e. common kernel
merge pattern I understand from your previous messages), your
"hacky version" [*2*], extended for recursive operation, would
spit out 98% select and 2% merge, and probably the origin of
these selects are distributed across ancestor=90%, his=4%,
my=4%, or something similar.  Am I misestimating grossly?

Assuming I am correct in the above, this would not scale for a
huge project.  We need to cut down the number of "90% select"
part of the output to make it manageable.

I am thinking about:

 - adding recursive behaviour (I am almost done with this);

 - adding another command line argument to merge-tree.c, to 
   tell "do not output anything for the path if the resulting
   merge is the same as what is in this tree";

 - adding another output type, "delete" to make the output type
   repertoire these three:

    delete path
    select <mode> <sha1> path
    merge <mode>-><mode>,<mode> <sha1>-><sha1>,<sha1> path

When the user of the output of 

  $ merge-tree <ancestor-sha1> <my-sha1> <his-sha1> <result-base-sha1>

want to get a dircache populated with the merged result, he can:

  1. read-tree <result-base-sha1>
  2. for each output:
     a) "delete" -- delete path from dircache
     b) "select" -- register mode-sha1 at path
     c) "merge"  -- do the 3-way merge and register result at path

Do you think this is sensible?

The reason I have the separate <result-base-sha1> instead of
always using <ancestor-sha1> is because the user may be thinking
of patching an existing base which is different from "my" or
"his" or "ancestor" and doing it in place.  That way, probably
Pasky's SCM can use it to patch the dircache it creates in its
own ,,merge/ directory, which would most likely be initially
populated from the dircache in the user's working directory---
which may or may not match "my-sha1" if the user has uncommitted
update-cache there.

Pasky, do you think this is workable?  If so do you think this
would make your life easier?


[Footnotes]

*1* That's how I found the S_IFDIR problem (not in your tree but
in the copy I had).

*2* I did not find it quite "hacky".  It was a pleasant read.
Especially I liked "smaller()" part.


