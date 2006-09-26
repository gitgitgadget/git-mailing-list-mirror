From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git packing leaves unpacked files
Date: Tue, 26 Sep 2006 11:28:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609261116170.3952@g5.osdl.org>
References: <45196BC8.8060608@shadowen.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 26 20:29:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSHfi-0007G5-Ux
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 20:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbWIZS2o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 14:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbWIZS2o
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 14:28:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26548 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751562AbWIZS2n (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 14:28:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8QISdnW009191
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Sep 2006 11:28:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8QISdi8028823;
	Tue, 26 Sep 2006 11:28:39 -0700
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <45196BC8.8060608@shadowen.org>
X-Spam-Status: No, hits=-0.479 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.152 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27809>



On Tue, 26 Sep 2006, Andy Whitcroft wrote:
>
> I was just looking at my kernel repository and noticed that even after a
> git repack -a -d I have some loose files.  A quick look at repack
> doesn't seem to explain why some are either not packed or are kept unpacked.
> 
> Is this something I should be expecting?

Depending on what you're doing, yes.

You can often get a hint of what is going on by just running 
"git-fsck-objects" and seeing the "dangling" objects - objects that exist, 
but are not reachable.

There are a few things that cause dangling objects quite normally:

 - If you use "git update-index" to update the index half-way, and then do 
   more work, and use "git update-index" again (or commit), then the 
   half-way work will visible be in the form of dangling blobs. You can 
   just do a "git cat-file -p <blobname>" and see it, and maybe you'll 
   recognize that it was something you were about to commit, but never 
   did, because you did further development.

 - if you ever rebase any branch in the project, or do "git reset" to set 
   it to some old point, or delete a branch, dangling commits are very 
   much to be expected.

 - Even if _you_ didn't rebase anything, if the project you track rebases 
   itself, you'll get dangling objects because you had commits that became 
   unreachable when they were replaced by new history.

   My kernel tree doesn't do that, but some other ones occasionally do, 
   and git itself (in the "pu" branch) obviously does all the time.

   This is often the most common reason, especially if you follow 
   Junio's git tree.

   The most common sign of this is that there's a few dangling commits, 
   and when you use gitk to examine them, you see old valid commits that 
   just aren't reachable any more.

 - if you do any merges at all, and they've conflicted or they have had 
   more than one parent and the recursive merger has generated an 
   intermediate version of the tree, you'll have the merge process leave 
   the objects of those intermediate merges around as dangling left-overs 
   that aren't actually reachable from the end result of the merge.

   The most common form of this is that you see a few pending "blob"s, and 
   when you do "git cat-file -p <sha1> | less -S" on the blob-file, you'll 
   generally find a conflict marker in it (ie the "<<<<" "====" ">>>>" 
   things that a three-way merge leaves behind). You might also have a 
   whole dangling tree due to this.

 - if you use the rsync:// protocol, you'll often end up getting objects 
   that aren't reachable from the heads _you_ have, because you got the 
   whole object database from somebody else that had other heads (or, you 
   might get the dangling objects that they had due to any of the reasons 
   above).

   The rsync:// protocol simply doesn't do any git-level reachability 
   analysis, so it just gets everything, regardless.

Hmm. Those are tha main reasons I can think of. There may be other cases, 
but I think these are the main ones, and I think any other cases end up 
being just variations on the same kind of theme.

			Linus
