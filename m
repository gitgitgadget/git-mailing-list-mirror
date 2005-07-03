From: Linus Torvalds <torvalds@osdl.org>
Subject: "Incremental packs"
Date: Sun, 3 Jul 2005 16:00:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507031543170.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Jul 04 01:01:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpDSg-0006ib-Ft
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 01:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVGCXBL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 19:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVGCXBL
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 19:01:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5605 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261560AbVGCXBC (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jul 2005 19:01:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j63N0ujA001016
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 3 Jul 2005 16:00:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j63N0qkG025544;
	Sun, 3 Jul 2005 16:00:54 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ok,
 I've changed things around a bit to make it much easier to create various 
incremental packs. It's still not the "just append everything" thing that 
Peter envisions, but it should hopefully be fairly usable in practice, and 
might even be worth trying on kernel.org now.

One big user-visible change: in order to allow multiple packs, where the 
pack-name itself does not cause clashes when you rsync them between 
repositories, I changed git-pack-objects to add the SHA1 of all the 
objects added to the pack to the name.

So when you do

	git-pack-objects pack

it will create two files: "pack-xyz.idx" and "pack-xyz.pack", where the 
"xyz" is the SHA1 of all the object names that were added to the pack. The 
command also writes that SHA1 to its standard output, so you can do

	packname=$(git-rev-list ... | git-pack-objects pack)

and "packname" will contain the part you're missing (ie then you can look
at "pack-$packname.idx" to see the index).

I've also added flags to make it possible to easily do "incremental 
packs", which just pack the stuff that wasn't already packed. So 
"git-rev-list --unpacked" will consider any packed commit to be 
un-interesting, and "git-pack-objects --incremental" will similarly just 
ignore any objects that already exist in a pack.

This, together with "git-rev-parse --all", which shows all the current 
refs, makes it possible to do "git repack", which basically boils down to

	packname=$(git-rev-list --unpacked --objects $(git-rev-parse --all) |
		git-pack-objects --non-empty --incremental .tmp-pack)

where "non-empty" means that if the list of objects is empty, we won't
create a pack at all (and git-pack-objects will not write any SHA1 to its 
stdout, so "packname" will be empty).

Look at "git repack" for all the small details if you care, but basically 
it's designed so that you can run "git repack" on a git archive every 
week, and it will create pack-files of any new data.

Now, once you actually trust the pack-files, you can then do

	git-prune-packed

which will remove all unpacked objects that are available in a pack. 
CAREFUL! Only do this once you trust the pack! "git repack" will not do 
this on its own.

The theory behind all this is that since the pack-files are now named 
according to their contents, they are also distributable exactly the same 
way the normal object files are, so you can still use "rsync" if you 
really want to distribute the resulting mess. A git-aware distribution is 
obviously preferable, but at least rsync won't corrupt any archive, and 
this allows you to get rid of the "millions of small files" effect.

It might be worth trying out on kernel.org. Peter, what do you think? 
Doing the initial "git repack" is pretty expensive, but then the weekly 
incremental packs should be pretty cheap. And it really should not be done 
very often, because then the pack-files end up just being many and small, 
which is what we're trying to avoid in the first place.

Oh, one (obvious) detail: in order for webgit to continue working,
www.kernel.org needs to have a recent enough git, of course.

		Linus
