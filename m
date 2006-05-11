From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] Fix git-pack-objects for 64-bit platforms
Date: Thu, 11 May 2006 19:36:32 +0200
Message-ID: <20060511173632.G60c08b4@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 11 19:36:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FeF5Z-0008BQ-7j
	for gcvg-git@gmane.org; Thu, 11 May 2006 19:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbWEKRgf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 May 2006 13:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbWEKRge
	(ORCPT <rfc822;git-outgoing>); Thu, 11 May 2006 13:36:34 -0400
Received: from v345.ncsrv.de ([89.110.145.104]:22244 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1030392AbWEKRge (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 May 2006 13:36:34 -0400
Received: from leonov.stosberg.net (p213.54.91.79.tisdip.tiscali.de [213.54.91.79])
	by ncs.stosberg.net (Postfix) with ESMTP id 02BB4AEBA00A
	for <git@vger.kernel.org>; Thu, 11 May 2006 19:36:10 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 64BA3F604B; Thu, 11 May 2006 19:36:32 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
Received: from leonov ([unix socket]) by leonov (Cyrus v2.1.18-IPv6-Debian-2.1.18-1+sarge2) with LMTP; Thu, 11 May 2006 19:28:01 +0200
X-Sieve: CMU Sieve 2.2
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19908>

The offset of an object in the pack is recorded as a 4-byte integer
in the index file.  When reading the offset from the mmap'ed index
in prepare_pack_revindex(), the address is dereferenced as a long*.
This works fine as long as the long type is four bytes wide.  On
NetBSD/sparc64, however, a long is 8 bytes wide and so dereferencing
the offset produces garbage.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>

---

I am not sure whether an int cast or an int32_t cast is more
appropriate here.  An int is not guaranteed to be four bytes wide,
but I don't know of any modern platform where that's not the case.
On the other hand int32_t is not necessarily available before C99.

Any opinions?  I wonder why no one has hit this on x86_64...


 pack-objects.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

026b1b2cdd5332f59e15cd8611a49ead3094d08c
diff --git a/pack-objects.c b/pack-objects.c
index 523a1c7..29bda43 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -156,7 +156,7 @@ static void prepare_pack_revindex(struct
 
 	rix->revindex = xmalloc(sizeof(unsigned long) * (num_ent + 1));
 	for (i = 0; i < num_ent; i++) {
-		long hl = *((long *)(index + 24 * i));
+		long hl = *((int *)(index + 24 * i));
 		rix->revindex[i] = ntohl(hl);
 	}
 	/* This knows the pack format -- the 20-byte trailer
-- 
1.3.2.gbe65
