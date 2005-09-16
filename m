From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Avoid building object ref lists when not needed
Date: Fri, 16 Sep 2005 15:17:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509161505410.26803@g5.osdl.org>
References: <Pine.LNX.4.58.0509161446100.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 17 00:18:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGOWd-0001ua-G3
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 00:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVIPWRl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 18:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVIPWRl
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 18:17:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16017 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750722AbVIPWRk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 18:17:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8GMHXBo021477
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Sep 2005 15:17:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8GMHVk7016558;
	Fri, 16 Sep 2005 15:17:32 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0509161446100.26803@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8738>



On Fri, 16 Sep 2005, Linus Torvalds wrote:
> 
> and note how the number of pages touched by git-rev-list for this
> particular object list has shrunk from 26,718 (104 MB) to 18,509 (72 MB).

One final note: since I'm only looking at the total page footprint for the 
process, this _includes_ all the mmap faults of not just the executable, 
but since my kernel is usign a packed archive, also the actual mapping of 
the pack itself.

The pack itself is 76MB in size, but obviously not all of it actually
needs to be read in. For example, it doesn't need to actually read any of
the objects themselves (that's done by the actual packing phase), so we're
only touching the "commit" and "tree" parts of the pack.

Of the 72MB, valgrind reports that "only" about 24MB is now used for
actual malloc'ed memory. So while the _total_ "touched pages" have shrunk
from 187 MB (when I started) to 72 MB (now), the malloc()'ed memory has
actually shrunk a lot more (all the savings have been by either avoiding 
allocations altogether, or by freeing them as soon as we can).

I'm done for the while. There are small wins still to be had, but they are 
smaller and harder to reach. Maybe I'll get a spurt of energy one of these 
days, so if somebody finds a particularly problematic load, tell me.

		Linus
