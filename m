From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 09:19:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 18:20:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYniK-0004gE-Jj
	for gcvg-git@gmane.org; Thu, 19 May 2005 18:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbVESQSS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 12:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVESQSS
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 12:18:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:49107 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262561AbVESQRb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 12:17:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4JGHNU3027582
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 May 2005 09:17:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4JGHMe1028361;
	Thu, 19 May 2005 09:17:23 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 19 May 2005, Junio C Hamano wrote:
> 
> Special request for Linus is to check if I did not screw up the
> various calls into the diff core from diff-tree.  Essentially
> the idea is to start one patchset session with diff_setup() and
> close it with diff_flush() before you start another patchset
> session.

It all looks ok from a quick setup, and with this I can now do

	git-whatchanged -M

in the kernel, and searching for renames I find:

	diff --git a/arch/um/kernel/sys_call_table.c b/arch/um/sys-x86_64/sys_call_table.c
	rename old arch/um/kernel/sys_call_table.c
	rename new arch/um/sys-x86_64/sys_call_table.c
	--- a/arch/um/kernel/sys_call_table.c
	+++ b/arch/um/sys-x86_64/sys_call_table.c
	@@ -1,4 +1,4 @@
	-/* 
	+/*
	  * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
	  * Copyright 2003 PathScale, Inc.
	  * Licensed under the GPL
	@@ -14,6 +14,12 @@
	 #include "sysdep/syscalls.h"
	 #include "kern_util.h"
	 
	+#ifdef CONFIG_NFSD
	....

which looks quite correct.

I notice that you left some debugging output in there ("**score **" 
stuff), and I'll remove it, but it's merged and pushed out and passed my 
trivial tests. 

[ rambling mode on: ]

One thing that struck me is that there is nothing wrong with having the 
same old file marked twice for a rename, or considering new files to be 
copies of old files. So if we ever allow that, then "rename" may be the 
wrong name for this, since the logic certainly allows the old file to 
still exist (or be removed and show up multiple times in a new guise).

In other words, let's say that we create a new architecture or a new 
filesystem, and we have tons of _new_ files, but not a lot of removed 
files. It would literally be very cool to see that the new files are based 
on contents of old files, and that it would thus potentially be very 
interesting to see a diff like

	diff --git a/arch/i386/kernel/irq.c b/arch/x86-64/kernel/irq.c
	based-on old arch/i386/kernel/irq.c
	creates new arch/x86-64/kernel/irq.c
	--- arch/i386/kernel/irq.c
	+++ arch/x86_64/kernel/irq.c
	@@ -1,205 +1,31 @@
	 /*
	- *     linux/arch/i386/kernel/irq.c
	+ *     linux/arch/x86_64/kernel/irq.c
	  *
	  *     Copyright (C) 1992, 1998 Linus Torvalds, Ingo Molnar
	  *
	...

(the above is a made-up example, but it's at least _half-way_ valid).

I'm not suggesting you actually do this, if only because it's quite
expensive: it means that any newly added file would have to be compared
with _all_ files in the previous archive, which is just too damn
expensive. But I'd like people to kind of keep this in mind as a
possibility, because maybe wasting CPU time in a big way might actually be
acceptable in some cases, and having a separate flag to enable this kind 
of thing might be interesting, no?

		Linus
