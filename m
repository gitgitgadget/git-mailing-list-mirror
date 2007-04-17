From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFD PATCH 0/3] Use "object index" rather than pointers in the object
 hashing
Date: Mon, 16 Apr 2007 21:12:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704162041290.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 06:13:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdf3t-0007eu-0v
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 06:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbXDQEM5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 00:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbXDQEM5
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 00:12:57 -0400
Received: from smtp.osdl.org ([65.172.181.24]:34420 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932081AbXDQEM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 00:12:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3H4CpIs016516
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Apr 2007 21:12:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3H4Cojs019783;
	Mon, 16 Apr 2007 21:12:50 -0700
X-Spam-Status: No, hits=-0.952 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44715>


This is a series of three patches that changes the low-level object 
hashing to use a "object index" rather than the pointer to a "struct 
object" in the hash-tables. It's something I've been thinking about for a 
long time, so I just decided to do it.

The reason to do it is that on 64-bit architectures the object hash table 
is actually a fairly sizeable entity, and not for a very good reason. It 
has a ton of pointers to the objects we have allocated, so each hash-table 
entry is 64-bits, even though obviously we aren't likely to ever have that 
many objects.

So instead, we could use a 32-bit index into an object table - and in 
fact, since we already do all normal object allocations using a special 
dense allocatory that allocates 1024 objects in one go, we already kind of 
were set up for this, with the low 10 bits of the object index being a 
very natural index into each allocation block.

Could we ever want more than 4 billion objects? Unlikely, since you'd 
actually need 80GB of memory just to keep track of the object names in 
such a hash table, but hey, if that day ever comes, we can certainly 
trivially make the index be 64-bit instead (or more likely, make it be 
48-bit and use 16 bits of the hash table entry as an extended hash value 
or something).

Anyway, the before-and-after numbers are somewhat debatable, so this is 
purely a request for discussion..

Before:

	[torvalds@woody linux]$ /usr/bin/time git-rev-list --all --objects | wc -l
	5.66user 0.46system 0:06.12elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+44389minor)pagefaults 0swaps
	445065

After:

	[torvalds@woody linux]$ /usr/bin/time ~/git/git-rev-list --all --objects | wc -l
	6.96user 0.36system 0:07.36elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+40240minor)pagefaults 0swaps
	445065

ie it's actually slightly slower, but it uses almost 10% less memory 
(minor page faults). Is it worth it? Probably not, but since I made the 
patches, I thought I'd post them anyway. And the two first patches are 
probably worth applying regardless - it's only the third patch that 
actually changes things to use a hash index.

Anyway, the three patches are:

	0001-Use-proper-object-allocators-for-unknown-object-node.patch
	0002-Clean-up-object-creation-to-use-more-common-code.patch
	0003-Make-the-object-lookup-hash-use-a-object-index-ins.patch

where 1-2 are pretty much just cleanups.

Comments?

		Linus
