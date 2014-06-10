From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 45/48] refs.c: pass a skip list to name_conflict_fn
Date: Tue, 10 Jun 2014 15:29:33 -0700
Message-ID: <1402439376-25839-46-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:38:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUZh-0005yY-Qe
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbaFJWay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:30:54 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:38911 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so138340pde.4
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gHJ53iYk+At0KvVxNnGkxwCm7XsWwjXjn10qsUAmYAc=;
        b=b9geAZSlGfWonvePOlLQgXn0MyhUJ6y8mUN9Ige5/lAHauCMejYerle036uNkGTDbI
         aTMBTxQKufslH++HImwp1ZSNHAcHncFKFGu8dQ7apgFnPogvJMRhzJXYQXipuorfoBxg
         elsO4LZ/6XFefdGRBKdSKynuFHt3oFzyTy2mnc+rBFToBpTzqeDlsBBHzlCdHQPde4ik
         ytgJFtieuStsJAmTgPE/HZuLe4Yql/bfIPlwzqtnZPe/i81ZUH5s2qnLvylg3zD9mhUl
         LJRFESjvDyWIitS0aoXUshABIWW3NUoupb5LdNA5vlngjSjG1upig/J1xVPmMj9Ry0lp
         Tm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gHJ53iYk+At0KvVxNnGkxwCm7XsWwjXjn10qsUAmYAc=;
        b=LYMNbSXI3ZlBJDXzuHuEjWDDczI/rX6df2S8f9icN37A5O0uFOKgEC+pE0PdqNrYZ8
         rwQZ487S+Er7m/zv7Q2Vmpi0sKEFFE6Yhjv4mrRT/8r9rgcwLWEATJClnkAdtp40uVmd
         HS0xXt2hi3PopOlYtqch/5TnSgB90XVAFm/O22tBgfacjhsO9wc7M4LkihQbofoP+deS
         IKWa+kruBw0H4/q8CErkHcJfXd/fPRpCN1BJ6JMNDrSRqSjoKe/filShMqCnARfxRDe9
         X5TVHYoXwe3VIuWHZ5fLeTuxqZ7atMoBkbHY9WI0f7Wm9VdvDQb+oreCXETwTgirqXkh
         ZeHw==
X-Gm-Message-State: ALoCoQkFR4ke89/UxcqCxxuhQFHgO5rPbDTuyw2/mfCrHM5hmpVS2MIDvx1K94rbOgbi4kDXRrrR
X-Received: by 10.68.202.99 with SMTP id kh3mr6162938pbc.8.1402439382230;
        Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si1396162yhb.3.2014.06.10.15.29.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 036C55A47F3;
	Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D45B7E06A0; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251285>

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
index f482b03..5e1c0fd 100644
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
@@ -2051,7 +2057,8 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 /* This function should make sure errno is meaningful on error */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
-					    int flags, int *type_p)
+					    int flags, int *type_p,
+					    const char **skip, int skipnum)
 {
 	char *ref_file;
 	const char *orig_refname = refname;
@@ -2100,7 +2107,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, NULL, get_packed_refs(&ref_cache))) {
+	     !is_refname_available(refname, get_packed_refs(&ref_cache),
+				   skip, skipnum)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2158,7 +2166,7 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
+	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p, NULL, 0);
 }
 
 /*
@@ -2650,10 +2658,12 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
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
@@ -2683,7 +2693,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL, NULL, 0);
 	if (!lock) {
 		error("unable to lock %s for update", newrefname);
 		goto rollback;
@@ -2698,7 +2708,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL, NULL, 0);
 	if (!lock) {
 		error("unable to lock %s for rollback", oldrefname);
 		goto rollbacklog;
@@ -3576,7 +3586,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.574.g30c2c5e
