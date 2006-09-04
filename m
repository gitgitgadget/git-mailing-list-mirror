From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: New git commit tool
Date: Mon, 4 Sep 2006 10:10:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609040952550.27779@g5.osdl.org>
References: <17660.4995.977221.767112@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 19:10:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKHxk-0008TX-VJ
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 19:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWIDRKR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 13:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWIDRKR
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 13:10:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19840 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964941AbWIDRKO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Sep 2006 13:10:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k84HABnW003746
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 4 Sep 2006 10:10:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k84HABWB029574;
	Mon, 4 Sep 2006 10:10:11 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17660.4995.977221.767112@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-0.487 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26426>



On Mon, 4 Sep 2006, Paul Mackerras wrote:
> 
> Files can also be partly checked in, for example, if changes were made
> and checked in, and then further changes were made.  Clicking on such
> a file will show a 3-way diff (HEAD vs. checked-in state vs. working
> file), provided Junio applies my patch to diff-lib.c. :)

I like the feature, but not necessarily how it's been done. I see three 
problems:

a) the three-way diff makes it hard to see what you would _actually_ check 
   in (if you use the index state), because it (by design, of course) 
   mixes in not just the data you check in, but also the current state.

b) if you ever click the icon to mark the whole file for checkin, you've 
   now forever lost the old index state (ie it seems to do the equivalent 
   of "git-update-index" into the main index). So you can't recover from 
   mistakenly clicking on the icon.

c) there's no way to exit gracefully without saving the changes you've 
   done (related to (b), but also something you might want to do 
   regardless of any half-way-updated index state).

Now, the second and third problem are really one and the same, I guess. It 
all boils down to the fact that I think one reasonable usage-case is that 
you ran out of time and had to do something else, and you have two cases: 
you _want_ to start up the next time with the half-way done thing (ie 
you've marked certain files for committing), or you decide that you would 
much prefer to restart from the beginning for next time around. Both are 
entirely valid cases, and right now your git commit tool makes it 
impossible to do the latter.

So for problems (b)-(c), I _think_ the right answer is to do all the index 
work in a new temporary copy of the index, and only on commit (or on "quit 
and save current work") do you actually write back to the old index file. 
That way, you can also always re-read the original index file to get the 
previous state..

As to (a) - I think it would in many ways be nicer if you could have some 
way to in addition to the three-way diff also show the regular two-way 
diffs for

 (i) what would you actually commit
 (ii) what are the _additional_ changes there in that file

which is what you'd normally want to see, I think. The three-way diff 
shows that, of course, but in a form that most people wouldn't understand, 
methinks.

I do have a fourth issue, which is that I hate "gitool" as a name. It 
either parses as "gi"+"tool", which makes no sense, or "git"+"ool", which 
also makes no sense. "gitk" was cute, "gitool" is just irritating ;)

That said, it definitely has potential. 

			Linus
