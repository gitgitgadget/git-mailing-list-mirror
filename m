From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 07/12] ref_newer: convert to use struct object_id
Date: Tue, 10 Nov 2015 02:22:25 +0000
Message-ID: <1447122150-672570-8-git-send-email-sandals@crustytoothpaste.net>
References: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 03:23:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvyav-0001RF-5U
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 03:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbbKJCXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 21:23:31 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58417 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752247AbbKJCW4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 21:22:56 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AAD012809B;
	Tue, 10 Nov 2015 02:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1447122174;
	bh=e2dmk4TKAy52wPPnH/YRzPcDlH4W0Rt8CJxFeCHd2HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V2BFarTA0byv8M7St3PToEhDJgw2P3ZeyO3bCJjIQ293EHooEL6ewFkhgHC5luSxh
	 aqOOkb+Ky9jk2DTtU6edfylp0k/vUASvzSA+I+aN7CGT27NejJumUUzw8b7/irZuzN
	 uMICqTjTPrzmnWC+lMkKt60LNu64eR2SlvlFVd8NPvqzNgAqE/Ic+p9hLp+PI6Sr3f
	 JLoHpUA4Vpbsp+PvAvqTQHUerXXWg3Q7H4FPl52F01k9CivyD+25QOD9iQxv2AGacw
	 k7l86rcJxjvUYeJb7NRuoJiWgHLNOdZ1mwEYMeR4yBq8BAGvH+PgkqDDVC8ay9XaKq
	 qUdLSK63daOc/Tk7fIj4zx/HoXbeSuhYJEMB7S/4TplJc00covLCSXHPwxWMTyLQ8f
	 chOcXy4oNblj3y4oe/BaDEgDHZFM4LrGSahZKnPjkItB+VTN5ndqGksy/FYKtAHp+8
	 IUkeYH0zqGhj7WA0ugKPKL8t4iATtVAHY5EYGb1zYSEgniz2kWt
X-Mailer: git-send-email 2.6.2.409.gb049f0a
In-Reply-To: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281100>

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
index f2db3a62..68ce3405 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1886,8 +1886,8 @@ int main(int argc, char **argv)
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
index 4beebadc..bdae86c6 100644
--- a/remote.c
+++ b/remote.c
@@ -1590,7 +1590,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 			else if (!lookup_commit_reference_gently(ref->old_oid.hash, 1) ||
 				 !lookup_commit_reference_gently(ref->new_oid.hash, 1))
 				reject_reason = REF_STATUS_REJECT_NEEDS_FORCE;
-			else if (!ref_newer(ref->new_oid.hash, ref->old_oid.hash))
+			else if (!ref_newer(&ref->new_oid, &ref->old_oid))
 				reject_reason = REF_STATUS_REJECT_NONFASTFORWARD;
 		}
 
@@ -1944,7 +1944,7 @@ static void unmark_and_free(struct commit_list *list, unsigned int mark)
 	}
 }
 
-int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
+int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 {
 	struct object *o;
 	struct commit *old, *new;
@@ -1955,12 +1955,12 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
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
2.6.2.409.gb049f0a
