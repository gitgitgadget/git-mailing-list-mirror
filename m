From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 13:50:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701111324350.3594@woody.osdl.org>
References: <Pine.LNX.4.64.0701111023090.3594@woody.osdl.org>
 <20070111211143.GG17999@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 22:51:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H57pU-0004vq-BU
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 22:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbXAKVvG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 16:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbXAKVvG
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 16:51:06 -0500
Received: from smtp.osdl.org ([65.172.181.24]:37511 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487AbXAKVvB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 16:51:01 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0BLoKWi006855
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 Jan 2007 13:50:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0BLoEdn004051;
	Thu, 11 Jan 2007 13:50:17 -0800
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20070111211143.GG17999@mellanox.co.il>
X-Spam-Status: No, hits=-0.664 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36617>



On Thu, 11 Jan 2007, Michael S. Tsirkin wrote:
> 
> I did lots of resets and they did not seems to help.

NOTE! If "nothing seems to help" means "git-fsck-objects" still complains, 
then that is very much expected.

"git reset" does NOT fix a corrupted database. Never has, never will. It 
should only fix the case where a branch head points to a corrupt or 
incomplete tree.

To actually fix the database, you need to remove the broken objects. Which 
"git prune" did for you (but you could have just done it by hand too).

> Then, on a hunch, I just did git prune and
> it cleaned the tree so I can pull/push fine.

If so, your branch heads had _already_ been fixed (by one of the resets), 
and "git prune" just got rid of the (unreachable) objects that were 
broken.

> How come?

What happens is:

 - you had gotten some corrupt objects due to the disk filling up 
   (probably during the pull that thus populated the object database with
   partially written objects)

   In particular, the 4d4d30be967d3284cbf59afd4fba6ab536e295f5 object was 
   corrupt. fsck gave a confusing error message:

	error: 4d4d30be967d3284cbf59afd4fba6ab536e295f5: object not found
	error: c03590b581d51d5fa43adbef9415e935d0229412: object not found

   which is really because the _file_ for that object does exist, but the 
   file doesn't actually contain the object it expects (due to 
   corruption), so the object wasn't "found". 

 - git-fsck-objects complained about them, but it doesn't actually do 
   anything about it (which you maybe expected it to do - it doesn't 
   really act as a filesystem fsck which tries to _fix_ things, it really 
   just does the "check" part, since "fixing" things is almost always a 
   manual operation)

 - "git prune" actually removed all the unreachable objects, and since 
   none of the _reachable_ objects were broken, that makes 
   git-fsck-objects shut up too.

 - your "git pull" failed, because it was fetching objects that were 
   corrupt in your local database - and the rule is that local objects 
   ALWAYS override remote objects. That's an important security thing (a 
   "pull" is _never_ allowed to overwrite something you already have, and 
   it doesn't matter if it's corrupt or not, you're not ever going to have 
   a "git pull" overwriting old data)

> So it seems the tree was more or less fine (it just has some useless objects
> because of the disk full failure), the bug seems to be that pull/push fail.

Not a bug. See above. It's really a very important safety feature: we 
never EVER overwrite any old objects. Even if they are corrupt. But it 
means that you need to _fix_ any corruption in order to use the 
repository. 

That's a security feature. It's a feature because git absolutely ALWAYS 
considers the "local repository" to be the trustworthy one. It matters not 
a whit if git thinks a local object may be corrupt - the local copy is 
_still_ considered to always be the definite copy. It's part of what makes 
git stable.

You may not think that sounds "stable" to you right now, in that it made 
it harder to "fix" the problem, but it indirectly means that even a 
_buggy_ git binary (say, you by mistake use an older git binary that 
doesn't understand some new object format) will never overwrite data that 
you already had. That's true safety. 

It does mean that if you have a corrupt database, you really do need to 
fix it first, but it's _still_ a safety feature: git won't fix the 
database for you "by mistake". You need to fix it consciously.

That's true robustness.

			Linus
