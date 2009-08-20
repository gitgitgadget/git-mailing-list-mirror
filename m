From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Issue with gitweb + tag + branch of the same name from master
	branch commit
Date: Thu, 20 Aug 2009 16:30:31 -0700
Message-ID: <1250811031.26147.42.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 01:35:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeHAe-0006vK-RM
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 01:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017AbZHTXfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 19:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754843AbZHTXfn
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 19:35:43 -0400
Received: from n18.bullet.mail.mud.yahoo.com ([68.142.206.145]:44057 "HELO
	n18.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754117AbZHTXfn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Aug 2009 19:35:43 -0400
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Aug 2009 19:35:43 EDT
Received: from [68.142.200.225] by n18.bullet.mail.mud.yahoo.com with NNFMP; 20 Aug 2009 23:30:33 -0000
Received: from [68.142.201.64] by t6.bullet.mud.yahoo.com with NNFMP; 20 Aug 2009 23:30:33 -0000
Received: from [127.0.0.1] by omp416.mail.mud.yahoo.com with NNFMP; 20 Aug 2009 23:30:33 -0000
X-Yahoo-Newman-Id: 592060.26841.bm@omp416.mail.mud.yahoo.com
Received: (qmail 40772 invoked from network); 20 Aug 2009 23:30:33 -0000
Received: from unknown (HELO ?192.168.0.119?) (nab@70.231.230.229 with plain)
  by smtp108.sbc.mail.sp1.yahoo.com with SMTP; 20 Aug 2009 23:30:32 -0000
X-YMail-OSG: fSO4tmYVM1l0ZIO6i3zUsBXmWEKPQott0ObWnbEHrJeoeE1ssTwCT7XRiIZ5AkWcBMXnpRSxmEBehvfgmpAs1CCCy1emOH5hBvoyJ1oG9fdgJ5talA3ASq26okLV5NS8hSP2r0ugXvllvKO7.3GjLrvFZN7EHt7Hvser5gDKtNE.F7uOj2AYcrmKi6Kj.sfbW1C.ZKafXhVHM.XV7DNNBgmLBYFsJR2pV14RhbQ.ztSb_X.5.txGkpzz.FDRK415eXs2TKbPPfZyFUsufC8f3UPUU.9nE9w-
X-Yahoo-Newman-Property: ymail-3
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126662>

Greetings git folks,

I have recently been trying to make a tag and branch of the same name
from a previous <COMMIT> on a master branch on a kernel.org tree using
the following commands:

	# Create the tag:
	git tag -a lio-x.y <COMMIT>
	# Push the tags:
	git push --tags origin
	# Fetch to be sure
	git fetch origin
	# Make tagged branch:
	git checkout -b lio-x.y <COMMIT>
	# Make <NEW_COMMIT> to lio-x.y and commit
        git commit frob
	# Switch back to master branch
	git checkout master
	# Push local branch to origin
	git push origin refs/heads/lio-x.y

At this point after pushing to origin, I can do a fresh clone of the
tree, and do a 'git checkout origin/lio-x.y and I see '<NEW_COMMIT>',
and the logs and blobs look as expected..

However, after checking gitweb log for branch lio-x.y on kernel.org, I
only see <COMMIT>, and not <NEW_COMMIT>, and all of the blobs in branch
lio-x.y still reference the original <COMMIT>, et al.

John Hawley has been helping to resolve the issue (I am just going to
use different tag/branch names instead), and hpa asked me to report this
as it is easy to reproduce with the gitweb version on kernel.org..

Here is a bit of the IRC log:

22:30 < nab> Hmm, I wonder if the fact that I was tagging a commit from master, and then branching using the same 
             commit ID to a tag of the same name as the branch..?
22:33 < warthog9> not use the same name, I think what your doing is fine just the identical naming is whats 
                  causing the problem
22:33 < warthog9> like tag-lio-3.0
22:33 < nab> Ahhhhhh
22:33 < warthog9> and branch: lio-3.0
22:34 < warthog9> since I think somewhere in git it's got two different orders of preference for tag vs. branch
22:34 < nab> Ok, so I should just delete the branch and tags and redo with diff names..?
22:34 < warthog9> one operation is using the tag, one is using the branch and we are seeing the conflicting 
                  results

<SNIP> warthog9 makes somechanges to git repo with gitweb issues </SNIP>

22:40 < warthog9> that *looks* right to me now?
22:40 < nab> Yep, looks correct
22:41 < warthog9> so yeah, git is getting confused
22:41 < warthog9> ok so my theory is right, it's getting confused between the tag / branch
22:41 < nab> the blob for the ./autoconfigure is correct as well..
22:42 < nab> Ok, I have no problem using different names.. :-)
22:42 < warthog9> I would got show this to the git people, it *could* just be an old bug in gitweb (ours is not 
                  particularly up to date) but if I can replicate it here easily enough I'm guessing there's 
                  still a bug elsewhere

Many thanks for your most valuable of time,

--nab
