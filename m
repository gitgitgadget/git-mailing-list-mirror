From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: My git repo is broken, how to fix it ?
Date: Thu, 22 Mar 2007 09:29:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703220924590.6730@woody.linux-foundation.org>
References: <200702281036.30539.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703200836490.6730@woody.linux-foundation.org>
 <200703210956.50018.litvinov2004@gmail.com> <200703211024.04740.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703220858400.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 17:29:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUQAL-0004qp-4k
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 17:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934111AbXCVQ3P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 12:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934112AbXCVQ3P
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 12:29:15 -0400
Received: from smtp.osdl.org ([65.172.181.24]:38392 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934111AbXCVQ3O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 12:29:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2MGTCG9009349
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Mar 2007 09:29:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2MGTBnZ024496;
	Thu, 22 Mar 2007 09:29:11 -0700
In-Reply-To: <Pine.LNX.4.64.0703220858400.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.471 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42864>



On Thu, 22 Mar 2007, Linus Torvalds wrote:
> 
> It's also possible that the real bug is that we have some memory scribble 
> internally in git, and that it shows up for you just because Cygwin and/or 
> WinXp has different allocation patterns than other platforms. Do you know 
> if there are any "debugging malloc" libraries for Cygwin? Something like 
> ElectricFence/dmalloc under Linux, or running with valgrind.

Yeehaa! I think I'm on the right trail.

Git people: do this:

	yum install ElectricFence

(or similar, apt-get, whatever), and then apply this patch, and do

	make test

and it will fail in "git-apply"! Which (having read Alexander's corruption 
sequence once more) must have been what corrupted things for Alexander 
too!

I've not debugged it any more, but gdb on the core-dump shows:

	(gdb) where
	#0  0x0000003768462331 in SHA1_Update () from /lib64/libcrypto.so.6
	#1  0x0000000000461b0e in write_sha1_file_prepare (buf=0x2ba371737fd0, len=46, type=0x49a50b "blob", sha1=0x7fff395c84a0 "",
	    hdr=0x7fff395c8480 "blob 46", hdrlen=0x7fff395c847c) at sha1_file.c:1823
	#2  0x0000000000461e6f in write_sha1_file (buf=0x2ba371737fd0, len=46, type=0x49a50b "blob", returnsha1=0x2ba371733fe0 "")
	    at sha1_file.c:1962
	#3  0x000000000040aa9a in add_index_file (path=0x2ba371719ffc "one", mode=33188, buf=0x2ba371737fd0, size=46) at builtin-apply.c:2350
	#4  0x000000000040aeb5 in create_file (patch=0x2ba37170cf40) at builtin-apply.c:2451
	#5  0x000000000040af45 in write_out_one_result (patch=0x2ba37170cf40, phase=1) at builtin-apply.c:2475
	#6  0x000000000040b291 in write_out_results (list=0x2ba37170cf40, skipped_patch=0) at builtin-apply.c:2560
	#7  0x000000000040b71c in apply_patch (fd=6, filename=0x7fff395c96ec "patch.file", inaccurate_eof=0) at builtin-apply.c:2676
	#8  0x000000000040bd1b in cmd_apply (argc=3, argv=0x7fff395c8990, unused_prefix=0x0) at builtin-apply.c:2836
	#9  0x0000000000403fbb in handle_internal_command (argc=3, argv=0x7fff395c8990, envp=0x7fff395c89b0) at git.c:322
	#10 0x0000000000404193 in main (argc=3, argv=0x7fff395c8990, envp=0x7fff395c89b0) at git.c:391

so I thought I'd send out this email asap, in case somebody else finds the 
bug before I do.

Anyway, this looks like a real smoking gun..

		Linus
----
diff --git a/Makefile b/Makefile
index 51c1fed..7e20410 100644
--- a/Makefile
+++ b/Makefile
@@ -123,7 +123,7 @@ uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
-CFLAGS = -g -O2 -Wall
+CFLAGS = -g -Wall
 LDFLAGS =
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
@@ -647,7 +647,7 @@ prefix_SQ = $(subst ','\'',$(prefix))
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 
-LIBS = $(GITLIBS) $(EXTLIBS)
+LIBS = $(GITLIBS) $(EXTLIBS) -lefence
 
 BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' \
 	-DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"' $(COMPAT_CFLAGS)
