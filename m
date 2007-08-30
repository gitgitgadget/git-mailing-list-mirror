From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix same sized delta logic
Date: Wed, 29 Aug 2007 21:17:17 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708292107520.16727@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Aug 30 03:17:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQYfI-00061v-75
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 03:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbXH3BRU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 21:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754466AbXH3BRU
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 21:17:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49268 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974AbXH3BRT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 21:17:19 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNK00FQ9BKTLQ70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Aug 2007 21:17:18 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56992>

The code favoring shallower deltas when size is equal was triggered 
only when previous delta was also cached.  There should be no relation 
between cached deltas and same sized deltas.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 9b3ef94..12509fa 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1389,21 +1389,25 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	if (!delta_buf)
 		return 0;
 
-	if (trg_entry->delta_data) {
+	if (trg_entry->delta) {
 		/* Prefer only shallower same-sized deltas. */
 		if (delta_size == trg_entry->delta_size &&
 		    src->depth + 1 >= trg->depth) {
 			free(delta_buf);
 			return 0;
 		}
-		delta_cache_size -= trg_entry->delta_size;
-		free(trg_entry->delta_data);
-		trg_entry->delta_data = NULL;
 	}
+
 	trg_entry->delta = src_entry;
 	trg_entry->delta_size = delta_size;
 	trg->depth = src->depth + 1;
 
+	if (trg_entry->delta_data) {
+		delta_cache_size -= trg_entry->delta_size;
+		free(trg_entry->delta_data);
+		trg_entry->delta_data = NULL;
+	}
+
 	if (delta_cacheable(src_size, trg_size, delta_size)) {
 		trg_entry->delta_data = xrealloc(delta_buf, delta_size);
 		delta_cache_size += trg_entry->delta_size;
