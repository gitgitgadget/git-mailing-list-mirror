From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] Second parent for reverts
Date: Wed, 9 May 2007 15:20:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 21:20:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlrhu-0008FH-Ad
	for gcvg-git@gmane.org; Wed, 09 May 2007 21:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbXEITUJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 15:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbXEITUJ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 15:20:09 -0400
Received: from iabervon.org ([66.92.72.58]:2845 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704AbXEITUH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 15:20:07 -0400
Received: (qmail 28008 invoked by uid 1000); 9 May 2007 19:20:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 May 2007 19:20:05 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46770>

The discussion about having a header to specify, for a revert commit, what 
it reverts made me realize that this header *would* be useful, but that we 
don't need a *new* header for it. I think that the right method is to add 
the parent of the reverted commit as a second parent for the revert.

If you have:

a -> b -> c -> d

And you want to revert b, the most exact flow would be:

a -> b -> c -> d -> e
       \         /
        -> a' ---

I.e., you exactly remove the effects of b to generate a commit that has 
the same tree as a, and then you merge.

But a' doesn't actually take anything from b, since it's reverting all of 
b (unless it's only reverting part of b), and, if b isn't there, it 
doesn't need a commit message, either, so it's not different from a. So 
the flow should be:

a -> b -> c -> d -> e
  \              /
   --------------

And this means blame work correctly: lines that b changed will be blamed 
on a (or an ancestor), because e will match a there and be different from 
d. So I think git-revert should simply add in the reverted patch's parent. 
Does this analysis make sense to other people?

	-Daniel
*This .sig left intentionally blank*
