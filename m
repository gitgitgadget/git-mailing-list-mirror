From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: git bisect and the merge from hell
Date: Fri, 3 Feb 2006 15:44:01 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602031531440.3969@g5.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F059F4AF6@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 00:44:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5Ab7-0003Th-DY
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 00:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946080AbWBCXoJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 18:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946004AbWBCXoJ
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 18:44:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23778 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946080AbWBCXoI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2006 18:44:08 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k13Ni4DZ017620
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 3 Feb 2006 15:44:05 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k13Ni1Y7003147;
	Fri, 3 Feb 2006 15:44:02 -0800
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F059F4AF6@scsmsx401.amr.corp.intel.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15558>



On Fri, 3 Feb 2006, Luck, Tony wrote:
> 
> So Len's mega-octopus merge wasn't a problem at all, but this is still
> all his fault :-)  I'll go beat on him.

Note that this _can_ be a problem with huge octopus merges.

If some bug only appears as a result of the interaction of two branches, 
doing a 12-way merge will make it harder to debug. Doing a "git bisect" 
will (correctly) pinpoint the merge as being the problem, but after that 
you're on your own as to how to debug it.

So _if_ it had been a merge error, there's two issues with that:

 - debugging merges is usually a bit less straightforward than debugging a 
   single well-defined changeset anyway.

 - especially an octopus-merge will cause "git-bisect" to be less 
   efficient, since it cannot be bisected, so if the bug is in the merge 
   itself, it will ask you to test _every_ _single_ top-of-branch before 
   the merge.

(Normally, testing 12 kernels would zoom in on a bug from 10.000 feet, and 
you'd have bisected a massive four-thousand commits. So having to test 12 
branch heads just to pinpoint a _single_ commit is "unusually expensive" 
by any standard for git bisection).

Anyway, had it been a merge bug, you should then have done:

 - check if it's simply a mis-merge. Do "git-diff-tree --cc" to see if 
   there were any conflicts, and check them out more closely to see 
   if maybe they were incorrectly fixed up.

   Normally, an octopus merge will never have any actual _manual_ 
   conflicts (the standard git tools shouldn't allow it), but there can 
   still be several branches that touch the same area and that could have 
   merged strangely.

If that doesn't get you anywhere, you'll literally have to go to the next 
step:

 - re-do the merges one by one, until the bug appears, or, if it's not 
   there once you've re-done them all, check what the differences are 
   (there _should_ be none, but see above on doing mis-merging) with the 
   final octopus one.

Anyway, for "normal" bugs (like this one apparently is), git-bisect 
shouldn't ever pinpoint a merge, since the bug hopefully was introduced 
somewhere _during_ the branch development, and not when it was merged 
back. Hopefully.

Anyway. The message you should take home from this is that "git bisect" 
handles merges perfectly well, and that at worst it might be less 
efficient and harder to debug - especially for octopus merges - but that 
both of those problems are likely (a) rare and (b) not insurmountable.

		Linus
