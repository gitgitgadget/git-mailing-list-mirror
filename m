From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 38/41] refs.c: pass a skip list to name_conflict_fn
Date: Tue,  3 Jun 2014 14:37:56 -0700
Message-ID: <1401831479-3388-39-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:41:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwSE-0007H4-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934192AbaFCVjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:39:11 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:53803 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934329AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so1408511veb.5
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fQ5c7ybUS/qhzWOEdj9pBhuonRhIuEVHZ216BAKn/Zs=;
        b=ljFBALfwd1sCtGnYoLtztkfVSo9qEFwDNFHyAwoWe3mFssLEJqfbUil2uXFrCiS9Us
         xUU4d70eiEQkKQzZ1riunpvn0C/ijCOhjtFb3AAgOObhX2sYp3dC5VlZZyzL1pGouoXt
         QKMyr/K/uaGQ0Q1qYDryX6nbUoaAhekjWDu/MMJoh5eD7BUhFgrsg3lqryogHnTN4NzU
         LsGMoEkxpUvgoqt6DmA3QkfviKLYSdmE99MrHyc7jmL/TJ3ju7tONiPBYxe8KxRF+Dd6
         hJNTREkZoSknmRxSPXisAFeZdnvlGdtUvi4Fgvp+wmHckpti0TcjZtU5d4wOkhgpue/h
         5O9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fQ5c7ybUS/qhzWOEdj9pBhuonRhIuEVHZ216BAKn/Zs=;
        b=dL0hN66Vu+RRHZwwgnZxJWXGJUVDv2Uz4WWQHBiL6F0REYs25KWLVeE97rDH7+TIic
         U6LHESltVKozUq8UwCIL3BnoFvCEX6iF05f1UmIaPmgoF6hakE5wcGGnR4eXBbGOQHJ4
         pesR6Mzwznysz94EfQc0ljBZwFBqzIBW5XKeBE1z7lk168AC+p/i+jrDSuCRU+juVTKe
         Ezg6J7Dz3hm/alPTIHoISHv//esr72wpAb/0b5xDO0prUSAPxt2Mssoz2jpktRgx2q0F
         IuLvJ8PCDI3oD4kN6SdNumf+GjFZlxfPA6CYoqhWsRV0xm3u/uOpBIqrE3uZ4PpOmcyW
         2Oog==
X-Gm-Message-State: ALoCoQn3xkrQXSUFsRLbB1YREC8OmND3fzr/s/q2Nidn3XEVaZoZnwc9UtpMXwPOac6MYdiHVDs9
X-Received: by 10.236.124.100 with SMTP id w64mr7694441yhh.57.1401831488680;
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si29586yhk.4.2014.06.03.14.38.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 790FB31C425;
	Tue,  3 Jun 2014 14:38:08 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5B334E07FA; Tue,  3 Jun 2014 14:38:08 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250666>

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
 refs.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index f13c0be..f2ca96a 100644
--- a/refs.c
+++ b/refs.c
@@ -791,15 +791,18 @@ static int names_conflict(const char *refname1, const char *refname2)
 
 struct name_conflict_cb {
 	const char *refname;
-	const char *oldrefname;
 	const char *conflicting_refname;
+	const char **skip;
+	int skipnum;
 };
 
 static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
 {
 	struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
-	if (data->oldrefname && !strcmp(data->oldrefname, entry->name))
-		return 0;
+	int i;
+	for (i = 0; i < data->skipnum; i++)
+		if (!strcmp(entry->name, data->skip[i]))
+			return 0;
 	if (names_conflict(data->refname, entry->name)) {
 		data->conflicting_refname = entry->name;
 		return 1;
@@ -812,15 +815,18 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
  * conflicting with the name of an existing reference in dir.  If
  * oldrefname is non-NULL, ignore potential conflicts with oldrefname
  * (e.g., because oldrefname is scheduled for deletion in the same
- * operation).
+ * operation). skip contains a list of refs we want to skip checking for
+ * conflicts with.
  */
-static int is_refname_available(const char *refname, const char *oldrefname,
-				struct ref_dir *dir)
+static int is_refname_available(const char *refname,
+				struct ref_dir *dir,
+				const char **skip, int skipnum)
 {
 	struct name_conflict_cb data;
 	data.refname = refname;
-	data.oldrefname = oldrefname;
 	data.conflicting_refname = NULL;
+	data.skip = skip;
+	data.skipnum = skipnum;
 
 	sort_ref_dir(dir);
 	if (do_for_each_entry_in_dir(dir, 0, name_conflict_fn, &data)) {
@@ -2047,7 +2053,8 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
-					    int flags, int *type_p)
+					    int flags, int *type_p,
+					    const char **skip, int skipnum)
 {
 	char *ref_file;
 	const char *orig_refname = refname;
@@ -2096,7 +2103,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, NULL, get_packed_refs(&ref_cache))) {
+	     !is_refname_available(refname, get_packed_refs(&ref_cache),
+				   skip, skipnum)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2154,7 +2162,7 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
+	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p, NULL, 0);
 }
 
 /*
@@ -2645,10 +2653,12 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!symref)
 		return error("refname %s not found", oldrefname);
 
-	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(&ref_cache)))
+	if (!is_refname_available(newrefname, get_packed_refs(&ref_cache),
+				  &oldrefname, 1))
 		return 1;
 
-	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(&ref_cache)))
+	if (!is_refname_available(newrefname, get_loose_refs(&ref_cache),
+				  &oldrefname, 1))
 		return 1;
 
 	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
@@ -2681,7 +2691,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL, NULL, 0);
 	if (!lock) {
 		error("unable to lock %s for update", newrefname);
 		goto rollback;
@@ -2696,7 +2706,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL, NULL, 0);
 	if (!lock) {
 		error("unable to lock %s for rollback", oldrefname);
 		goto rollbacklog;
@@ -3572,7 +3582,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.567.g64a7adf
