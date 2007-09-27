From: linux@horizon.com
Subject: Re: History over-simplification
Date: 27 Sep 2007 00:56:40 -0400
Message-ID: <20070927045640.31040.qmail@science.horizon.com>
Cc: gitster@pobox.com, linux@horizon.com
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Sep 27 07:23:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ialqc-0007qd-Lc
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 07:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbXI0FXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 01:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbXI0FXY
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 01:23:24 -0400
Received: from science.horizon.com ([192.35.100.1]:13592 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753897AbXI0FXY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 01:23:24 -0400
X-Greylist: delayed 1601 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2007 01:23:23 EDT
Received: (qmail 31041 invoked by uid 1000); 27 Sep 2007 00:56:40 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59263>

>>  b) The resulting path matches one of the parents but not one of
>>     the others.  In such a case the merge should still be output if
>>     a 3-way read-tree would not have chosen this result by default.

> I am not sure (b) is useful in general.  Merging two branches
> that fix the same issue but in different ways (think: 'maint'
> and 'master' have different infrastructure and a fix initially
> made on 'master' was backported to 'maint', and then later
> 'maint' needed to be merged to 'master' to carry forward other
> fixes) is a norm, and in such cases taking the version from the
> merged-to branch is almost always what happens.
>
> Also it sounds to me by "if read-tree would not have chosen this
> result by default" you mean this feature would not just need to
> run merge-base but also recursive merge-base synthesis, and also
> recreate the structural merge (aka "rename detection") there as
> well.  Even if (b) is useful, it sounds like a very expensive
> option, and the current merge-recursive code is structured in
> such a way to be easily reused for this purpose.

These seem like roundabout ways of expressing the requirement.
The desired rule is "no silent changes in the simplified history".
E.g. if the revision history of a particular file is:

      +-C-+
     /     \
A---B       B---D
     \     /
      +-B-+

Then the normal code will notice that there are no changes on the
lower branch, prune the merge entirely, and simplify to A---B---C---D.
This is, however, misleading; the true history is A---B---C---B---D.
A merge must be shown unless it matches a *non-eliminated* ancestor.

The point is that this isn't expressed in terms of what merge-base would
do, but in terms of what the path limiter is in the process of doing.


Now, I haven't dived into the Deep Magic of revision.c to figure out
where to put this into the code, unfortunately.


Another way to say it is that the desired simplified history
is achieved when you have exhausted the following two rules:
- You may delete any revision which has only one ancestor and
  is identical (after path-limiting) to that ancestor.
  (Descendants are implicitly linked to that ancestor.)
- You may delete any ancestor link A---B if there is an
  alternative directed path between A and B.
  (Fast-forward rule.)
Given unlabeled ancestor links, there is a unique fixed point.

The current code is willing to delete a revision that is
identical to *any* ancestor, even deleted ones.
