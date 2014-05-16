From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 42/44] refs.c: pass a skip list to name_conflict_fn
Date: Fri, 16 May 2014 10:37:30 -0700
Message-ID: <1400261852-31303-43-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:38:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM5f-00008b-Vo
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757587AbaEPRiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:38:09 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:38885 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758097AbaEPRhk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:40 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so885704vcb.4
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LsQxmza2z6t3q+yqM39EX+WVQug8gEbUacZ+WmNHclo=;
        b=b2okPxlQ2M7NUBwddwypCxC1VXAPULqRIqyzgBekErJ4X6ZZ2QN8ytTgFqNEGAMaDE
         JZQkZCVwurROkLiysHxghdQ5KqlIiTCMQ3YJglKZ5+uiUgScvKpuhH+TP/nf+b8w2/u9
         WtTGsm3G3UqEr5OMbNIh1C5IZ1T4u0gFikA4rtOEimcf50377cxEVPMA2uHxnMzIY/so
         NYWSDVxdKT5mKIIEkW7xsbaxIy7Lu3U1zHErOsdF0akh7w4uZwYa8ugQRNIYgolyEfoR
         6XTdoItEWoz8717NQTRgbMgBaEYAcMNYnMCM0cn3/KGChXYw2NKic3vD8rfAo+kh85Bf
         Y6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LsQxmza2z6t3q+yqM39EX+WVQug8gEbUacZ+WmNHclo=;
        b=Ba21ElntRDwnyCCiCf6DZhJ0WGwis8UFHdyvbU9toqspW+r+gvJUFqeOT3avpXpYM2
         04NBsFscg1/+hPmg2A8dgQaQCjWBJ1N+zitFlDEfv79f5gFVW/SgPg+05SeVO07HhWE2
         fsk7tVM+LEhpPexd+p7mFrzMIemMmfafRe2ZgLuy0c9VMfRfveCPrBaALkvi6dSoTqSq
         CPnHBcIq2SE7VlfPvLAGk8pjKjyKAEIs1rIyYN1KFCFjFWYujTy1suNLgk1X9KAYNwou
         AmIETnAKEF+T9Lhj+FoS2U3Kb6Ilves8aXu17l+9N/nJTupUpgXpMxmJRP/TRtOlxabR
         oktw==
X-Gm-Message-State: ALoCoQkO208dkJnENpasRJRNBSLEI3HMYIJv19QA8GgKePwwp7J/FNAg+eRpTdvt+ngTGrYckJ13
X-Received: by 10.236.128.195 with SMTP id f43mr7566570yhi.45.1400261858740;
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h18si443265yhj.0.2014.05.16.10.37.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 86D4D31C273;
	Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6619DE0C3A; Fri, 16 May 2014 10:37:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249368>

Allow passing a list of refs to skip checking to name_conflict_fn.
There are some conditions where we want to allow a temporary conflict and skip
checking those refs. For example if we have a transaction that
1, guarantees that m is a packed refs and there is no loose ref for m
2, the transaction will delete m from the packed ref
3, the transaction will create conflicting m/m

For this case we want to be able to lock and create m/m since we know that the
conflict is only transient. I.e. the conflict will be automatically resolved
by the transaction when it deletes m.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index c5d41bb..3967333 100644
--- a/refs.c
+++ b/refs.c
@@ -798,11 +798,19 @@ struct name_conflict_cb {
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
@@ -817,15 +825,21 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
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
@@ -2037,7 +2051,8 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
-					    int flags, int *type_p)
+					    int flags, int *type_p,
+					    const char **skip, int skipnum)
 {
 	char *ref_file;
 	const char *orig_refname = refname;
@@ -2084,7 +2099,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -2142,7 +2159,7 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
+	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p, NULL, 0);
 }
 
 /*
@@ -2620,6 +2637,9 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	const char *symref = NULL;
 
+	if (!strcmp(oldrefname, newrefname))
+		return 0;
+
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
@@ -2630,10 +2650,12 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
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
@@ -2666,7 +2688,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL, NULL, 0);
 	if (!lock) {
 		error("unable to lock %s for update", newrefname);
 		goto rollback;
@@ -2681,7 +2703,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL, NULL, 0);
 	if (!lock) {
 		error("unable to lock %s for rollback", oldrefname);
 		goto rollbacklog;
@@ -3536,7 +3558,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 						    update->old_sha1 :
 						    NULL),
 						   update->flags,
-						   &update->type);
+						   &update->type,
+						   delnames, delnum);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
-- 
2.0.0.rc3.510.g20c254b
