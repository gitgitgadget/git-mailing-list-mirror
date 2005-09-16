From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git fsck messages - what to do about it?
Date: Fri, 16 Sep 2005 11:34:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509161114540.26803@g5.osdl.org>
References: <20050916101138.99906352682@atlas.denx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 20:36:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGL3E-000658-GO
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 20:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161255AbVIPSfF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 14:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161258AbVIPSfF
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 14:35:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24008 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161255AbVIPSfD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 14:35:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8GIYwBo005714
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Sep 2005 11:34:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8GIYtXD005823;
	Fri, 16 Sep 2005 11:34:57 -0700
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050916101138.99906352682@atlas.denx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8704>



On Fri, 16 Sep 2005, Wolfgang Denk wrote:
>
> When running git fsck I get some messages:
> 
> -> git-fsck-cache --unreachable $(cat .git/HEAD .git/refs/heads/*)

Btw, you shouldn't need to list the heads explicitly any more: if you 
don't give any heads, git-fsck-cache by default will pick up all of them. 
In fact, it will generally do a better job of it that you did, since it 
will look at _all_ the refs in .git/refs/.

The above is very old-fashioned ;)

> unreachable commit 08cf4121ad704faa5ae7c7ae7b3dca4476ef2770
> unreachable tree 29a4c18afd958cc6cee938f0fe7fa59764418097
> unreachable tree 3b722a7278e02b272ddc8aefbc7be22703d8a94f
> unreachable tree 4ebc50d240d99b4236952d13d5044691f9078e3c
> unreachable tree 63af5944e130b449338cc907ee77c51f4a69e339
> unreachable tree 79c9a6bb02a80df15c7d829bdac0901f88c5e301
> unreachable blob 85dcf4b5c4c0f6833cd63fa1d0fd29ef250162af
> unreachable commit c1b779fbce762c970e3ace4332bb6ddc0de65e61
> unreachable blob d70d1d44f12db7b2a3976c2a5313c90568a62c25
> unreachable commit e1bcd2a5d53bceef2679737474487e32d87e7f2c
> 
> I have to admit that I don't know what to do next...
> 
> a) I understand that these  messages  are  indications  of  problems,
>    right? What can I do to clean this up?

First off, not necessarily. Especially if you have mixed rsync and the 
"native git pack" transports, you may have packs that refer to unpacked 
objects, and then since git-fsck-cache by default doesn't look into packs 
(it assumes that they are fine and self-sufficient), you can get this 
error.

The same is true if you have "alternates" directories: git-fsck-cache 
won't do the reachability in the other directories by default.

If you add the "--full" flag, git-fsck-cache will also look at all those 
things.

Now, I assume that this isn't the case, and what you have is actually real 
unreachable objects. And that's perfectly normal too: it will happen if 
you ever "drop" a commit (undo) by resetting a branch to its parent. For 
example, if I notice I've made a mistake after a commit, I just do

	git reset HEAD^

which effectively undoes the commit. I can then fix things up and 
re-commit. And this is all _normal_.

And what it results in is that the commit objects that I undid are
obviously not reachable from anything else. git-fsck-cache will say that
they are unreachable, and "git prune" will get rid of them.

The same thing happens if you do "git-update-cache" on a file, but instead 
of committing that blob object, you realize that you need to edit it a bit 
more, and do _another_ git-update-cache and commit only the final blob. 
The first blob will be unreachable - nothing ends up pointing to it.

So an unreachable object is not necessarily an error at all. Git - very 
much on purpose - will leave the stale objects around, because it's too 
expensive to try to be exact, so it's much better to just let them be, and 
do an occasional "cleanup" with "git prune".

There are other reasons to have "unreachable" objects, even more benign. 

Any time you use "rsync" as the fetch protocol, you'll get _all_ the 
objects from the other end. Regardless of whether you actually fetch all 
the _refs_ from the other end. In particular, if the other end has 
multiple branches, and you only pull _one_ of them, you'll still get the 
objects for all the others. And git-fsck-cache will correctly say that 
those objects are unreachable.

(And _yet_ another reason for unreachable objects: you share the object 
directory with some other project - those objects will be unreachable from 
_your_ project, but maybe they're reachable from another one?)

> b) Is there any way to find out what I did wrong in the first place?

Well, it probably isn't even an error, but there are nice tools to check 
it out. For example, you can just list the commits it lists to gitk, and 
you'll get a nice graphical view of where they are in the tree. That 
probably makes you go "Duh, yes, I did a 'git reset' to undo those".

Or maybe you recognize that the commit was clearly part of a chain that
you hadn't even committed, but came from another tree that you had 
rsync'ed with.

And if that is the case, just ignore them. Or do "git prune" to keep your 
tree nice and clean, and to make "git-fsck-cache --unreachable" happy.

		Linus
