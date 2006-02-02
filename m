From: Junio C Hamano <junkio@cox.net>
Subject: Re: The merge from hell...
Date: Wed, 01 Feb 2006 23:05:46 -0800
Message-ID: <7v8xsuuto5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 08:05:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4YXP-0006xd-Tt
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 08:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423039AbWBBHFt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 02:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423085AbWBBHFt
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 02:05:49 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:38638 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1423039AbWBBHFs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2006 02:05:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060202070553.CBIJ25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Feb 2006 02:05:53 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 1 Feb 2006 22:28:56 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15487>

Linus Torvalds <torvalds@osdl.org> writes:

>  I've been holding off on having octopus merges in the kernel tree, but I 
> just merged an ACPI update that had used one of them, and I didn't really 
> see any real reason not to take it.
>
> That octopus commit has got _twelve_ parents.

Len must have been smoking something really good.  Even I would
not attempt to do such an octopus and expect to keep my sanity,
but why not? ;-)

> It's commit 9fdb62af92c741addbea15545f214a6e89460865, and passing it to 
> git-diff-tree with the "--cc" option seems to do the largely the right 
> thing (although arguably, since one of the parents always matches the end 
> result in all the files, it shouldn't have shown anything at all, so I 
> think it could do with some tweaking).

Hmph.  Do you mean a hunk like this?

diff --cc kernel/sys.c
@@@@@@@@@@@@@ +33,7 @@@@@@@@@@@@@

            #include <linux/compat.h>
            #include <linux/syscalls.h>
   + +++    #include <linux/kprobes.h>

            #include <asm/uaccess.h>
            #include <asm/io.h>

Currently I cull hunks that have changes from only one parent,
or when the changes are the same from all but one parent.  This
hunk does not match either criteria.

Instead I could cull all hunks that have either "all whitespace"
or "plus and minus in the same set of columns" hunks.  If I did
so, this would become uninteresting:

diff --cc arch/ia64/pci/pci.c
@@@@@@@@@@@@@ +709,7 @@@@@@@@@@@@@
             */
            int ia64_pci_legacy_write(struct pci_dev *bus, u16...
            {
  ------ -  	int ret = 0;
  ++++++ +  	int ret = size;
            
            	switch (size) {
            	case 1:

But this is still interesting:

@@@@@@@@@@@@@ +308,35 @@@@@@@@@@@@@
            			goto end;
            		}
            	}
  --        	cx->usage++;
  --        
            
     +++    #ifdef CONFIG_HOTPLUG_CPU
     +++    	/*


> git-diff-tree takes almost three seconds to get its result, though.

One trivial thing I should be able to do to speed things up is
to reuse previous diff with other parents.  For example, that
commit does this to kernel/sys.c from its 12 parents.

:100644 100644 d09cac2... 0929c69... M  kernel/sys.c
:100644 100644 eecf845... 0929c69... M  kernel/sys.c
:100644 100644 c3b1874... 0929c69... M  kernel/sys.c
:100644 100644 bce933e... 0929c69... M  kernel/sys.c
:100644 100644 eecf845... 0929c69... M  kernel/sys.c
:100644 100644 bce933e... 0929c69... M  kernel/sys.c
:100644 100644 bce933e... 0929c69... M  kernel/sys.c
:100644 100644 bce933e... 0929c69... M  kernel/sys.c
:100644 100644 eecf845... 0929c69... M  kernel/sys.c
:100644 100644 eecf845... 0929c69... M  kernel/sys.c
:100644 100644 eecf845... 0929c69... M  kernel/sys.c
:100644 100644 eecf845... 0929c69... M  kernel/sys.c

Running "sort -u" on these would leave only 4 lines.

I did not expect anybody to be _that_ sick (eh, pardon my
language) to do a 12-way octpus, so I did not consider this
optimization possibility, but I should be doing only 4 diffs to
format -c for this commit.  Currently I do 12.

> So think of it as a correctness/scalability test.

Heh.  I like this one as a practice.  Thanks!
