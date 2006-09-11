From: linux@horizon.com
Subject: Re: Change set based shallow clone
Date: 11 Sep 2006 10:26:44 -0400
Message-ID: <20060911142644.32313.qmail@science.horizon.com>
References: <17669.8191.778645.311304@cargo.ozlabs.ibm.com>
Cc: git@vger.kernel.org, jonsmirl@gmail.com, linux@horizon.com
X-From: git-owner@vger.kernel.org Mon Sep 11 16:27:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMmkk-0000ly-V1
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 16:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWIKO0x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 10:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWIKO0x
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 10:26:53 -0400
Received: from science.horizon.com ([192.35.100.1]:37197 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751193AbWIKO0w
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 10:26:52 -0400
Received: (qmail 32314 invoked by uid 1000); 11 Sep 2006 10:26:44 -0400
To: paulus@samba.org, torvalds@osdl.org
In-Reply-To: <17669.8191.778645.311304@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26851>

> Could we do a cache of the refs that stores the stat information for
> each of the files under .git/refs plus the sha1 that the ref points
> to?  In other words this cache would do for the refs what the index
> does for the working directory.  Reading all the refs would mean we
> still had to stat each of the files, but that's much quicker than
> reading them in the cold-cache case.  In the common case when most of
> the stat information matches, we don't have to read the file because
> we have the sha1 that the file contains right there in the cache.

Well, that could save one of two seeks, but that's not *much* quicker.
(Indeed, a git ref would fit into the 60 bytes of block pointer space
in an ext2/3 inode if regular files were stuffed there as well as symlinks.)

> Ideally we would have two sha1 values in the cache - the sha1 in the
> file, and if that is the ID of a tag object, we would also put the
> sha1 of the commit that the tag points to in the cache.

Now that's not a bad idea.  Hacking it in to Linus's scheme, that's

<foo sha>\t<foo^{} sha>\tfoo


A couple of thoughts:
1) I bet Hans Reiser is enjoying this; he's been agitating for better
   lots-of-small-files support for years.

2) Since I've written about two caches in a few minutes (here
   and in git-rev-list), a standardized cache validation hook for
   git-fsck-objects and git-prune's use might be useful.

3) If we use Linus's idea of a flat "static refs" file overridden by loose
   refs (presumably, refs would be stuffed in if their mod times got old
   enough, and on initial import you'd use the timestamp of the commit
   they point to), we'll have to do a bit of a dance to move refs to and
   from it.

   Basically, to move refs into the refs file, it's
   - Read all the old refs and loose refs and write the new refs file.
   - Rename the new refs file into place.
   - For each loose ref moved in, lock it, verify it hasn'd changed,
     and delete it.
   with some more locking to prevent two people from doing this at once.

   Folks looking up tags will do an FS search, then validate their refs
   file cache, then if necessary, suck in the refs file.

   Now, exploding a refs file into loose refs is tricky.  There's
   the possible race condition with a reader:

   A: Looks for loose ref "foo", doesn't find it.
		B: Write out loose ref "foo"
		B: Deletes now-unpacked refs file
   A: Looks for refs file, doesn't find it.
   A: Concludes that ref "foo" doesn't exist.

   The only solution I can think of is to stat the refs file at the
   start of the operation and restart from the beginning if it changes
   by the time it actually opens and read it.
