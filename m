Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 11339 invoked by uid 107); 4 Oct 2009 14:47:47 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 10:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbZJDOlm (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 10:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752783AbZJDOlm
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 10:41:42 -0400
Received: from up.nbi.dk ([130.225.212.6]:47025 "EHLO mail2.nbi.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbZJDOll (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 10:41:41 -0400
X-Greylist: delayed 1621 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Oct 2009 10:41:40 EDT
Received: from bottom.nbi.dk (bottom.nbi.dk [130.225.212.9])
	by mail2.nbi.dk (Postfix) with ESMTP id A7BF63C947;
	Sun,  4 Oct 2009 16:14:01 +0200 (CEST)
Received: by bottom.nbi.dk (Postfix, from userid 32342)
	id 909503C005; Sun,  4 Oct 2009 16:14:01 +0200 (CEST)
Date:	Sun, 4 Oct 2009 16:13:55 +0200
From:	Petter Urkedal <urkedal@nbi.dk>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, urkedal@nbi.dk
Subject: Re: [PATCH] Reserve a slot for argv[0] in default_arg.
Message-ID: <20091004141355.GA15783@eideticdew.org>
References: <1254576571-29274-1-git-send-email-urkedal@nbi.dk>
 <20091004133333.GA13894@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20091004133333.GA13894@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 2009-10-04, Jeff King wrote:
> On Sat, Oct 03, 2009 at 03:29:31PM +0200, Petter Urkedal wrote:
> 
> > Setting "av" to one slot before the allocated "default_arg" array causes
> > glibc abort with "free(): invalid next size (normal)" in some
> > configurations (Gentoo, glibc-2.9_p20081201-r2, gcc-5.3.2 with PIE).
> 
> Thanks, your fix looks sane. But I am curious about whether we are
> triggering some glibc pickiness that is in your setup, or if we are
> somehow violating the assumption that we only ever look at
> default_arg[1] and beyond.

I was wondering myself.  I tried to switch off optimisation, but that
had no effect.  I'm suspecting PIE, but it could be some other
configuration implied by the Gentoo "hardened" use-flag.

> What show-branch command did you issue to hit this? I was hoping to run
> it under valgrind.

I can reproduce it on my machine with

    mkdir test-repo; cd test-repo
    /path/to/git init
    /path/to/git config showbranch.default --topo-order
    /path/to/git show-branch

> Also:
> 
> > +			if (!default_num)
> > +			    /* One unused position for argv[0]. */
> > +			    default_arg[default_num++] = NULL;
> 
> I don't know if we have a style rule for comments on single line
> conditionals, but I had to read this a few times to make sure it wasn't
> missing braces.

Comment's are treated as whitespace, but I'll adjust it for readability.
Maybe worse: I missed the 8-column indentation.  So, here is the patch
again (attached, I hope Git can extract it).

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="showbranch-argv0.txt"

1552 eideticdew /tmp/test-repo$ gdb /home/urkedal/proj-ext/git/git show-branch
GNU gdb 6.8
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-pc-linux-gnu"...
/tmp/test-repo/show-branch: No such file or directory.
(gdb) run show-branch
[Thread debugging using libthread_db enabled]
*** glibc detected *** /home/urkedal/proj-ext/git/git: corrupted double-linked list: 0x0000000000734340 ***
[New Thread 0x7f937d4c36f0 (LWP 15739)]
======= Backtrace: =========
/lib/libc.so.6[0x7f937c84e1f2]
/lib/libc.so.6[0x7f937c84e4a4]
/lib/libc.so.6[0x7f937c84f7fc]
/lib/libc.so.6(cfree+0x75)[0x7f937c84fb13]
/lib/libc.so.6[0x7f937c8407bf]
/home/urkedal/proj-ext/git/git[0x48c921]
/home/urkedal/proj-ext/git/git[0x48e617]
/home/urkedal/proj-ext/git/git[0x44e1d2]
/home/urkedal/proj-ext/git/git[0x4042a3]
/home/urkedal/proj-ext/git/git[0x40444d]
/lib/libc.so.6(__libc_start_main+0xe6)[0x7f937c7fd56e]
/home/urkedal/proj-ext/git/git[0x403d59]
======= Memory map: ========
00400000-004e8000 r-xp 00000000 fd:04 12700046                           /home/urkedal/proj-ext/git/git
006e7000-006e8000 r--p 000e7000 fd:04 12700046                           /home/urkedal/proj-ext/git/git
006e8000-006ed000 rw-p 000e8000 fd:04 12700046                           /home/urkedal/proj-ext/git/git
006ed000-00755000 rw-p 00000000 00:00 0                                  [heap]
7f9378000000-7f9378021000 rw-p 00000000 00:00 0 
7f9378021000-7f937c000000 ---p 00000000 00:00 0 
7f937c3c5000-7f937c3da000 r-xp 00000000 08:01 32689                      /lib64/libgcc_s.so.1
7f937c3da000-7f937c5d9000 ---p 00015000 08:01 32689                      /lib64/libgcc_s.so.1
7f937c5d9000-7f937c5da000 r--p 00014000 08:01 32689                      /lib64/libgcc_s.so.1
7f937c5da000-7f937c5db000 rw-p 00015000 08:01 32689                      /lib64/libgcc_s.so.1
7f937c5db000-7f937c5dd000 r-xp 00000000 08:01 33045                      /lib64/libdl-2.9.so
7f937c5dd000-7f937c7dd000 ---p 00002000 08:01 33045                      /lib64/libdl-2.9.so
7f937c7dd000-7f937c7de000 r--p 00002000 08:01 33045                      /lib64/libdl-2.9.so
7f937c7de000-7f937c7df000 rw-p 00003000 08:01 33045                      /lib64/libdl-2.9.so
7f937c7df000-7f937c91e000 r-xp 00000000 08:01 32884                      /lib64/libc-2.9.so
7f937c91e000-7f937cb1e000 ---p 0013f000 08:01 32884                      /lib64/libc-2.9.so
7f937cb1e000-7f937cb22000 r--p 0013f000 08:01 32884                      /lib64/libc-2.9.so
7f937cb22000-7f937cb23000 rw-p 00143000 08:01 32884                      /lib64/libc-2.9.so
7f937cb23000-7f937cb28000 rw-p 00000000 00:00 0 
7f937cb28000-7f937cb3d000 r-xp 00000000 08:01 32902                      /lib64/libpthread-2.9.so
7f937cb3d000-7f937cd3d000 ---p 00015000 08:01 32902                      /lib64/libpthread-2.9.so
7f937cd3d000-7f937cd3e000 r--p 00015000 08:01 32902                      /lib64/libpthread-2.9.so
7f937cd3e000-7f937cd3f000 rw-p 00016000 08:01 32902                      /lib64/libpthread-2.9.so
7f937cd3f000-7f937cd43000 rw-p 00000000 00:00 0 
7f937cd43000-7f937ce95000 r-xp 00000000 fd:00 1181123                    /usr/lib64/libcrypto.so.0.9.8
7f937ce95000-7f937d095000 ---p 00152000 fd:00 1181123                    /usr/lib64/libcrypto.so.0.9.8
7f937d095000-7f937d0a3000 r--p 00152000 fd:00 1181123                    /usr/lib64/libcrypto.so.0.9.8
7f937d0a3000-7f937d0bb000 rw-p 00160000 fd:00 1181123                    /usr/lib64/libcrypto.so.0.9.8
7f937d0bb000-7f937d0bf000 rw-p 00000000 00:00 0 
7f937d0bf000-7f937d0d3000 r-xp 00000000 08:01 32655                      /lib64/libz.so.1.2.3
7f937d0d3000-7f937d2d2000 ---p 00014000 08:01 32655                      /lib64/libz.so.1.2.3
7f937d2d2000-7f937d2d3000 r--p 00013000 08:01 32655                      /lib64/libz.so.1.2.3
7f937d2d3000-7f937d2d4000 rw-p 00014000 08:01 32655                      /lib64/libz.so.1.2.3
7f937d2d4000-7f937d2f0000 r-xp 00000000 08:01 33042                      /lib64/ld-2.9.so
7f937d4c3000-7f937d4c6000 rw-p 00000000 00:00 0 
7f937d4ed000-7f937d4ef000 rw-p 00000000 00:00 0 
7f937d4ef000-7f937d4f0000 r--p 0001b000 08:01 33042                      /lib64/ld-2.9.so
7f937d4f0000-7f937d4f1000 rw-p 0001c000 08:01 33042                      /lib64/ld-2.9.so
7fff94a38000-7fff94a4e000 rw-p 00000000 00:00 0                          [stack]
7fff94bff000-7fff94c00000 r-xp 00000000 00:00 0                          [vdso]
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]

Program received signal SIGABRT, Aborted.
[Switching to Thread 0x7f937d4c36f0 (LWP 15739)]
0x00007f937c810536 in raise () from /lib/libc.so.6
(gdb) bt
#0  0x00007f937c810536 in raise () from /lib/libc.so.6
#1  0x00007f937c811723 in abort () from /lib/libc.so.6
#2  0x00007f937c84953f in ?? () from /lib/libc.so.6
#3  0x00007f937c84e1f2 in ?? () from /lib/libc.so.6
#4  0x00007f937c84e4a4 in ?? () from /lib/libc.so.6
#5  0x00007f937c84f7fc in ?? () from /lib/libc.so.6
#6  0x00007f937c84fb13 in free () from /lib/libc.so.6
#7  0x00007f937c8407bf in ?? () from /lib/libc.so.6
#8  0x000000000048c921 in get_packed_refs () at refs.c:234
#9  0x000000000048e617 in do_for_each_ref (base=0x3d7b <Address 0x3d7b out of bounds>, fn=0x3d7b, 
    trim=6, flags=-1, cb_data=0x7f937c8e71e0) at refs.c:598
