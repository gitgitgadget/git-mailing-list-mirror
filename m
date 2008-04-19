From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git performance on OS X
Date: Sat, 19 Apr 2008 15:39:37 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sun Apr 20 00:40:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnLjU-0006OK-K4
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 00:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbYDSWjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 18:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752628AbYDSWjq
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 18:39:46 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44026 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751904AbYDSWjp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2008 18:39:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3JMdcHD031182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Apr 2008 15:39:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3JMdbAp003382;
	Sat, 19 Apr 2008 15:39:38 -0700
In-Reply-To: <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.445 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79928>



On Sun, 20 Apr 2008, Pieter de Bie wrote:
>
> I just tested this. "git status ." does 428815 (400k!) lstats, almost 10x as
> many as there are files in the repository. I'd agree that this is the reason
> it's slow on OS X :).

Yeah. I didn't look any further, but we do a total of *nine* 'lstat()' 
calls for each file we know about that is dirty, and *seven* when they are 
clean. Plus maybe a few more.

I had some patches that cut that down a lot, but some of it had to be 
reverted because of the subtle interactions with different internal copies 
of the index, and I think the case with a partial commit (which is what 
you have when using a pathspec) was the case that got reverted.

Maybe I should revisit it, now that we have internal support for actually 
keeping multiple indexes in place and being able to merge them.

Appended, in case somebody is interested, are the callchains for the 
different lstat() callers (for the case of a single file that was clean).

(This is with a non-pristine git source-base, so the line numbers may not 
match 100%, but the changes are pretty small, so it should still be an 
interesting set of callers)

At least two of them are due to ce_smudge_racily_clean_entry(), which in 
turn is because we trigger the is_racy_timestamp() test. Hmm.

And four of them are because of two cases of the pattern

	if (file_exists())
		add_file_to_cache(p->path, 0);

where the "file_exists()" first does an lstat() to see if it exists, and 
then "add_file_to_cache()" does an lstat() to get the stat info..

			Linus

---
First:
	#1  0x0000000000481fd7 in file_exists (f=0x1ac3f10 "Makefile") at dir.c:742
	#2  0x00000000004196bd in add_remove_files (list=0x7fff87223310) at builtin-commit.c:179
	#3  0x0000000000419aa1 in prepare_index (argc=1, argv=0x7fff872235d0, prefix=0x0) at builtin-commit.c:308
	#4  0x000000000041b3b2 in cmd_status (argc=1, argv=0x7fff872235d0, prefix=0x0) at builtin-commit.c:781
	#5  0x000000000040482e in run_command (p=0x704eb8, argc=2, argv=0x7fff872235d0) at git.c:264
	#6  0x00000000004049db in handle_internal_command (argc=2, argv=0x7fff872235d0) at git.c:394
	#7  0x0000000000404b47 in main (argc=2, argv=0x7fff872235d0) at git.c:458

Second:
	#1  0x00000000004973a0 in add_file_to_index (istate=0x7494c0, path=0x1ac3f10 "Makefile", verbose=0) at read-cache.c:471
	#2  0x00000000004196d7 in add_remove_files (list=0x7fff87223310) at builtin-commit.c:180
	#3  0x0000000000419aa1 in prepare_index (argc=1, argv=0x7fff872235d0, prefix=0x0) at builtin-commit.c:308
	#4  0x000000000041b3b2 in cmd_status (argc=1, argv=0x7fff872235d0, prefix=0x0) at builtin-commit.c:781
	#5  0x000000000040482e in run_command (p=0x704eb8, argc=2, argv=0x7fff872235d0) at git.c:264
	#6  0x00000000004049db in handle_internal_command (argc=2, argv=0x7fff872235d0) at git.c:394
	#7  0x0000000000404b47 in main (argc=2, argv=0x7fff872235d0) at git.c:458

Third:
	#1  0x00000000004992a4 in ce_smudge_racily_clean_entry (ce=0x1ac4000) at read-cache.c:1267
	#2  0x000000000049956d in write_index (istate=0x7494c0, newfd=6) at read-cache.c:1348
	#3  0x0000000000419ac7 in prepare_index (argc=1, argv=0x7fff872235d0, prefix=0x0) at builtin-commit.c:310
	#4  0x000000000041b3b2 in cmd_status (argc=1, argv=0x7fff872235d0, prefix=0x0) at builtin-commit.c:781
	#5  0x000000000040482e in run_command (p=0x704eb8, argc=2, argv=0x7fff872235d0) at git.c:264
	#6  0x00000000004049db in handle_internal_command (argc=2, argv=0x7fff872235d0) at git.c:394
	#7  0x0000000000404b47 in main (argc=2, argv=0x7fff872235d0) at git.c:458

