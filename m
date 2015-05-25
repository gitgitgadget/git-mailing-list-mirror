From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 46/56] upload-pack: rewrite functions to take object_id arguments
Date: Mon, 25 May 2015 18:39:12 +0000
Message-ID: <1432579162-411464-47-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:41:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxJB-0001F8-6k
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbbEYSkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:47 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50747 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751491AbbEYSkc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:32 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4B9F52809F;
	Mon, 25 May 2015 18:40:31 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269870>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 upload-pack.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 8268037..929284f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -681,9 +681,9 @@ static void receive_needs(void)
 }
 
 /* return non-zero if the ref is hidden, otherwise 0 */
-static int mark_our_ref(const char *refname, const unsigned char *sha1)
+static int mark_our_ref(const char *refname, const struct object_id *oid)
 {
-	struct object *o = lookup_unknown_object(sha1);
+	struct object *o = lookup_unknown_object(oid->hash);
 
 	if (ref_is_hidden(refname)) {
 		o->flags |= HIDDEN_REF;
@@ -693,9 +693,10 @@ static int mark_our_ref(const char *refname, const unsigned char *sha1)
 	return 0;
 }
 
-static int check_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int check_ref(const char *refname, const struct object_id *oid,
+		     int flag, void *cb_data)
 {
-	mark_our_ref(refname, sha1);
+	mark_our_ref(refname, oid);
 	return 0;
 }
 
@@ -709,7 +710,8 @@ static void format_symref_info(struct strbuf *buf, struct string_list *symref)
 		strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
 }
 
-static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int send_ref(const char *refname, const struct object_id *oid,
+		    int flag, void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
@@ -717,7 +719,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	const char *refname_nons = strip_namespace(refname);
 	unsigned char peeled[20];
 
-	if (mark_our_ref(refname, sha1))
+	if (mark_our_ref(refname, oid))
 		return 0;
 
 	if (capabilities) {
@@ -725,7 +727,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 
 		format_symref_info(&symref_info, cb_data);
 		packet_write(1, "%s %s%c%s%s%s%s agent=%s\n",
-			     sha1_to_hex(sha1), refname_nons,
+			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
 			     allow_tip_sha1_in_want ? " allow-tip-sha1-in-want" : "",
 			     stateless_rpc ? " no-done" : "",
@@ -733,7 +735,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
 	} else {
-		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname_nons);
+		packet_write(1, "%s %s\n", oid_to_hex(oid), refname_nons);
 	}
 	capabilities = NULL;
 	if (!peel_ref(refname, peeled))
@@ -765,20 +767,14 @@ static void upload_pack(void)
 	head_ref_namespaced(find_symref, &symref);
 
 	if (advertise_refs || !stateless_rpc) {
-		struct each_ref_fn_sha1_adapter wrapped_send_ref =
-			{send_ref, &symref};
-
 		reset_timeout();
-		head_ref_namespaced(each_ref_fn_adapter, &wrapped_send_ref);
-		for_each_namespaced_ref(each_ref_fn_adapter, &wrapped_send_ref);
+		head_ref_namespaced(send_ref, &symref);
+		for_each_namespaced_ref(send_ref, &symref);
 		advertise_shallow_grafts(1);
 		packet_flush(1);
 	} else {
-		struct each_ref_fn_sha1_adapter wrapped_check_ref =
-			{check_ref, NULL};
-
-		head_ref_namespaced(each_ref_fn_adapter, &wrapped_check_ref);
-		for_each_namespaced_ref(each_ref_fn_adapter, &wrapped_check_ref);
+		head_ref_namespaced(check_ref, NULL);
+		for_each_namespaced_ref(check_ref, NULL);
 	}
 	string_list_clear(&symref, 1);
 	if (advertise_refs)
-- 
2.4.0
