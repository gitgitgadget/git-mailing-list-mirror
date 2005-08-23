From: Carl Baldwin <cnb@fc.hp.com>
Subject: [RFC] Removing deleted files after checkout
Date: Tue, 23 Aug 2005 10:21:56 -0600
Organization: Hewlett Packard
Message-ID: <20050823162156.GA32240@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
X-From: git-owner@vger.kernel.org Tue Aug 23 18:23:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7bXF-0004HM-94
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 18:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVHWQV6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 12:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbVHWQV6
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 12:21:58 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:55504 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1750823AbVHWQV5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 12:21:57 -0400
Received: from smtp1.fc.hp.com (smtp1.fc.hp.com [15.15.136.127])
	by atlrel7.hp.com (Postfix) with ESMTP id 3253A789
	for <git@vger.kernel.org>; Tue, 23 Aug 2005 12:21:57 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP id D42C138157
	for <git@vger.kernel.org>; Tue, 23 Aug 2005 16:21:56 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id B96602B0D2; Tue, 23 Aug 2005 10:21:56 -0600 (MDT)
To: git@vger.kernel.org
Content-Disposition: inline
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I recently started using git to revision control the source for my
web-page.  I wrote a post-update hook to checkout the files when I push
to the 'live' repository.

In this particular context I decided that it was important to me to remove
deleted files after checking out the new HEAD.  I accomplished this by running
git-ls-files before and after the checkout.

Is there a better way?  Could there be some way built into git to easily
find out what files dissappear when replacing the current index with one
from a new tree?  Is there already?  The behavior of git should NOT
change to delete these files but I would argue that some way should
exist to query what files disappeared if removing them is desired.

Here is some code that I wrote for this.  It feels a bit hackish to me but I
couldn't think of anything better.  Comments and criticism are welcome.

#!/bin/sh

# HEAD changed so checkout the new HEAD deleted any files that should no longer
# be around.
oldlist=$(tempfile)
newlist=$(tempfile)
removedlist=$(tempfile)

git-ls-files | sort -r > $oldlist
git-checkout-script -f
git-ls-files | sort -r > $newlist

diff -u $oldlist $newlist |
  tail -n +4 |
  sed -n 's/^-//p' > $removedlist

# Remove each file
cat $removedlist | xargs -rl rm -f
# Remove the directories if empty
cat $removedlist | xargs -rl dirname | xargs -rl rmdir -p --ignore-fail-on-non-empty

rm -f $oldlist $newlist $removedlist

# --- snip ---

If you are interested I attached the full post-update hook script that I
actually use to do this.  Again, comments are welcome.

Thanks,
Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=post-update

#!/bin/sh

export PATH=/usr/local/bin:/usr/bin:/bin

# cd to the root of the project directory (assume one dir up from GIT_DIR)
cd $GIT_DIR/..
unset GIT_DIR

# Set up some temporary files and a trap to delete them
oldlist=$(tempfile)
newlist=$(tempfile)
removelist=$(tempfile)
trap "rm -f $oldlist $newlist $removelist" 0 1 2 3 15

# Get list of files from the current index
git-ls-files | sort -r > $oldlist

# Checkout the index to the working directory
git-checkout-script -f

# Get list of files from the current (new) index
git-ls-files | sort -r > $newlist

# Use diff to determine which files to remove from the working copy
diff -u $oldlist $newlist |
  tail -n +4 |
  sed -n 's/^-//p' > $removelist

cat $removelist | xargs -rl rm -f
cat $removelist | xargs -rl dirname | xargs -rl rmdir -p --ignore-fail-on-non-empty

--UlVJffcvxoiEqYs2--
