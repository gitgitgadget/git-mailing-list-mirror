From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: RFC: working with sparse work-copy: where to start?
Date: Mon, 1 Jan 2007 11:24:13 +0200
Message-ID: <20070101092413.GB9114@mellanox.co.il>
References: <7vodpjdekh.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 01 10:24:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1JOo-0003v8-GQ
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 10:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbXAAJX6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 04:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753681AbXAAJX6
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 04:23:58 -0500
Received: from p02c11o146.mxlogic.net ([208.65.145.69]:44949 "EHLO
	p02c11o146.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbXAAJX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 04:23:57 -0500
Received: from unknown [63.251.237.3] (EHLO mtiexch01.mti.com)
	by p02c11o146.mxlogic.net (mxl_mta-4.0.1-5)
	with ESMTP id d23d8954.1983822768.134254.00-010.p02c11o146.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 01 Jan 2007 02:23:57 -0700 (MST)
Received: from mtlexch01.mtl.com ([10.0.8.11]) by mtiexch01.mti.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 1 Jan 2007 01:26:30 -0800
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 1 Jan 2007 11:26:10 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon,  1 Jan 2007 11:29:17 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodpjdekh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 01 Jan 2007 09:26:10.0328 (UTC) FILETIME=[DF94B180:01C72D86]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14908.002
X-TM-AS-Result: No--22.476200-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [63.251.237.3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35734>

> > Hi!
> > I've been thinking about working in a sparsely-populated work copy.
> > E.g. svn will let you do a checkout of a specific sub-directory
> > and do all your development there assuming you only care about
> > changes in that directory. Ideally, it would be possible to specify
> > a set of directories that I care about.
> > ...
> > What other commands need to be fixed for this to work?
> 
> Pretty much everything needs to be changed, I suspect.
> 
> The point of git is to track the whole tree, and that is
> ingrained to the design of the tool everywhere.  You need to
> bend backwards to operate in the way you propose; I am not
> saying it is impossible but I suspect it will be very hard or
> inefficient or both.
> 
> Your commits, although your working tree will only have selected
> subtrees in "wrong" places, should have the same "directory
> structure" as everybody else.  This is an absolute requirement
> for the result of your work in your repository to be usable by
> others.
> 
> One design level thing you need to worry about is what to do
> with merges, if you are pulling from more than one people and
> they start their work in different version of "the whole tree".
> You may not be interested in what happens in "other parts" of
> the whole tree you are not checking out.  For your merge result
> to be any useful for other people you later want to merge from
> you, you still have to come up with and record the sensible
> result when these "other parts" have conflicts.

Yes, I've been thinking about this problem. As far as the merge can be
done in-index it should be fine though. Maybe failing a merge if there are
merges that can't be done with the checked out subtree is the right thing to do.
But, this means that we should try harder to merge in-index
changes that touch non-checked-out files.

For example, a commit could touch a checked-out and non-checked out file,
and non-checked-out file could be index-mergeable but checked-out one
would need file level merge. Yes?

> This means the tree objects you will create as the final product
> has to have the same directory structure as other people, while
> your working tree will have only selected things, and in "wrong"
> (from the tree's perspective) places.
> 
> One decision you need to make early is which side you place your
> index on.
> 
> One approach would be to have the same directory structure in
> the index.  The other possibility is to match the directory
> structure recorded in the index with the structure of your
> working tree.  I am not sure pros-and-cons offhand.
> 
> Regardless of which avenue you pursue, you need to have a way to
> tell your version of git which subtree your repository is
> interested in, and where in your working tree you want to check
> them out.  And you would need to change affected commands to
> take this new information into account when do their work.
> 
> The former approach means you do not have to touch write-tree
> and read-tree, but your diff-index, diff-tree (when you want it
> to work sensibly inside subdirectories), checkout-index and
> update-index need to know about this.  The latter means you do
> not have to touch diff-files, update-index and checkout-index,
> but read-tree will be affected.  Any command that deals with
> both tree and working directory at the same time (diff-index,
> read-tree -u, merge-recursive, etc.) or works from a
> subdirectory (pretty much all Porcelain commands -- think of
> 'git add .' in a subdirectory) will need to change regardless of
> which approach is taken.
> 
> I think it would be a lot simpler if you do not mind deep
> directory structure but still support a sparse checkout,
> though.

OK, I don't mind the deep directory structure so much.

I'm sorry, Junio, but I'm a bit lost wrt which of your comments
are related to the directory structure change idea
(which it seems wise to drop) and which to the sparse checkout
support which might be more doable. Could you help please?

-- 
MST
