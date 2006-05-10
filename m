From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fix diff-delta bad memory access
Date: Wed, 10 May 2006 10:00:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605100953090.3718@g5.osdl.org>
References: <Pine.LNX.4.64.0605101216360.24505@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 10 19:02:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fds4t-00085r-Vz
	for gcvg-git@gmane.org; Wed, 10 May 2006 19:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWEJRCV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 13:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWEJRCV
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 13:02:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56981 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965000AbWEJRCU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 May 2006 13:02:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4AH21tH004526
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 10 May 2006 10:02:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4AH1AA3018672;
	Wed, 10 May 2006 10:01:20 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0605101216360.24505@localhost.localdomain>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19889>



On Wed, 10 May 2006, Nicolas Pitre wrote:
>
> It cannot be assumed that the given buffer will never be moved when 
> shrinking the allocated memory size with realloc().  So let's ignore 
> that optimization for now.

Yeah, that was totally bogus. It would re-allocate _part_ of an 
allocation, but that allocation contained not just the index, but all the 
hashes and the hash entries too!

This has nothing to do with moving a buffer - it has everything to do with 
the fact that you shrunk a buffer that still contained all the other 
buffers: you shrunk the "mem" allocation to fit just the first part of it, 
and entirely ignored the "hash" and "entry" parts of it.

Btw, I think that whole "allocate everything in one allocation" thing is 
potentially bogus even the way it is now, if the alignment constraints of 
"index", "hash" and "entry" are different.

When you do

	..
	index = mem;
	mem = index + 1;
	hash = mem;
	mem = hash + hsize;
	entry = mem;
	..

it's perfectly fine for "index", but "hash" and "entry" end up having 
alignments that depend on the size/alignment of "index" (and for "entry" 
on "hash").

So if their alignment requirements are different, you're basically 
screwed.

It may work in practice (maybe they all align on pointer boundaries), but 
it's damn scary. You should re-consider, or at least make that code be a 
lot safer (like actually taking alignment into consideration, both for 
total size and for the offset calculations).

That could be done by using unions or something.

			Linus
