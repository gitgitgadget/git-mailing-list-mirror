From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Switching heads and head vs branch after CVS import
Date: Mon, 15 Aug 2005 09:42:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508150930020.3553@g5.osdl.org>
References: <20050815080931.64F0D352633@atlas.denx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 15 18:44:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4i2j-00025D-3r
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 18:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbVHOQma (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 12:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVHOQm3
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 12:42:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24287 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964835AbVHOQm2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 12:42:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7FGgMjA005367
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 Aug 2005 09:42:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7FGgKBZ031239;
	Mon, 15 Aug 2005 09:42:21 -0700
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050815080931.64F0D352633@atlas.denx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 15 Aug 2005, Wolfgang Denk wrote:
> 
> I asked this question before without receiving any reply:
> 
> Assume I know exactly where the merge back happenend - is  there  any
> way to tell git about it, so I don't see all these dangling heads any
> more?

You'd have to teach cvsimport about it. Basically, in cvsimport, you have

		...
                my @par = ();
                @par = ("-p",$parent) if $parent;

which sets the parent. Right now the parent is _always_ just the previous 
head of the branch we're committing to (I'm no good with perl, but I think 
Martin was wrong - there's no code to handle the case of a merge: once we 
branch off, "git cvsimport" will not currently ever create a 
merge-commit).

But if you have some heuristic for figuring out that it's a merge, and
know the other branch is, you could add more parents by just adding
another ("-p", $merge_parent) to the parameters to git-commit-tree.

The problem is literally how to figure out that it's a merge. You can 
probably make a guess from the commit message together with possibly 
looking at the diff. 

The good news is that if you guess wrong, and you claim a merge where none
exists, it doesn't really do any real damage. It might make th history
look strange, and it might make subsequent git merges harder if the branch
is actually still live and you want to continue development within git.
But even that is debatable (if the eventual git merge isn't trivial,
you're likely to have to merge by hand anyway - and it's going to be as
hard as a CVS merge would have been, because quite frankly, you've got the
same information CVS had..).

		Linus