Fourth:
	#1  0x0000000000481fd7 in file_exists (f=0x1ac3f10 "Makefile") at dir.c:742
	#2  0x00000000004196bd in add_remove_files (list=0x7fff87223310) at builtin-commit.c:179
	#3  0x0000000000419b21 in prepare_index (argc=1, argv=0x7fff872235d0, prefix=0x0) at builtin-commit.c:318
	#4  0x000000000041b3b2 in cmd_status (argc=1, argv=0x7fff872235d0, prefix=0x0) at builtin-commit.c:781
	#5  0x000000000040482e in run_command (p=0x704eb8, argc=2, argv=0x7fff872235d0) at git.c:264
	#6  0x00000000004049db in handle_internal_command (argc=2, argv=0x7fff872235d0) at git.c:394
	#7  0x0000000000404b47 in main (argc=2, argv=0x7fff872235d0) at git.c:458

Fifth:
	#1  0x00000000004973a0 in add_file_to_index (istate=0x7494c0, path=0x1ac3f10 "Makefile", verbose=0) at read-cache.c:471
	#2  0x00000000004196d7 in add_remove_files (list=0x7fff87223310) at builtin-commit.c:180
	#3  0x0000000000419b21 in prepare_index (argc=1, argv=0x7fff872235d0, prefix=0x0) at builtin-commit.c:318
	#4  0x000000000041b3b2 in cmd_status (argc=1, argv=0x7fff872235d0, prefix=0x0) at builtin-commit.c:781
	#5  0x000000000040482e in run_command (p=0x704eb8, argc=2, argv=0x7fff872235d0) at git.c:264
	#6  0x00000000004049db in handle_internal_command (argc=2, argv=0x7fff872235d0) at git.c:394
	#7  0x0000000000404b47 in main (argc=2, argv=0x7fff872235d0) at git.c:458

Sixth:
	#1  0x00000000004992a4 in ce_smudge_racily_clean_entry (ce=0x1ac4740) at read-cache.c:1267
	#2  0x000000000049956d in write_index (istate=0x7494c0, newfd=6) at read-cache.c:1348
	#3  0x0000000000419b47 in prepare_index (argc=1, argv=0x7fff872235d0, prefix=0x0) at builtin-commit.c:321
	#4  0x000000000041b3b2 in cmd_status (argc=1, argv=0x7fff872235d0, prefix=0x0) at builtin-commit.c:781
	#5  0x000000000040482e in run_command (p=0x704eb8, argc=2, argv=0x7fff872235d0) at git.c:264
	#6  0x00000000004049db in handle_internal_command (argc=2, argv=0x7fff872235d0) at git.c:394
	#7  0x0000000000404b47 in main (argc=2, argv=0x7fff872235d0) at git.c:458

Seventh:
	#1  0x0000000000475a37 in check_work_tree_entity (ce=0x1ac4870, st=0x7fff87221ea0, symcache=0x7fff87221f30 "") at diff-lib.c:343
	#2  0x0000000000475eab in run_diff_files (revs=0x7fff87222fc0, option=0) at diff-lib.c:466
	#3  0x00000000004bd62e in wt_status_print_changed (s=0x7fff872232f0) at wt-status.c:220
	#4  0x00000000004bdb1d in wt_status_print (s=0x7fff872232f0) at wt-status.c:310
	#5  0x0000000000419c0b in run_status (fp=0x37d8751760, index_file=0x711ef1 "/home/torvalds/git-test/.git/next-index-14646.lock", prefix=0x0, 
	    nowarn=0) at builtin-commit.c:349
	#6  0x000000000041b3cf in cmd_status (argc=1, argv=0x7fff872235d0, prefix=0x0) at builtin-commit.c:783
	#7  0x000000000040482e in run_command (p=0x704eb8, argc=2, argv=0x7fff872235d0) at git.c:264
	#8  0x00000000004049db in handle_internal_command (argc=2, argv=0x7fff872235d0) at git.c:394
	#9  0x0000000000404b47 in main (argc=2, argv=0x7fff872235d0) at git.c:458
