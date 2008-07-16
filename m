From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 4/5] pack-objects: learn about pack index version 2
Date: Wed, 16 Jul 2008 02:31:38 -0400
Message-ID: <1216189899-14279-5-git-send-email-nico@cam.org>
References: <1216189899-14279-1-git-send-email-nico@cam.org>
 <1216189899-14279-2-git-send-email-nico@cam.org>
 <1216189899-14279-3-git-send-email-nico@cam.org>
 <1216189899-14279-4-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 08:33:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ0ZX-0006cW-RC
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 08:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbYGPGbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 02:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752781AbYGPGbu
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 02:31:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11931 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbYGPGbn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 02:31:43 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K43006BG64RTN50@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 16 Jul 2008 02:31:41 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.3.499.geae9
In-reply-to: <1216189899-14279-4-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88643>

This is the reading part only.  No creation of index v2 is provided.

(extracted from commit c553ca25bd60dc9fd50b8bc7bd329601b81cee66)

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   30 +++++++++++++++++++++++++-----
 1 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b9c3da2..5198563 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -172,13 +172,33 @@ static void prepare_pack_revindex(struct pack_revindex *rix)
 	int i;
 	const char *index = p->index_data;
 
-	index += 4 * 256;
 	rix->revindex = xmalloc(sizeof(*rix->revindex) * (num_ent + 1));
-	for (i = 0; i < num_ent; i++) {
-		uint32_t hl = *((uint32_t *)(index + 24 * i));
-		rix->revindex[i].offset = ntohl(hl);
-		rix->revindex[i].nr = i;
+	index += 4 * 256;
+
+	if (p->index_version > 1) {
+		const uint32_t *off_32 =
+			(uint32_t *)(index + 8 + p->num_objects * (20 + 4));
+		const uint32_t *off_64 = off_32 + p->num_objects;
+		for (i = 0; i < num_ent; i++) {
+			uint32_t off = ntohl(*off_32++);
+			if (!(off & 0x80000000)) {
+				rix->revindex[i].offset = off;
+			} else {
+				rix->revindex[i].offset =
+					((uint64_t)ntohl(*off_64++)) << 32;
+				rix->revindex[i].offset |=
+					ntohl(*off_64++);
+			}
+			rix->revindex[i].nr = i;
+		}
+	} else {
+		for (i = 0; i < num_ent; i++) {
+			uint32_t hl = *((uint32_t *)(index + 24 * i));
+			rix->revindex[i].offset = ntohl(hl);
+			rix->revindex[i].nr = i;
+		}
 	}
+
 	/* This knows the pack format -- the 20-byte trailer
 	 * follows immediately after the last object data.
 	 */
-- 
1.5.6.3.499.geae9
