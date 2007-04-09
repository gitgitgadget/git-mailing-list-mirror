From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 10/10] pack-redundant.c: learn about index v2
Date: Mon, 09 Apr 2007 01:06:37 -0400
Message-ID: <11760952033684-git-send-email-nico@cam.org>
References: <11760951973172-git-send-email-nico@cam.org>
 <11760951973319-git-send-email-nico@cam.org>
 <11760951993458-git-send-email-nico@cam.org>
 <11760951993225-git-send-email-nico@cam.org>
 <11760951993409-git-send-email-nico@cam.org>
 <11760952002687-git-send-email-nico@cam.org>
 <11760952002410-git-send-email-nico@cam.org>
 <117609520190-git-send-email-nico@cam.org>
 <11760952023952-git-send-email-nico@cam.org>
 <11760952021074-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 07:07:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ham5y-00038I-Es
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 07:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbXDIFHE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 01:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbXDIFHC
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 01:07:02 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64601 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbXDIFGq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 01:06:46 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG700EK9SV173A3@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 01:06:43 -0400 (EDT)
In-reply-to: <11760952021074-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.1.31.ge421f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44034>

Initially the conversion was made using nth_packed_object_sha1() which
made this file completely index version agnostic. Unfortunately the
overhead was quite significant so I went back to raw index walking but
with selectable base and step values which brought back similar
performances as the original.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 pack-redundant.c |   47 +++++++++++++++++++++++++++--------------------
 1 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/pack-redundant.c b/pack-redundant.c
index 40e579b..87077e1 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -247,16 +247,19 @@ static struct pack_list * pack_list_difference(const struct pack_list *A,
 
 static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
 {
-	int p1_off, p2_off;
+	unsigned long p1_off = 0, p2_off = 0, p1_step, p2_step;
 	const unsigned char *p1_base, *p2_base;
 	struct llist_item *p1_hint = NULL, *p2_hint = NULL;
 
-	p1_off = p2_off = 256 * 4 + 4;
 	p1_base = p1->pack->index_data;
 	p2_base = p2->pack->index_data;
+	p1_base += 256 * 4 + ((p1->pack->index_version < 2) ? 4 : 8);
+	p2_base += 256 * 4 + ((p2->pack->index_version < 2) ? 4 : 8);
+	p1_step = (p1->pack->index_version < 2) ? 24 : 20;
+	p2_step = (p2->pack->index_version < 2) ? 24 : 20;
 
-	while (p1_off <= p1->pack->index_size - 3 * 20 &&
-	       p2_off <= p2->pack->index_size - 3 * 20)
+	while (p1_off < p1->pack->num_objects * p1_step &&
+	       p2_off < p2->pack->num_objects * p2_step)
 	{
 		int cmp = hashcmp(p1_base + p1_off, p2_base + p2_off);
 		/* cmp ~ p1 - p2 */
@@ -265,14 +268,14 @@ static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
 					p1_base + p1_off, p1_hint);
 			p2_hint = llist_sorted_remove(p2->unique_objects,
 					p1_base + p1_off, p2_hint);
-			p1_off+=24;
-			p2_off+=24;
+			p1_off += p1_step;
+			p2_off += p2_step;
 			continue;
 		}
 		if (cmp < 0) { /* p1 has the object, p2 doesn't */
-			p1_off+=24;
+			p1_off += p1_step;
 		} else { /* p2 has the object, p1 doesn't */
-			p2_off+=24;
+			p2_off += p2_step;
 		}
 	}
 }
@@ -352,28 +355,31 @@ static int is_superset(struct pack_list *pl, struct llist *list)
 static size_t sizeof_union(struct packed_git *p1, struct packed_git *p2)
 {
 	size_t ret = 0;
-	int p1_off, p2_off;
+	unsigned long p1_off = 0, p2_off = 0, p1_step, p2_step;
 	const unsigned char *p1_base, *p2_base;
 
-	p1_off = p2_off = 256 * 4 + 4;
 	p1_base = p1->index_data;
 	p2_base = p2->index_data;
+	p1_base += 256 * 4 + ((p1->index_version < 2) ? 4 : 8);
+	p2_base += 256 * 4 + ((p2->index_version < 2) ? 4 : 8);
+	p1_step = (p1->index_version < 2) ? 24 : 20;
+	p2_step = (p2->index_version < 2) ? 24 : 20;
 
-	while (p1_off <= p1->index_size - 3 * 20 &&
-	       p2_off <= p2->index_size - 3 * 20)
+	while (p1_off < p1->num_objects * p1_step &&
+	       p2_off < p2->num_objects * p2_step)
 	{
 		int cmp = hashcmp(p1_base + p1_off, p2_base + p2_off);
 		/* cmp ~ p1 - p2 */
 		if (cmp == 0) {
 			ret++;
-			p1_off+=24;
-			p2_off+=24;
+			p1_off += p1_step;
+			p2_off += p2_step;
 			continue;
 		}
 		if (cmp < 0) { /* p1 has the object, p2 doesn't */
-			p1_off+=24;
+			p1_off += p1_step;
 		} else { /* p2 has the object, p1 doesn't */
-			p2_off+=24;
+			p2_off += p2_step;
 		}
 	}
 	return ret;
@@ -535,7 +541,7 @@ static void scan_alt_odb_packs(void)
 static struct pack_list * add_pack(struct packed_git *p)
 {
 	struct pack_list l;
-	size_t off;
+	unsigned long off = 0, step;
 	const unsigned char *base;
 
 	if (!p->pack_local && !(alt_odb || verbose))
@@ -544,11 +550,12 @@ static struct pack_list * add_pack(struct packed_git *p)
 	l.pack = p;
 	llist_init(&l.all_objects);
 
-	off = 256 * 4 + 4;
 	base = p->index_data;
-	while (off <= p->index_size - 3 * 20) {
+	base += 256 * 4 + ((p->index_version < 2) ? 4 : 8);
+	step = (p->index_version < 2) ? 24 : 20;
+	while (off < p->num_objects * step) {
 		llist_insert_back(l.all_objects, base + off);
-		off += 24;
+		off += step;
 	}
 	/* this list will be pruned in cmp_two_packs later */
 	l.unique_objects = llist_copy(l.all_objects);
-- 
1.5.1.696.g6d352-dirty
