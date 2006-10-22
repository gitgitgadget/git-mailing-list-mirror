From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Commit-ish shortcut for immediate parent range
Date: Sun, 22 Oct 2006 13:56:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610221331571.3962@g5.osdl.org>
References: <200610221548.42048.andyparkins@gmail.com>
 <Pine.LNX.4.64.0610221017180.3962@g5.osdl.org> <200610222117.45766.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 22:56:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbkN4-0005Bg-Fr
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 22:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWJVU4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 16:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWJVU4f
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 16:56:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25751 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751500AbWJVU4e (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 16:56:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9MKuUaX025373
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 22 Oct 2006 13:56:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9MKuTgV001083;
	Sun, 22 Oct 2006 13:56:29 -0700
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200610222117.45766.andyparkins@gmail.com>
X-Spam-Status: No, hits=-0.479 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29791>



On Sun, 22 Oct 2006, Andy Parkins wrote:
> 
> You're entirely correct, that that is what I was looking for in that 
> particular case.  However, the reason I raised it as a question was that I 
> was poking around with git (which I'm enjoying immensely by the way - it 
> really is as perfect an SCM as I have ever used) and in short succession did
> 
> git-diff X^..X
> git-log X^..X
> git-format-patch X^..X

Now, "git show" obviously does exactly what you probably wanted, but for 
future reference, the "git log" family of commands also take a "number of 
commits" limiter.

So you can also do things like

	git log --cc -1 X

and it will actually do something very similar to "git show". It's not 
_quite_ identical, but it's close - at least for the special case of a 
single commit.

"git show" actually uses a magic "no_walk" internal flag which means that 
you can give it _several_ revisions, and it will take them as a raw "list" 
of revisions rather than take them as a command to "walk" the revision 
space and then just show one of them (like the "git log --cc -1" example 
would do).

So with "git show", you can do

	git show X Y Z

and it will show those exact three commits. That's _different_ from

	git log --cc -3 X Y Z

which will show the three "most recent" commits when you start walking the 
revision DAG. (The above "git log" command really doesn't make much sense, 
since the output will depend on commit date - it has well-specified 
behaviour, but it's really a pretty random thing to do: it might, for 
example, show the three commits X, X^ and Z, and not Y at all).

Anyway, "git show" is a very useful thing. It's actually one of the 
commands I use most. If I ever want to see what happened in a single 
commit (eg somebody sends me a bug-report and says "commit XYZ introduced 
a regression"), that's what I would use.

Looking at my history, the commands I tend to use most are:

	git log
	git diff
	git pull <some-remote-repo>
	gitk ORIG_HEAD..
	git log -p some/directory/or/file
	git grep -w <some-identifier> [possibly-some-subdirectory]
	git show <some-rev>

and while I think that "git pull" and "gitk ORIG_HEAD.." thing tends to be 
something special to being a top-level maintainer (although maybe I'm 
wrong - you'd probably do the same just because you're following a remote 
tree under active development), all the rest are commands that everybody 
should know so intimately that they don't even need to think about them.

"git grep" in particular seems to be something that a lot of people 
haven't necessarily even realized is there. Yet it's actually extremely 
powerful and efficient both for the "current tree" and for "old 
revisions". 

It's interesting: I used to do a lot of "plain grep" usage, but with git, 
most of my greps by far are all of the form "git grep". I've gotten so 
used to it that I find myself wanting to do "git grep" even on non-git 
stuff, and if I look at somebody elses tar-ball I often end up doing

	git init-db
	git add .

just to be able to do "git grep" on it. I've totally stopped doing the 
"find . -name '*.[ch]' | xargs grep -w" sequence that I _used_ to do a lot 
of.

			Linus
