X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-add update with all-0 object
Date: Thu, 30 Nov 2006 22:20:10 -0800
Message-ID: <7vhcwgcf39.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611301634080.20138@iabervon.org>
	<Pine.LNX.4.64.0611301431420.3513@woody.osdl.org>
	<Pine.LNX.4.64.0611301749450.20138@iabervon.org>
	<20061201045727.GA22622@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 1 Dec 2006 06:20:51 +0000 (UTC)
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061201045727.GA22622@thunk.org> (Theodore Tso's message of
	"Thu, 30 Nov 2006 23:57:27 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32853>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq1lL-00035M-0f for gcvg-git@gmane.org; Fri, 01 Dec
 2006 07:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759120AbWLAGU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 01:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759156AbWLAGU1
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 01:20:27 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:54667 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1759131AbWLAGUL
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 01:20:11 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061201062011.XLBZ18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Fri, 1
 Dec 2006 01:20:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id tJLK1V00r1kojtg0000000; Fri, 01 Dec 2006
 01:20:20 -0500
To: Theodore Tso <tytso@mit.edu>
Sender: git-owner@vger.kernel.org

Theodore Tso <tytso@mit.edu> writes:

> The question then is how can we fix the "git diff" man page, and how
> do we explain "git diff" in a tutorial so that users can understand
> what in the world does it do?  For a starting point, I'd recommend
> moving the EXAMPLES to the beginning of the man page, and moving the
> any mention of git-diff-index, git-diff-files, and git-diff-tree to
> the very end of the man page, and to put the most commonly used
> options in the git-diff man page, so that most users don't have to
> look at the low-level plumbing man pages to figure out how the
> high-level git-diff works.  

All good points.  The only slight worry I have is that just
moving EXAMPLE up deviates from the traditional UNIX manpage
order of presenting information.

I think the plumbing manuals can (and probably should) stay as
the technical manual for Porcelain writers.  "git diff", "git
add" and friends that are clearly Porcelain should talk about
what it does in the terms of end user operation in the
DESCRIPTION section and puts less stress on how things work
behind the scene in technical terms.  For example, from
git-diff(1):

        DESCRIPTION
        -----------
        Show changes between two trees, a tree and the working tree, a
        tree and the index file, or the index file and the working tree.
        The combination of what is compared with what is determined by
        the number of trees given to the command.

That may be an accurate description of what the command does in
technical terms, but it does not tell why the user may want to
compare "a tree and the working tree".  The users would want to
know which case applies to their current situation and we should
make it easier for them to find that information.

For example, although --cached is technically speaking one of
the --diff-options, it should be separated out from other
options when we talk about 'git-diff'.  Also, although 'git-diff'
is designed to work on tree-ish, Porcelain users will use with
commit-ish (either a commit or an annotated signed tag that
points at a commit) 99.9% of the time, so we should mention
<tree-ish> at the end as a sidenote and talk about <commit>.

	DESCRIPTION
	-----------
	This command shows changes between four combinations 
	of states.

	* 'git-diff' [--options] [--] [<path>...]

          is to see the changes you made relative to the index
          (staging area for the next commit).  In other words, the
          differences are what you _could_ tell git to further add
          to the index but you still haven't.  You can stage
          these changes by using gitlink:git-update-index[1].

        * 'git-diff' [--options] --cached [<commit>] [--] [<path>...]

          is to see the changes you staged for the next commit
          relative to the named <tree-ish>.  Typically you would
          want comparison with the latest commit, so if you do
          not give <commit>, it defaults to HEAD.

        * 'git-diff' [--options] <commit> -- [<path>...]

          is to see the changes you have in your working tree,
          regardless of you staged them or not, relative to the
          named <commit>.

	* 'git-diff' [--options] <commit> <commit> -- [<path>...]

	  is to see the changes between two <commit>.

	Just in case if you are doing something exotic, it
        should be noted that all of the <commit> in the above
        descriptoin can be any <tree-ish>.

