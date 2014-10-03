From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v22.5 09/24] refs.c: pass a list of names to skip to
 is_refname_available
Date: Fri, 3 Oct 2014 14:39:00 -0700
Message-ID: <20141003213900.GT1175@google.com>
References: <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <20141002014817.GS1175@google.com>
 <20141002020332.GB1175@google.com>
 <xmqq61g2nuud.fsf@gitster.dls.corp.google.com>
 <20141003185128.GS1175@google.com>
 <xmqqoattkm87.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 23:39:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaAZD-0005qP-KR
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 23:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236AbaJCVjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 17:39:07 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:58102 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbaJCVjF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 17:39:05 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb1so2160373pad.11
        for <git@vger.kernel.org>; Fri, 03 Oct 2014 14:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2DTiDhD46R/TZOp1AVPU5uem+wAPYii5uAjyXTuY9Q0=;
        b=BPOlpAFvocEhwCLhBobDuPI1omGUFI35T1rMGUyuUcpHhw3GICEH+A+XtufaTD+OGY
         i9XzGjrWlOZkl+7kr4ndPqhJqF+wOM3WMNdh73XVt3w88eQJ4e80v0+fzmPHjWQR0qL9
         iqO3CXXlXcPVZkIcImrKwe+VYZxww4iDGtaMGSCX5gTW9dPcZqUnDEsGBoYTOjrCtVl4
         x6bVpMoiq2LsAv5zhE4h+VaFQ04tXaN3lCm8zn0aqLwk7GALBGlb5nAc+8ECIfQ0sv7D
         3gSTM/wNbLvN7UM1061UkuMnGpjMUrjvnBq/9qbMyQJcJEIbkf6eXx2pZ4acJmUeEfJB
         kHGw==
X-Received: by 10.66.160.167 with SMTP id xl7mr9314459pab.97.1412372344275;
        Fri, 03 Oct 2014 14:39:04 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id k5sm1940175pdk.38.2014.10.03.14.39.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 Oct 2014 14:39:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqoattkm87.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257871>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 1 May 2014 11:16:07 -0700

commit 23acf975d74825789112a3a7ba97dbbdc76904f4 upstream.

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

Change-Id: I8c68f0a47eef25759d572436ba683cb7b1ccb7eb
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Thanks for the heads up.  (I hadn't realized the ref-transaction-1 was
>> part of 'master' --- yay!)  Rebased and reworked:
>> https://code-review.googlesource.com/1027
>
> Heh, I was sort of expecting that heavy-weight contributors that
> throw many and/or large patch series would at least be paying
> attention to "What's cooking" reports.

That's fair.  I don't pay enough attention to the 'graduated' section.

> Will take a look over there (I really hate having to context switch
> only to review this series, though).

Here's a copy to save a trip.

 refs.c | 50 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 83b2c77..05e42a7 100644
--- a/refs.c
+++ b/refs.c
@@ -785,13 +785,13 @@ static void prime_ref_dir(struct ref_dir *dir)
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
 
@@ -815,16 +815,19 @@ static void report_refname_conflict(struct ref_entry *entry,
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
@@ -838,12 +841,12 @@ static int is_refname_available(const char *refname, const char *oldrefname,
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
@@ -876,13 +879,13 @@ static int is_refname_available(const char *refname, const char *oldrefname,
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
@@ -2137,6 +2140,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
  */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
+					    const struct string_list *skip,
 					    int flags, int *type_p)
 {
 	char *ref_file;
@@ -2186,7 +2190,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, NULL, get_packed_refs(&ref_cache))) {
+	     !is_refname_available(refname, skip, get_packed_refs(&ref_cache))) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2244,7 +2248,7 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
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
