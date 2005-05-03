From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and symlinks as tracked content
Date: Tue, 3 May 2005 12:02:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
References: <1115145234.21105.111.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 20:55:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT2Xb-0001mR-9q
	for gcvg-git@gmane.org; Tue, 03 May 2005 20:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVECTAw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 15:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVECTAw
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 15:00:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:63209 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261596AbVECTAe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 15:00:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j43J0Ws4009819
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 May 2005 12:00:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j43J0Vu6010338;
	Tue, 3 May 2005 12:00:32 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <1115145234.21105.111.camel@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 3 May 2005, Kay Sievers wrote:
>
> Is there a sane model to make git aware of tracking symlinks in the
> repository? In the bk udev tree we've had a test sysfs-tree with a lot
> of symlinks in it.
> 
> Where can we store the link-target? In its own blob-object or directly
> in the tree-object?

I'd suggest you create a blob object with the symlink name, and then in
the tree you point to that blob, but with the S_IFLNK value in the mode
field (0120000).

So you have

 - directories: S_IFDIR (0040000) point to "tree" objects for contents
 - symlinks: S_IFLNK (0120000) point to "blob" objects
 - executables: S_IFREG | 0755 (0100755) point to "blob" objects
 - regular files: S_IFREG | 0644 (0100644) point to "blob" objects

which seems very sane and regular. 

Now, I also haev a plan for device nodes, but that one is so ugly that I'm 
a bit ashamed of it. That one does:

 - S_IFCHR/S_IFBLK (0020000 or 0060000), with the 20-byte SHA1 not being a 
   SHA1 at all, but just the major:minor numbers in some nice binary 
   encoding. Probably: two network byte order 32-bit values, with twelve 
   bytes of some non-zero signature (the SHA1 of all zeroes should be 
   avoided, so the signature really should be soemthing else than just 
   twelve bytes of zero).

That should cover most of it.

> How would a exported "patch" with symlinks as content look like?

The easiest way is to make this exactly the same as the "executable bit". 
A symlink is just a normal blob, it just has a "symlink mode" instead of 
"0755" or "0644" mode.

When you think of it that way, the "patch" ends up falling out very 
naturally, I think. It would look like

	New file: filename (Mode: 0120000)
	--- /dev/null
	+++ filename
	@@ 0,0 1,1
	+symlink-value

(or something, you get the idea).

		Linus
