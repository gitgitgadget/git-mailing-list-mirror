From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git performance on OS X
Date: Sat, 19 Apr 2008 14:54:40 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sat Apr 19 23:55:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnL1x-0003wX-5W
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 23:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009AbYDSVyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 17:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753415AbYDSVyr
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 17:54:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48506 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753251AbYDSVyq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2008 17:54:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3JLsf8U028984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Apr 2008 14:54:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3JLse1Q001929;
	Sat, 19 Apr 2008 14:54:40 -0700
In-Reply-To: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.447 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79923>



Btw, the "git status" issue is totally different.

On Sat, 19 Apr 2008, Pieter de Bie wrote:
>
> Now we can look at the "git status" commands and compare them to the actual
> status' of the actual webkit repository.
> 
> Results
> ======================================================================
> Command                                            Mean     Std    
> git status                                         4.573  0.514
> git status .                                       13.515  0.448
> hg status                                          4.411  1.594
> hg status .                                        4.903  0.171

The reason "git status ." is slower has nothing to do with the pathspec 
matching, and everything to do with the fact that "git status" with a 
pathspec means soemthing different again.

Remember: "git status" is basically shorthand for "what would happen if I 
did a "git commit" with these arguments.

Which means that "git status ." basically is something similar to a 
private invocation of "git add -u ." in addition to the regular git 
status.

So try it out: change some file (let's say the top-level Makefile) and do 
the two operations, and see how the _output_ is totally different:

Without the ".", you should see something like:

	# On branch master
	# Changed but not updated:
	#   (use "git add <file>..." to update what will be committed)
	#
	#       modified:   Makefile
	#
	no changes added to commit (use "git add" and/or "git commit -a")

ie there is nothing to commit, but Makefile is modified and _could_ be 
committed.

Now, don't look down at the answer, but instead try to think it through: 
what is "git status ." going to say?

Answer: it's going to show something totally different, because "git 
commit ." is going to add that changed Makefile to the commit, so by the 
logic that "git status" is supposed to show what commit will do, you'll 
*not* see that "no changes" line at all, but instead you'll see

	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#       modified:   Makefile

ie now we *would* commit that Makefile change!

So the reason "git status ." is more expensive is that it's doing 
something else.

I don't know what "hg status ." means, but I suspect that it's more of a 
"same thing as 'hg status', but limited to '.'".

And yes, most of the time in "git status ." is going to be the lstat() 
calls. Which are expensive on OS X. And yes, we do too many of them. I'll 
look at seeing if we can avoid some.

		Linus
