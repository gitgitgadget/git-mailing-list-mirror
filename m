From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fix signed range problems with hex conversions
Date: Wed, 30 May 2007 10:32:19 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705301025170.26602@woody.linux-foundation.org>
References: <alpine.LFD.0.99.0705301213450.11491@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 30 19:33:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtS30-0004Gd-Bq
	for gcvg-git@gmane.org; Wed, 30 May 2007 19:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbXE3RdP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 13:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754228AbXE3RdP
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 13:33:15 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:53338 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754042AbXE3RdO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2007 13:33:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4UHWKln028313
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 May 2007 10:32:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4UHWJ6p000687;
	Wed, 30 May 2007 10:32:19 -0700
In-Reply-To: <alpine.LFD.0.99.0705301213450.11491@xanadu.home>
X-Spam-Status: No, hits=-4.673 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48774>



On Wed, 30 May 2007, Nicolas Pitre wrote:
> 
> This patch adds a range test to hexval() in order to prevent this.  Also 
> let's index the hexval_table array directly in get_sha1_hex() using 
> explicitly unsigned chars to avoid the range test producing faster
> code.

Please just make hexval() take a "unsigned char" instead, solving the 
problem in a manner that makes it much easier for the compiler to realize 
that it never needs to sign-extend the value or test the end result..

Ie I think your patch would be better off something like the following 
instead (it would be a one-liner, but I agree that marking hexval_table 
"const" is also a good idea).

With this, gcc can just generate:

	movzbl  (%rdi), %eax
	movsbl  hexval_table(%rax),%edx
	movzbl  1(%rdi), %eax
	movsbl  hexval_table(%rax),%eax
	sall    $4, %edx
	orl     %eax, %edx

for the code to generate a byte from two hex characters.

		Linus

----
diff --git a/cache.h b/cache.h
index ec85d93..0da7070 100644
--- a/cache.h
+++ b/cache.h
@@ -359,8 +359,8 @@ extern void *map_sha1_file(const unsigned char *sha1, unsigned long *);
 extern int has_pack_file(const unsigned char *sha1);
 extern int has_pack_index(const unsigned char *sha1);
 
-extern signed char hexval_table[256];
-static inline unsigned int hexval(unsigned int c)
+extern const signed char hexval_table[256];
+static inline unsigned int hexval(unsigned char c)
 {
 	return hexval_table[c];
 }
diff --git a/sha1_file.c b/sha1_file.c
index 12d2ef2..f959fe5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -33,7 +33,7 @@ const unsigned char null_sha1[20];
 
 static unsigned int sha1_file_open_flag = O_NOATIME;
 
-signed char hexval_table[256] = {
+const signed char hexval_table[256] = {
 	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
 	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 08-0f */
 	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 10-17 */