#10 0x000000000044e1d2 in cmd_show_branch (ac=<value optimized out>, av=0x734348, prefix=0x0)
    at builtin-show-branch.c:478
#11 0x00000000004042a3 in handle_internal_command (argc=1, argv=0x7fff94a4b1e0) at git.c:249
#12 0x000000000040444d in main (argc=1, argv=0x7fff94a4b1e0) at git.c:436
(gdb) q

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="0001-Reserve-a-slot-for-argv-0-in-default_arg.patch"

From a6bea57b5f9e3ebca38afce7829922ccb8f7d24f Mon Sep 17 00:00:00 2001
From: Petter Urkedal <urkedal@nbi.dk>
Date: Sat, 3 Oct 2009 14:52:41 +0200
Subject: [PATCH] Reserve a slot for argv[0] in default_arg.

Setting "av" to one slot before the allocated "default_arg" array causes
glibc abort with "free(): invalid next size (normal)" in some
configurations (Gentoo, glibc-2.9_p20081201-r2, gcc-5.3.2 with PIE).
---
 builtin-show-branch.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 3510a86..81c477c 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -568,6 +568,10 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
 		if (default_alloc <= default_num + 1) {
 			default_alloc = default_alloc * 3 / 2 + 20;
 			default_arg = xrealloc(default_arg, sizeof *default_arg * default_alloc);
+			if (!default_num) {
+				/* One unused position for argv[0]. */
+				default_arg[default_num++] = NULL;
+			}
 		}
 		default_arg[default_num++] = xstrdup(value);
 		default_arg[default_num] = NULL;
@@ -692,8 +696,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 
 	/* If nothing is specified, try the default first */
 	if (ac == 1 && default_num) {
-		ac = default_num + 1;
-		av = default_arg - 1; /* ick; we would not address av[0] */
+		ac = default_num;
+		av = default_arg;
 	}
 
 	ac = parse_options(ac, av, prefix, builtin_show_branch_options,
-- 
1.6.4.4


--LZvS9be/3tNcYl/X--
