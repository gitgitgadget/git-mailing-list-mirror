From: Linus Torvalds <torvalds@osdl.org>
Subject: Careful object writing..
Date: Tue, 3 May 2005 12:15:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue May 03 21:07:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT2jR-0005lG-U8
	for gcvg-git@gmane.org; Tue, 03 May 2005 21:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVECTNP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 15:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVECTNP
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 15:13:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:43137 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261614AbVECTNK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 15:13:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j43JD7s4010980
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Tue, 3 May 2005 12:13:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j43JD7c8010857
	for <git@vger.kernel.org>; Tue, 3 May 2005 12:13:07 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I just pushed out the commit that tries to finally actually write the sha1
objects the right way in a shared object directory environment.

I used to be lazy, and just do "O_CREAT | O_EXCL" on the final name, but
that obviously is not very nice when it can result in other people seeing
objects that haven't been fully finalized yet.

So now I do it "right", and create a temporary file in the "top" object
directory, and then when it's all done, I do a "link()" to the final place
and unlink the original.

I also change the permission to 0444 before it gets its final name.

Two notes:

 - because the objects all get created initially in .git/objects rather 
   than in the subdirectory they get moved to, you can't use symlinks 
   to other filesystems for the 256 object subdirectories. The object 
   directory has to be one filesystem (but it doesn't have to be the same 
   one as you actually keep your working ddirectories on, of course)

 - The upside of this is that filesystem block allocators should do the 
   right thing. Instead of spreading the objects out (because they are in 
   different directories), they should be created together.

Anyway, somebody should double-check the thing. It _should_ now work
correctly over NFS etc too, and everything should be nice and atomic (and
with any half-way decent filesystem, it also means that even if you have a
system crash in the middle, you'll never see half-created objects).

NOTE NOTE NOTE! I have _not_ updated all the helper stuff that also write 
objects. So things like "git-http-pull" etc will still write objects 
directly into the object directory, and that can cause problems with 
shared usage. Same goes for "write_sha1_from_fd()" that rpull.c uses. I 
hope somebody will take a look at those issues..

Anyway, at least the really core operations should now really be
"thread-safe" in a shared object directory environment.

		Linus
