From: mhagger@alum.mit.edu
Subject: [PATCH v2 10/14] refs: change signatures of get_packed_refs() and get_loose_refs()
Date: Mon, 17 Oct 2011 09:39:19 +0200
Message-ID: <1318837163-27112-11-git-send-email-mhagger@alum.mit.edu>
References: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 09:40:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFhoM-00086Z-Ob
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 09:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091Ab1JQHkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 03:40:19 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:33686 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068Ab1JQHkS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 03:40:18 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RFhhf-0000eM-Jy; Mon, 17 Oct 2011 09:33:43 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183783>

From: Michael Haggerty <mhagger@alum.mit.edu>

Change get_packed_refs() and get_loose_refs() to take a (struct
ref_cache *) instead of the name of the submodule.

Change get_ref_dir() to take a submodule name (i.e., "" for the main
module) rather than a submodule pointer (i.e., NULL for the main
module) so that refs->name can be used as its argument.  (In a moment
this function will also be changed to take a (struct ref_cache *),
too.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   36 +++++++++++++++++-------------------
 1 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/refs.c b/refs.c
index 7417f9a..9051b9f 100644
--- a/refs.c
+++ b/refs.c
@@ -280,16 +280,14 @@ void clear_extra_refs(void)
 	clear_ref_array(&extra_refs);
 }
 
-static struct ref_array *get_packed_refs(const char *submodule)
+static struct ref_array *get_packed_refs(struct ref_cache *refs)
 {
-	struct ref_cache *refs = get_ref_cache(submodule);
-
 	if (!refs->did_packed) {
 		const char *packed_refs_file;
 		FILE *f;
 
-		if (submodule)
-			packed_refs_file = git_path_submodule(submodule, "packed-refs");
+		if (*refs->name)
+			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
 		else
 			packed_refs_file = git_path("packed-refs");
 		f = fopen(packed_refs_file, "r");
@@ -308,7 +306,7 @@ static void get_ref_dir(const char *submodule, const char *base,
 	DIR *dir;
 	const char *path;
 
-	if (submodule)
+	if (*submodule)
 		path = git_path_submodule(submodule, "%s", base);
 	else
 		path = git_path("%s", base);
@@ -402,12 +400,10 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
 
-static struct ref_array *get_loose_refs(const char *submodule)
+static struct ref_array *get_loose_refs(struct ref_cache *refs)
 {
-	struct ref_cache *refs = get_ref_cache(submodule);
-
 	if (!refs->did_loose) {
-		get_ref_dir(submodule, "refs", &refs->loose);
+		get_ref_dir(refs->name, "refs", &refs->loose);
 		sort_ref_array(&refs->loose);
 		refs->did_loose = 1;
 	}
@@ -423,7 +419,7 @@ static int resolve_gitlink_packed_ref(char *name, int pathlen,
 {
 	int retval = -1;
 	struct ref_entry *ref;
-	struct ref_array *array = get_packed_refs(name);
+	struct ref_array *array = get_packed_refs(get_ref_cache(name));
 
 	ref = search_ref_array(array, refname);
 	if (ref != NULL) {
@@ -504,7 +500,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
  */
 static int get_packed_ref(const char *refname, unsigned char *sha1)
 {
-	struct ref_array *packed = get_packed_refs(NULL);
+	struct ref_array *packed = get_packed_refs(get_ref_cache(NULL));
 	struct ref_entry *entry = search_ref_array(packed, refname);
 	if (entry) {
 		hashcpy(sha1, entry->sha1);
@@ -682,7 +678,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		return -1;
 
 	if ((flag & REF_ISPACKED)) {
-		struct ref_array *array = get_packed_refs(NULL);
+		struct ref_array *array = get_packed_refs(get_ref_cache(NULL));
 		struct ref_entry *r = search_ref_array(array, refname);
 
 		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
@@ -707,8 +703,9 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 			   int trim, int flags, void *cb_data)
 {
 	int retval = 0, i, p = 0, l = 0;
-	struct ref_array *packed = get_packed_refs(submodule);
-	struct ref_array *loose = get_loose_refs(submodule);
+	struct ref_cache *refs = get_ref_cache(submodule);
+	struct ref_array *packed = get_packed_refs(refs);
+	struct ref_array *loose = get_loose_refs(refs);
 
 	struct ref_array *extra = &extra_refs;
 
@@ -1144,7 +1141,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, NULL, get_packed_refs(NULL))) {
+	     !is_refname_available(refname, NULL, get_packed_refs(get_ref_cache(NULL)))) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -1204,7 +1201,7 @@ static int repack_without_ref(const char *refname)
 	struct ref_entry *ref;
 	int fd, i;
 
-	packed = get_packed_refs(NULL);
+	packed = get_packed_refs(get_ref_cache(NULL));
 	ref = search_ref_array(packed, refname);
 	if (ref == NULL)
 		return 0;
@@ -1288,6 +1285,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	const char *symref = NULL;
+	struct ref_cache *refs = get_ref_cache(NULL);
 
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
@@ -1299,10 +1297,10 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!symref)
 		return error("refname %s not found", oldrefname);
 
-	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(NULL)))
+	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(refs)))
 		return 1;
 
-	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(NULL)))
+	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(refs)))
 		return 1;
 
 	lock = lock_ref_sha1_basic(renamed_ref, NULL, 0, NULL);
-- 
1.7.7.rc2
