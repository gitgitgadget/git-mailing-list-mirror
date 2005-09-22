From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Thu, 22 Sep 2005 14:37:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509221427520.2553@g5.osdl.org>
References: <E1EIWUv-0004HR-F6@jdl.com> <Pine.LNX.4.58.0509221413400.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 23:39:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIYlu-0006b7-8r
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 23:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVIVViE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 17:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVIVViE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 17:38:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32202 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751198AbVIVViB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 17:38:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8MLbnBo016822
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Sep 2005 14:37:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8MLbi9w021716;
	Thu, 22 Sep 2005 14:37:47 -0700
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <Pine.LNX.4.58.0509221413400.2553@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9145>



On Thu, 22 Sep 2005, Linus Torvalds wrote:
> 
> Now, the fixing up any merges is pretty much exactly the same as under 
> CVS - you'll get the same "<<<<" "====" ">>>>" markers.

I should have continued this. 

What you do is you just edit the end result to be what it should be 
(exactly as under CVS), and then you do "git commit --all" to commit the 
manual merge.

NOTE NOTE NOTE! This is one case where if you had dirty state in your tree
before the merge, that you need to be careful. In that case you obviously
must NOT use "--all", since that will commit all the dirty state - both
your old dirty state _and_ your manual merge resolve. So if you had other 
changes in your tree that you don't want to commit, you need to do

	git commit <list manually merged files individually here>

so that it doesn't commit anything else. 

Oh. And while preparing the merge, you can use

	git diff

to see what the manual part was: the automated part of the merge will have
updated index for the automatic side, so this will _not_ show the part 
of the merge that was done automatically for you.

Or, of you want to see _everything_ the merge has done, just do

	git diff HEAD

to see what the _total_ diff from your pre-merge head was to what is now
in your tree. But that will be the diff for what you're merging - so it
can be _huge_ if you're pulling my tree and merging everything I've
accepted over the last week or two.

And if the merge ends up being too complex, and you decide that you need 
help and want to undo the partial merge entirely and not even try to fix 
it up, do

	git reset --hard

which will roll back the index and the working tree to your old HEAD (BUT 
LOOK OUT! IT WILL ALSO DESTROY ANY DIRTY STATE YOU HAD BEFORE THE MERGE!).

Basically: having dirty state in your tree and then ending up having to do 
a manual merge is a big pain. Not worth it. I just keep really small dirty 
stuff so that I don't mind blowing it away if I need to.

		Linus
