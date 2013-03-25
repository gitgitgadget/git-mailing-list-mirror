From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 2/3] Refactor parts of in_delta_base_cache/cache_or_unpack_entry
Date: Mon, 25 Mar 2013 19:07:40 +0100
Message-ID: <987ab8138000d0aaa7d1bb6242cced1344e4d339.1364234154.git.trast@student.ethz.ch>
References: <cover.1364234154.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Zager <szager@google.com>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"Nicolas Pitre" <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 25 19:08:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKBol-0002Te-N0
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 19:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572Ab3CYSHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 14:07:52 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:34151 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932314Ab3CYSHq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 14:07:46 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 25 Mar
 2013 19:07:41 +0100
Received: from linux-k42r.v.cablecom.net (129.132.10.215) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 25 Mar
 2013 19:07:42 +0100
X-Mailer: git-send-email 1.8.2.266.g8176668
In-Reply-To: <cover.1364234154.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.10.215]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219056>

The delta base cache lookup and test were shared.  Refactor them;
we'll need both parts again.  Also, we'll use the clearing routine
later.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 sha1_file.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 71877a7..bd054d1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1756,32 +1756,51 @@ static unsigned long pack_entry_hash(struct packed_git *p, off_t base_offset)
 	return hash % MAX_DELTA_CACHE;
 }
 
-static int in_delta_base_cache(struct packed_git *p, off_t base_offset)
+static struct delta_base_cache_entry *
+get_delta_base_cache_entry(struct packed_git *p, off_t base_offset)
 {
 	unsigned long hash = pack_entry_hash(p, base_offset);
-	struct delta_base_cache_entry *ent = delta_base_cache + hash;
+	return delta_base_cache + hash;
+}
+
+static int cmp_delta_base_cache_entry(struct delta_base_cache_entry *ent,
+				      struct packed_git *p, off_t base_offset)
+{
 	return (ent->data && ent->p == p && ent->base_offset == base_offset);
 }
 
+static int in_delta_base_cache(struct packed_git *p, off_t base_offset)
+{
+	struct delta_base_cache_entry *ent;
+	ent = get_delta_base_cache_entry(p, base_offset);
+	return cmp_delta_base_cache_entry(ent, p, base_offset);
+}
+
+static void clear_delta_base_cache_entry(struct delta_base_cache_entry *ent)
+{
+	ent->data = NULL;
+	ent->lru.next->prev = ent->lru.prev;
+	ent->lru.prev->next = ent->lru.next;
+	delta_base_cached -= ent->size;
+}
+
 static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
 	unsigned long *base_size, enum object_type *type, int keep_cache)
 {
+	struct delta_base_cache_entry *ent;
 	void *ret;
-	unsigned long hash = pack_entry_hash(p, base_offset);
-	struct delta_base_cache_entry *ent = delta_base_cache + hash;
 
-	ret = ent->data;
-	if (!ret || ent->p != p || ent->base_offset != base_offset)
+	ent = get_delta_base_cache_entry(p, base_offset);
+
+	if (!cmp_delta_base_cache_entry(ent, p, base_offset))
 		return unpack_entry(p, base_offset, type, base_size);
 
-	if (!keep_cache) {
-		ent->data = NULL;
-		ent->lru.next->prev = ent->lru.prev;
-		ent->lru.prev->next = ent->lru.next;
-		delta_base_cached -= ent->size;
-	} else {
+	ret = ent->data;
+
+	if (!keep_cache)
+		clear_delta_base_cache_entry(ent);
+	else
 		ret = xmemdupz(ent->data, ent->size);
-	}
 	*type = ent->type;
 	*base_size = ent->size;
 	return ret;
-- 
1.8.2.266.g8176668
