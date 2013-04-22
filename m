From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 19/33] refs: change how packed refs are deleted
Date: Mon, 22 Apr 2013 21:52:27 +0200
Message-ID: <1366660361-21831-20-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:54:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMoT-0005Bt-2q
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162Ab3DVTx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:53:57 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:55440 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755155Ab3DVTxz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:53:55 -0400
X-AuditID: 12074414-b7fb86d000000905-29-51759552bc9c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 3C.4B.02309.25595715; Mon, 22 Apr 2013 15:53:54 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOW008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:53 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqBs0tTTQ4OsLa4uuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M6YfmgWc8EZnYrHb7eyNzC2
	qHQxcnJICJhIbLi6iRnCFpO4cG89WxcjF4eQwGVGibUNXYwQzgUmiTefdzCCVLEJ6Eos6mlm
	ArFFBNQkJrYdYgGxmQUcJDZ/bgSrERZwkrjeeAIsziKgKvHg9AmwDbwCrhITf0PUSAgoSBzf
	vg3M5gSKn+6AqBcScJFYcXAqywRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdC30cjNL
	9FJTSjcxQoJFZAfjkZNyhxgFOBiVeHgF3UsDhVgTy4orcw8xSnIwKYnyckwBCvEl5adUZiQW
	Z8QXleakFh9ilOBgVhLhFc0HyvGmJFZWpRblw6SkOViUxHm/LVb3ExJITyxJzU5NLUgtgsnK
	cHAoSfBmgAwVLEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VGfDEwOkBSPEB7I0Ha
	eYsLEnOBohCtpxiNOWZtffKakeNr58vXjEIsefl5qVLivG6TgEoFQEozSvPgFsHSxCtGcaC/
	hXk9QAbyAFMM3LxXQKuYgFZlJpSArCpJREhJNTCKO//XuaG7vCYusu/sh43HN/gkW8a/bOt/
	y1WsIaBn6yx63dEz9lH8zkdiTXELP0V/+exUkWDL/n291u3DvdUXqqeEcgd/15DR2meT+sDz
	2PtDYX6fvkZo75z6NWeb9G5JE/k9X8/Udz09FLRhX8PlxXfzCstjlAMSyo8/mz1P 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222061>

Add a function remove_ref(), which removes a single entry from a
reference cache.

Use this function to reimplement repack_without_ref().  The old
version iterated over all refs, packing all of them except for the one
to be deleted, then discarded the entire packed reference cache.  The
new version deletes the doomed reference from the cache *before*
iterating.

This has two advantages:

* the code for writing packed-refs becomes simpler, because it doesn't
  have to exclude one of the references.

* it is no longer necessary to discard the packed refs cache after
  deleting a reference: symbolic refs cannot be packed, so packed
  references cannot depend on each other, so the rest of the packed
  refs cache remains valid after a reference is deleted.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 68 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 9fd49e8..51915a8 100644
