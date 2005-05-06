From: Junio C Hamano <junkio@cox.net>
Subject: GIT blame (was Re: Quick command reference)
Date: Fri, 06 May 2005 02:32:30 -0700
Message-ID: <7v3bt0em35.fsf_-_@assigned-by-dhcp.cox.net>
References: <17012.53862.704670.858276@cargo.ozlabs.ibm.com>
	<4274EB3D.2060602@dgreaves.com> <4274F373.6030001@khandalf.com>
	<4274FB3F.8090206@dgreaves.com>
	<Pine.LNX.4.58.0505010927040.2296@ppc970.osdl.org>
	<42750D06.70004@dgreaves.com>
	<7vhdhgeuj1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Greaves <david@dgreaves.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 11:26:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTz5q-0003Wa-C4
	for gcvg-git@gmane.org; Fri, 06 May 2005 11:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVEFJcg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 05:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVEFJcg
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 05:32:36 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:44493 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261172AbVEFJcc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 05:32:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050506093232.QYXH7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 May 2005 05:32:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vhdhgeuj1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 05 May 2005 23:30:10 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> I == Junio C Hamano <junkio@cox.net> said:

JCH> Linus, please pull from git-jc.git archive at:
JCH>     http://members.cox.net/junkio/git-jc.git/

Since that message I have added a couple more commits there.
One of the things is a backport of -t (tag) flag to git-ls-files
from Cogito fork.

The reason I am writing this message is not because I am excited
about the backport [*1*], but because I find it quite cool the
way I found out which commit in Pasky's development line
introduced the change.  It demonstrates your previous "renames
does not matter when doing CVS blame" argument actually works.

Here is what I did:

  1. Go into git.pasky and look at ls-files.c, grab a couple of
     lines that look particular to Cogito version and store
     those lines in a file.  I used the following:

     $ cat >pattern <<\EOF
     static const char *tag_cached = "";
     static const char *tag_unmerged = "";
     static const char *tag_removed = "";
     static const char *tag_other = "";
     EOF

  2. Run the following command:

     $ jit-search-change HEAD pattern

What jit-search-change does is essentially what you described in
your "renames do not matter" argument.  It does git-rev-list to
list the commits from newer to older, runs git-diff-tree between
parent-commit pairs, with GIT_EXTERNAL_DIFF set to a script that
shows the diff between corresponding file in these two trees
only if the file from one tree has that pattern string and the
other tree's does not.  When it shows this diff, it also reports
the commit pair, and that's how you can find out which commit
introduced that change.

It currently shows useless hits when it sees merges from you to
Cogito, since those merges re-introduces the same change by
forward porting it over and over, which I am thinking about ways
to cull.  Maybe limiting the search only to parent-commit pair
that has only one parent would be good enough.  There are other
things to improve, but I am reasonably happy how it worked out.

[Footnote]

*1* The reason for the backport is because it is so small and
trivial change that does not affect the operation of the command
when the flag is not used.  I do not see a reason to force Pasky
to keep shipping the version modified for Cogito use.

