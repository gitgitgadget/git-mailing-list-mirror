From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH] pack-objects: Prefer shallower deltas if the size is equal
Date: Sun, 8 Jul 2007 23:45:21 -0500
Message-ID: <20070709044521.GI4087@lavos.net>
References: <20070709044326.GH4087@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 06:45:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7l7u-0002Ug-U4
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 06:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbXGIEpc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 00:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbXGIEpc
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 00:45:32 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:1055 "EHLO
	asav13.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbXGIEpb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 00:45:31 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav13.insightbb.com with ESMTP; 09 Jul 2007 00:45:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnA9AKBakUZKhvbzR2dsb2JhbACBTIVdiAQBAT8B
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 9B1C1309F31; Sun,  8 Jul 2007 23:45:21 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070709044326.GH4087@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51950>

Change "try_delta" so that if it finds a delta that has the same size
but shallower depth than the existing delta, it will prefer the
shallower one.  This makes certain delta trees vastly less deep.

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 builtin-pack-objects.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 3d396ca..54b9d26 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1337,7 +1337,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	if (max_size == 0)
 		return 0;
 	if (trg_entry->delta && trg_entry->delta_size <= max_size)
-		max_size = trg_entry->delta_size-1;
+		max_size = trg_entry->delta_size;
 	src_size = src_entry->size;
 	sizediff = src_size < trg_size ? trg_size - src_size : 0;
 	if (sizediff >= max_size)
@@ -1371,6 +1371,12 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		return 0;
 
 	if (trg_entry->delta_data) {
+		/* Prefer only shallower same-sized deltas. */
+		if (delta_size == trg_entry->delta_size &&
+		    src_entry->depth + 1 >= trg_entry->depth) {
+			free(delta_buf);
+			return 0;
+		}
 		delta_cache_size -= trg_entry->delta_size;
 		free(trg_entry->delta_data);
 	}
-- 
1.5.2.GIT
