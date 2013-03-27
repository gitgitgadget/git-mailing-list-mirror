From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 2/3] Refactor parts of in_delta_base_cache/cache_or_unpack_entry
Date: Wed, 27 Mar 2013 21:03:41 +0100
Message-ID: <272cfb933d5ab748fa8c1b3ebb769ecf90f3bbfb.1364414442.git.trast@inf.ethz.ch>
References: <cover.1364414442.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Zager <szager@google.com>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"Nicolas Pitre" <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 27 21:04:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKwaH-00059F-0C
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 21:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236Ab3C0UDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 16:03:54 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:31391 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754141Ab3C0UDw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 16:03:52 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 27 Mar
 2013 21:03:48 +0100
Received: from linux-k42r.v.cablecom.net (46.126.8.85) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 27 Mar
 2013 21:03:49 +0100
X-Mailer: git-send-email 1.8.2.344.g1440b22
In-Reply-To: <cover.1364414442.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219320>

The delta base cache lookup and test were shared.  Refactor them;
we'll need both parts again.  Also, we'll use the clearing routine
later.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 sha1_file.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 2c8b549..da41f51 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1835,32 +1835,51 @@ static unsigned long pack_entry_hash(struct packed_git *p, off_t base_offset)
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
+static int eq_delta_base_cache_entry(struct delta_base_cache_entry *ent,
+				     struct packed_git *p, off_t base_offset)
+{
 	return (ent->data && ent->p == p && ent->base_offset == base_offset);
 }
 
+static int in_delta_base_cache(struct packed_git *p, off_t base_offset)
+{
+	struct delta_base_cache_entry *ent;
+	ent = get_delta_base_cache_entry(p, base_offset);
+	return eq_delta_base_cache_entry(ent, p, base_offset);
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
+	if (!eq_delta_base_cache_entry(ent, p, base_offset))
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
1.8.2.344.g1440b22
