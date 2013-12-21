From: Jeff King <peff@peff.net>
Subject: [PATCH v4 04/23] pack-objects: factor out name_hash
Date: Sat, 21 Dec 2013 08:59:39 -0500
Message-ID: <20131221135939.GD21145@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 14:59:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuN5n-0004pz-62
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 14:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867Ab3LUN7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 08:59:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:48473 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754669Ab3LUN7l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 08:59:41 -0500
Received: (qmail 7320 invoked by uid 102); 21 Dec 2013 13:59:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 07:59:40 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 08:59:39 -0500
Content-Disposition: inline
In-Reply-To: <20131221135651.GA20818@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239596>

From: Vicent Marti <tanoku@gmail.com>

As the pack-objects system grows beyond the single
pack-objects.c file, more parts (like the soon-to-exist
bitmap code) will need to compute hashes for matching
deltas. Factor out name_hash to make it available to other
files.

Signed-off-by: Vicent Marti <tanoku@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 24 ++----------------------
 pack-objects.h         | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f3f0cf9..faf746b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -778,26 +778,6 @@ static void write_pack_file(void)
 			written, nr_result);
 }
 
-static uint32_t name_hash(const char *name)
-{
-	uint32_t c, hash = 0;
-
-	if (!name)
-		return 0;
-
-	/*
-	 * This effectively just creates a sortable number from the
-	 * last sixteen non-whitespace characters. Last characters
-	 * count "most", so things that end in ".c" sort together.
-	 */
-	while ((c = *name++) != 0) {
-		if (isspace(c))
-			continue;
-		hash = (hash >> 2) + (c << 24);
-	}
-	return hash;
-}
-
 static void setup_delta_attr_check(struct git_attr_check *check)
 {
 	static struct git_attr *attr_delta;
@@ -826,7 +806,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	struct object_entry *entry;
 	struct packed_git *p, *found_pack = NULL;
 	off_t found_offset = 0;
-	uint32_t hash = name_hash(name);
+	uint32_t hash = pack_name_hash(name);
 	uint32_t index_pos;
 
 	entry = packlist_find(&to_pack, sha1, &index_pos);
@@ -1082,7 +1062,7 @@ static void add_preferred_base_object(const char *name)
 {
 	struct pbase_tree *it;
 	int cmplen;
-	unsigned hash = name_hash(name);
+	unsigned hash = pack_name_hash(name);
 
 	if (!num_preferred_base || check_pbase_path(hash))
 		return;
diff --git a/pack-objects.h b/pack-objects.h
index f528215..90ad0a8 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -44,4 +44,24 @@ struct object_entry *packlist_find(struct packing_data *pdata,
 				   const unsigned char *sha1,
 				   uint32_t *index_pos);
 
+static inline uint32_t pack_name_hash(const char *name)
+{
+	uint32_t c, hash = 0;
+
+	if (!name)
+		return 0;
+
+	/*
+	 * This effectively just creates a sortable number from the
+	 * last sixteen non-whitespace characters. Last characters
+	 * count "most", so things that end in ".c" sort together.
+	 */
+	while ((c = *name++) != 0) {
+		if (isspace(c))
+			continue;
+		hash = (hash >> 2) + (c << 24);
+	}
+	return hash;
+}
+
 #endif
-- 
1.8.5.1.399.g900e7cd
