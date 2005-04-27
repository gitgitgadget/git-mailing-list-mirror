From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Finding file revisions
Date: Wed, 27 Apr 2005 15:19:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504271506290.18901@ppc970.osdl.org>
References: <200504271251.00635.mason@suse.com> <Pine.LNX.4.58.0504271027460.18901@ppc970.osdl.org>
 <200504271423.37433.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 00:46:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQvHo-0007DD-UF
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 00:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVD0WTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 18:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVD0WSt
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 18:18:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:53903 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262052AbVD0WR3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 18:17:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3RMHPs4020795
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 15:17:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3RMHOqw013057;
	Wed, 27 Apr 2005 15:17:25 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504271423.37433.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 27 Apr 2005, Chris Mason wrote:
> 
> So, new prog attached.  New usage:
> 
> file-changes [-c commit_id] [-s commit_id] file ...
> 
> -c is the commit where you want to start searching
> -s is the commit where you want to stop searching

Your script will do some funky stuff, because you incorrectly think that
the rev-list is sorted linearly. It's not. It's sorted in a rough
chronological order, but you really can't do the "last" vs "cur" thing
that you do, because two commits after each other in the rev-list listing
may well be from two totally different branches, so when you compare one
tree against the other, you're really doing something pretty nonsensical.

diff-tree will happily compare trees that aren't related, so it will 
"work" in a sense, but it doesn't actually do what you think it does ;)

So what you should do is basically something like

	open(RL, "rev-list $commit|") || die "rev-list failed";
	while(<RL>) {
		chomp;
		my $cur = $_;

(so far so good) but then you should look at the _parents_ of that 
commit, ie do (NOTE NOTE NOTE! I'm a total perl idiot, so I'm not going to 
do this right):

		open(PARENT, "cat-file commit $cur") || die "cat-file failed");
		while(<PARENT>) {
			chomp;
			my @words = split;
			if ($words[1] == "tree")
				continue;
			if ($words[1] != "parent")
				break;
			test_diff($cur, $words[2]);
		}
		close(PARENT);
	}
	close(RL);

and now your "test_diff()" thing can do the tree diff.

That way you actually do "tree-diff" on the thing you should do, and it 
will show you _which_ way it changed in a merge (ie if you hit a 
merge-point, it will do a tree-diff against both parents, and show you 
which one had the difference - then you'll obviously usually see that same 
difference later on when you dig down to the actual changeset that did it 
too).

Remember: time is not a nice linear stream.

		Linus
