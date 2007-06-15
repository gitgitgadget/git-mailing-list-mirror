From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: pull into dirty working tree
Date: Thu, 14 Jun 2007 18:07:01 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706141801030.14121@woody.linux-foundation.org>
References: <18031.64456.948230.375333@lisa.zopyra.com> 
 <alpine.LFD.0.98.0706132216300.14121@woody.linux-foundation.org> 
 <18033.14520.846510.640130@lisa.zopyra.com> 
 <alpine.LFD.0.98.0706140836450.14121@woody.linux-foundation.org>
 <46a038f90706141746n1cb69258r23ba676bbcf7c425@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 03:07:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz0HZ-0004UY-Rn
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 03:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbXFOBHU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 21:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbXFOBHU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 21:07:20 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51534 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750747AbXFOBHS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jun 2007 21:07:18 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5F177na021700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2007 18:07:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5F1714T007238;
	Thu, 14 Jun 2007 18:07:01 -0700
In-Reply-To: <46a038f90706141746n1cb69258r23ba676bbcf7c425@mail.gmail.com>
X-Spam-Status: No, hits=-2.573 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50231>



On Fri, 15 Jun 2007, Martin Langhoff wrote:
> 
> Right now git merges/fforwards well with dirty state as long as the
> same path is not touched on both sides. But there are several
> situations where it could do better allowing those ops to go through
> if they don't result in any conflict.
> 
> - For Fast Forwards on a dirty path - attempt the merge on a temp file
>   and refuse to complete the FF there is a conflict.
> - For merges on a dirty path, attempt the merge. If both the tree
>   merge _and_ the subsequent with the dirty state are clean, then there
>   is no problem updating the checkout.
> 
> In both cases, we can still go ahead in the case of a conflict against
> the local state and give the user the normal conflict markers (or
> separate files of the patch doesn't apply at all. The situation where
> I think it is valid to refuse to go ahead is in the "merge on dirty
> path" where the tree merge results in a conflict. Too many states to
> keep track of -- not for git but for the user.

I agree, but there is actually a practical implementation problem with 
doing that:

 - currently, we can decide *ahead* of time (by just looking at the index, 
   whether the index entry is clean, and the two branches) whether the 
   merge can go ahead or not.

 - so we actually do two passes: the first pass checks that we can do what 
   we want to do cleanly, and the second pass actually starts changing the 
   working tree!

Now, if you actually start doing the *merge* thing, the biggest practical 
problem ends up being that the natural place where you find out that 
"oops, we can't get a clean result" is in phase 2 - *after* you have 
potentially already done earlier merges in the working directory!

And that's unacceptable. A "git pull" needs to either fail early without 
making any modifications at all (telling people that the tree is dirty and 
cannot be merged), or it needs to complete but leave conflict markers.

But yeah, if you can check in stage 1 (_without_ changing the working 
tree) whether the merge will work, then everything is fine.

		Linus
