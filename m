From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 09:08:38 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908180906441.3162@localhost.localdomain>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com> <4A8AA511.1060205@gmail.com> <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com> <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0908180836440.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>, Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 18:09:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdRFv-000113-8B
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 18:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758717AbZHRQJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 12:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758576AbZHRQJO
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 12:09:14 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57329 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752861AbZHRQJM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 12:09:12 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7IG8c4b007545
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Aug 2009 09:08:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7IG8cjC005318;
	Tue, 18 Aug 2009 09:08:38 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0908180836440.3162@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-5.463 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126406>



On Tue, 18 Aug 2009, Linus Torvalds wrote:
> 
> I'd suggest not using a gcc builtin, since if you're using gcc you might 
> as well just use inline asm that has been around forever (unlike the 
> builtin).

That seems to be what glibc does too.

Here's a patch.

		Linus
---
 block-sha1/sha1.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 464cb25..e6e7170 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -22,6 +22,11 @@
 #define SHA_ROL(x,n)	SHA_ASM("rol", x, n)
 #define SHA_ROR(x,n)	SHA_ASM("ror", x, n)
 
+#undef htonl
+#undef ntohl
+#define htonl(x) ({ unsigned int __res; __asm__("bswap %0":"=r" (__res):"0" (x)); __res; })
+#define ntohl(x) htonl(x)
+
 #else
 
 #define SHA_ROT(X,l,r)	(((X) << (l)) | ((X) >> (r)))
