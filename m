From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Cygwin: problem with renaming and case
Date: Fri, 21 Mar 2008 10:46:55 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803211037160.3020@woody.linux-foundation.org>
References: <47E3DD28.4030302@tiscali.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Frank <streamlake@tiscali.it>
X-From: git-owner@vger.kernel.org Fri Mar 21 18:48:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JclLf-0002NL-ET
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 18:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758365AbYCURra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 13:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758304AbYCURra
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 13:47:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53142 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753349AbYCURr3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2008 13:47:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2LHkujg011838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 21 Mar 2008 10:46:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2LHkujD002552;
	Fri, 21 Mar 2008 10:46:56 -0700
In-Reply-To: <47E3DD28.4030302@tiscali.it>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.256 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77751>



On Fri, 21 Mar 2008, Frank wrote:
>
> Don't know exactly if this is a bug or a feature or something in the middle,
> but I have a lot of problems while changing just the casing of file names and
> using git mv und cygwin.

It's not exactly a bug, it's a "feature" of that crap we call Windows and 
OS X that makes them claim that soem files exist even though they don't.

> Here's a test case:
> [ ... ]
> echo "NEW AAA" >Aaa.txt
> git add Aaa.txt
> git commit -m "Added Aaa"
> #aaa.txt exists in master, Aaa.txt in new_branch
> git checkout master
> 
> Last command gives: "fatal: Untracked working tree file 'aaa.txt' would be
> overwritten by merge".

So what happens here is that git is trying to switch back to master, which 
has the file "aaa.txt" in it, and before it does that switch is wants to 
make sure that the new files it creates won't be overwriting some 
untracked file data that you may already have.

Now, you don't *really* have a file called "aaa.txt" any more, but what 
git is doing is that it knows it will create that file, so before it 
starts writing it, it will do a "lstat()" on the file to see that there is 
nothing there.

So git will lstat() that pathname "aaa.txt", and your absolute crap 
filesystem will say "sure, I have that file". Because it will match the 
"Aaa.txt" that you do have from before the merge.

Now, you're tracking "Aaa.txt" in the branch you're leaving, and git knows 
that, but git also knows that the branch you're leaving is *not* tracking 
"aaa.txt", so obviously the copy of "aaa.txt" that the filesystem reports 
is not saved anywhere, and git says "I refuse to overwrite it, because 
that would destroy your untracked content".

> I know I can use git checkout -f but the problem returns while others do
> merging/pulling from my repo, etc.

Case-insensitive filesystems are utter crap. Git doesn't really support 
them, but you can use git on them pretty well as long as you don't 
introduce these kinds of issues by hand. For now, -f is the only 
reasonable thing to do.

Will we fix it? I suspect we will teach git about these kinds of name 
aliases some day, but most of the git developers avoid broken filesystems, 
and the ones that are on broken filesystems tend to avoid having the same 
name in different cases, so it's not exactly a high priority.

It's actually nontrivial to get right and test (on sane filesystems).

I could probably whip up something that gets US-ASCII right for this 
particular case (ie just switching between branches) reasonably easily (ie 
do a pretty stupid "works for the common case" thing without even trying 
to be anythign else). I just really haven't had a lot of motivation to do 
it. Let's see if I can get the energy..

		Linus
