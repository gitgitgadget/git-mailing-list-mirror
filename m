From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fix signed range problems with hex conversions
Date: Wed, 30 May 2007 10:42:41 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705301038310.26602@woody.linux-foundation.org>
References: <alpine.LFD.0.99.0705301213450.11491@xanadu.home>
 <alpine.LFD.0.98.0705301025170.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 30 19:43:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtSCW-0006oA-Jo
	for gcvg-git@gmane.org; Wed, 30 May 2007 19:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbXE3RnI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 13:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753118AbXE3RnH
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 13:43:07 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:37992 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754321AbXE3RnG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2007 13:43:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4UHgggH028728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 May 2007 10:42:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4UHgfZR000858;
	Wed, 30 May 2007 10:42:41 -0700
In-Reply-To: <alpine.LFD.0.98.0705301025170.26602@woody.linux-foundation.org>
X-Spam-Status: No, hits=-4.677 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48775>



On Wed, 30 May 2007, Linus Torvalds wrote:
> 
> With this, gcc can just generate:
> 
> 	movzbl  (%rdi), %eax
>	...

Btw, in the kernel we have a rule for *.c -> *.s files exactly because 
it's nice to be able to easily say "ok, what does that generate". 

Here's a patch to add such a rule to git too, in case anybody is 
interested. It makes it much simpler to just do

	make sha1_file.s

and look at the compiler-generated output that way, rather than having to 
fire up gdb on the resulting binary.

(Add -fverbose-asm or something if you want to, it can make the result 
even more readable)

		Linus

---
diff --git a/Makefile b/Makefile
index 7527734..7ffb803 100644
--- a/Makefile
+++ b/Makefile
@@ -846,6 +846,8 @@ git$X git.spec \
 
 %.o: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+%.s: %.c GIT-CFLAGS
+	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
 %.o: %.S
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
