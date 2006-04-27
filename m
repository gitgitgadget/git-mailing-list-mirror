From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: bug: git-repack -a -d produces broken pack on NFS
Date: Thu, 27 Apr 2006 16:54:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604271630030.3701@g5.osdl.org>
References: <20060427213207.GA6709@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 01:54:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZGJu-00076Y-Lg
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 01:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWD0Xys (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 19:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWD0Xyr
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 19:54:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34945 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751768AbWD0Xyr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Apr 2006 19:54:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3RNsZtH008670
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Apr 2006 16:54:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3RNsYNk018165;
	Thu, 27 Apr 2006 16:54:35 -0700
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060427213207.GA6709@steel.home>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19254>


Ok, trying to think some more about this..

On Thu, 27 Apr 2006, Alex Riesen wrote:
> 
> $SRC/linux.git$ git repack -a -d
> Generating pack...
> Done counting 235947 objects.
> Deltifying 235947 objects.
>  100% (235947/235947) done
> Writing 235947 objects.
>  100% (235947/235947) done
> Total 235947, written 235947 (delta 182131), reused 235466 (delta 181650)
> Pack pack-6dcda5a7782864d57ec44bd30ebec13b07df2c87 created.
> $SRC/linux.git$ git fsck-objects --full
> git-fsck-objects: error: Packfile .git/objects/pack/pack-6dcda5a7782864d57ec44bd30ebec13b07df2c87.pack SHA1 mismatch with idx

This is interesting on so many levels.

First off, the index file or the pack-file is clearly somehow corrupt, 
because when you then try to do the "git clone" off the result later on 
(which won't actually check the SHA1's), it gets

> git-index-pack: fatal: packfile '/mnt/large/tmp/raa/tmp/.git/objects/pack/tmp-wcRvk5': bad object at offset 102601801: inflate returned -3

which means that either the offset was wrong, or the data at that offset 
was wrong.

That made me suspect the object re-use code - it might have been broken in 
the original pack, and then on re-use the broken data would have been just 
copied over.

HOWEVER - that doesn't actually fly as an explanation, because even if the 
data itself was broken, the repack would have re-generated the SHA1, so if 
the problem had been about copying an already broken pack over, you'd have 
gotten the "git clone" error, but you would _not_ have gotten the "pack 
SHA1 does not match index" error.

So in order for the SHA1 to not match, we literally must have corrupted 
things when we created the pack-file.

However, I've stared and stared at the sha1file writing code, and I don't 
see how you _could_ corrupt it. We use it with interruptible file 
descriptors all the time (sockets - the exact same code is used to 
transfer packs over the network), and that "intr" shouldn't matter one 
whit. We're doing very safe things, as far as I can tell.

The thing is, even if a wild pointer corrupts the write buffer for the 
sha1file writing code somehow, we actually always do the "calculate the 
SHA1" and "flush the buffer to the file" together. So even if somebody 
corrupted the buffer, we'd still generate the "right" SHA1 (of the 
corrupted buffer).

So the only thing that I can see that can generate bad SHA1 checksums is
 - actual problem in the SHA1 buffers themselves (ie a wild pointer 
   corrupting the "SHA1_CTX" thing itself)
 - real filesystem corruption. With NFS, the UDP checksums aren't all that 
   strong, but the ethernet CRC should catch things (there have been 
   reports of network cards that don't check the CRC well, but quite 
   frankly, I haven't seen one in a _loong_ time)
 - RAM corruption and/or kernel NFS bugs.

I'll continue to stare at the code, but I can't see anything even remotely 
suspicious in git itself so far.

		Linus
