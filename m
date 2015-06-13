From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 08/10] ref_newer: convert to use struct object_id
Date: Sat, 13 Jun 2015 22:16:41 +0000
Message-ID: <1434233803-422442-9-git-send-email-sandals@crustytoothpaste.net>
References: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 00:17:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3tjw-0002tS-5M
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 00:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbbFMWRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 18:17:09 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:42863 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751255AbbFMWQx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 18:16:53 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0E4CB28099;
	Sat, 13 Jun 2015 22:16:52 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -1 ALL_TRUSTED
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271598>

Convert ref_newer and its caller to use struct object_id instead of
unsigned char *.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/remote.c | 2 +-
 http-push.c      | 4 ++--
 remote.c         | 8 ++++----
 remote.h         | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index fa4d04c..0efc388 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -411,7 +411,7 @@ static int get_push_ref_states(const struct ref *remote_refs,
 		else if (is_null_oid(&ref->old_oid))
 			info->status = PUSH_STATUS_CREATE;
 		else if (has_object_file(&ref->old_oid) &&
-			 ref_newer(ref->new_oid.hash, ref->old_oid.hash))
+			 ref_newer(&ref->new_oid, &ref->old_oid))
 			info->status = PUSH_STATUS_FASTFORWARD;
 		else
 			info->status = PUSH_STATUS_OUTOFDATE;
diff --git a/http-push.c b/http-push.c
index d054fdb..0e688a7 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1899,8 +1899,8 @@ int main(int argc, char **argv)
 		    !is_null_oid(&ref->old_oid) &&
 		    !ref->force) {
 			if (!has_object_file(&ref->old_oid) ||
-			    !ref_newer(ref->peer_ref->new_oid.hash,
-				       ref->old_oid.hash)) {
+			    !ref_newer(&ref->peer_ref->new_oid,
+				       &ref->old_oid)) {
 				/*
 				 * We do not have the remote ref, or
 				 * we know that the remote ref is not
diff --git a/remote.c b/remote.c
index 0574120..cb85c3e 100644
--- a/remote.c
+++ b/remote.c
@@ -1626,7 +1626,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 			else if (!lookup_commit_reference_gently(ref->old_oid.hash, 1) ||
 				 !lookup_commit_reference_gently(ref->new_oid.hash, 1))
 				reject_reason = REF_STATUS_REJECT_NEEDS_FORCE;
-			else if (!ref_newer(ref->new_oid.hash, ref->old_oid.hash))
+			else if (!ref_newer(&ref->new_oid, &ref->old_oid))
 				reject_reason = REF_STATUS_REJECT_NONFASTFORWARD;
 		}
 
@@ -1982,7 +1982,7 @@ static void unmark_and_free(struct commit_list *list, unsigned int mark)
 	}
 }
 
-int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
+int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 {
 	struct object *o;
 	struct commit *old, *new;
@@ -1993,12 +1993,12 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
 	 * Both new and old must be commit-ish and new is descendant of
 	 * old.  Otherwise we require --force.
 	 */
-	o = deref_tag(parse_object(old_sha1), NULL, 0);
+	o = deref_tag(parse_object(old_oid->hash), NULL, 0);
 	if (!o || o->type != OBJ_COMMIT)
 		return 0;
 	old = (struct commit *) o;
 
-	o = deref_tag(parse_object(new_sha1), NULL, 0);
+	o = deref_tag(parse_object(new_oid->hash), NULL, 0);
 	if (!o || o->type != OBJ_COMMIT)
 		return 0;
 	new = (struct commit *) o;
diff --git a/remote.h b/remote.h
index 163ea5e..4a039ba 100644
--- a/remote.h
+++ b/remote.h
@@ -150,7 +150,7 @@ extern struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 				     struct sha1_array *shallow);
 
 int resolve_remote_symref(struct ref *ref, struct ref *list);
-int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1);
+int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
 
 /*
  * Remove and free all but the first of any entries in the input list
-- 
2.4.0
