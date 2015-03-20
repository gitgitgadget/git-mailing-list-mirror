From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 16/16] refs: convert struct ref_lock to struct object_id
Date: Fri, 20 Mar 2015 19:28:36 +0000
Message-ID: <1426879716-47835-17-git-send-email-sandals@crustytoothpaste.net>
References: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 20:29:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ2bk-0001va-LW
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 20:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbbCTT3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 15:29:07 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50668 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751475AbbCTT27 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 15:28:59 -0400
Received: from vauxhall.crustytoothpaste.net (wsip-184-177-1-73.no.no.cox.net [184.177.1.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DEA4D28093;
	Fri, 20 Mar 2015 19:28:58 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: 0.163 () BAYES_00,RDNS_DYNAMIC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265948>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs.c | 22 +++++++++++-----------
 refs.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 941e466..b54525a 100644
--- a/refs.c
+++ b/refs.c
@@ -2099,16 +2099,16 @@ static struct ref_lock *verify_lock(struct ref_lock *lock,
 {
 	if (read_ref_full(lock->ref_name,
 			  mustexist ? RESOLVE_REF_READING : 0,
-			  lock->old_sha1, NULL)) {
+			  lock->old_oid.hash, NULL)) {
 		int save_errno = errno;
 		error("Can't verify ref %s", lock->ref_name);
 		unlock_ref(lock);
 		errno = save_errno;
 		return NULL;
 	}
-	if (hashcmp(lock->old_sha1, old_sha1)) {
+	if (hashcmp(lock->old_oid.hash, old_sha1)) {
 		error("Ref %s is at %s but expected %s", lock->ref_name,
-			sha1_to_hex(lock->old_sha1), sha1_to_hex(old_sha1));
+			oid_to_hex(&lock->old_oid), sha1_to_hex(old_sha1));
 		unlock_ref(lock);
 		errno = EBUSY;
 		return NULL;
@@ -2254,7 +2254,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	}
 
 	refname = resolve_ref_unsafe(refname, resolve_flags,
-				     lock->old_sha1, &type);
+				     lock->old_oid.hash, &type);
 	if (!refname && errno == EISDIR) {
 		/* we are trying to lock foo but we used to
 		 * have foo/bar which now does not exist;
@@ -2268,7 +2268,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			goto error_return;
 		}
 		refname = resolve_ref_unsafe(orig_refname, resolve_flags,
-					     lock->old_sha1, &type);
+					     lock->old_oid.hash, &type);
 	}
 	if (type_p)
 	    *type_p = type;
@@ -2278,7 +2278,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			orig_refname, strerror(errno));
 		goto error_return;
 	}
-	missing = is_null_sha1(lock->old_sha1);
+	missing = is_null_oid(&lock->old_oid);
 	/* When the ref did not exist and we are creating it,
 	 * make sure there is no existing ref that is packed
 	 * whose name begins with our refname, nor a ref whose
@@ -2866,7 +2866,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 	lock->force_write = 1;
-	hashcpy(lock->old_sha1, orig_sha1);
+	hashcpy(lock->old_oid.hash, orig_sha1);
 	if (write_ref_sha1(lock, orig_sha1, logmsg)) {
 		error("unable to write current sha1 into %s", newrefname);
 		goto rollback;
@@ -3069,7 +3069,7 @@ static int write_ref_sha1(struct ref_lock *lock,
 		errno = EINVAL;
 		return -1;
 	}
-	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
+	if (!lock->force_write && !hashcmp(lock->old_oid.hash, sha1)) {
 		unlock_ref(lock);
 		return 0;
 	}
@@ -3098,9 +3098,9 @@ static int write_ref_sha1(struct ref_lock *lock,
 		return -1;
 	}
 	clear_loose_ref_cache(&ref_cache);
-	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
+	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
-	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
+	     log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg) < 0)) {
 		unlock_ref(lock);
 		return -1;
 	}
@@ -3124,7 +3124,7 @@ static int write_ref_sha1(struct ref_lock *lock,
 					      head_sha1, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name))
-			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
+			log_ref_write("HEAD", lock->old_oid.hash, sha1, logmsg);
 	}
 	if (commit_ref(lock)) {
 		error("Couldn't set %s", lock->ref_name);
diff --git a/refs.h b/refs.h
index b893f4a..538391c 100644
--- a/refs.h
+++ b/refs.h
@@ -7,7 +7,7 @@ struct ref_lock {
 	char *ref_name;
 	char *orig_ref_name;
 	struct lock_file *lk;
-	unsigned char old_sha1[20];
+	struct object_id old_oid;
 	int lock_fd;
 	int force_write;
 };
-- 
2.2.1.209.g41e5f3a
