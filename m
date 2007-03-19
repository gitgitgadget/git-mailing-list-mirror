From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/2] clean up the delta base cache size a bit
Date: Mon, 19 Mar 2007 16:28:51 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703191625090.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 21:28:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTOTQ-0006ky-FG
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 21:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbXCSU2x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 16:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbXCSU2x
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 16:28:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39546 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbXCSU2w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 16:28:52 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF6002SL3K3G6M0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 19 Mar 2007 16:28:52 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42667>

Currently there are 3 different ways to deal with the cache size.
Let's stick to only one.  The compiler is smart enough to produce the exact
same code in those cases anyway.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 sha1_file.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index b0b2177..8a19d7e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1369,7 +1369,7 @@ static unsigned long pack_entry_hash(struct packed_git *p, off_t base_offset)
 
 	hash = (unsigned long)p + (unsigned long)base_offset;
 	hash += (hash >> 8) + (hash >> 16);
-	return hash & 0xff;
+	return hash % MAX_DELTA_CACHE;
 }
 
 static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
@@ -1417,13 +1417,13 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	release_delta_base_cache(ent);
 	delta_base_cached += base_size;
 	for (i = 0; delta_base_cached > delta_base_cache_limit
-		&& i < ARRAY_SIZE(delta_base_cache); i++) {
+		    && i < MAX_DELTA_CACHE ; i++) {
 		struct delta_base_cache_entry *f = delta_base_cache + i;
 		if (f->type == OBJ_BLOB)
 			release_delta_base_cache(f);
 	}
 	for (i = 0; delta_base_cached > delta_base_cache_limit
-		&& i < ARRAY_SIZE(delta_base_cache); i++)
+		    && i < MAX_DELTA_CACHE ; i++)
 		release_delta_base_cache(delta_base_cache + i);
 
 	ent->p = p;
-- 
1.5.1.rc1.596.ge11e-dirty
