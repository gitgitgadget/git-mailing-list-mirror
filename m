From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 10:19:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702140958440.3604@woody.linux-foundation.org>
References: <17875.13564.622087.63653@lisa.zopyra.com>
 <7vhctor78j.fsf@assigned-by-dhcp.cox.net> <17875.17647.74882.218627@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 19:20:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHOjk-0000uN-8L
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 19:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbXBNSUI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 13:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbXBNSUI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 13:20:08 -0500
Received: from smtp.osdl.org ([65.172.181.24]:38254 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932426AbXBNSUG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 13:20:06 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1EIJwhB010735
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Feb 2007 10:19:58 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1EIJrso005066;
	Wed, 14 Feb 2007 10:19:55 -0800
In-Reply-To: <17875.17647.74882.218627@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.407 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39719>



On Wed, 14 Feb 2007, Bill Lear wrote:
>
> % git fsck-objects --full
> error: Packfile .git/objects/pack/pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack SHA1 mismatch with itself

This in itself could have been due to a historical buglet that shouldn't 
matter (SHA1 on pack-files got miscomputed). However, that's probably NOT 
the problem, since:

> fatal: failed to find delta-pack base object 90bad0d280a6d7c155bbd9582b35ffcf5e3bdd27

implies that the pack really is corrupt.

Even a single-bit error will corrupt a pack in bad ways, which is one 
reason why we're so careful with it and add its own SHA1 to the end.

The best way to proceed:

 - MAKE A BACKUP ("tar" up everything). If for no other reason than

   (a) then you don't have to worry about making things worse even by 
       mistake
   (b) it might be interesting for others (if you can make those 
       pack-files available) to try to figure out what exactly the 
       corruption was. We've done it before, when it turned out to be a 
       single-bit error.

 - if you have other git archives or just back-ups of everything, just use 
   them, and throw the corrupt one away entirely (but see above on why 
   it's nice to have an archive of the corruption for posterity anyway)

 - if you don't, you can try "git unpack-objects -r". See the man-page on 
   why you need to first _move_ the pack-file away:

	mv <bad-pack-file> .git/bad-pack.pack
	mv <bad-pack-index> .git/bad-index.index

	git unpack-objects -r < .git/bad-pack.pack

   this will unpack as many objects into loose format as it can. Hopefully 
   you haven't lost much.

 - after that, the ones that you *did* lose, you can hopefully find in 
   older git repos: even if you didn't have the *full* new repo anywhere 
   else, other git repositories may have the particular objects that got 
   corrupted. "git fsck" will tell you what is missing, and you can just 
   point your .git/info/alternates file at other repositories to "steal" 
   objects from automatically.

 - if you aren't missing any objects after that, you can now repack the 
   repository, and then remove the alternates file:

	git repack -a -d
	rm .git/info/alternates

   because the repack will steal all the objects you need, and thus you 
   don't need alternates any more.

Finally: it would be very interesting to hear if you do something strange 
or unusual that could have made your chances of getting corruption higher.

Have you ever seen random SIGSEV's or strange oopses, which could be a 
sign of memory corruption on your machine? Do you do a lot of things over 
NFS? (which really can corrupt things, especially in circumstances with 
dodgy ethernet chips: the UDP checksums are very weak, and some ethernet 
cards do not do a good job of checking the ethernet CRC's!).

> So, all I did was try to do a commit with the new git ... haven't
> recloned, or pulled from upstream...

Yes, don't do anything more (certainly do *not* repack or anything) until 
you have tarred up and saved the current state, and then only _after_ you 
have a good safe archive to restart from, try to fix it up.

And if you can make the git history available to outsiders, I'd love to 
see the corrupt tar-file (it doesn't have to be *public*, if you just can 
trust me and perhaps a few other people with the data).

So far, as far as I can recall, we've certainly had people screw up their 
own trees by mistake, but apart from that kind of "user error" things, the 
only real corruption I recall was the single-bit error in a pack-file. We 
were able to recover that, but in general, for safety, the best way to 
protect your data is to replicate it across multiple independent machines 
(something that git is _good_ at, happily).

		Linus
