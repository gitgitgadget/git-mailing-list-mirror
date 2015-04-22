From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 12/16] refs: rename do_for_each_ref_oid to do_for_each_ref
Date: Wed, 22 Apr 2015 23:24:17 +0000
Message-ID: <1429745061-295908-13-git-send-email-sandals@crustytoothpaste.net>
References: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 01:25:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl412-000415-JV
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 01:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965560AbbDVXZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 19:25:00 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44795 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758583AbbDVXYg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 19:24:36 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D3F98282AE;
	Wed, 22 Apr 2015 23:24:33 +0000 (UTC)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267664>

do_for_each_ref was unused due to previous patches, so rename
do_for_each_ref_oid to do_for_each_ref.  Similarly, remove the unused fn
member from struct ref_entry in favor of renaming the fn_oid member.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs.c | 43 +++++++++++--------------------------------
 1 file changed, 11 insertions(+), 32 deletions(-)

diff --git a/refs.c b/refs.c
index 185b40f..9f687e8 100644
--- a/refs.c
+++ b/refs.c
@@ -693,8 +693,7 @@ struct ref_entry_cb {
 	const char *base;
 	int trim;
 	int flags;
-	each_ref_fn *fn;
-	each_ref_fn_oid *fn_oid;
+	each_ref_fn_oid *fn;
 	void *cb_data;
 };
 
@@ -718,13 +717,8 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
 	/* Store the old value, in case this is a recursive call: */
 	old_current_ref = current_ref;
 	current_ref = entry;
-	if (data->fn_oid) {
-		retval = data->fn_oid(entry->name + data->trim, &entry->u.value.oid,
-				 entry->flag, data->cb_data);
-	} else {
-		retval = data->fn(entry->name + data->trim, entry->u.value.oid.hash,
-				 entry->flag, data->cb_data);
-	}
+	retval = data->fn(entry->name + data->trim, &entry->u.value.oid,
+			 entry->flag, data->cb_data);
 	current_ref = old_current_ref;
 	return retval;
 }
@@ -1949,28 +1943,13 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
  * 0.
  */
 static int do_for_each_ref(struct ref_cache *refs, const char *base,
-			   each_ref_fn fn, int trim, int flags, void *cb_data)
-{
-	struct ref_entry_cb data;
-	data.base = base;
-	data.trim = trim;
-	data.flags = flags;
-	data.fn = fn;
-	data.fn_oid = NULL;
-	data.cb_data = cb_data;
-
-	return do_for_each_entry(refs, base, do_one_ref, &data);
-}
-
-static int do_for_each_ref_oid(struct ref_cache *refs, const char *base,
 			   each_ref_fn_oid fn, int trim, int flags, void *cb_data)
 {
 	struct ref_entry_cb data;
 	data.base = base;
 	data.trim = trim;
 	data.flags = flags;
-	data.fn = NULL;
-	data.fn_oid = fn;
+	data.fn = fn;
 	data.cb_data = cb_data;
 
 	if (ref_paranoia < 0)
@@ -2011,23 +1990,23 @@ int head_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data)
 
 int for_each_ref(each_ref_fn_oid fn, void *cb_data)
 {
-	return do_for_each_ref_oid(&ref_cache, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(&ref_cache, "", fn, 0, 0, cb_data);
 }
 
 int for_each_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data)
 {
-	return do_for_each_ref_oid(get_ref_cache(submodule), "", fn, 0, 0, cb_data);
+	return do_for_each_ref(get_ref_cache(submodule), "", fn, 0, 0, cb_data);
 }
 
 int for_each_ref_in(const char *prefix, each_ref_fn_oid fn, void *cb_data)
 {
-	return do_for_each_ref_oid(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
+	return do_for_each_ref(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
 }
 
 int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 		each_ref_fn_oid fn, void *cb_data)
 {
-	return do_for_each_ref_oid(get_ref_cache(submodule), prefix, fn, strlen(prefix), 0, cb_data);
+	return do_for_each_ref(get_ref_cache(submodule), prefix, fn, strlen(prefix), 0, cb_data);
 }
 
 int for_each_tag_ref(each_ref_fn_oid fn, void *cb_data)
@@ -2062,7 +2041,7 @@ int for_each_remote_ref_submodule(const char *submodule, each_ref_fn_oid fn, voi
 
 int for_each_replace_ref(each_ref_fn_oid fn, void *cb_data)
 {
-	return do_for_each_ref_oid(&ref_cache, "refs/replace/", fn, 13, 0, cb_data);
+	return do_for_each_ref(&ref_cache, "refs/replace/", fn, 13, 0, cb_data);
 }
 
 int head_ref_namespaced(each_ref_fn_oid fn, void *cb_data)
@@ -2085,7 +2064,7 @@ int for_each_namespaced_ref(each_ref_fn_oid fn, void *cb_data)
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
 	strbuf_addf(&buf, "%srefs/", get_git_namespace());
-	ret = do_for_each_ref_oid(&ref_cache, buf.buf, fn, 0, 0, cb_data);
+	ret = do_for_each_ref(&ref_cache, buf.buf, fn, 0, 0, cb_data);
 	strbuf_release(&buf);
 	return ret;
 }
@@ -2127,7 +2106,7 @@ int for_each_glob_ref(each_ref_fn_oid fn, const char *pattern, void *cb_data)
 
 int for_each_rawref(each_ref_fn_oid fn, void *cb_data)
 {
-	return do_for_each_ref_oid(&ref_cache, "", fn, 0,
+	return do_for_each_ref(&ref_cache, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
-- 
2.3.5
