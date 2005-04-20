From: Linus Torvalds <torvalds@osdl.org>
Subject: WARNING! Object DB conversion (was Re: [PATCH] write-tree performance
 problems)
Date: Wed, 20 Apr 2005 02:08:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com> <200504191708.23536.mason@suse.com>
 <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org> <200504192049.21947.mason@suse.com>
 <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org> <42660708.60109@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Mason <mason@suse.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 11:07:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOBA2-0001kZ-6A
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 11:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVDTJKN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 05:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVDTJKM
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 05:10:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:4501 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261516AbVDTJGf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 05:06:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3K96Ss4006148
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 02:06:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3K96Rv4028031;
	Wed, 20 Apr 2005 02:06:27 -0700
To: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <42660708.60109@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



I converted my git archives (kernel and git itself) to do the SHA1 hash 
_before_ the compression phase.

So I'll just have to publically admit that everybody who complained about 
that particular design decision was right. Oh, well.

On Wed, 20 Apr 2005, H. Peter Anvin wrote:
> Linus Torvalds wrote:
> > 
> > So I'll see if I can turn the current fsck into a "convert into
> > uncompressed format", and do a nice clean format conversion. 
> > 
> 
> Just let me know what you want to do, and I can trivially change the 
> conversion scripts I've already written to do what you want.

I actually wrote a trivial converter myself, and while I have to say that 
this object database conversion is a bit painful, the nice thing is that I 
tried very hard to make it so that the "git" programs will work with both 
a pre-conversion and a post-conversion database.

The only program where that isn't true is "fsck-cache", since fsck-cache
for obvious reasons is very very unhappy if the sha1 of a file doesn't
match what it should be. But even there, a post-conversion fsck will eat
old objects, it will just warn about a sha1 mismatch (and eventually it
will refuse to touch them).

Anyway, what this means is that you should be actually able to get my
already-converted git database even using an older version of git: fsck
will complain mightily, so don't run it.

What I've done is to just switch the SHA1 calculation and the compression
around, but I've left all other data structures in their original format,
including the low-level object details like the fact that all objects are
tagged with their type and length.

As a result, the _only_ thing that breaks is that a new object will not
have a SHA1 that matches the expectations of an old git, but since
_checking_ the SHA1 is only done by fsck, not normal operations, all
normal ops should work fine.

So to convert your old git setup to a new git setup, do the following:

 - save your old setup. Just in case. I've converted my whole kernel tree 
   this way, so it's actually tested and I felt comfortable enough with it 
   to blow the old one away, but never take risks.

 - do _not_ update to my new version first. Instead, while you still have 
   an fsck that is happy with your old archive, make sure to fsck 
   everything you have with

	fsck-cache --unreachable $(cat .git/HEAD)

   and it shouldn't complain about anything. Use "git-prune-script" to 
   remove dangling objects if you want.

   (If you read this after you already updated, no worries - everything 
   should still work. It's just a good idea to verify your old repo first)

 - update to my new git tools. checkout, build, install

 - convert your git object database with

	convert-cache $(cat .git/HEAD)

   which will give you a new head object. Just for fun, you can 
   double-check that "re-converting" that head object should always result
   in the same head object. If it doesn't, something is wrong.

 - take the new head object, and make it your new head:

	echo xxxxxx > .git/HEAD

 - run the new "fsck-cache". It should complain about "sha1 mismatch" for 
   all your old objects, and they should all be unreachable (and you 
   should have two root objects: your old root and your new root)

 - run "git-prune-script" to remove all the unreachable objects (which are 
   all old).

 - run "fsck-cache --unreachable $(cat .git/HEAD)" with the new fsck
   again, just to check that it is now quiet.

 - blow your old index file away by re-reading your HEAD tree:

	cat-file commit $(cat .git/HEAD)
	read-tree .....

 - "update-cache --refresh"

Doing this on the git repository is nearly instantaneous. Doing it on the
kernel takes maybe a minute or so, depending on how fast your machine is.

Sorry about this, but it's a hell of a lot simpler to do it now than it
will be after we have lots of users, and I've really tried to make the
conversion be as simple and painless as possible.

And while it doesn't matter right now (since git still does exactly the
same - I did the minimal changes necessary to get the new hashes, and
that's it), this _will_ allow us to notice existing objects before we
compress them, and we can now play with different compression levels
without it being horribly painful.

				Linus
