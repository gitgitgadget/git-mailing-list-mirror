From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 9/9] pack-objects: don't leak pack window reference when
 splitting packs
Date: Wed, 29 Oct 2008 19:02:52 -0400
Message-ID: <1225321372-6570-10-git-send-email-nico@cam.org>
References: <1225321372-6570-1-git-send-email-nico@cam.org>
 <1225321372-6570-2-git-send-email-nico@cam.org>
 <1225321372-6570-3-git-send-email-nico@cam.org>
 <1225321372-6570-4-git-send-email-nico@cam.org>
 <1225321372-6570-5-git-send-email-nico@cam.org>
 <1225321372-6570-6-git-send-email-nico@cam.org>
 <1225321372-6570-7-git-send-email-nico@cam.org>
 <1225321372-6570-8-git-send-email-nico@cam.org>
 <1225321372-6570-9-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 00:06:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvK6z-0004tU-6c
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758235AbYJ2XEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758230AbYJ2XEE
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:04:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39112 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757643AbYJ2XEC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:04:02 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9I00DV4W0SZRE0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Oct 2008 19:02:55 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.3.757.g01be.dirty
In-reply-to: <1225321372-6570-9-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99431>

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 826c762..c93d69a 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -389,22 +389,28 @@ static unsigned long write_object(struct sha1file *f,
 			dheader[pos] = ofs & 127;
 			while (ofs >>= 7)
 				dheader[--pos] = 128 | (--ofs & 127);
-			if (limit && hdrlen + sizeof(dheader) - pos + datalen + 20 >= limit)
+			if (limit && hdrlen + sizeof(dheader) - pos + datalen + 20 >= limit) {
+				unuse_pack(&w_curs);
 				return 0;
+			}
 			sha1write(f, header, hdrlen);
 			sha1write(f, dheader + pos, sizeof(dheader) - pos);
 			hdrlen += sizeof(dheader) - pos;
 			reused_delta++;
 		} else if (type == OBJ_REF_DELTA) {
-			if (limit && hdrlen + 20 + datalen + 20 >= limit)
+			if (limit && hdrlen + 20 + datalen + 20 >= limit) {
+				unuse_pack(&w_curs);
 				return 0;
+			}
 			sha1write(f, header, hdrlen);
 			sha1write(f, entry->delta->idx.sha1, 20);
 			hdrlen += 20;
 			reused_delta++;
 		} else {
-			if (limit && hdrlen + datalen + 20 >= limit)
+			if (limit && hdrlen + datalen + 20 >= limit) {
+				unuse_pack(&w_curs);
 				return 0;
+			}
 			sha1write(f, header, hdrlen);
 		}
 		copy_pack_data(f, p, &w_curs, offset, datalen);
-- 
1.6.0.3.757.g01be.dirty
