From: Joey Hess <joey@kitenet.net>
Subject: finding unmerged branches
Date: Thu, 27 Aug 2009 18:02:41 -0400
Message-ID: <20090827220241.GA1413@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 00:12:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgnCK-0004Ai-Lz
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 00:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbZH0WLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 18:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753296AbZH0WLq
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 18:11:46 -0400
Received: from wren.kitenet.net ([80.68.85.49]:57639 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753271AbZH0WLq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 18:11:46 -0400
X-Greylist: delayed 529 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Aug 2009 18:11:46 EDT
Received: from gnu.kitenet.net (unknown [216.184.70.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id A1270314413
	for <git@vger.kernel.org>; Thu, 27 Aug 2009 18:02:57 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 6A390298020; Thu, 27 Aug 2009 18:02:41 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127223>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

My situation is this: My project has a lot of remotes with
lots of branches; about 250 branches in total. I want to
figure out which of these branches to look at to consider
merging.

So, I reach for git branch -a --no-merged master; that's what
its man page says its for. But this still finds 120 branches,
and a lot of them are not things I want to look at. Many of
them are copies of some of my own branches.

What I really want is a way to find remote branches that
are not merged with any of my local branches (or any origin
branches). A slow and stupid implementation of that is in the
attached git-unmerged script, and it weeds the branch list
down to 68 branches, which are mostly really ones I might
want to look at.

So, three questions:

* Is this situation somewhat common, or an I doing something wrong?
  (Assuming that I have a good reason to want to look at remote 
  branches rather than waiting to get merge requests.)
* Is there a better way to accomplish this than a slow perl script that
  runs git branch -r --merged foreach of my branches?
* Should git have something builtin to handle this case better?

-- 
see shy jo

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=git-unmerged

#!/usr/bin/perl

my @remote_branches = split ' ', `git branch -r | awk '{print $1}'`;

# have to filter out the "* "
my @local_branches = split ' ', `git branch | sed 's/^..//'`;

my @origin_branches = grep /^origin\//, @remote_branches;

my %unmerged = (map { $_ => 1 } @remote_branches),
	(map { $_ => 0 } @local_branches, @origin_branches);

foreach my $branch (@local_branches, @origin_branches) {
	map { $unmerged{$_}=0 } split ' ', `git branch -r --merged "$branch" | awk '{print $1}'`
}

foreach my $branch (sort keys %unmerged) {
	print "$branch\n" if $unmerged{$branch};
}

--Dxnq1zWXvFF0Q93v--
