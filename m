From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/3] call init_pack_revindex() lazily
Date: Mon, 23 Jun 2008 21:22:14 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806232121060.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 03:24:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAxGT-0004Gg-Qr
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 03:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441AbYFXBWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 21:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbYFXBWu
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 21:22:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10419 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754441AbYFXBWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 21:22:16 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K2Y00MYB14FV2G0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 Jun 2008 21:21:51 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85958>

This makes life much easier for next patch, as well as being more efficient
when the revindex is actually not used.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |    2 --
 pack-check.c           |    1 -
 pack-revindex.c        |    6 ++++--
 pack-revindex.h        |    1 -
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 447d492..827673c 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1148,8 +1148,6 @@ static void get_object_details(void)
 		sorted_by_offset[i] = objects + i;
 	qsort(sorted_by_offset, nr_objects, sizeof(*sorted_by_offset), pack_offset_sort);
 
-	init_pack_revindex();
-
 	for (i = 0; i < nr_objects; i++)
 		check_object(sorted_by_offset[i]);
 
diff --git a/pack-check.c b/pack-check.c
index f489873..b99a917 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -107,7 +107,6 @@ static void show_pack_info(struct packed_git *p)
 
 	nr_objects = p->num_objects;
 	memset(chain_histogram, 0, sizeof(chain_histogram));
-	init_pack_revindex();
 
 	for (i = 0; i < nr_objects; i++) {
 		const unsigned char *sha1;
diff --git a/pack-revindex.c b/pack-revindex.c
index a8aa2cd..cd300bd 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -40,7 +40,7 @@ static int pack_revindex_ix(struct packed_git *p)
 	return -1 - i;
 }
 
-void init_pack_revindex(void)
+static void init_pack_revindex(void)
 {
 	int num;
 	struct packed_git *p;
@@ -118,9 +118,11 @@ struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
 	struct pack_revindex *rix;
 	struct revindex_entry *revindex;
 
+	if (!pack_revindex_hashsz)
+		init_pack_revindex();
 	num = pack_revindex_ix(p);
 	if (num < 0)
-		die("internal error: pack revindex uninitialized");
+		die("internal error: pack revindex fubar");
 
 	rix = &pack_revindex[num];
 	if (!rix->revindex)
diff --git a/pack-revindex.h b/pack-revindex.h
index c3527a7..36a514a 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -6,7 +6,6 @@ struct revindex_entry {
 	unsigned int nr;
 };
 
-void init_pack_revindex(void);
 struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs);
 
 #endif
-- 
1.5.6.GIT
