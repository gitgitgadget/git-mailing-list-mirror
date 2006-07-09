From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFH: refactor read-tree
Date: Sat, 8 Jul 2006 20:15:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607082011060.5623@g5.osdl.org>
References: <Pine.LNX.4.63.0607090015250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 05:15:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzPls-0008Rh-IK
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 05:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbWGIDPp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 23:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161073AbWGIDPp
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 23:15:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161071AbWGIDPp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 23:15:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k693FfnW028413
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 8 Jul 2006 20:15:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k693FfqX008745;
	Sat, 8 Jul 2006 20:15:41 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607090015250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.84__
X-MIMEDefang-Filter: osdl$Revision: 1.138 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23519>



On Sun, 9 Jul 2006, Johannes Schindelin wrote:
> 
> I also played a little with git-merge-tree, because it seems so much 
> simpler and easier to refactor. But there is a problem: Either I call it 
> the wrong way, or it does not yet work correctly: I tried
> 
> 	git-merge-tree $(git-merge-base branch1 branch2) branch1 branch2
> 
> with what is in 'next'. But it only showed the _new_ files, not the 
> modified ones.

What git-merge-tree does is to show the _difference_ to "branch1".

So if the result of the merge would be totally identical to "branch1", 
then git-merge-tree should be totally silent.

The basic idea is that "branch1" should be your current branch, and it 
obviously is also expected to match (more or less) the current index. So 
you can do a merge by

 - reading in "branch1" into the index:

	GIT_INDEX_FILE=.git/tmp-index git-read-tree -m branch1

 - doing a "git-merge-tree $base $branch1 $branch2"

 - using the _result_ of "git-merge-tree" to modify the index you just 
   read in.

 - write out the end result as the result of the merge.

And yes, I agree 100% that "git-read-tree" has become an unholy mess. I 
looked at it, and I think it's unfixable. I considered re-writing it from 
scratch, at least for some specific cases, but I couldn't bring myself to 
do it.

			Linus
