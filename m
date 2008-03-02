From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: kernel.org git tree corrupt?
Date: Sun, 2 Mar 2008 13:16:48 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0803021302070.17889@woody.linux-foundation.org>
References: <524f69650803020749o469f2e48l125a55267b0b5d13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: lkml <linux-kernel@vger.kernel.org>, git@vger.kernel.org
To: Steve French <smfrench@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 22:17:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVvZ7-0005JJ-NV
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 22:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756805AbYCBVRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 16:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756663AbYCBVRM
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 16:17:12 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36450 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756073AbYCBVRK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2008 16:17:10 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.14.2/Debian-2build1) with ESMTP id m22LGrHF021254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 2 Mar 2008 13:16:55 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m22LGmUJ016888;
	Sun, 2 Mar 2008 13:16:48 -0800
In-Reply-To: <524f69650803020749o469f2e48l125a55267b0b5d13@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.645 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75843>



On Sun, 2 Mar 2008, Steve French wrote:
>
> In preparation for a merge request I do
>     cg-diff -m -r origin: | diffstat -p1
> (git diff -m -r origin: shows the same problem) and
>     cg-log -m -r origin:

First off, you really should lay off the cogito thing, it's pretty much 
guaranteed that any cogito usage will just be harder and less likely to be 
correct than just usign native git (and almost nobody will be able to help 
you any more - it's not like it's been maintained for the last year).

It *sounds* like your "origin" isn't what you expect it to be. 

> Was the linux-2.6.git rebuilt in the last four weeks with different 
> changeset numbers? Something seems to have drastically changed in the 
> kernel.org tree in the last few weeks.

Nope, nothing has been rebuilt, but there's been another merge window, so 
there's certainly been drastic changes.

> Doing "cg-log -m -r origin: fs/cifs" shows changesets that are already
> in linux-2.6.git (e.g. the vfs-wide changes to add path_put
> 1d957f9bf87da74f420424d16ece005202bbebd3 and
> 4ac9137858e08a19f29feac4e1f4df7c268b0ba5 )

In that case, your "origin" simply isn't updated, but points somewhere 
long back in history. I can only assume that cogito has done something 
wrong, like not been able to handle packed refs or something, and you have 
an updated tree but "origin" pointing to way back in the history.

> Ideas for another solution short of recloning and sorting through all
> of the last month or two of patches that affect this directory by
> hand?

Do this:

 - get rid of cogito (or at least make sure that it doesn't mess up the 
   following sequence)

 - look at your .git/config file to make sure that the remote branches are 
   sane. It should have something like this (and if it doesn't, add it):

	[remote "origin"]
		url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
		fetch = +refs/heads/*:refs/remotes/origin/*

	[branch "master"]
		remote = origin
		merge = refs/heads/master

 - look at your "origin" branch, and make sure it's a *remote* branch, not 
   the old-style local one. Ie it should *not* show up when you do a 
   plain

	git branch

   but it *should* show up (as both "origin/HEAD" and "origin/master") 
   when you do

	git branch -a

   and if it's a local branch (very possible, since you're using cogito 
   that may not even understand remote branches), then just blow it away 
   entirely with "git branch -D origin".

 - do "git fetch" to make sure that the remote branches are up-to-date

 - now do "git log origin" an it should show something recent like

	commit 038f2f725503b55ab76cfd2645915a85594710fe
	Merge: 8d07a67... 855c603...
	Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
	Date:   Sun Mar 2 12:38:17 2008 -0800
	
	    Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux139
	...

 - and if it does, now you should be all good, and you can dothe normal 
   "gitk origin.." and see the commits that are in your tree but not in 
   mine.

Now your setup should be ok again. I *suspect* that what has happened is 
that you got a local "origin" branch - probably through cogito - that hid 
the remote one. 

		Linus
