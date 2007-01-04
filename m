From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] pack-check.c::verify_packfile(): don't run SHA-1 update on huge data
Date: Wed, 03 Jan 2007 23:26:07 -0800
Message-ID: <7vr6ubmewg.fsf_-_@assigned-by-dhcp.cox.net>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	<Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
	<7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Lee <chris133@gmail.com>, Shawn Pearce <spearce@spearce.org>,
	Sasha Khapyorsky <sashak@voltaire.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 08:26:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2MzU-0000wV-LQ
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 08:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbXADH0L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 02:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbXADH0K
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 02:26:10 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:63060 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307AbXADH0J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 02:26:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070104072609.FSRC7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Thu, 4 Jan 2007 02:26:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6vSP1W0051kojtg0000000; Thu, 04 Jan 2007 02:26:24 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 03 Jan 2007 22:25:30 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35919>

Running the SHA1_Update() on the whole packfile in a single call
revealed an overflow problem we had in the SHA-1 implementation
on POWER architecture some time ago, which was fixed with commit
b47f509b (June 19, 2006).  Other SHA-1 implementations may have
a similar problem.

The sliding mmap() series already makes chunked calls to
SHA1_Update(), so this patch itself will become moot when it
graduates to "master", but in the meantime, run the hash
function in smaller chunks to prevent possible future problems.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Chris, if you have a chance could you try this on the huge
   pack you had trouble with?

   Also whose SHA-1 implementation are you using, if this indeed
   is the problem, I wonder?

 pack-check.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/pack-check.c b/pack-check.c
index c0caaee..8e123b7 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -1,16 +1,18 @@
 #include "cache.h"
 #include "pack.h"
 
+#define BATCH (1u<<20)
+
 static int verify_packfile(struct packed_git *p)
 {
 	unsigned long index_size = p->index_size;
 	void *index_base = p->index_base;
 	SHA_CTX ctx;
 	unsigned char sha1[20];
-	unsigned long pack_size = p->pack_size;
-	void *pack_base;
 	struct pack_header *hdr;
 	int nr_objects, err, i;
+	unsigned char *packdata;
+	unsigned long datasize;
 
 	/* Header consistency check */
 	hdr = p->pack_base;
@@ -25,11 +27,19 @@ static int verify_packfile(struct packed_git *p)
 			     "while idx size expects %d", nr_objects,
 			     num_packed_objects(p));
 
+	/* Check integrity of pack data with its SHA-1 checksum */
 	SHA1_Init(&ctx);
-	pack_base = p->pack_base;
-	SHA1_Update(&ctx, pack_base, pack_size - 20);
+	packdata = p->pack_base;
+	datasize = p->pack_size - 20;
+	while (datasize) {
+		unsigned long batch = (datasize < BATCH) ? datasize : BATCH;
+		SHA1_Update(&ctx, packdata, batch);
+		datasize -= batch;
+		packdata += batch;
+	}
 	SHA1_Final(sha1, &ctx);
-	if (hashcmp(sha1, (unsigned char *)pack_base + pack_size - 20))
+
+	if (hashcmp(sha1, (unsigned char *)(p->pack_base) + p->pack_size - 20))
 		return error("Packfile %s SHA1 mismatch with itself",
 			     p->pack_name);
 	if (hashcmp(sha1, (unsigned char *)index_base + index_size - 40))
