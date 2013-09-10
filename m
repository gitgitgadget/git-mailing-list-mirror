From: Brad King <brad.king@kitware.com>
Subject: [PATCH v6 3/8] refs: factor update_ref steps into helpers
Date: Mon,  9 Sep 2013 20:57:41 -0400
Message-ID: <6021464d478d95d0a5763e4421762efae30d67b7.1378773895.git.brad.king@kitware.com>
References: <cover.1378732710.git.brad.king@kitware.com> <cover.1378773895.git.brad.king@kitware.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 10 03:00:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJCJM-0007JJ-17
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 03:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482Ab3IJBAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 21:00:04 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:41685 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756456Ab3IJBAB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 21:00:01 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 917D09FB90; Mon,  9 Sep 2013 20:57:46 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <cover.1378773895.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234409>

Factor the lock and write steps and error handling into helper functions
update_ref_lock and update_ref_write to allow later use elsewhere.
Expose lock_any_ref_for_update's type_p to update_ref_lock callers.

While at it, drop "static" from the local "lock" variable as it is not
necessary to keep across invocations.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 refs.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 5832a8f..f7d3c09 100644
--- a/refs.c
+++ b/refs.c
@@ -3170,12 +3170,13 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
-int update_ref(const char *action, const char *refname,
-		const unsigned char *sha1, const unsigned char *oldval,
-		int flags, enum action_on_err onerr)
+static struct ref_lock *update_ref_lock(const char *refname,
+					const unsigned char *oldval,
+					int flags, int *type_p,
+					enum action_on_err onerr)
 {
-	static struct ref_lock *lock;
-	lock = lock_any_ref_for_update(refname, oldval, flags, NULL);
+	struct ref_lock *lock;
+	lock = lock_any_ref_for_update(refname, oldval, flags, type_p);
 	if (!lock) {
 		const char *str = "Cannot lock the ref '%s'.";
 		switch (onerr) {
@@ -3183,8 +3184,14 @@ int update_ref(const char *action, const char *refname,
 		case DIE_ON_ERR: die(str, refname); break;
 		case QUIET_ON_ERR: break;
 		}
-		return 1;
 	}
+	return lock;
+}
+
+static int update_ref_write(const char *action, const char *refname,
+			    const unsigned char *sha1, struct ref_lock *lock,
+			    enum action_on_err onerr)
+{
 	if (write_ref_sha1(lock, sha1, action) < 0) {
 		const char *str = "Cannot update the ref '%s'.";
 		switch (onerr) {
@@ -3197,6 +3204,17 @@ int update_ref(const char *action, const char *refname,
 	return 0;
 }
 
+int update_ref(const char *action, const char *refname,
+	       const unsigned char *sha1, const unsigned char *oldval,
+	       int flags, enum action_on_err onerr)
+{
+	struct ref_lock *lock;
+	lock = update_ref_lock(refname, oldval, flags, 0, onerr);
+	if (!lock)
+		return 1;
+	return update_ref_write(action, refname, sha1, lock, onerr);
+}
+
 /*
  * generate a format suitable for scanf from a ref_rev_parse_rules
  * rule, that is replace the "%.*s" spec with a "%s" spec
-- 
1.8.4.rc3
