From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH 6/9] fetch: Check if all objects exist after fetching
Date: Tue, 16 Mar 2010 19:48:07 +0100
Message-ID: <d3c00e2a27003dca196d5480007544610cc1e5b8.1268913163.git.agruen@suse.de>
References: <cover.1268913163.git.agruen@suse.de>
	<f2bf11648d2cfb58e348d2c8caffa841012fd994.1268913163.git.agruen@suse.de>
	<f747d7538f2a2bbdb48c9902298fa87691097eba.1268913163.git.agruen@suse.de>
	<b7762c1e05412618584e38b868bcc870676f6e62.1268913163.git.agruen@suse.de>
	<672662f82e19ab268bd83f2b48980f43f126c089.1268913163.git.agruen@suse.de>
	<dbb0f92deca35a16c898af697dc41affc377ae0b.1268913163.git.agruen@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 18 12:56:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsEKb-0002C7-VL
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 12:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010Ab0CRLzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 07:55:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:53037 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752863Ab0CRLz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 07:55:28 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 345E593EE3
	for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:55:27 +0100 (CET)
In-Reply-To: <dbb0f92deca35a16c898af697dc41affc377ae0b.1268913163.git.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142460>

Check if all objects reachable from the fetched refs exist after
fetching instead of before: this allows us to distinguish between a
repository which is not up to date and a corrupted repository, and to
ensure that the repository is up to date and complete after the fetch.

In select_missing_refs() we must check which objects we have, instead of
checking which refs are up to date: otherwise, we might fetch objects
into the repository which exist in an alternate.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 builtin/fetch.c |   82 ++++++++++++++++++++++++++-----------------------------
 1 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6dc75d4..0f292b8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -440,20 +440,15 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 }
 
 /*
- * We would want to bypass the object transfer altogether if
- * everything we are going to fetch already exists and is connected
- * locally.
- *
- * The refs we are going to fetch are in ref_map.  If running
+ * If running
  *
  *  $ git rev-list --objects --stdin --not --all
  *
  * (feeding all the refs in ref_map on its standard input)
  * does not error out, that means everything reachable from the
- * refs we are going to fetch exists and is connected to some of
- * our existing refs.
+ * refs we have fetched exists.
  */
-static int quickfetch(struct ref *ref_map)
+static int check_connectivity(struct ref *ref_map)
 {
 	struct child_process revlist;
 	struct ref *ref;
@@ -461,16 +456,6 @@ static int quickfetch(struct ref *ref_map)
 	const char *argv[] = {"rev-list",
 		"--quiet", "--objects", "--stdin", "--not", "--all", NULL};
 
-	/*
-	 * If we are deepening a shallow clone we already have these
-	 * objects reachable.  Running rev-list here will return with
-	 * a good (0) exit status and we'll bypass the fetch that we
-	 * really need to perform.  Claiming failure now will ensure
-	 * we perform the network exchange to deepen our history.
-	 */
-	if (depth)
-		return -1;
-
 	if (!ref_map)
 		return 0;
 
@@ -513,46 +498,57 @@ static int quickfetch(struct ref *ref_map)
 	return finish_command(&revlist) || err;
 }
 
-static void check_existing_refs(struct ref *ref_map) {
+static void select_missing_refs(struct ref *ref_map) {
 	struct ref *ref;
-	int done = 1;
 
-	if (!depth) {
-		for (ref = ref_map; ref; ref = ref->next) {
-			if (ref->peer_ref &&
-			    !is_null_sha1(ref->old_sha1) &&
-			    !hashcmp(ref->peer_ref->old_sha1, ref->old_sha1))
-				ref->dont_fetch = 1;
-			else
-				done = 0;
-		}
+	for (ref = ref_map; ref; ref = ref->next) {
+		if (has_sha1_file(ref->old_sha1))
+			ref->dont_fetch = 1;
 	}
-	if (done) {
-		/*
-		 * When deepening of a shallow repository is requested, local
-		 * and remote refs are likely to still be equal.  In addition,
-		 * we get here if all refs are up to date but quickfetch() did
-		 * not succeed.  In both cases, fetch all refs.
-		 */
-		for (ref = ref_map; ref; ref = ref->next)
+}
+
+static int select_all_refs(struct ref *ref_map) {
+	struct ref *ref;
+	int done = 1;
+
+	for (ref = ref_map; ref; ref = ref->next) {
+		if (ref->dont_fetch) {
 			ref->dont_fetch = 0;
+			done = 0;
+		}
 	}
+
+	return done;
 }
 
 static int fetch_refs(struct transport *transport, struct ref *ref_map)
 {
 	int ret;
 
-	ret = quickfetch(ref_map);
+	if (depth) {
+		/* When deepening a shallow clone, re-fetch all the refs:
+		 * it doesn't help to have the topmost commits of each ref.
+		 */
+		select_all_refs(ref_map);
+	} else
+		select_missing_refs(ref_map);
+	ret = transport_fetch_refs(transport, ref_map);
+	if (ret)
+		return ret;
+	ret = check_connectivity(ref_map);
 	if (ret) {
-		check_existing_refs(ref_map);
+		if (select_all_refs(ref_map))
+			return ret;
+		transport_unlock_pack(transport);
 		ret = transport_fetch_refs(transport, ref_map);
+		if (ret)
+			return ret;
 	}
-	if (!ret)
-		ret |= store_updated_refs(transport->url,
-				transport->remote->name,
-				ref_map);
+	ret = store_updated_refs(transport->url,
+				 transport->remote->name,
+				 ref_map);
 	transport_unlock_pack(transport);
+
 	return ret;
 }
 
-- 
1.7.0.2.273.gc2413
