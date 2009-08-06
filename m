From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6/7] block-sha1: Use '(B&C)+(D&(B^C))' instead of '(B&C)|(D&(B|C))'
 in round 3
Date: Thu, 6 Aug 2009 08:24:07 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908060822390.3390@localhost.localdomain>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <alpine.LFD.2.01.0908060814050.3390@localhost.localdomain> <alpine.LFD.2.01.0908060815430.3390@localhost.localdomain> <alpine.LFD.2.01.0908060816550.3390@localhost.localdomain>
 <alpine.LFD.2.01.0908060818220.3390@localhost.localdomain> <alpine.LFD.2.01.0908060820110.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 17:24:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ4ph-0004Of-5J
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 17:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053AbZHFPY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 11:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756052AbZHFPY2
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 11:24:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47103 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755680AbZHFPY1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 11:24:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76FO7fK009472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 08:24:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76FO7Pn005503;
	Thu, 6 Aug 2009 08:24:07 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0908060820110.3390@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125085>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Aug 2009 07:27:57 -0700
Subject: [PATCH 6/7] block-sha1: Use '(B&C)+(D&(B^C))' instead of '(B&C)|(D&(B|C))' in round 3

It's an equivalent expression, but the '+' gives us some freedom in
instruction selection (for example, we can use 'lea' rather than 'add'),
and associates with the other additions around it to give some minor
scheduling freedom.

Suggested-by: linux@horizon.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

A small micro-optimization. It may not matter hugely, but it's definitely 
the right thing to do. And with the new macroized thing, you can see 
clearly what part of the SHA1 rounds it affects, and how.

 block-sha1/sha1.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 4837d58..9a060a6 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -112,7 +112,7 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 #define T_0_15(t)  SHA_ROUND(t, SHA_SRC, (((C^D)&B)^D) , 0x5a827999 )
 #define T_16_19(t) SHA_ROUND(t, SHA_MIX, (((C^D)&B)^D) , 0x5a827999 )
 #define T_20_39(t) SHA_ROUND(t, SHA_MIX, (B^C^D) , 0x6ed9eba1 )
-#define T_40_59(t) SHA_ROUND(t, SHA_MIX, ((B&C)|(D&(B|C))) , 0x8f1bbcdc )
+#define T_40_59(t) SHA_ROUND(t, SHA_MIX, ((B&C)+(D&(B^C))) , 0x8f1bbcdc )
 #define T_60_79(t) SHA_ROUND(t, SHA_MIX, (B^C^D) ,  0xca62c1d6 )
 
 static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
-- 
1.6.4.31.g154b2.dirty
