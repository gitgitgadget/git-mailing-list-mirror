From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and commiting
Date: Fri, 8 Jul 2005 13:10:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507081254190.17536@g5.osdl.org>
References: <42CE88A6.5080502@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 22:15:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqzFR-00087l-PU
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 22:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbVGHUOP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 16:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbVGHUMQ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 16:12:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8339 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262856AbVGHUKa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 16:10:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j68KARjA016111
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 8 Jul 2005 13:10:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j68KAPGx022789;
	Fri, 8 Jul 2005 13:10:26 -0700
To: Mateusz Berezecki <mateuszb@gmail.com>
In-Reply-To: <42CE88A6.5080502@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 8 Jul 2005, Mateusz Berezecki wrote:
> 
> How to commit and check-in changes done to the checked-out source code?
> The "git commit" command seems to only commit the changes locally
> without pushing them via rsync.
> Is there any way I can push commits via rsync? Am I missing the point
> and git commit is not enough?

"git commit" is "enough" in the sense that it does indeed commit 
everything to the local tree, and often that is enough.

But what you're asking for is to _export_ the changes to others. And 
that's a different issue.

There's actually two different parts to exporting your changes:

 - making your existing tree (or branch) available as-is on some public 
   place.

   This is done with

	git-send-pack <destination> [branches]

   where the destination can either be a locally writable tree, or it's a 
   ssh-format remote tree (ie you need to have some place where you can 
   log into with ssh).

   For example, when I export my kernel changes, I do so with

	git-send-pack master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6

   which I have in a "push-all" script in my kernel directory (so that 
   regardless of what project I'm working on, I can just do "./push-all" 
   to push it to the repositories I have as the public destinations).

 - other people will _pull_ the changes (ie you don't push them to others: 
   you publicize, and then it's up to others to decide whether they want 
   to pull your tree).

Now, there's one special case, namely when you use a shared "CVS-line" 
repository that multiple people push to. If you do that, then you are both 
pusher and puller, and exactly like with CVS, you'll have to be up-to-date 
in order to push. So before you do the git-send-pack, you should first see 
if you need to update with work that other people have done in the shared 
repository, ie it might look something like this:

	git pull repo.work.com:/project/work.git branch
	git-send-pack repo.work.com:/project/work.git branch

where the first command makes sure that you're up-to-date (and as with 
"cvs update", you may need to fix up any merge issues), and the second 
command then pushes back the merge results.

NOTE NOTE NOTE! As it stands, git-send-pack is really geared towards _my_
kind of usage, ie it is geared towards sending to a public repository that
doesn't have other people pushing to it (ie it's "public for reading", but
it's "private for writing"). That's the way _I_ work, but it's not the 
way you'd work in a more CVS-like environment with multiple people that 
push to a common repository.

What this means is that "git-send-pack" is a bit too eager to try to make
the other end look exactly like _your_ end. It's a bit too easy to re-set
a branch that somebody else may have changed to what _you_ happen to have
in your tree, so be careful. The data doesn't go away, of course, but if
you reset a branch the old contents aren't reachable any more, so it might
as well be considered gone (you can use "git-fsck-cache" to find the
non-reachable commits and re-name them to some new branch, but the point
is that it's real work).

I'll try to make git-send-pack much more careful about setting branches to 
new values.

		Linus
