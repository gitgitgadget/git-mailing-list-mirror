From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH 4/9] fetch: Move deepening fetch check into builtin/fetch.c
Date: Tue, 16 Mar 2010 16:45:47 +0100
Message-ID: <672662f82e19ab268bd83f2b48980f43f126c089.1268913163.git.agruen@suse.de>
References: <cover.1268913163.git.agruen@suse.de>
	<f2bf11648d2cfb58e348d2c8caffa841012fd994.1268913163.git.agruen@suse.de>
	<f747d7538f2a2bbdb48c9902298fa87691097eba.1268913163.git.agruen@suse.de>
	<b7762c1e05412618584e38b868bcc870676f6e62.1268913163.git.agruen@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 18 12:55:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsEK8-0001wv-HL
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 12:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903Ab0CRLz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 07:55:28 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50440 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688Ab0CRLz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 07:55:26 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id A7853890B6
	for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:55:25 +0100 (CET)
In-Reply-To: <b7762c1e05412618584e38b868bcc870676f6e62.1268913163.git.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142457>

Check if we are doing a deepening fetch in fetch instead of guessing in
transport_fetch_refs().

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 builtin/fetch.c |   34 ++++++++++++++++++++++++++++++++--
 cache.h         |    3 ++-
 transport.c     |   38 +++++++++++++-------------------------
 3 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 957be9f..fc6efc7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -489,11 +489,41 @@ static int quickfetch(struct ref *ref_map)
 	return finish_command(&revlist) || err;
 }
 
+static void check_existing_refs(struct ref *ref_map) {
+	struct ref *ref;
+	int done = 1;
+
+	if (!depth) {
+		for (ref = ref_map; ref; ref = ref->next) {
+			if (ref->peer_ref &&
+			    !is_null_sha1(ref->old_sha1) &&
+			    !hashcmp(ref->peer_ref->old_sha1, ref->old_sha1))
+				ref->dont_fetch = 1;
+			else
+				done = 0;
+		}
+	}
+	if (done) {
+		/*
+		 * When deepening of a shallow repository is requested, local
+		 * and remote refs are likely to still be equal.  In addition,
+		 * we get here if all refs are up to date but quickfetch() did
+		 * not succeed.  In both cases, fetch all refs.
+		 */
+		for (ref = ref_map; ref; ref = ref->next)
+			ref->dont_fetch = 0;
+	}
+}
+
 static int fetch_refs(struct transport *transport, struct ref *ref_map)
 {
-	int ret = quickfetch(ref_map);
-	if (ret)
+	int ret;
+
+	ret = quickfetch(ref_map);
+	if (ret) {
+		check_existing_refs(ref_map);
 		ret = transport_fetch_refs(transport, ref_map);
+	}
 	if (!ret)
 		ret |= store_updated_refs(transport->url,
 				transport->remote->name,
diff --git a/cache.h b/cache.h
index 89f6a40..abfc682 100644
--- a/cache.h
+++ b/cache.h
@@ -869,7 +869,8 @@ struct ref {
 	unsigned int force:1,
 		merge:1,
 		nonfastforward:1,
-		deletion:1;
+		deletion:1,
+		dont_fetch:1;
 	enum {
 		REF_STATUS_NONE = 0,
 		REF_STATUS_OK,
diff --git a/transport.c b/transport.c
index 8ce3936..d1288af 100644
--- a/transport.c
+++ b/transport.c
@@ -1127,36 +1127,24 @@ const struct ref *transport_get_remote_refs(struct transport *transport)
 
 int transport_fetch_refs(struct transport *transport, struct ref *refs)
 {
-	int rc;
-	int nr_heads = 0, nr_alloc = 0, nr_refs = 0;
-	struct ref **heads = NULL;
+	int rc = 0;
+	int nr_heads;
+	struct ref **heads;
 	struct ref *rm;
 
-	for (rm = refs; rm; rm = rm->next) {
-		nr_refs++;
-		if (rm->peer_ref &&
-		    !is_null_sha1(rm->old_sha1) &&
-		    !hashcmp(rm->peer_ref->old_sha1, rm->old_sha1))
+	for (nr_heads = 0, rm = refs; rm; rm = rm->next) {
+		if (rm->dont_fetch)
 			continue;
-		ALLOC_GROW(heads, nr_heads + 1, nr_alloc);
-		heads[nr_heads++] = rm;
+		nr_heads++;
 	}
-
-	if (!nr_heads) {
-		/*
-		 * When deepening of a shallow repository is requested,
-		 * then local and remote refs are likely to still be equal.
-		 * Just feed them all to the fetch method in that case.
-		 * This condition shouldn't be met in a non-deepening fetch
-		 * (see builtin-fetch.c:quickfetch()).
-		 */
-		heads = xmalloc(nr_refs * sizeof(*heads));
-		for (rm = refs; rm; rm = rm->next)
-			heads[nr_heads++] = rm;
+	heads = xmalloc(nr_heads * sizeof(*heads));
+	for (nr_heads = 0, rm = refs; rm; rm = rm->next) {
+		if (rm->dont_fetch)
+			continue;
+		heads[nr_heads++] = rm;
 	}
-
-	rc = transport->fetch(transport, nr_heads, heads);
-
+	if (nr_heads)
+		rc = transport->fetch(transport, nr_heads, heads);
 	free(heads);
 	return rc;
 }
-- 
1.7.0.2.273.gc2413
