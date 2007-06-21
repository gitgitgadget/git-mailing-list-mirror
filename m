From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 21 Jun 2007 10:16:46 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706211005520.3593@woody.linux-foundation.org>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net> <7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
 <7vd50xz7lq.fsf@assigned-by-dhcp.cox.net> <7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
 <7virac547s.fsf@assigned-by-dhcp.cox.net> <7v6466oygl.fsf@assigned-by-dhcp.cox.net>
 <7vfy54tt3l.fsf@assigned-by-dhcp.cox.net> <7vtztbbnsq.fsf@assigned-by-dhcp.pobox.com>
 <7v4pl1zsd7.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 19:16:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1QHD-0000xO-6j
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 19:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173AbXFURQ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 13:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754876AbXFURQ5
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 13:16:57 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45403 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753992AbXFURQ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jun 2007 13:16:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5LHGpct014642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2007 10:16:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5LHGktl000791;
	Thu, 21 Jun 2007 10:16:46 -0700
In-Reply-To: <7v4pl1zsd7.fsf@assigned-by-dhcp.pobox.com>
X-Spam-Status: No, hits=-2.536 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50646>



On Thu, 21 Jun 2007, Junio C Hamano wrote:
> 
> Also I am not convinced its handling of merges is sane.  If you
> have an ancestry graph like this, and the commit A renames the
> followed path, it would show the file _before_ rename, which is
> very good.
> 
>       o-------B---A---o----o
>                      /  
>         o----C------'

I agree. That's even what I tried to explain (but your graph is better) in 
my commit message, when I was talking about how it linearizes the history 
in "git log" order, and decides that renames happen "within that 
linearized" world.

You can actually see an *example* of this by doing

	git log --stat --follow arch/i386/pci/common.c

on the old historical Linux archive (the BK import one, not the bkcvs 
import - the latter has been linearized by bkcvs so won't show concurrent 
development anyway). 

What you get is:

	[ ... ]

	commit f9001d4262148fbfb7ecdcb88c73d9791c1ac0ad
	Author: Greg Kroah-Hartman <greg@kroah.com>
	Date:   Mon May 6 20:18:16 2002 -0700
	
	    Move arch/i386/kernel/pci/ to arch/i386/pci/
	
	 arch/i386/{kernel => }/pci/common.c |    0
	 1 files changed, 0 insertions(+), 0 deletions(-)
	
	commit bbb283cca10b2d2c935ae35327620ebae07f7d80
	Author: Patrick Mochel <mochel@segfault.osdl.org>
	Date:   Mon May 6 20:09:44 2002 -0700
	
	    Move arch/i386/kernel/pci/ to arch/i386/pci/
	
	 arch/i386/kernel/pci/common.c |  206 -----------------------------------------
	 1 files changed, 0 insertions(+), 206 deletions(-)

	[ ... ]

and this is an artifact of two _concurrent_ directory moves, and look at 
what "git log --follow" did: it actually found the rename (we looked at 
Greg's version first), but then *because* it found the rename, it is now 
starting to look at the *previous* name, which was

	arch/i386/kernel/pci/common.c

and when it then sees the rename in Pat's commit, it's no longer finding 
that previous entry as a "new file that got created" (which triggers the 
rename logic), but now it finds that filename has being *removed* (because 
the _old_ filename really did go away - it got renamed!)

This is 100% logical within that linearized history, but it's a bit 
surprising. But it's how "git log --follow" just works.

If you want to see the real history, you need to do it with "git blame", 
which actually understands about merges, or with some graphical viewer 
that would be extended to follow renames when it notices that a filename 
goes away.

But "git log" itself really fundamentally has no clue, and you really 
should see "git log" as a *linearization* thing. It linearizes the history 
by creating a one-dimensional streaming log. And within that linearized 
history, there can not be anything like "concurrent renames".

			Linus
