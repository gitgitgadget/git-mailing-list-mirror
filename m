From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/25] refs.c: pass a list of names to skip to
 is_refname_available
Date: Tue, 14 Oct 2014 17:50:09 -0700
Message-ID: <20141015005009.GN32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:50:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCnD-0001iF-UD
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755787AbaJOAuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:50:14 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:51588 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517AbaJOAuM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:50:12 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so219793pad.36
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=akwzU9o5o9onzS5UFLtepum89XNfhgDOLvFY0LL2/hc=;
        b=tBfjqiGWlEnFO/lzbEd73tzgmTJtVO+l7BYrJ1awxuAKwZK+exMLtANHPZU7CE1gNf
         SsccxSE6rvMHQGmsz2WRl8tnb6ylSInwevgSiU7OLTfqP5Qro2Zc7MC8NaT/zXPYdwdu
         H+pAqNFBJc0QkOIe0YHdkHfsaUAYMlaEeu8WTKobCHPTuhsnXnOF5ZkpIeuNm64Aps/d
         GWwa4ka5aR1WOJlZCy2xiyNDbFoog9em9uiiJdpqN4QQUFVokwa0XXMjn4SBtUdWw/VM
         hpqQza3VlH8gkS4KSWcZdVccn3nuWz+h6UvhS5FsonSI4D6dq+5DlVy5JeprQMpmA4T5
         drAQ==
X-Received: by 10.70.91.176 with SMTP id cf16mr8825129pdb.111.1413334212507;
        Tue, 14 Oct 2014 17:50:12 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id uj7sm15510635pac.4.2014.10.14.17.50.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:50:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 refs.c | 50 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index b591b9c..a007cf3 100644
--- a/refs.c
+++ b/refs.c
@@ -787,13 +787,13 @@ static void prime_ref_dir(struct ref_dir *dir)
 	}
 }
 
-static int entry_matches(struct ref_entry *entry, const char *refname)
+static int entry_matches(struct ref_entry *entry, const struct string_list *list)
 {
-	return refname && !strcmp(entry->name, refname);
+	return list && string_list_has_string(list, entry->name);
 }
 
 struct nonmatching_ref_data {
-	const char *skip;
+	const struct string_list *skip;
 	struct ref_entry *found;
 };
 
@@ -817,16 +817,19 @@ static void report_refname_conflict(struct ref_entry *entry,
 /*
  * Return true iff a reference named refname could be created without
  * conflicting with the name of an existing reference in dir.  If
- * oldrefname is non-NULL, ignore potential conflicts with oldrefname
- * (e.g., because oldrefname is scheduled for deletion in the same
+ * skip is non-NULL, ignore potential conflicts with refs in skip
+ * (e.g., because they are scheduled for deletion in the same
  * operation).
  *
  * Two reference names conflict if one of them exactly matches the
  * leading components of the other; e.g., "foo/bar" conflicts with
  * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
  * "foo/barbados".
+ *
+ * skip must be sorted.
  */
-static int is_refname_available(const char *refname, const char *oldrefname,
+static int is_refname_available(const char *refname,
+				const struct string_list *skip,
 				struct ref_dir *dir)
 {
 	const char *slash;
@@ -840,12 +843,12 @@ static int is_refname_available(const char *refname, const char *oldrefname,
 		 * looking for a conflict with a leaf entry.
 		 *
 		 * If we find one, we still must make sure it is
-		 * not "oldrefname".
+		 * not in "skip".
 		 */
 		pos = search_ref_dir(dir, refname, slash - refname);
 		if (pos >= 0) {
 			struct ref_entry *entry = dir->entries[pos];
-			if (entry_matches(entry, oldrefname))
+			if (entry_matches(entry, skip))
 				return 1;
 			report_refname_conflict(entry, refname);
 			return 0;
@@ -878,13 +881,13 @@ static int is_refname_available(const char *refname, const char *oldrefname,
 		/*
 		 * We found a directory named "refname". It is a
 		 * problem iff it contains any ref that is not
-		 * "oldrefname".
+		 * in "skip".
 		 */
 		struct ref_entry *entry = dir->entries[pos];
 		struct ref_dir *dir = get_ref_dir(entry);
 		struct nonmatching_ref_data data;
 
-		data.skip = oldrefname;
+		data.skip = skip;
 		sort_ref_dir(dir);
 		if (!do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data))
 			return 1;
@@ -2139,6 +2142,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
  */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
+					    const struct string_list *skip,
 					    int flags, int *type_p)
 {
 	char *ref_file;
@@ -2188,7 +2192,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, NULL, get_packed_refs(&ref_cache))) {
+	     !is_refname_available(refname, skip, get_packed_refs(&ref_cache))) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2246,7 +2250,7 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
+	return lock_ref_sha1_basic(refname, old_sha1, NULL, flags, type_p);
 }
 
 /*
@@ -2690,6 +2694,18 @@ static int rename_tmp_log(const char *newrefname)
 	return 0;
 }
 
+static int rename_ref_available(const char *oldname, const char *newname)
+{
+	struct string_list skip = STRING_LIST_INIT_NODUP;
+	int ret;
+
+	string_list_insert(&skip, oldname);
+	ret = is_refname_available(newname, &skip, get_packed_refs(&ref_cache))
+	    && is_refname_available(newname, &skip, get_loose_refs(&ref_cache));
+	string_list_clear(&skip, 0);
+	return ret;
+}
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
@@ -2709,10 +2725,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!symref)
 		return error("refname %s not found", oldrefname);
 
-	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(&ref_cache)))
-		return 1;
-
-	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(&ref_cache)))
+	if (!rename_ref_available(oldrefname, newrefname))
 		return 1;
 
 	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
@@ -2742,7 +2755,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, 0, NULL);
 	if (!lock) {
 		error("unable to lock %s for update", newrefname);
 		goto rollback;
@@ -2757,7 +2770,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, 0, NULL);
 	if (!lock) {
 		error("unable to lock %s for rollback", oldrefname);
 		goto rollbacklog;
@@ -3636,6 +3649,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 						   (update->have_old ?
 						    update->old_sha1 :
 						    NULL),
+						   NULL,
 						   update->flags,
 						   &update->type);
 		if (!update->lock) {
-- 
2.1.0.rc2.206.gedb03e5
