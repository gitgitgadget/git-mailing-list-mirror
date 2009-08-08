From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Fri, 7 Aug 2009 21:16:46 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908072107170.3288@localhost.localdomain>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain>
 <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain> <4A7B4D84.80906@gmail.com> <4A7B509A.5010405@gmail.com> <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain> <alpine.LFD.2.01.0908061909310.3390@localhost.localdomain>
 <alpine.LFD.2.01.0908071614310.3288@localhost.localdomain> <4A7CBD28.6070306@gmail.com> <4A7CBF47.9000903@gmail.com> <alpine.LFD.2.01.0908071700290.3288@localhost.localdomain> <4A7CC380.3070008@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 06:17:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZdMg-0005uZ-5H
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 06:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbZHHEQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 00:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbZHHEQt
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 00:16:49 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45396 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750738AbZHHEQt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Aug 2009 00:16:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n784GkBE030182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Aug 2009 21:16:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n784Gkoi006084;
	Fri, 7 Aug 2009 21:16:46 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A7CC380.3070008@gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.965 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125244>



On Sat, 8 Aug 2009, Artur Skawina wrote:
> 
> i was seeing such large variations depending on the -mtune flags that
> i gave up and now do just -march=i686; that's what i would expect
> for generic x86 binaries.

I think I have found a way to avoid the gcc crazyness.

Lookie here:

	#             TIME[s] SPEED[MB/s]
	rfc3174         5.094       119.8
	rfc3174         5.098       119.7
	linus           1.462       417.5
	linusas         2.008         304
	linusas2        1.878         325
	mozilla         5.566       109.6
	mozillaas       5.866       104.1
	openssl         1.609       379.3
	spelvin         1.675       364.5
	spelvina        1.601       381.3
	nettle          1.591       383.6

notice? I outperform all the hand-tuned asm on 32-bit too. By quite a 
margin, in fact.

Now, I didn't try a P4, and it's possible that it won't do that there, but 
the 32-bit code generation sure looks impressive on my Nehalem box. The 
magic? I force the stores to the 512-bit hash bucket to be done in order. 
That seems to help a lot.

The diff is trivial (on top of the "rename registers with cpp" patch), as 
appended. And it does seem to fix the P4 issues too, although I can 
obviously (once again) only test Prescott, and only in 64-bit mode:

	#             TIME[s] SPEED[MB/s]
	rfc3174         1.662       36.73
	rfc3174          1.64       37.22
	linus          0.2523       241.9
	linusas        0.4367       139.8
	linusas2       0.4487         136
	mozilla        0.9704        62.9
	mozillaas      0.9399       64.94

that's some really impressive improvement. All from just saying "do the 
stores in the order I told you to, dammit!" to the compiler.

		Linus

---
 block-sha1/sha1.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 19dc41d..f70e1ba 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -93,6 +93,7 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 
 /* This "rolls" over the 512-bit array */
 #define W(x) (array[(x)&15])
+#define setW(x, val) (*(volatile unsigned int *)&W(x) = (val))
 
 /*
  * Where do we get the source from? The first 16 iterations get it from
@@ -102,7 +103,7 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 #define SHA_MIX(t) SHA_ROL(W(t+13) ^ W(t+8) ^ W(t+2) ^ W(t), 1)
 
 #define SHA_ROUND(t, input, fn, constant, A, B, C, D, E) do { \
-	unsigned int TEMP = input(t); W(t) = TEMP; \
+	unsigned int TEMP = input(t); setW(t, TEMP); \
 	E += TEMP + SHA_ROL(A,5) + (fn) + (constant); \
 	B = SHA_ROR(B, 2); } while (0)
 
