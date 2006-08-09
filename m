From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: merge-recur status
Date: Wed, 9 Aug 2006 23:02:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608092232000.13885@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Aug 09 23:03:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAvCc-0008A0-9G
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 23:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWHIVCy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 17:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWHIVCy
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 17:02:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:12008 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751363AbWHIVCx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 17:02:53 -0400
Received: (qmail invoked by alias); 09 Aug 2006 21:02:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 09 Aug 2006 23:02:52 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25146>

Hi,

with my last patches, I tested merge-recur on 'next' (46faaaf8) by 
comparing the index after -recur and -recursive, respectively.

At this stage, there are 1017 merges with exactly two parents (which is 
the only type of merge -recursive can handle).

For all but 9 of them, the indices where identical. The reason for those 9 
to differ: the order of the merge-bases. -recursive does its own thing 
(set intersection after traversing the commits by hand, probably in 
topological order), whereas with the last patches, -recur orders them by 
decreasing date.

The 9 cases are:

52bc0e29: 1 better
a5c8a98c: 1 better, 2 identical
63bccad3: 1 identical
dcaad49c: 3 identical
7f2d5cb5: 3 identical
c2b9e699: 2 identical
4cc0b8a4: 2 identical
d2b9b5f5: 1 identical
41094b8e: worse

where

- "1 better" means that -recursive has a conflicting hunk, where 
  -recur resolves it (it is identical with the commit),

- "1 identical" means that there were multiply conflicting hunks (meaning 
  that merging two merge-bases already conflicted, and another conflict 
  came on top), and the versions of -recursive and -recur differ only in 
  the order of the conflict nesting, and

- "worse" means that the merge of 859ab4c and 061ad5f, which _should_ have 
  resulted in 41094b8e (as with -recursive) resulted in a

  "fatal: Entry 'epoch.c' would be overwritten by merge. Cannot merge."

  It might have its reason in the fact that 859ab4c and 061ad5f have
  8 (!) merge bases.

Now, on average, -recur takes 0.1 seconds on average, spending only 9.9% 
of what -recursive takes (on average). So I am happy with the speed.

I think -recur is really really close to being trustworthy, _but_ I do not 
understand the reason behind the error. It happens in line 614 of 
unpack-trees.c, where the "index" contains epoch.c, and "index" and 
"remote" are identical, but "head" is empty.

I tried to wrap my head over it, but seem unable to do so. Also, I do not 
find the case 14ALT (which is mentioned in unpack-trees.c:603) in 
Documentation/technical/trivial-merge.txt.

Help?

Ciao,
Dscho
