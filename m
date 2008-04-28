From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: my git problem
Date: Mon, 28 Apr 2008 14:47:17 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804281437160.3119@woody.linux-foundation.org>
References: <20080427112938.4dbe8e2a.akpm@linux-foundation.org> <alpine.LFD.1.10.0804271204510.3119@woody.linux-foundation.org> <20080427124454.6a606305.akpm@linux-foundation.org> <alpine.LFD.1.10.0804271315010.3119@woody.linux-foundation.org>
 <20080428143501.7d6e3ad0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 23:49:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqbDC-0008Cj-CL
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 23:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934469AbYD1Vru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 17:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934434AbYD1Vru
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 17:47:50 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59881 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934241AbYD1Vrt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 17:47:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3SLlI2G007004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 28 Apr 2008 14:47:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3SLlHrO017381;
	Mon, 28 Apr 2008 14:47:17 -0700
In-Reply-To: <20080428143501.7d6e3ad0.akpm@linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.475 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80625>



On Mon, 28 Apr 2008, Andrew Morton wrote:
> 
> origin.patch (generated via git-diff v2.6.25...origin) has:
> 
> commit 7f424a8b08c26dc14ac5c17164014539ac9a5c65
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Fri Apr 25 17:39:01 2008 +0200
> 
>     fix idle (arch, acpi and apm) and lockdep
> 
> 
> and git-x86 (generated via git-diff origin...git-x86) has:
> 
> commit 0a1679501624482a06c19af49d55b68d3973e2f0
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Fri Apr 25 17:39:01 2008 +0200
> 
>     fix idle (arch, acpi and apm) and lockdep
>     
> 
> which I assume is the same patch as a different commit.

Yes. 

So this is an example of the fact that that patch was merged in two 
different trees as separate patches, so when you do

	git diff origin..git-x86

then it shows literally the diff from the last common state, and does 
*not* take into account that since that last common state there has been 
updates to the origin branch that essentially conflict (and in this case 
trivially, by just duplicating the work).

> The old `doit' prevented that by doing a merge.

Yes. And it sounds like what you want is that merge, followed by the diff. 
You're not actually asking for "what has changed since the last common 
state". You are literally asking for "what would a merge result in".

> git-diff was "wrong" to claim that this change is actually present in the
> origin->git-x86 diff.  But I guess it cannot operate at that level and we
> need to do the merge to resolve it.  Or something.

I don't actually see what was wrong with the old script.  The merge was
really oddly done, but apart from that, something like this should work
(just your old script with some trivial fixes to 'git merge' and using
somewhat saner arguments):

	doit()
	{
		tree=$1
		upstream=$2
	
		cd $GIT_TREE
		git reset --hard "$upstream"
		git fetch "$tree" || exit 1
		git merge --no-commit FETCH_HEAD > /dev/null
	
		{
			git_header "$tree"
			git shortlog --no-merges ORIG_HEAD..FETCH_HEAD
			git diff -p --stat ORIG_HEAD
		} >$PULL/$tree.patch

		{
			echo DESC
			echo $tree.patch
			echo EDESC
			git_header "$tree"
			git log --no-merges ORIG_HEAD..FETCH_HEAD
		} >$PULL/$tree.txt
		git reset --hard "$upstream"
	}

but obviously that will still result in problems if there are real conflicts.

			Linus
