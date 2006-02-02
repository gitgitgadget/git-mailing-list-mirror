From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The merge from hell...
Date: Wed, 1 Feb 2006 23:51:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602012334360.21884@g5.osdl.org>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
 <7v8xsuuto5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>,
	Len Brown <len.brown@intel.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 08:52:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4ZGI-0000We-Vg
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 08:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423362AbWBBHwG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 02:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423364AbWBBHwG
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 02:52:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54924 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423361AbWBBHwE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 02:52:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k127paDZ023643
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Feb 2006 23:51:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k127pYlc008739;
	Wed, 1 Feb 2006 23:51:35 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xsuuto5.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15491>



On Wed, 1 Feb 2006, Junio C Hamano wrote:
> 
> > It's commit 9fdb62af92c741addbea15545f214a6e89460865, and passing it to 
> > git-diff-tree with the "--cc" option seems to do the largely the right 
> > thing (although arguably, since one of the parents always matches the end 
> > result in all the files, it shouldn't have shown anything at all, so I 
> > think it could do with some tweaking).
> 
> Hmph.  Do you mean a hunk like this?
> 
> diff --cc kernel/sys.c
> @@@@@@@@@@@@@ +33,7 @@@@@@@@@@@@@
> 
>             #include <linux/compat.h>
>             #include <linux/syscalls.h>
>    + +++    #include <linux/kprobes.h>
> 
>             #include <asm/uaccess.h>
>             #include <asm/io.h>

Yes.

> Currently I cull hunks that have changes from only one parent,
> or when the changes are the same from all but one parent.  This
> hunk does not match either criteria.

Correct. I think "git-diff-tree --cc" actually works as you advertized, 
but that we should change the rules. More akin to

 - if there are only two versions of a hunk, and one of those versions 
   ended up in the result, the hunk is considered successfully merged
   and should be ignored under "--cc"

Under that rule, the kernel/sys.c hunk you specify is indeed 
uninteresting, because there are only two versions: the version that 
didn't have the addition, and the version that did.

> or "plus and minus in the same set of columns" hunks.  If I did
> so, this would become uninteresting:
> 
> diff --cc arch/ia64/pci/pci.c
> @@@@@@@@@@@@@ +709,7 @@@@@@@@@@@@@
>              */
>             int ia64_pci_legacy_write(struct pci_dev *bus, u16...
>             {
>   ------ -  	int ret = 0;
>   ++++++ +  	int ret = size;
>             
>             	switch (size) {
>             	case 1:

Yes. Again, only two versions. Either it was "ret = 0" or it was "ret = 
size". No other version existed in any branch or in the end result, so 
there really were only two versions, and one of them ended up being the 
end result.

> But this is still interesting:
> 
> @@@@@@@@@@@@@ +308,35 @@@@@@@@@@@@@
>             			goto end;
>             		}
>             	}
>   --        	cx->usage++;
>   --        
>             
>      +++    #ifdef CONFIG_HOTPLUG_CPU
>      +++    	/*

Not under my suggested "two version" rule.

The above has _three_ versions: the one with no changes, the one with 
"cx->usage++" removed and the one with "#ifdef CONFIG_HOTPLUG_CPU" added.

So under the two-version rule, the last one would still be interesting.

> > git-diff-tree takes almost three seconds to get its result, though.
> 
> One trivial thing I should be able to do to speed things up is
> to reuse previous diff with other parents.

Yes. In this example, it would apparently cut down the work by a third for 
that file, although it migt make it harder to calculate the proper "-/+" 
patterns..

> I did not expect anybody to be _that_ sick (eh, pardon my
> language) to do a 12-way octpus, so I did not consider this
> optimization possibility, but I should be doing only 4 diffs to
> format -c for this commit.  Currently I do 12.

I agree, I wouldn't have considered that 12-way merge sane either, but 
hey, it worked, and our octopus merge rules are simple enough that I guess 
there's not really any downside to it.

And I was actually happy to have "git-diff-tree --cc" to look at it, and 
that "gitk" eventually gave results that looked decent. I didn't go 
through it all that closely, but the ones I _looked_ at looked fine, and 
it was mighty pleasant to have the tools to look more closely.

So thanks for "--cc" yet again.

> > So think of it as a correctness/scalability test.
> 
> Heh.  I like this one as a practice.  Thanks!

Thank Len. He may have done it as a way to avoid having extra merges, 
since I complained about those last time ;)

		Linus
