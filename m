From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Wed, 11 Apr 2007 16:16:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704092115020.6730@woody.linux-foundation.org>
 <461D6432.90205@vilain.net> <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org>
 <461D6858.4090007@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 01:17:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbm3o-0003fo-Vb
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 01:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbXDKXRF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 19:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbXDKXRE
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 19:17:04 -0400
Received: from smtp.osdl.org ([65.172.181.24]:35746 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753354AbXDKXRB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 19:17:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3BNGtVZ026165
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Apr 2007 16:16:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3BNGsOp017419;
	Wed, 11 Apr 2007 16:16:54 -0700
In-Reply-To: <461D6858.4090007@vilain.net>
X-Spam-Status: No, hits=-0.957 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44274>



On Thu, 12 Apr 2007, Sam Vilain wrote:
> >
> > And yes, that's absolutely true, but it's technically no different from 
> > just using GIT_OBJECT_DIRECTORY to share objects between totally unrelated 
> > projects, or using git/alternates to share objects between (probably 
> > *less* unrelated repositories, but still clearly individual repos).
> 
> Would that be the only distinction?
> 
> Would submodules be descended into for object reachability questions?

I think we'll eventually want that *regardless* of how the object handling 
is done (a kind of "cross-submodule boundary check"), but I think that's 
actually outside of the scope of the current fsck.

The current fsck goes to great lengths to make sure that the internal 
consistency of a repository is good. That's also why it takes so long, and 
why it is such an expensive operation to do (notably when you do a 
"--full" check).

In contrast, the "cross-submodule boundary check" is a much cheaper 
operation, *if* you have already verified that the projects are internally 
consistent. It literally boils down to doing a very simplified commit 
chain walker that only parses tree objects and simply spits out the 
SHA1's of the sub-tree commits (and their location in the tree), and then 
a separate phase that just verifies those against the submodules.

And that separate phase - once you've done the fsck for all the 
*individual* repositories - is truly trivial. It's literally just a matter 
of "is that SHA1 a valid commit object". That's *cheap*.

See?

> I'm particularly interested in repositories with, say, thousands of
> submodules but only a few hundred meg. I really want to avoid the
> situation where each of those submodules gets checked or descended into
> separately for updates etc.

So I think that the way to verify a superproject is:

 - fsck each and every project totally independently. This is something 
   you have to do *anyway*.

 - either as you fsck, or as a separate phase after the fsck, just 
   traverse the trees and spit out "these are the SHA1's of subprojects"

 - finally, just go through the list of SHA1's (after every project has 
   been fsck'd) and verify that they exist (since if they exist, they will 
   have everything that is reachable from them, as that's one of the 
   things that the *local* fsck verifies)

Notice? At no point do you actually need to do a "global fsck". You can do 
totally independent local fsck's, and then a really cheap test of 
connectedness once those fsck's have completed.

The reason a *full* global fsck is so expensive is that it would have an 
absolutely humungous working set, and effectively keep everything in 
memory through it all. Doing it in stages ("fsck smaller individiual trees 
separately") is actually the same amount of absolute work, but the working 
set never grows, so it scales much better.

(fsck'ing projects individually also happens to allow you to do the 
sub-project fsck's in parallel across multiple CPU's or multiple machines, 
so it actually scales much better that way too - but the big problem 
tends to be excessive memory use, so the "SMP parallel version" only 
makes sense if you have tons of memory and can afford to do these things 
at the same time!)

			Linus
