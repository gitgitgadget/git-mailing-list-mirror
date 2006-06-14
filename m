From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Repacking many disconnected blobs
Date: Wed, 14 Jun 2006 11:52:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606141146310.5498@g5.osdl.org>
References: <1150269478.20536.150.camel@neko.keithp.com> 
 <Pine.LNX.4.64.0606140826200.5498@g5.osdl.org> <1150307715.20536.166.camel@neko.keithp.com>
 <Pine.LNX.4.64.0606141113130.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 20:52:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqaTd-0000eP-1C
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 20:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWFNSwZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 14:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWFNSwZ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 14:52:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38083 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750763AbWFNSwZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 14:52:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5EIqMgt003942
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Jun 2006 11:52:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5EIqLl6015080;
	Wed, 14 Jun 2006 11:52:22 -0700
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <Pine.LNX.4.64.0606141113130.5498@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21851>



On Wed, 14 Jun 2006, Linus Torvalds wrote:
> 
> You don't _need_ to shuffle. As mentioned, it will only affect the 
> location of the data in the pack-file, which in turn will mostly matter 
> as an IO pattern thing, not anything really fundamental.  If the pack-file 
> ends up caching well, the IO patterns obviously will never matter.

Actually, thinking about it more, the way you do things, shuffling 
probably won't even help.

Why? Because you'll obviously have multiple files, and even if each file 
were to be sorted "correctly", the access patterns from any global 
standpoint won't really matter, becase you'd probably bounce back and 
forth in the pack-file anyway.

So if anything, I would say

 - just dump them into the packfile in whatever order is most convenient

 - if you know that later phases will go through the objects and actually 
   use them (as opposed to just building trees out of their SHA1 values) 
   in some particular order, _that_ might be the ordering to use.

 - in many ways, getting good delta chains is _much_ more important, since 
   "git repack -a -d" will re-use good deltas from a previous pack, but 
   will _not_ care about any ordering in the old pack. As well as 
   obviously improving the size of the temporary pack-files anyway.

I'll pontificate more if I can think of any other cases that might matter.

		Linus
