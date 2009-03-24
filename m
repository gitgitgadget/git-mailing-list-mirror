From: Jeff King <peff@peff.net>
Subject: Re: Adding a new file to all git branches
Date: Tue, 24 Mar 2009 02:31:31 -0400
Message-ID: <20090324063131.GA28636@coredump.intra.peff.net>
References: <f662f0210903232041p6f86b882of7b2d708946ea905@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Aneesh Bhasin <contact.aneesh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 07:34:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm0Dn-0004ET-G7
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 07:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643AbZCXGbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 02:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753432AbZCXGbl
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 02:31:41 -0400
Received: from peff.net ([208.65.91.99]:51893 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533AbZCXGbk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 02:31:40 -0400
Received: (qmail 27287 invoked by uid 107); 24 Mar 2009 06:31:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Mar 2009 02:31:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2009 02:31:31 -0400
Content-Disposition: inline
In-Reply-To: <f662f0210903232041p6f86b882of7b2d708946ea905@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114403>

On Tue, Mar 24, 2009 at 09:11:15AM +0530, Aneesh Bhasin wrote:

> I was wondering if it is possible to add a file to all the branches in
> a repository without individually checking out each branch ?
> 
> A possible use-case for such a scenario is say I have a git repository
> with various branches related to different features, versions or
> bug-fixes and I want to be able to add a README file which contains
> instructions/information common to all of those branches as of now
> (but may diverge in future). So, do I have to checkout each branch
> individually to add the same README file to all of them or is there a
> direct/indirect workaround ?

Not really.

You basically have three options:

 1. branch a new "README" line of development from some common ancestor
    of all branches, add the README, and then merge this new branch into
    your other branches

    The advantage of this approach is that you could actually keep the
    README branch around, making changes to it and merging it back into
    your other branches as appropriate.

    Of course, you asked about avoiding "checkout", and you will still
    have to checkout each branch to do the merge.

 2. For a one-off addition of such a README, it is probably simpler to
    just use a for loop with checkout:

      for i in branch1 branch2 branch3; do
        git checkout $i &&
        cp /path/to/README . &&
        git add README &&
        git commit -m 'add README'
      done

     Which again, obviously does checkout, but at least it's
     non-interactive. The biggest downside is that doing a full checkout
     between branches might be slow.

 3. You could also just iterate over the branches with plumbing, adding
    the README to each tree. Something like:

      hash=`git hash-object -w /path/to/README`
      for i in b1 b2 b3; do
        GIT_INDEX_FILE=index.$i; export GIT_INDEX_FILE
        git read-tree $i &&
        git update-index --add --cacheinfo 100644 $hash README &&
        tree=$(git write-tree) &&
        parent=$(git rev-parse $i) &&
        commit=$(echo added README | git commit-tree $tree -p $parent) &&
        git update-ref -m "commit: added README" refs/heads/$i $commit $parent
        rm $GIT_INDEX_FILE
        sleep 1
      done

    This is going to be faster, but obviously is much more complicated.

For a one-off addition, I would probably just do (2).

-Peff
