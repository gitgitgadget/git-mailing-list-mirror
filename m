From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 40/42] refs.c: pass a skip list to name_conflict_fn
Date: Thu,  1 May 2014 13:37:40 -0700
Message-ID: <1398976662-6962-41-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:38:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfxkM-00011h-87
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbaEAUiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:19 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:37433 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbaEAUiB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:38:01 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so662114pab.5
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g/A1+RywqPskOIomfjGs0FGxn1rwC1b803aAnBjt7t4=;
        b=X/nfyvfCm1uvDmSjCBX+NzhgbJGQAXMlbFIyf5oBcskC2u4OGIwsGnweeHsaaKwYxW
         /jYOpr7FraH0G5R8IwHshS/NzM7oBWPYZakNh/t/Q68J8WTJ+Y3Tnz9bGrQpmo4OZSxH
         W80x0s7dv4fhX+DjB1hH/t8f6BQMw4ElUmpQ8xqHxE4toOoCd3mfGQBKKUNtAdf29Rnq
         ioKyyiUD5SmuexxVS/xqRtJDMdCn9SzHhDpBywGKWCYBP6ElF4MUeBB3hpNOqeVHsUsC
         CboaEvQZbXOXpucKg+cId+ikKB21ZBv8yhPOL5xu4MYVX4R86Y/D7VTK3d8IABKUjY7D
         yzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g/A1+RywqPskOIomfjGs0FGxn1rwC1b803aAnBjt7t4=;
        b=lJqwZKWb7fORBwsrk8be4GKpqc5ONDaGVBLX2Y3TtjZFt7udDXIFaP44jPU3OBoDD0
         WSwdBA3pj2/7x82KYixBVvkt4RxXeGLhFHhzoRGNED2yORAR3YPNIoJZhQ77S78FRcUw
         s9XI+zZn4B6P1wteiDfabtkdwhkfus/vtgZ3DpfBjXXtp/iThEmHt1H+TJBFvmme0Ixq
         EdAb400t9IqP1nawV0MjOvxcmPVJGQviJNk1oOa4p7WR9aGuDCR/GLahiu7GjujsafLJ
         09Y4rIYnyo/rU9KwnfT2EHgwZ08RUTGOYmYgL/pneCdcKHVgnH4guxHf8x2lLe8zlu7i
         T/Ww==
X-Gm-Message-State: ALoCoQk7PIaWY7zJesZ1nhjupT6dtB4eoZzQ84d51RJdKsFr8BQUPYLrkeuwD4IoMWQuTwZE4ir/
X-Received: by 10.66.156.66 with SMTP id wc2mr7588188pab.23.1398976681066;
        Thu, 01 May 2014 13:38:01 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l7si2126417yho.1.2014.05.01.13.38.01
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:38:01 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id CF06231C1CC;
	Thu,  1 May 2014 13:38:00 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 94069E097F; Thu,  1 May 2014 13:38:00 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247841>

Allow passing a list of refs to ckip checking to name_conflict_fn.
There are some conditions where we want to allow a temporary conflict and skip
checking those refs. For example if we have a transaction that
1, guarantees that m is a packed refs and there is no loose ref for m
2, the transaction will delete m from the packed ref
3, the transaction will create conflicting m/m

For this case we want to be able to lock anc create m/m since we know that the
conflict is only transient. I.e. the conflict will be automatically resolved
by the transaction when it deletes m.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index b525076..eb75927 100644
--- a/refs.c
+++ b/refs.c
@@ -789,11 +789,19 @@ struct name_conflict_cb {
 	const char *refname;
 	const char *oldrefname;
 	const char *conflicting_refname;
+	const char **skip;
+	int skipnum;
 };
 
 static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
 {
 	struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
+	int i;
+	for(i = 0; i < data->skipnum; i++) {
+		if (!strcmp(entry->name, data->skip[i])) {
+			return 0;
+		}
+	}
 	if (data->oldrefname && !strcmp(data->oldrefname, entry->name))
 		return 0;
 	if (names_conflict(data->refname, entry->name)) {
@@ -808,15 +816,21 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
  * conflicting with the name of an existing reference in dir.  If
  * oldrefname is non-NULL, ignore potential conflicts with oldrefname
  * (e.g., because oldrefname is scheduled for deletion in the same
- * operation).
+ * operation). skip contains a list of refs we want to skip checking for
+ * conflicts with. Refs may be skipped due to us knowing that it will
+ * be deleted later during a transaction that deletes one reference and then
+ * creates a new conflicting reference. For example a rename from m to m/m.
  */
 static int is_refname_available(const char *refname, const char *oldrefname,
-				struct ref_dir *dir)
+				struct ref_dir *dir,
+				const char **skip, int skipnum)
 {
 	struct name_conflict_cb data;
 	data.refname = refname;
 	data.oldrefname = oldrefname;
 	data.conflicting_refname = NULL;
+	data.skip = skip;
+	data.skipnum = skipnum;
 
 	sort_ref_dir(dir);
 	if (do_for_each_entry_in_dir(dir, 0, name_conflict_fn, &data)) {
@@ -2032,7 +2046,8 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
-					    int flags, int *type_p)
+					    int flags, int *type_p,
+					    const char **skip, int skipnum)
 {
 	char *ref_file;
 	const char *orig_refname = refname;
@@ -2079,7 +2094,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, NULL, get_packed_refs(&ref_cache))) {
+	     !is_refname_available(refname, NULL,
+				   get_packed_refs(&ref_cache),
+				   skip, skipnum)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2137,7 +2154,7 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
+	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p, NULL, 0);
 }
 
 /*
@@ -2576,6 +2593,9 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	const char *symref = NULL;
 
+	if (!strcmp(oldrefname, newrefname))
+		return 0;
+
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
@@ -2586,10 +2606,12 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!symref)
 		return error("refname %s not found", oldrefname);
 
-	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(&ref_cache)))
+	if (!is_refname_available(newrefname, oldrefname,
+				  get_packed_refs(&ref_cache), NULL, 0))
 		return 1;
 
-	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(&ref_cache)))
+	if (!is_refname_available(newrefname, oldrefname,
+				  get_loose_refs(&ref_cache), NULL, 0))
 		return 1;
 
 	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
@@ -2622,7 +2644,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL, NULL, 0);
 	if (!lock) {
 		error("unable to lock %s for update", newrefname);
 		goto rollback;
@@ -2637,7 +2659,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL, NULL, 0);
 	if (!lock) {
 		error("unable to lock %s for rollback", oldrefname);
 		goto rollbacklog;
@@ -3483,7 +3505,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 						    update->old_sha1 :
 						    NULL),
 						   update->flags,
-						   &update->type);
+						   &update->type,
+						   delnames, delnum);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err ,"Cannot lock the ref '%s'.",
-- 
2.0.0.rc1.351.g4d2c8e4
