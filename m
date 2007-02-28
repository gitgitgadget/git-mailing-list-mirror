From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: My git repo is broken, how to fix it ?
Date: Wed, 28 Feb 2007 08:19:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702280802150.12485@woody.linux-foundation.org>
References: <200702281036.30539.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0702272039540.12485@woody.linux-foundation.org>
 <200702281754.42383.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 17:19:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMRWh-00039U-4G
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 17:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbXB1QTc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 11:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbXB1QTc
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 11:19:32 -0500
Received: from smtp.osdl.org ([65.172.181.24]:59966 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577AbXB1QTb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 11:19:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1SGJThB019705
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Feb 2007 08:19:29 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1SGJSmW019653;
	Wed, 28 Feb 2007 08:19:29 -0800
In-Reply-To: <200702281754.42383.litvinov2004@gmail.com>
X-Spam-Status: No, hits=-0.44 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40955>



On Wed, 28 Feb 2007, Alexander Litvinov wrote:
>
> >  - replace any broken and/or missing objects
> >
> >    This is the challenging part. Sometimes (hopefully often!) you can find
> >    the missing objects in other copies of the repositories. At other
> >    times, you may need to try to find the data some other way (for
> >    example, maybe your checked-out copy contains the file content that
> >    when hashed will be the missing object?).
> 
> Thanks for answer. I have found this blob in cloned repo. I just copy it into 
> objects subdir and repack repo again. fsck works without any errors.

Good to hear.

It would probably be good to

 - try to figure out why things got corrupted in the first place.

   In particular, we should probably check our (my) assumption that the 
   file rename on cygwin is atomic. Your comment that you use ^C a lot 
   makes me worry that something basically caused an incomplete write or 
   other thing to happen..

   To be more precise, git will actually start off trying to do a "link + 
   unlink" pair, because that is the safest thing to do on a UNIX 
   filesystem: if the linked target already exists, we won't overwrite it 
   (and the git data consistency rules have always been: honor existing 
   data over new one, and *never* change anything that has already been 
   written).

   But I would not be shocked to hear that the "link + unlink" sequence 
   ends up being emulated under cygwin as a "copy + delete" due to lack of 
   hardlinks or something.

   Also, even if the link fails, and git then falls back to "rename()" 
   (since some filesystems don't do hardlinks at all, or limit them to one 
   particular directory), I would _still_ not be totally surprised if the 
   rename got emulated as a copy/delete for some strange Windows reason.

   There are other possibilities for corruption, of course: just plain 
   disk corruption, or (again) some other subtle cygwin emulation or 
   Windows issue could bite us. 

 - Even under UNIX, I'm not entirely sure about http/ftp/rsync transfers. 
   rsync in particular doesn't check anything at all, but last I looked, 
   the http fetcher was also doing things like checking the integrity of 
   the object *after* it had already moved it to its final resting place 
   (which is again unsafe with ^C).

   In general, I strongly suggest that people use the "native git" 
   pack-transfers. The "dumb protocol" transfers are called "dumb" for a 
   reason..

 - It would probably be good to write up the "How to recover" thing, 
   regardless of why any corruption happens. It doesn't matter if you're 
   under UNIX and using native protocols, and just being careful as hell: 
   disks get corrupted, sh*t happens, alpha-particles in the wrong place 
   do bad things to memory cells. And bugs _are_ inevitable, even if 
   we've been pretty damn good about these things.

   So it's important for people to know what the limits on corruption are, 
   and tell people that regardless of how stable the git data structures 
   are, if you care about your data, you need to have things in multiple 
   places (and no, RAID is _not_ the answer either, even if it can be a 
   small _part_ of doing things well).

Anybody?

		Linus
