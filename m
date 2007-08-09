From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 9 Aug 2007 10:11:16 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
References: <20070809163026.GD568@mbox.bz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: moe <moe-git@mbox.bz>
X-From: git-owner@vger.kernel.org Thu Aug 09 19:11:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJBXu-0008M2-0y
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 19:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965774AbXHIRL3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 13:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965619AbXHIRL3
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 13:11:29 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44520 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965607AbXHIRL2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 13:11:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l79HBMfd008993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Aug 2007 10:11:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l79HBGHX009777;
	Thu, 9 Aug 2007 10:11:16 -0700
In-Reply-To: <20070809163026.GD568@mbox.bz>
X-Spam-Status: No, hits=-2.686 required=5 tests=AWL,BAYES_00,TW_BW
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55461>



On Thu, 9 Aug 2007, moe wrote:
> 
> i made some tests on latest master branch
> (1.5.3.rc4.29.g74276) and it seems like git
> hits a wall somewhere above ~50k files.

Good catch. Definitely not acceptable performance.

We seem to spend a lot of our time in memcpy:

	samples  %        image name               app name                 symbol name
	200527   25.4551  libc-2.6.so              libc-2.6.so              _wordcopy_bwd_aligned
	104505   13.2660  libc-2.6.so              libc-2.6.so              _wordcopy_fwd_aligned
	99185    12.5907  libz.so.1.2.3            libz.so.1.2.3            (no symbols)
	83452    10.5935  libc-2.5.so              libc-2.5.so              (no symbols)
	54203     6.8806  git                      git                      assign_blame
	46153     5.8587  git                      git                      read_directory_recursive
	27665     3.5118  git                      git                      handle_split
	21385     2.7146  vmlinux                  vmlinux                  blk_complete_sgv4_hdr_rq
	20745     2.6334  git                      git                      read_packed_refs
	12709     1.6133  git                      git                      builtin_diffstat
	7829      0.9938  git                      git                      show_patch_diff
	...

but the silly thing is, this is only true if you give the filenames 
explicitly!

Lookie here:

	[torvalds@woody bummer]$ date >50/500
	[torvalds@woody bummer]$ time git commit -a -m 'expose the turtle'
	Created commit 25ca22d: expose the turtle
	 1 files changed, 1 insertions(+), 1 deletions(-)
	
	real    0m4.612s
	user    0m4.224s
	sys     0m0.412s

	[torvalds@woody bummer]$ date >50/500
	[torvalds@woody bummer]$ time git commit -m 'expose the turtle' 50/500
	Created commit 009f6b5: expose the turtle
	 1 files changed, 1 insertions(+), 1 deletions(-)
	
	real    0m12.464s
	user    0m12.129s
	sys     0m0.336s

ie we take almost three times longer with explicitly naming the file, than 
when just using "git commit -a". Oops.

That said, even the 4.6 seconds is really not acceptable: this is on a 
good 2.6GHz Core 2 Duo too, so on weaker hardware it would be quite 
painful.

I haven't looked at *why* it's that slow, but it's not anything really 
fundamental, the basic operations are fast:

	[torvalds@woody bummer]$ time git add 50/500

	real    0m0.064s
	user    0m0.048s
	sys     0m0.016s

	[torvalds@woody bummer]$ time git write-tree
	7480230419e510c93082a4a19e23d928a426973a
	
	real    0m0.069s
	user    0m0.048s
	sys     0m0.024s

	[torvalds@woody bummer]$ time git diff
	
	real    0m0.127s
	user    0m0.000s
	sys     0m0.000s

so it's not the "lstat()" that we do on all files, or the write-tree 
(which are all O(n) in files, with a rather small constant), but some 
O(n**2) behaviour elsewhere.

And all the expense seems to be in not the commit itself, but in

	[torvalds@woody bummer]$ time git 'runstatus' '--nocolor'

	real    0m4.208s
	user    0m4.068s
	sys     0m0.140s

and that thing seems to suck really really hard.

Doing an ltrace on it shows tons and tons of:

	...
	strlen("35")
	strlen("349")
	calloc(1, 72)
	memcpy(0x73034e, "10/", 3)
	memcpy(0x730351, "349", 4)
	memmove(0x2ab637f41e80, 0x2ab637f41e78, 781768)
	...

but I haven't looked at where they come from yet.

		Linus
