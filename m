From: David Miller <davem@davemloft.net>
Subject: Re: testsuite failures in mainline...
Date: Fri, 14 Dec 2007 16:08:45 -0800 (PST)
Message-ID: <20071214.160845.185161708.davem@davemloft.net>
References: <20071214214533.GA4943@steel.home>
	<20071214.142448.52660507.davem@davemloft.net>
	<7v7ijgq311.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: raa.lkml@gmail.com, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 15 01:09:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3Kae-0001kU-M9
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 01:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbXLOAIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 19:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbXLOAIr
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 19:08:47 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:54578
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752059AbXLOAIq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 19:08:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 6D272C8C182;
	Fri, 14 Dec 2007 16:08:45 -0800 (PST)
In-Reply-To: <7v7ijgq311.fsf@gitster.siamese.dyndns.org>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68362>

From: Junio C Hamano <gitster@pobox.com>
Date: Fri, 14 Dec 2007 15:18:02 -0800

> It makes me wonder what my C library has been returning during the
> tests...

If the 'name' string is high enough in the address space, the
'NULL - name' is still small enough to keep malloc() from
failing.

It might be neat to defeat bugs like this by making a
pointer_diff(a,b) macro or similar, that abort()'s when
one of the arguments is NULL.  Otherwise these bugs are
so hard to find.

I tested your patch and that part of the testsuite passes now.

It now fails on t9301-fast-export.sh

+ eval '

	MASTER=$(git rev-parse --verify master) &&
	REIN=$(git rev-parse --verify rein) &&
	WER=$(git rev-parse --verify wer) &&
	MUSS=$(git rev-parse --verify muss) &&
	mkdir new &&
	git --git-dir=new/.git init &&
	git fast-export --all |
	(cd new &&
	 git fast-import &&
	 test $MASTER = $(git rev-parse --verify refs/heads/master) &&
	 test $REIN = $(git rev-parse --verify refs/tags/rein) &&
	 test $WER = $(git rev-parse --verify refs/heads/wer) &&
	 test $MUSS = $(git rev-parse --verify refs/tags/muss))

'
+++ git rev-parse --verify master
++ MASTER=e529bca54909ee82f6ed442ef855ff541aec034c
+++ git rev-parse --verify rein
++ REIN=e529bca54909ee82f6ed442ef855ff541aec034c
+++ git rev-parse --verify wer
++ WER=ce754ded7a378a51278b2ff76d6898ec20093068
+++ git rev-parse --verify muss
++ MUSS=d85ef2305117d94969d4990d3c752752d4719be1
++ mkdir new
++ git --git-dir=new/.git init
Initialized empty Git repository in new/.git/
++ git fast-export --all
++ cd new
++ git fast-import
./test-lib.sh: line 194: 17409 Bus error               (core dumped) git fast-import

This usually indicates an unaligned memory access on sparc,
which is where I'm running this.

The problem is the pool allocator in fast-import.c, it aligned objects
on the size of a pointer.  But this is insufficient, it needs to be at
least "uintmax_t" aligned.

Also, mem_pool->space needs to be suitably aligned for a uintmax_t
as well.

The following patch fixes the bug, and together with your patch all
test cases now pass for me on sparc.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/fast-import.c b/fast-import.c
index 98c2bd5..4646c05 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -196,7 +196,7 @@ struct mem_pool
 	struct mem_pool *next_pool;
 	char *next_free;
 	char *end;
-	char space[FLEX_ARRAY]; /* more */
+	uintmax_t space[FLEX_ARRAY]; /* more */
 };
 
 struct atom_str
@@ -534,15 +534,15 @@ static void *pool_alloc(size_t len)
 		total_allocd += sizeof(struct mem_pool) + mem_pool_alloc;
 		p = xmalloc(sizeof(struct mem_pool) + mem_pool_alloc);
 		p->next_pool = mem_pool;
-		p->next_free = p->space;
+		p->next_free = (char *) p->space;
 		p->end = p->next_free + mem_pool_alloc;
 		mem_pool = p;
 	}
 
 	r = p->next_free;
-	/* round out to a pointer alignment */
-	if (len & (sizeof(void*) - 1))
-		len += sizeof(void*) - (len & (sizeof(void*) - 1));
+	/* round out to a 'uintmax_t' alignment */
+	if (len & (sizeof(uintmax_t) - 1))
+		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
 	p->next_free += len;
 	return r;
 }
