From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/24] refs.c: pass a list of names to skip to
 is_refname_available
Date: Wed, 1 Oct 2014 19:03:32 -0700
Message-ID: <20141002020332.GB1175@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <20141002014817.GS1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 04:03:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZVk4-0007qX-Ce
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 04:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbaJBCDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 22:03:36 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:54608 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbaJBCDf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 22:03:35 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb1so1341297pad.25
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 19:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yGRbLlqCg9zy2aEInR6gRsy7FZ68gd7erTpb0ty7QwQ=;
        b=dTZwkK07cDHAWOmrTWhK+u9RY072JR33iLcnKNFQH7Wbxc3p4uDsSRlT89gsgGOQrn
         X6YwAVSlBlHpCyyFvoA/QZfWnKnVpSDhx/aJCxlQ2WBc9uKLKZ08GCdpMyr7U1quLYEo
         TtnWihyR5lQBlaSF8cvESElRKgo/znUDjZjhzoYhI9rdqpBYOcV+PD/cnmdLw9sa5K0x
         J18ELDDTB61RIIvToBDyd9iGW/CrsY7s8IhGfskXt1UWqrf9ZhqB8H57XVt7Pf/A3cay
         BknL3ARPRzCkJI0t7Fzcs0Czl3KagirMKL2vxs2gmssvFds8q4Bu85VT3UcHOCC5Lcy0
         57Tw==
X-Received: by 10.68.179.66 with SMTP id de2mr83172032pbc.31.1412215415072;
        Wed, 01 Oct 2014 19:03:35 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id tu10sm2158658pab.14.2014.10.01.19.03.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 19:03:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257780>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 1 May 2014 11:16:07 -0700

Change is_refname_available to take a list of strings to exclude when
checking for conflicts instead of just one single name. We can already
exclude a single name for the sake of renames. This generalizes that support.

ref_transaction_commit already tracks a set of refs that are being deleted
in an array.  This array is then used to exclude refs from being written to
the packed-refs file.  At some stage we will want to change this array to a
struct string_list and then we can pass it to is_refname_available via the
call to lock_ref_sha1_basic.  That will allow us to perform transactions
that perform multiple renames as long as there are no conflicts within the
starting or ending state.

For example, that would allow a single transaction that contains two
renames that are both individually conflicting:

   m -> n/n
   n -> m/m

No functional change intended yet.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Since v21:
- clarified commit message
- clarified comments

 refs.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index f124c2b..6820c93 100644
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
@@ -820,17 +822,18 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
 /*
  * Return true iff a reference named refname could be created without
  * conflicting with the name of an existing reference in dir.  If
- * oldrefname is non-NULL, ignore potential conflicts with oldrefname
- * (e.g., because oldrefname is scheduled for deletion in the same
- * operation).
+ * skiplist is non-NULL, ignore potential conflicts with names in
+ * skiplist (e.g., because those refs are scheduled for deletion in
+ * the same operation).  skiplist must be sorted.
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
@@ -2080,6 +2083,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
  */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
+					    struct string_list *skiplist,
 					    int flags, int *type_p)
 {
 	char *ref_file;
@@ -2129,7 +2133,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, NULL, get_packed_refs(&ref_cache))) {
+	     !is_refname_available(refname, get_packed_refs(&ref_cache),
+				   skiplist)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2187,7 +2192,7 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
+	return lock_ref_sha1_basic(refname, old_sha1, NULL, flags, type_p);
 }
 
 /*
@@ -2648,6 +2653,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	const char *symref = NULL;
+	struct string_list skiplist = STRING_LIST_INIT_NODUP;
 
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
@@ -2659,11 +2665,18 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
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
@@ -2692,7 +2705,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, 0, NULL);
 	if (!lock) {
 		error("unable to lock %s for update", newrefname);
 		goto rollback;
@@ -2707,7 +2720,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, 0, NULL);
 	if (!lock) {
 		error("unable to lock %s for rollback", oldrefname);
 		goto rollbacklog;
@@ -3582,6 +3595,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 						   (update->have_old ?
 						    update->old_sha1 :
 						    NULL),
+						   NULL,
 						   update->flags,
 						   &update->type);
 		if (!update->lock) {
-- 
2.1.0.rc2.206.gedb03e5
