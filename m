From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 33/33] refs: handle the main ref_cache specially
Date: Mon, 22 Apr 2013 21:52:41 +0200
Message-ID: <1366660361-21831-34-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 22:02:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMwH-0007fY-RY
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235Ab3DVUBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:01:54 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:63507 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755111Ab3DVUBx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 16:01:53 -0400
X-AuditID: 12074412-b7f216d0000008d4-81-51759566c09b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 54.8F.02260.66595715; Mon, 22 Apr 2013 15:54:14 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOk008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:54:13 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqJs2tTTQ4M0fcYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7427maseC4dcWTtjXMDYwX
	DbsYOTkkBEwk9u+YzwRhi0lcuLeerYuRi0NI4DKjxJqX+9khnAtMEhMevgOrYhPQlVjU0wxm
	iwioSUxsO8QCYjMLOEhs/tzICGILCzhLHNxxnxnEZhFQlei8uI0VxOYVcJVYf3UFO8Q2BYnj
	27eB1XMCxU93nACbIyTgIrHi4FSWCYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunl
	ZpbopaaUbmKEBIvQDsb1J+UOMQpwMCrx8Aq4lwYKsSaWFVfmHmKU5GBSEuXlmAIU4kvKT6nM
	SCzOiC8qzUktPsQowcGsJMIrmg+U401JrKxKLcqHSUlzsCiJ8/5crO4nJJCeWJKanZpakFoE
	k5Xh4FCS4P02GahRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQb8cXA6ABJ8QDt
	lQe5ibe4IDEXKArReopRl2PW1ievGYVY8vLzUqXEed0mARUJgBRllObBrYClhleM4kAfC/Py
	gYziAaYVuEmvgJYwAS3JTCgBWVKSiJCSamBkqVySnXmykvFHjPPmOF+tBfva3t6uaXdhWJh1
	M/NlZ8DXDENB821Llj1/EXiOYS7zvBqFvNCTLRO4Fi9/+ypqrqiD2NlVLg32USs/n2tmunso
	4em1mS8ChY85tJXbPWp7fVCRbcOU27q5bzjuihzi9gp7+KSTOa3qxKKbrJEWM/fu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222084>

Hold the ref_cache instance for the main repository in a dedicated,
statically-allocated instance to avoid the need for a function call
and a linked-list traversal when it is needed.

Suggested by: Heiko Voigt <hvoigt@hvoigt.net>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 60 +++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/refs.c b/refs.c
index f246b77..d17931a 100644
--- a/refs.c
+++ b/refs.c
@@ -810,9 +810,13 @@ static struct ref_cache {
 	struct ref_cache *next;
 	struct ref_entry *loose;
 	struct ref_entry *packed;
-	/* The submodule name, or "" for the main repo. */
-	char name[FLEX_ARRAY];
-} *ref_cache;
+	/*
+	 * The submodule name, or "" for the main repo.  We allocate
+	 * length 1 rather than FLEX_ARRAY so that the main ref_cache
+	 * is initialized correctly.
+	 */
+	char name[1];
+} ref_cache, *submodule_ref_caches;
 
 static void clear_packed_ref_cache(struct ref_cache *refs)
 {
@@ -850,18 +854,18 @@ static struct ref_cache *create_ref_cache(const char *submodule)
  */
 static struct ref_cache *get_ref_cache(const char *submodule)
 {
-	struct ref_cache *refs = ref_cache;
-	if (!submodule)
-		submodule = "";
-	while (refs) {
+	struct ref_cache *refs;
+
+	if (!submodule || !*submodule)
+		return &ref_cache;
+
+	for (refs = submodule_ref_caches; refs; refs = refs->next)
 		if (!strcmp(submodule, refs->name))
 			return refs;
-		refs = refs->next;
-	}
 
 	refs = create_ref_cache(submodule);
-	refs->next = ref_cache;
-	ref_cache = refs;
+	refs->next = submodule_ref_caches;
+	submodule_ref_caches = refs;
 	return refs;
 }
 
@@ -1010,8 +1014,8 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 
 void add_packed_ref(const char *refname, const unsigned char *sha1)
 {
-	add_ref(get_packed_refs(get_ref_cache(NULL)),
-			create_ref_entry(refname, sha1, REF_ISPACKED, 1));
+	add_ref(get_packed_refs(&ref_cache),
+		create_ref_entry(refname, sha1, REF_ISPACKED, 1));
 }
 
 /*
@@ -1186,7 +1190,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
  */
 static struct ref_entry *get_packed_ref(const char *refname)
 {
-	return find_ref(get_packed_refs(get_ref_cache(NULL)), refname);
+	return find_ref(get_packed_refs(&ref_cache), refname);
 }
 
 const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int reading, int *flag)