--- a/refs.c
+++ b/refs.c
@@ -467,6 +467,57 @@ static struct ref_entry *find_ref(struct ref_dir *dir, const char *refname)
 }
 
 /*
+ * Remove the entry with the given name from dir, recursing into
+ * subdirectories as necessary.  If refname is the name of a directory
+ * (i.e., ends with '/'), then remove the directory and its contents.
+ * If the removal was successful, return the number of entries
+ * remaining in the directory entry that contained the deleted entry.
+ * If the name was not found, return -1.  Please note that this
+ * function only deletes the entry from the cache; it does not delete
+ * it from the filesystem or ensure that other cache entries (which
+ * might be symbolic references to the removed entry) are updated.
+ * Nor does it remove any containing dir entries that might be made
+ * empty by the removal.  dir must represent the top-level directory
+ * and must already be complete.
+ */
+static int remove_entry(struct ref_dir *dir, const char *refname)
+{
+	int refname_len = strlen(refname);
+	int entry_index;
+	struct ref_entry *entry;
+	int is_dir = refname[refname_len - 1] == '/';
+	if (is_dir) {
+		/*
+		 * refname represents a reference directory.  Remove
+		 * the trailing slash; otherwise we will get the
+		 * directory *representing* refname rather than the
+		 * one *containing* it.
+		 */
+		char *dirname = xmemdupz(refname, refname_len - 1);
+		dir = find_containing_dir(dir, dirname, 0);
+		free(dirname);
+	} else {
+		dir = find_containing_dir(dir, refname, 0);
+	}
+	if (!dir)
+		return -1;
+	entry_index = search_ref_dir(dir, refname, refname_len);
+	if (entry_index == -1)
+		return -1;
+	entry = dir->entries[entry_index];
+
+	memmove(&dir->entries[entry_index],
+		&dir->entries[entry_index + 1],
+		(dir->nr - entry_index - 1) * sizeof(*dir->entries)
+		);
+	dir->nr--;
+	if (dir->sorted > entry_index)
+		dir->sorted--;
+	free_ref_entry(entry);
+	return dir->nr;
+}
+
+/*
  * Add a ref_entry to the ref_dir (unsorted), recursing into
  * subdirectories as necessary.  dir must represent the top-level
  * directory.  Return 0 on success.
@@ -1894,19 +1945,12 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 	return lock_ref_sha1_basic(refname, old_sha1, flags, NULL);
 }
 
-struct repack_without_ref_sb {
-	const char *refname;
-	int fd;
-};
-
-static int repack_without_ref_fn(struct ref_entry *entry, void *cb_data)
+static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
 {
-	struct repack_without_ref_sb *data = cb_data;
+	int *fd = cb_data;
 	char line[PATH_MAX + 100];
 	int len;
 
-	if (!strcmp(data->refname, entry->name))
-		return 0;
 	if (entry->flag & REF_ISBROKEN) {
 		/* This shouldn't happen to packed refs. */
 		error("%s is broken!", entry->name);
@@ -1947,7 +1991,7 @@ static int repack_without_ref_fn(struct ref_entry *entry, void *cb_data)
 	/* this should not happen but just being defensive */
 	if (len > sizeof(line))
 		die("too long a refname '%s'", entry->name);
-	write_or_die(data->fd, line, len);
+	write_or_die(*fd, line, len);
 	return 0;
 }
 
@@ -1955,22 +1999,30 @@ static struct lock_file packlock;
 
 static int repack_without_ref(const char *refname)
 {
-	struct repack_without_ref_sb data;
+	int fd;
 	struct ref_cache *refs = get_ref_cache(NULL);
 	struct ref_dir *packed;
 
 	if (!get_packed_ref(refname))
 		return 0; /* refname does not exist in packed refs */
 
-	data.refname = refname;
-	data.fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
-	if (data.fd < 0) {
+	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
+	if (fd < 0) {
 		unable_to_lock_error(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refname);
 	}
 	clear_packed_ref_cache(refs);
 	packed = get_packed_refs(refs);
-	do_for_each_entry_in_dir(packed, 0, repack_without_ref_fn, &data);
+	/* Remove refname from the cache. */
+	if (remove_entry(packed, refname) == -1) {
+		/*
+		 * The packed entry disappeared while we were
+		 * acquiring the lock.
+		 */
+		rollback_lock_file(&packlock);
+		return 0;
+	}
+	do_for_each_entry_in_dir(packed, 0, repack_ref_fn, &fd);
 	return commit_lock_file(&packlock);
 }
 
@@ -1999,7 +2051,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	ret |= repack_without_ref(lock->ref_name);
 
 	unlink_or_warn(git_path("logs/%s", lock->ref_name));
-	invalidate_ref_cache(NULL);
+	clear_loose_ref_cache(get_ref_cache(NULL));
 	unlock_ref(lock);
 	return ret;
 }
-- 
1.8.2.1
