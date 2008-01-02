From: Charles Bailey <charles@hashpling.org>
Subject: Re: Stitching together private svn repo and public git repo
Date: Wed, 2 Jan 2008 21:40:05 +0000
Message-ID: <20080102214005.GA10924@hashpling.org>
References: <C3A195B5.10839%jefferis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gregory Jefferis <jefferis@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 22:40:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JABKJ-0003Ak-Au
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 22:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029AbYABVkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 16:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752746AbYABVkM
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 16:40:12 -0500
Received: from pih-relay04.plus.net ([212.159.14.131]:33611 "EHLO
	pih-relay04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbYABVkL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 16:40:11 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1JABJq-0004bd-TA; Wed, 02 Jan 2008 21:40:11 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m02Le6CZ013878;
	Wed, 2 Jan 2008 21:40:06 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m02Le64S013877;
	Wed, 2 Jan 2008 21:40:06 GMT
Content-Disposition: inline
In-Reply-To: <C3A195B5.10839%jefferis@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69493>

On Wed, Jan 02, 2008 at 07:25:41PM +0000, Gregory Jefferis wrote:
> 
> Right now I have been trying to pull B into A to splice:
> 
> A $ git checkout v1.91
> B $ git checkout v1.91-manualmerge
> B $ git pull --no-commit -s ours ../A

So you have something like this in B:

Av1* -- Av1_b -- Av1_c -- Av1_d -- Av2_d* -- Av2_e -- Av3_e*

Where the * are manual merges of the offical Avn releases...

And you want this:

Av1   --       --       -- Av2   --      -- Av3
  \                          \                \
  Av1_b -- Av1_c -- Av1_d -- Av2_d -- Av2_e -- Av3_e  ???

This is a "rewrite history" job as parent lists are part of each
commit.  (See Linus' big bold-face warning about history re-writes.)

First of all I would add a remote for the 'A' repository so that those
commits are available in the 'B' repository.

Something like:
git remote add repoA /path/to/A
git fetch repoA

You could then do this with a 'git filter-branch --parent-filter' to
rewrite the parents of the merge commits.  As far as I can see, you
would need to call filter-branch once per merge to rewrite everything
from the merge commit forwards.  At this point all later commits would
have different ids, so attempting to rewrite subsequent parent-ids in
the same filter-branch invocation is probably futile.

It might be possible to use an intelligent script in a single
--commit-filter invocation of filter-branch, but the script of the
actual filter would have to be a bit (a lot!) more sophisticated,
remember the ids of the new commits as it created them with 'git
commit-tree' and merging in the repoA parents at the right points.

Leaving that aside and concentrating on the multiple filter-branch
invocation option... for example, the first parent-filter script could
be:
sed -e 's/^$/-p <commit id of Av1>/'

( This is if you want your exisiting tree to branch from Av1 in the
original repo.  If you wanted to replace your tree root with a root at
Av1, because your current root is just a copy of Av1 then you want:
sed -e 's/<commit id of repoB's Av1 copy>/<commit id of Av1 in A>/'
)

Then, for whatever the Av2_d commit's new id is, you could do a
parent-filter of:
sed -e 's/\(<new commit id of Av1_d>\)/\1 -p <commit id of Av2>/'

This causes the Av2_d commit to be rewritten, maintaining its original
parent and adding another parent which comes from repoA.  It then
rewrites all the descendent commits of Av2_d to take account of this
new commit id and all the subsequent new commit ids.

Now you can do similar for the next merge commit:
sed -e 's/\(<new commit id of Av2_e>\)/\1 -p <commit id of Av3>/'

As noted, you end up with completely new commit objects with a
completely new history, so you will screw everyone who is
pulling/cloning from you.

Charles.
