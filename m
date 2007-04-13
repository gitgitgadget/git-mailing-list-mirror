From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fatal: Out of memory, malloc failed
Date: Fri, 13 Apr 2007 11:53:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704131143130.28042@woody.linux-foundation.org>
References: <461FBD02.6050105@eircom.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alan Larkin <nobrow@eircom.net>
X-From: git-owner@vger.kernel.org Fri Apr 13 20:54:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcQuJ-0004Vj-JH
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 20:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbXDMSxu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 14:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754132AbXDMSxu
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 14:53:50 -0400
Received: from smtp.osdl.org ([65.172.181.24]:46093 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754129AbXDMSxt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 14:53:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3DIrjIs029484
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 13 Apr 2007 11:53:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3DIri88006872;
	Fri, 13 Apr 2007 11:53:44 -0700
In-Reply-To: <461FBD02.6050105@eircom.net>
X-Spam-Status: No, hits=-0.457 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44424>



On Fri, 13 Apr 2007, Alan Larkin wrote:
> 
> Its not a huge push Im trying to do here (<about 150Mb) but always malloc fails!

Any huge objects?

Also, it might be interesting to run it under gdb, and put a breakpoint on 
the "die" function, so that it stops where it runs out of memory. Then. at 
that point, you can:

 - do a "where" in gdb to see what allocation it is (and ask it how big 
   it was by printing out the value of "size").

   It may be something totally uninteresting (just some random object that 
   happened to push things over the limit), but statistically, malloc 
   failures tend to happen to big objects, and sometimes just because 
   somebody needed a huge area that won't fit in the virtual address 
   space.

 - check with "ps" what the size of the process is. Maybe you even just 
   have some process limit set that causes brk/mmap to return failure 
   earlier than necessary..

   (It can also be interesting to look at /proc/<pid>/maps, in case
   there are big mmaps that fill up the VM etc)

Sometimes it's also a good idea to have a swap file.  You may not even
*need* to actually page, but it gives thew VM layer much more freedom,
especially if your distro has set the flags to disable memory "overcommit".

		Linus
