From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Storing state in $GIT_DIR
Date: Thu, 25 Aug 2005 11:16:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508251053000.3317@g5.osdl.org>
References: <46a038f905082420323b025e3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 20:19:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8MH1-0006ik-D7
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 20:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbVHYSQR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 14:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVHYSQR
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 14:16:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29120 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751402AbVHYSQQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2005 14:16:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7PIG1jA026832
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 25 Aug 2005 11:16:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7PIG0mT028357;
	Thu, 25 Aug 2005 11:16:01 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f905082420323b025e3b@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7754>



[ Junio, the fact that you can't script the initial commit with "git 
  commit" is _really_ irritating. ]

On Thu, 25 Aug 2005, Martin Langhoff wrote:
>
> Is there a convention of where/how it is safe to store additional
> (non-git) data in $GIT_DIR?

There's no convention, but I have a suggestion.

> The arch import needs to keep a cache with arch-commit-id  =
> git-commit-id mappings, and some notes about what patch-trading Arch
> recorded. It'd be great to be able to store those in
> $GIT_DIR/archimport/ . Is that supported?

Git won't care, so it will work, but things like clone/pull etc also won't
actually ever look there, so it will only work for that one repo.

Now, I have what I consider a clever idea (I've mentioned variations on it 
before), but it's entirely possible that people hate it.

The thing is, I think you _do_ want to revision-control the git-commit-id
mappings, but at the same time, you do _not_ want to mess up the resulting
git commit history with arch information.

The reason you want to revision-control them is that that way you get them 
on clones, and you can use push/pull to update them. And the reason you 
don't want to mess up the commit history is that it's just wrong and ugly.

The git solution to this (which nobody has ever _used_, but which
technically is wonderful) is to have a "side branch" that does not share
any commits (or files, for that matter) in common with the "real branch",
and which is used to track any metadata. In fact, you can obviously have 
any number of side branches.

So that "metadata branch" is a real git branch in its own right, but it
doesn't share the same root as the "normal" branch, and it's really
totally independent: you can pull just the main branch (ie somebody who
isn't arch-aware and has no reason to want the arch mappings), or you
could pull just the metadata branch (for example, somebody who doesn't
want to use git, but is trying to match up a git commit ID to whatever
ID's arch uses).

The way to maintain a metadata branch is to have not only a different 
branch name (obviously), but also use a totally different index file, so 
that you can index both branches in parallell, and you don't actually need 
to check out one or the other.

Now, your arch import tools would then use the raw git commands explicitly 
to maintain the metadata branch. Every time you do an incremental import 
from an arch project, your import scripts would save away the mapping 
information into the metadata branch.

I'll make a _really_ stupid example for you, just to make this a bit more 
concrete:

	mkdir silly-example
	cd silly-example

	#
	# The normal "main branch": use regular git
	# infrastructure
	#
	git init-db
	echo "Hello" > file
	git update-cache --add file
	git commit -m "Main branch"

	#
	# The metadata branch: magic, very special stuff
	#
	echo "initial commit:" $(git-rev-parse HEAD) > .archdata
	GIT_INDEX_FILE=.git/archindex git-update-cache --add .archdata
	arch_index_tree=$(GIT_INDEX_FILE=.git/archindex git-write-tree)
	echo "arch index" | git-commit-tree $arch_index_tree > .git/refs/heads/arch-index

(Btw, the above example shows that the initial "git commit" won't take a 
"-m" flag, which is really irritating for scripts.)

Then do a "gitk --all", see the two different branches, and realize that 
the "arch-index" branch can now contain all the tracking information 
necessary to go back-and-forth. 

		Linus
