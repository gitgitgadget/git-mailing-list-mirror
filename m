From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 10/16] refs: convert namespaced ref iteration functions to object_id
Date: Fri, 20 Mar 2015 19:28:30 +0000
Message-ID: <1426879716-47835-11-git-send-email-sandals@crustytoothpaste.net>
References: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 20:29:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ2bR-0001gd-5a
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 20:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbbCTT25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 15:28:57 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50652 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751129AbbCTT2y (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 15:28:54 -0400
Received: from vauxhall.crustytoothpaste.net (wsip-184-177-1-73.no.no.cox.net [184.177.1.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D09902808F;
	Fri, 20 Mar 2015 19:28:52 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: 0.163 () BAYES_00,RDNS_DYNAMIC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265941>

Convert head_ref_namespaced and for_each_namespaced_ref to use struct
object_id.  Update the various callbacks to use struct object_id
internally as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http-backend.c | 14 +++++++-------
 refs.c         | 12 ++++++------
 refs.h         |  4 ++--
 upload-pack.c  | 28 ++++++++++++++--------------
 4 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index b6c0484..e0d6627 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -350,16 +350,16 @@ static void run_service(const char **argv)
 		exit(1);
 }
 
-static int show_text_ref(const char *name, const unsigned char *sha1,
+static int show_text_ref(const char *name, const struct object_id *oid,
 	int flag, void *cb_data)
 {
 	const char *name_nons = strip_namespace(name);
 	struct strbuf *buf = cb_data;
-	struct object *o = parse_object(sha1);
+	struct object *o = parse_object(oid->hash);
 	if (!o)
 		return 0;
 
-	strbuf_addf(buf, "%s\t%s\n", sha1_to_hex(sha1), name_nons);
+	strbuf_addf(buf, "%s\t%s\n", oid_to_hex(oid), name_nons);
 	if (o->type == OBJ_TAG) {
 		o = deref_tag(o, name, 0);
 		if (!o)
@@ -402,21 +402,21 @@ static void get_info_refs(char *arg)
 	strbuf_release(&buf);
 }
 
-static int show_head_ref(const char *refname, const unsigned char *sha1,
+static int show_head_ref(const char *refname, const struct object_id *oid,
 	int flag, void *cb_data)
 {
 	struct strbuf *buf = cb_data;
 
 	if (flag & REF_ISSYMREF) {
-		unsigned char unused[20];
+		struct object_id unused;
 		const char *target = resolve_ref_unsafe(refname,
 							RESOLVE_REF_READING,
-							unused, NULL);
+							unused.hash, NULL);
 		const char *target_nons = strip_namespace(target);
 
 		strbuf_addf(buf, "ref: %s\n", target_nons);
 	} else {
-		strbuf_addf(buf, "%s\n", sha1_to_hex(sha1));
+		strbuf_addf(buf, "%s\n", oid_to_hex(oid));
 	}
 
 	return 0;
diff --git a/refs.c b/refs.c
index 0d9b340..1fa2ec0 100644
--- a/refs.c
+++ b/refs.c
@@ -2015,27 +2015,27 @@ int for_each_replace_ref(each_ref_fn_oid fn, void *cb_data)
 	return do_for_each_ref_oid(&ref_cache, "refs/replace/", fn, 13, 0, cb_data);
 }
 
-int head_ref_namespaced(each_ref_fn fn, void *cb_data)
+int head_ref_namespaced(each_ref_fn_oid fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret = 0;
-	unsigned char sha1[20];
+	struct object_id oid;
 	int flag;
 
 	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
-	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, sha1, &flag))
-		ret = fn(buf.buf, sha1, flag, cb_data);
+	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, oid.hash, &flag))
+		ret = fn(buf.buf, &oid, flag, cb_data);
 	strbuf_release(&buf);
 
 	return ret;
 }
 