@@ -1591,7 +1595,7 @@ int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_ref_cache(NULL), "", fn, 0, 0, cb_data);
+	return do_for_each_ref(&ref_cache, "", fn, 0, 0, cb_data);
 }
 
 int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
@@ -1601,7 +1605,7 @@ int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_ref_cache(NULL), prefix, fn, strlen(prefix), 0, cb_data);
+	return do_for_each_ref(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
 }
 
 int for_each_ref_in_submodule(const char *submodule, const char *prefix,
@@ -1642,7 +1646,7 @@ int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *c
 
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_ref_cache(NULL), "refs/replace/", fn, 13, 0, cb_data);
+	return do_for_each_ref(&ref_cache, "refs/replace/", fn, 13, 0, cb_data);
 }
 
 int head_ref_namespaced(each_ref_fn fn, void *cb_data)
@@ -1665,7 +1669,7 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
 	strbuf_addf(&buf, "%srefs/", get_git_namespace());
-	ret = do_for_each_ref(get_ref_cache(NULL), buf.buf, fn, 0, 0, cb_data);
+	ret = do_for_each_ref(&ref_cache, buf.buf, fn, 0, 0, cb_data);
 	strbuf_release(&buf);
 	return ret;
 }
@@ -1707,7 +1711,7 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
 
 int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_ref_cache(NULL), "", fn, 0,
+	return do_for_each_ref(&ref_cache, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
@@ -1913,7 +1917,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, NULL, get_packed_refs(get_ref_cache(NULL)))) {
+	     !is_refname_available(refname, NULL, get_packed_refs(&ref_cache))) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2102,7 +2106,7 @@ int pack_refs(unsigned int flags)
 
 	write_or_die(cbdata.fd, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
 
-	do_for_each_entry(get_ref_cache(NULL), "", pack_one_ref, &cbdata);
+	do_for_each_entry(&ref_cache, "", pack_one_ref, &cbdata);
 	if (commit_lock_file(&packlock) < 0)
 		die_errno("unable to overwrite old ref-pack file");
 	prune_refs(cbdata.ref_to_prune);
@@ -2160,7 +2164,6 @@ static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
 static int repack_without_ref(const char *refname)
 {
 	int fd;
-	struct ref_cache *refs = get_ref_cache(NULL);
 	struct ref_dir *packed;
 
 	if (!get_packed_ref(refname))
@@ -2171,8 +2174,8 @@ static int repack_without_ref(const char *refname)
 		unable_to_lock_error(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refname);
 	}
-	clear_packed_ref_cache(refs);
-	packed = get_packed_refs(refs);
+	clear_packed_ref_cache(&ref_cache);
+	packed = get_packed_refs(&ref_cache);
 	/* Remove refname from the cache. */
 	if (remove_entry(packed, refname) == -1) {
 		/*
@@ -2212,7 +2215,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	ret |= repack_without_ref(lock->ref_name);
 
 	unlink_or_warn(git_path("logs/%s", lock->ref_name));
-	clear_loose_ref_cache(get_ref_cache(NULL));
+	clear_loose_ref_cache(&ref_cache);
 	unlock_ref(lock);
 	return ret;
 }
@@ -2234,7 +2237,6 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	const char *symref = NULL;
-	struct ref_cache *refs = get_ref_cache(NULL);
 
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
@@ -2246,10 +2248,10 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!symref)
 		return error("refname %s not found", oldrefname);
 
-	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(refs)))
+	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(&ref_cache)))
 		return 1;
 
-	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(refs)))
+	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(&ref_cache)))
 		return 1;
 
 	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
@@ -2505,7 +2507,7 @@ int write_ref_sha1(struct ref_lock *lock,
 		unlock_ref(lock);
 		return -1;
 	}
-	clear_loose_ref_cache(get_ref_cache(NULL));
+	clear_loose_ref_cache(&ref_cache);
 	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
 	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
-- 
1.8.2.1
