From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/19] refs.c: pass a skip list to name_conflict_fn
Date: Wed, 10 Sep 2014 20:08:00 -0700
Message-ID: <20140911030800.GM18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 05:08:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRujy-0001gQ-GG
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbaIKDIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:08:06 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:45757 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbaIKDIF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:08:05 -0400
Received: by mail-pd0-f174.google.com with SMTP id v10so12343985pde.5
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FTRyBehC+6SfoPFwwbmBG/e+GsjLB4T03Sjp9E4ru4E=;
        b=KiVMijQgZct81vAcvnaJ/r8tkdkq1r2MnXldDIrLmZwtvkJLkXz+f8qXxbyo/1f1xm
         EZdkNg+KYQJg/ov6q6GTiwRD92+LnJ6tBOIV5pSiM98U3KWorQcG425qnO/0h81h/26U
         I+rAzHmySLD8f9Iwab0KnVq+buT4QGNF/nlCkstuZmYCJ5NllR1ZK7GHTGdV9ZXvyBUU
         wb+34uYvvyATsxMLe0GAD4CQJB9rllvQfFlmqlZtptzzMo3otQYKZQ6sYYgIt8GDJysC
         MQnbEW82ZIBttL3MiX+4de9q0zii3WULttZkNv+2c1E+p21ifZRLLNjDyu7RbhRnaaJK
         MDmQ==
X-Received: by 10.67.23.103 with SMTP id hz7mr1859068pad.118.1410404884111;
        Wed, 10 Sep 2014 20:08:04 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id z4sm15930376pda.23.2014.09.10.20.08.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:08:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256821>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 1 May 2014 11:16:07 -0700

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
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index f124c2b..b63ab2f 100644
--- a/refs.c
+++ b/refs.c
@@ -801,14 +801,16 @@ static int names_conflict(const char *refname1, const char *refname2)
 
 struct name_conflict_cb {
 	const char *refname;
-	const char *oldrefname;
 	const char *conflicting_refname;
+	struct string_list *skiplist;
 };
 
 static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
 {
 	struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
-	if (data->oldrefname && !strcmp(data->oldrefname, entry->name))
+
+	if (data->skiplist &&
+	    string_list_has_string(data->skiplist, entry->name))
 		return 0;
 	if (names_conflict(data->refname, entry->name)) {
 		data->conflicting_refname = entry->name;
@@ -822,15 +824,17 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
  * conflicting with the name of an existing reference in dir.  If
  * oldrefname is non-NULL, ignore potential conflicts with oldrefname
  * (e.g., because oldrefname is scheduled for deletion in the same
- * operation).
+ * operation). skiplist contains a list of refs we want to skip checking for
+ * conflicts with. skiplist must be sorted.
  */
-static int is_refname_available(const char *refname, const char *oldrefname,
-				struct ref_dir *dir)
+static int is_refname_available(const char *refname,
+				struct ref_dir *dir,
+				struct string_list *skiplist)
 {
 	struct name_conflict_cb data;
 	data.refname = refname;
-	data.oldrefname = oldrefname;
 	data.conflicting_refname = NULL;
+	data.skiplist = skiplist;
 
 	sort_ref_dir(dir);
 	if (do_for_each_entry_in_dir(dir, 0, name_conflict_fn, &data)) {
@@ -2080,6 +2084,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
  */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
+					    struct string_list *skiplist,
 					    int flags, int *type_p)
 {
 	char *ref_file;
@@ -2129,7 +2134,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, NULL, get_packed_refs(&ref_cache))) {
+	     !is_refname_available(refname, get_packed_refs(&ref_cache),
+				   skiplist)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2187,7 +2193,7 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
+	return lock_ref_sha1_basic(refname, old_sha1, NULL, flags, type_p);
 }
 
 /*
@@ -2648,6 +2654,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	const char *symref = NULL;
+	struct string_list skiplist = STRING_LIST_INIT_NODUP;
 
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
@@ -2659,11 +2666,18 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!symref)
 		return error("refname %s not found", oldrefname);
 
-	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(&ref_cache)))
+	string_list_insert(&skiplist, oldrefname);
+	if (!is_refname_available(newrefname, get_packed_refs(&ref_cache),
+				  &skiplist)) {
+		string_list_clear(&skiplist, 0);
 		return 1;
-
-	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(&ref_cache)))
+	}
+	if (!is_refname_available(newrefname, get_loose_refs(&ref_cache),
+				  &skiplist)) {
+		string_list_clear(&skiplist, 0);
 		return 1;
+	}
+	string_list_clear(&skiplist, 0);
 
 	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
 		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
@@ -2692,7 +2706,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, 0, NULL);
 	if (!lock) {
 		error("unable to lock %s for update", newrefname);
 		goto rollback;
@@ -2707,7 +2721,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, 0, NULL);
 	if (!lock) {
 		error("unable to lock %s for rollback", oldrefname);
 		goto rollbacklog;
@@ -3582,6 +3596,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 						   (update->have_old ?
 						    update->old_sha1 :
 						    NULL),
+						   NULL,
 						   update->flags,
 						   &update->type);
 		if (!update->lock) {
-- 
2.1.0.rc2.206.gedb03e5