-int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
+int for_each_namespaced_ref(each_ref_fn_oid fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
 	strbuf_addf(&buf, "%srefs/", get_git_namespace());
-	ret = do_for_each_ref(&ref_cache, buf.buf, fn, 0, 0, cb_data);
+	ret = do_for_each_ref_oid(&ref_cache, buf.buf, fn, 0, 0, cb_data);
 	strbuf_release(&buf);
 	return ret;
 }
diff --git a/refs.h b/refs.h
index 951e465..6d2d66d 100644
--- a/refs.h
+++ b/refs.h
@@ -113,8 +113,8 @@ extern int for_each_tag_ref_submodule(const char *submodule, each_ref_fn_oid fn,
 extern int for_each_branch_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
 extern int for_each_remote_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
 
-extern int head_ref_namespaced(each_ref_fn fn, void *cb_data);
-extern int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
+extern int head_ref_namespaced(each_ref_fn_oid fn, void *cb_data);
+extern int for_each_namespaced_ref(each_ref_fn_oid fn, void *cb_data);
 
 static inline const char *has_glob_specials(const char *pattern)
 {
diff --git a/upload-pack.c b/upload-pack.c
index 0566ce0..2105bc2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -681,16 +681,16 @@ static void receive_needs(void)
 }
 
 /* return non-zero if the ref is hidden, otherwise 0 */
-static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int mark_our_ref(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
-	struct object *o = lookup_unknown_object(sha1);
+	struct object *o = lookup_unknown_object(oid->hash);
 
 	if (ref_is_hidden(refname)) {
 		o->flags |= HIDDEN_REF;
 		return 1;
 	}
 	if (!o)
-		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
+		die("git upload-pack: cannot find object %s:", oid_to_hex(oid));
 	o->flags |= OUR_REF;
 	return 0;
 }
@@ -705,15 +705,15 @@ static void format_symref_info(struct strbuf *buf, struct string_list *symref)
 		strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
 }
 
-static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int send_ref(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
 		" include-tag multi_ack_detailed";
 	const char *refname_nons = strip_namespace(refname);
-	unsigned char peeled[20];
+	struct object_id peeled;
 
-	if (mark_our_ref(refname, sha1, flag, NULL))
+	if (mark_our_ref(refname, oid, flag, NULL))
 		return 0;
 
 	if (capabilities) {
@@ -721,7 +721,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 
 		format_symref_info(&symref_info, cb_data);
 		packet_write(1, "%s %s%c%s%s%s%s agent=%s\n",
-			     sha1_to_hex(sha1), refname_nons,
+			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
 			     allow_tip_sha1_in_want ? " allow-tip-sha1-in-want" : "",
 			     stateless_rpc ? " no-done" : "",
@@ -729,24 +729,24 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
 	} else {
-		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname_nons);
+		packet_write(1, "%s %s\n", oid_to_hex(oid), refname_nons);
 	}
 	capabilities = NULL;
-	if (!peel_ref(refname, peeled))
-		packet_write(1, "%s %s^{}\n", sha1_to_hex(peeled), refname_nons);
+	if (!peel_ref(refname, peeled.hash))
+		packet_write(1, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
 	return 0;
 }
 
-static int find_symref(const char *refname, const unsigned char *sha1, int flag,
-		       void *cb_data)
+static int find_symref(const char *refname, const struct object_id *oid,
+			   int flag, void *cb_data)
 {
 	const char *symref_target;
 	struct string_list_item *item;
-	unsigned char unused[20];
+	struct object_id unused;
 
 	if ((flag & REF_ISSYMREF) == 0)
 		return 0;
-	symref_target = resolve_ref_unsafe(refname, 0, unused, &flag);
+	symref_target = resolve_ref_unsafe(refname, 0, unused.hash, &flag);
 	if (!symref_target || (flag & REF_ISSYMREF) == 0)
 		die("'%s' is a symref but it is not?", refname);
 	item = string_list_append(cb_data, refname);
-- 
2.2.1.209.g41e5f3a
