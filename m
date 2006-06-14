From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Repacking many disconnected blobs
Date: Wed, 14 Jun 2006 12:18:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606141212190.5498@g5.osdl.org>
References: <1150269478.20536.150.camel@neko.keithp.com> 
 <Pine.LNX.4.64.0606140826200.5498@g5.osdl.org>  <1150307715.20536.166.camel@neko.keithp.com>
  <Pine.LNX.4.64.0606141113130.5498@g5.osdl.org> <1150311567.30681.28.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 21:18:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqatB-0005vZ-QD
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 21:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWFNTSZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 15:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWFNTSY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 15:18:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17360 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750817AbWFNTSW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 15:18:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5EJIJgt005455
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Jun 2006 12:18:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5EJIIEE016031;
	Wed, 14 Jun 2006 12:18:19 -0700
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1150311567.30681.28.camel@neko.keithp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21853>



On Wed, 14 Jun 2006, Keith Packard wrote:
> 
> Ok, sounds like shuffling isn't necessary; the only benefit packing
> gains me is to reduce the size of each directory in the object store;

There's actually a secondary benefit to packing that turned out to be much 
bigger from a performance standpoint: the size benefit coupled with the 
fact that it's all in one file ends up meaning that accessing packed 
objects is _much_ faster than accessing individual files.

The Linux system call overhead is one of the lowest ones out there, but 
it's still much bigger than just a function call, and doing a full 
pathname walk and open/close is bigger yet. In contrast, if you access 
lots of objects and they are all in a pack, you only end up doing one mmap 
and a page fault for each 4kB entry, and that's it.

So packing has a large performance benefit outside of the actual disk use 
one, and to some degree that performance benefit is then further magnified 
by good locality (ie you get more effective objects per page fault), but 
in your case that locality issue is secondary.

I assume that you never actually end up looking at the _contents_ of the 
objects any more ever afterwards, because in a very real sense you're 
really interested in the SHA1 names, right? All the latter phases of 
parsecvs will just use the SHA1 names directly, and never actually even 
open the data (packed or not).

So in that sense, you only care about the disksize and a much improved 
directory walk from fewer files (until the repository has actually been 
fully created, at which point a repack will do the right thing).

			Linus
