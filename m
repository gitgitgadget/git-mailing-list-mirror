From: Brad King <brad.king@kitware.com>
Subject: [PATCH/RFC 3/7] refs: factor update_ref steps into helpers
Date: Thu, 29 Aug 2013 10:11:51 -0400
Message-ID: <85ddf42be97e92e33ca883bc23cafca818a3df85.1377784597.git.brad.king@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 16:22:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF377-0000p3-2f
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 16:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442Ab3H2OWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 10:22:16 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:48739 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754253Ab3H2OWP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 10:22:15 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 71D8E9FB8A; Thu, 29 Aug 2013 10:11:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1377784597.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233257>

Factor the lock and write steps and error handling into helper functions
update_ref_lock and update_ref_write to allow later use elsewhere.
Expose lock_any_ref_for_update's type_p to update_ref_lock callers.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 refs.c |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 3a7b597..2e755b4 100644
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
 	static struct ref_lock *lock;
-	lock = lock_any_ref_for_update(refname, oldval, flags, 0);
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
+	static struct ref_lock *lock;
+	lock = update_ref_lock(refname, oldval, flags, 0, onerr);
+	if (!lock)
+		return 1;
+	return update_ref_write(action, refname, sha1, lock, onerr);
+}
+
 struct ref *find_ref_by_name(const struct ref *list, const char *name)
 {
 	for ( ; list; list = list->next)
-- 
1.7.10.4
