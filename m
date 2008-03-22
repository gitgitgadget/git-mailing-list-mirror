From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/7] Case-insensitive filesystem support, take 1
Date: Sat, 22 Mar 2008 10:21:05 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank <streamlake@tiscali.it>, Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 18:22:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd7QR-0001vF-SX
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 18:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbYCVRVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 13:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753539AbYCVRVx
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 13:21:53 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42747 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753511AbYCVRVw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2008 13:21:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MHL7SB001524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Mar 2008 10:21:09 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MHL5QE019283;
	Sat, 22 Mar 2008 10:21:06 -0700
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.756 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77827>


Ok, so I said it wasn't a high priority, but I had already done all the 
really core support for this in that we have the name hashes now that I 
wanted to use for looking up names case-insensitively, so I took it as a 
challenge to do this cleanly. I already knew how I wanted to do it, so how 
hard could it be?

First, a few caveats:

 - I've tested this series, both on a case-sensitive one (using hardlinks 
   to test corner cases) and on a vfat filesystem under Linux (which is 
   case-insensitive and *really* odd wrt case preservation - it remembers 
   the name of removed files, so it preserves case even across removal and 
   re-creation!)

 - HOWEVER. The testing has been very targeted, and I only convered a few 
   cases to really care. Things like case-renaming, for example, will be 
   trivial to do, but I didn't do it. So if you want to do a 

	git mv Abc abc

   on a case-insensitive filesystem, you currently still have to do it as 
   the sequence

	git mv Abc xyz
	git mv xyz abc

   because I did *not* make git-mv know about case-insensitivity.

 - The only two operations that care about case-insensitivity after this 
   series of seven patches are

    (a) "git status" and friends (like "git add") that use the directory 
        traversal code will know to ignore files that have a case- 
        insensitive version in the index. So if you have messed up the 
        case in the working tree (or the filesystem isn't even case- 
        preserving), then "git add" and "git status" won't show the 
        case-different file as being "unknown".

    (b) merging trees (git read-tree) knows about unexpectedly found files
        that are due to case-insensitive filesystems, and knows to ignore 
        them. This means that switching branches where the case of a file 
        changes works, and it means that going a merge across that case 
        also works.

 - I made this all conditional on

	[core]
		ignorecase = true

   because obviously I'm not at all interested in penalizing sane 
   filesystems. That said, I also worked at trying to make sure that it's 
   safe and possible to do this on a case-sensitive filesystem in case you 
   are working on a project that doesn't like case-sensitivity, so the 
   "git status" and "git add ." kind of operations won't add aliases

 - Finally: the "case independence" rules could be anything, but right now 
   I *only* do the standard US-ASCII versions. This will *not* help with 
   the insane OS X cases of UTF-8 normalization: to actually get that you 
   need to make sure that the hash-function for names and the comparison 
   functions work correctly with those more complex cases.

   So _conceptually_ this should all work for UTF-8 normalization 'case' 
   insensitivity too or on just generally utf-8 cases, but I didn't 
   actually do that more complex case. That's a separate area, and will 
   not affect the core logic.

And then one final caveat: I think the patch-series is fairly clean, and 
each patch in itself is pretty simple, but my testing has been limited, 
and not only haven't I extended the case-insensitivity to all operations, 
but I would suggest some care from people who test this.

But if you care about the crazy OS X UTF-8 normalization (which apparently 
can happen even on otherwise case-sensitive filesystems), or if you care 
about the more regular case insensitivity of HFS+ or Windows, you need to 
test this - even if you tests right now should be limited to US-ASCII 
only. Because I'll happily fix issues, but I'm not using those crap 
filesystems myself, nor will I be doing any more testing on VFAT unless 
people actually point out issues to me.

So it's up to you users of crap OS's to test the cases and make good 
reports, and I'll care just because I think it's a somewhat interesting 
problem (it's why I did this series), but I'll never do anything about 
this without prodding and good reports. Ok?

Junio: I think this is safe, if only because it's all so very 
straight-forward, and I tried very hard to make each change trivial and 
limited and fairly easy to understand. Some of the patches are pure 
cleanups that I hit when looking at the code and wanted to fix before I 
even made any other changes.

			Linus
