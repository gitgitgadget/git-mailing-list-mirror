From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 08/13] ref_newer: convert to use struct object_id
Date: Fri,  9 Oct 2015 01:43:54 +0000
Message-ID: <1444355039-186351-9-git-send-email-sandals@crustytoothpaste.net>
References: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 03:46:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkMl6-000293-3w
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 03:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958AbbJIBpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 21:45:47 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58078 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755838AbbJIBpM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2015 21:45:12 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 54BAD2809F;
	Fri,  9 Oct 2015 01:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1444355111;
	bh=d1RKW2fehV1zmdWcOjTw3PNbjF1Hs4nDSq7h+jy+fbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b9fzkNOEOGhFM/F9f3Lj3CM+l1gLr6dSiChVWVW7Z3ZhIaMD66cA6cj6hdnci3v1h
	 L7Jupcuf5s1zdZnnoWjcYUiGG6COwyIuY4KKZcQg8vhszy0yZJhJshhchuqjwZYNEH
	 KoKWcDaPj7HDA+70UgxKT1Jw0tPNgrVHB41jB2J0aQRR6fWL5iSdJkP8tPbrwD0iTK
	 zWG3dh1yAt1jZ2Ncdj94Bnr0cgmAskr5OvELNGolsJCig4WR6hafLJI0+F9nax2fvv
	 ayZX31IEKZyIIXv2u1jhQNyUA1krWd1nKP3rlg+6tWDXJDERE5RkEvosHoPaMuykdc
	 BVRkrNHMrOzv4qpIp+pCLs75tsWS1hBVveVmkomX/w4MEEKneNMn2oslbgDz4lJnMb
	 CubaMpG1u+WoUQdow2VuWe70+r5FoOZtHdvxQI1/VpPXGmRd7VtrmFm+rup8qep/aN
	 KSL8D+FefseNgYqLfg75eYrt2f04ejPXs2KBLn7eI6V21OT215d
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279297>

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
index 68dec162..6694cf20 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -417,7 +417,7 @@ static int get_push_ref_states(const struct ref *remote_refs,
 		else if (is_null_oid(&ref->old_oid))
 			info->status = PUSH_STATUS_CREATE;
 		else if (has_object_file(&ref->old_oid) &&
-			 ref_newer(ref->new_oid.hash, ref->old_oid.hash))
+			 ref_newer(&ref->new_oid, &ref->old_oid))
 			info->status = PUSH_STATUS_FASTFORWARD;
 		else
 			info->status = PUSH_STATUS_OUTOFDATE;
diff --git a/http-push.c b/http-push.c
index d054fdb9..0e688a76 100644
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
index 05741202..cb85c3e1 100644
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
index 163ea5e8..4a039bae 100644
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
2.6.1
