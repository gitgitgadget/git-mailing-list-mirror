From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/8] Apply standard object_id Coccinelle transformations.
Date: Tue,  7 Jun 2016 00:57:10 +0000
Message-ID: <20160607005716.69222-3-sandals@crustytoothpaste.net>
References: <20160607005716.69222-2-sandals@crustytoothpaste.net>
Cc: Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 02:57:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA5Kv-0003AM-2c
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 02:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbcFGA53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 20:57:29 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40722 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751473AbcFGA5Z (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 20:57:25 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8332B282A9;
	Tue,  7 Jun 2016 00:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1465261043;
	bh=IPPSvRrUCwx1OD1CumxR3gIPzLKxHDQRQSrBK/sihJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L8AWxtueIX3MilywpQ9uYJqY370JXM5rwEJuoGvSb2UnRTlBM9rrtps9dmXZGZ+6W
	 ta/7F3lur9kJXw/4lEd6Bdz8AFT1MTE8jXKp2tGLQypxG+AfRFJ1ABRAHlhcx+gCHZ
	 FVIKPLXgEJdI3SxEEo8cEu+4oYBGQS45cglvCckIhaED6v0dcztEmhS+ngzy0Flqge
	 3ljNKHSA/PzTaYDQWf9ATLfEEWzEC75S8iQVeFhaojAxYrOyobUp4Wv+iGsg0HJfD9
	 3vnxNj41JHVF42rrbf9EZ+xQY4L2r9cCm+C4KrZkBRnPqZp+xgr1WT3Dzaqgn+Hn30
	 mT2XPPqyncQqWTdVp91vEzPqaO0yntmB7+kdojYRAD08wFTrVXaPCPHm1hszexiEOQ
	 PisWrdT9VC9P2rHTSG5qHD1686WbRT7JdYdd46TSS/ylSJcC9wtGzT3zVUZGaDiucB
	 9e4PXLiVJpNlcEVh0Pls3KAqQkb2euozCLC27ob0+xEC70u9gD7
X-Mailer: git-send-email 2.8.1.369.geae769a
In-Reply-To: <20160607005716.69222-2-sandals@crustytoothpaste.net>
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296583>

Apply the standard set of semantic patches to convert some leftover
places using struct object_id's hash member to instead use the wrapper
functions that take struct object_id natively.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bisect.c             |  2 +-
 builtin/merge.c      | 13 ++++++-------
 refs/files-backend.c |  4 ++--
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/bisect.c b/bisect.c
index 6d93edbc..ff147589 100644
--- a/bisect.c
+++ b/bisect.c
@@ -754,7 +754,7 @@ static void handle_bad_merge_base(void)
 static void handle_skipped_merge_base(const unsigned char *mb)
 {
 	char *mb_hex = sha1_to_hex(mb);
-	char *bad_hex = sha1_to_hex(current_bad_oid->hash);
+	char *bad_hex = oid_to_hex(current_bad_oid);
 	char *good_hex = join_sha1_array_hex(&good_revs, ' ');
 
 	warning("the merge base between %s and [%s] "
diff --git a/builtin/merge.c b/builtin/merge.c
index b555a1bf..1e7be852 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -501,7 +501,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		if (ref_exists(truname.buf)) {
 			strbuf_addf(msg,
 				    "%s\t\tbranch '%s'%s of .\n",
-				    sha1_to_hex(remote_head->object.oid.hash),
+				    oid_to_hex(&remote_head->object.oid),
 				    truname.buf + 11,
 				    (early ? " (early part)" : ""));
 			strbuf_release(&truname);
@@ -515,7 +515,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		desc = merge_remote_util(remote_head);
 		if (desc && desc->obj && desc->obj->type == OBJ_TAG) {
 			strbuf_addf(msg, "%s\t\t%s '%s'\n",
-				    sha1_to_hex(desc->obj->oid.hash),
+				    oid_to_hex(&desc->obj->oid),
 				    typename(desc->obj->type),
 				    remote);
 			goto cleanup;
@@ -523,7 +523,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	}
 
 	strbuf_addf(msg, "%s\t\tcommit '%s'\n",
-		sha1_to_hex(remote_head->object.oid.hash), remote);
+		oid_to_hex(&remote_head->object.oid), remote);
 cleanup:
 	strbuf_release(&buf);
 	strbuf_release(&bname);
@@ -1366,7 +1366,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	for (p = remoteheads; p; p = p->next) {
 		struct commit *commit = p->item;
 		strbuf_addf(&buf, "GITHEAD_%s",
-			    sha1_to_hex(commit->object.oid.hash));
+			    oid_to_hex(&commit->object.oid));
 		setenv(buf.buf, merge_remote_util(commit)->name, 1);
 		strbuf_reset(&buf);
 		if (fast_forward != FF_ONLY &&
@@ -1425,7 +1425,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		goto done;
 	} else if (fast_forward != FF_NO && !remoteheads->next &&
 			!common->next &&
-			!hashcmp(common->item->object.oid.hash, head_commit->object.oid.hash)) {
+			!oidcmp(&common->item->object.oid, &head_commit->object.oid)) {
 		/* Again the most common case of merging one remote. */
 		struct strbuf msg = STRBUF_INIT;
 		struct commit *commit;
@@ -1499,8 +1499,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			 * HEAD^^" would be missed.
 			 */
 			common_one = get_merge_bases(head_commit, j->item);
-			if (hashcmp(common_one->item->object.oid.hash,
-				j->item->object.oid.hash)) {
+			if (oidcmp(&common_one->item->object.oid, &j->item->object.oid)) {
 				up_to_date = 0;
 				break;
 			}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1f380764..dac3a222 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1725,14 +1725,14 @@ static int verify_lock(struct ref_lock *lock,
 			errno = save_errno;
 			return -1;
 		} else {
-			hashclr(lock->old_oid.hash);
+			oidclr(&lock->old_oid);
 			return 0;
 		}
 	}
 	if (old_sha1 && hashcmp(lock->old_oid.hash, old_sha1)) {
 		strbuf_addf(err, "ref %s is at %s but expected %s",
 			    lock->ref_name,
-			    sha1_to_hex(lock->old_oid.hash),
+			    oid_to_hex(&lock->old_oid),
 			    sha1_to_hex(old_sha1));
 		errno = EBUSY;
 		return -1;
