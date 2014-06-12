From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 45/48] refs.c: pass a skip list to name_conflict_fn
Date: Thu, 12 Jun 2014 10:21:36 -0700
Message-ID: <1402593699-13983-46-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:22:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8hl-0007Gc-Uz
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933117AbaFLRWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:22:20 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:41780 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756291AbaFLRVq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:46 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so185904pbb.5
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tph9ipAOjdTZK/8aDBn18qWjFX5nylVo80zKChATM38=;
        b=FMI5RFVMs3RuTCYFjzJl4EnmaqkVZW0AZip0lYPrR6s7/rmu0Zd7W51457Qj6FQ8EM
         I7ahMfLRaMZArMim2cbq0d35AidJ8sNHvRWjZ77ZXxojJs//710451ZE6V+KAUgHC0iv
         n4PgcRiKcpPvXoGGbZ13hEsBsV7BNnyfJ+bUaouaTLYzf87bn2Yvpa29kQDghq/dEXfh
         36Rfi0WsPCuPUlTAVnQDc9OJZcuSCuaUjgaXm8iQx7L/67/gFggKvDo7JY5n+NG83zZP
         N9XdnbvVpvm/233H++pOm1IFu1sXNOEA9/TToibKzo7+zTX74muhGoHaLMP19VfaG83t
         BXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tph9ipAOjdTZK/8aDBn18qWjFX5nylVo80zKChATM38=;
        b=ICSUZX++AktXoZnT3eTchQozM10mJWxVekP+A7Zc2pjaDEUp2Dx56zz7/+uyjUqX/X
         h2BdBJuDZLh7Teb3d82M8xKHViuxVnPgVKrW3zoi7R19qv946/rjwAuGakg31fr45jp6
         XcjhRlosjrPIZoOH4+yj5ykhBNJ/y2NIj90ojjFbd+b515ayM/cmC+WmF11Tazv82G7L
         dtQwbJyrG0KrdsQI74+iU1xIB1cDFnGKXuBKDdY4jeuwmwUEAeUN7ymoiHiai0xbhfGL
         U4ih4bbKdhIB+xhG9hb9o5h0Is8XjNnXETOr46Q4zwC9dDP80M4R3/vDZLCYVumhA6Y3
         S7LA==
X-Gm-Message-State: ALoCoQne11GcUiYFJry1iVB0b9K2WcBjQ2sco69n+0jmRlZAq6+xBMvVuX1ar30glRQNBrlBZkgm
X-Received: by 10.66.234.194 with SMTP id ug2mr565479pac.37.1402593705144;
        Thu, 12 Jun 2014 10:21:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si113021yhb.3.2014.06.12.10.21.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id E07B231C65C;
	Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C32C8E0A0A; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251426>

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
index 6d367db..b1224f3 100644
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
2.0.0.599.g83ced0e
