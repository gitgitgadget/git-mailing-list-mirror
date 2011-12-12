From: mhagger@alum.mit.edu
Subject: [PATCH v2 09/51] refs: change signatures of get_packed_refs() and get_loose_refs()
Date: Mon, 12 Dec 2011 06:38:16 +0100
Message-ID: <1323668338-1764-10-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:40:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZyca-0000Sq-9U
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523Ab1LLFjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:39:55 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34594 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060Ab1LLFjq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:39:46 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aM015577;
	Mon, 12 Dec 2011 06:39:30 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186832>

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
index ea058c1..c62c682 100644
--- a/refs.c
+++ b/refs.c
@@ -278,16 +278,14 @@ void clear_extra_refs(void)
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
@@ -306,7 +304,7 @@ static void get_ref_dir(const char *submodule, const char *base,
 	DIR *dir;
 	const char *path;
 
-	if (submodule)
+	if (*submodule)
 		path = git_path_submodule(submodule, "%s", base);
 	else
 		path = git_path("%s", base);
@@ -399,12 +397,10 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
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
@@ -431,7 +427,7 @@ static int resolve_gitlink_packed_ref(char *name, int pathlen,
 	if (pathlen < 6 || memcmp(name + pathlen - 6, "/.git/", 6))
 		die("Oops");
 	name[pathlen - 6] = '\0'; /* make it path to the submodule */
-	array = get_packed_refs(name);
+	array = get_packed_refs(get_ref_cache(name));
 	ref = search_ref_array(array, refname);
 	if (ref != NULL) {
 		memcpy(sha1, ref->sha1, 20);
@@ -511,7 +507,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
  */
 static int get_packed_ref(const char *refname, unsigned char *sha1)
 {
-	struct ref_array *packed = get_packed_refs(NULL);
+	struct ref_array *packed = get_packed_refs(get_ref_cache(NULL));
 	struct ref_entry *entry = search_ref_array(packed, refname);
 	if (entry) {
 		hashcpy(sha1, entry->sha1);
@@ -695,7 +691,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		return -1;
 
 	if ((flag & REF_ISPACKED)) {
-		struct ref_array *array = get_packed_refs(NULL);
+		struct ref_array *array = get_packed_refs(get_ref_cache(NULL));
 		struct ref_entry *r = search_ref_array(array, refname);
 
 		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
@@ -720,8 +716,9 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 			   int trim, int flags, void *cb_data)
 {
 	int retval = 0, i, p = 0, l = 0;
-	struct ref_array *packed = get_packed_refs(submodule);
-	struct ref_array *loose = get_loose_refs(submodule);
+	struct ref_cache *refs = get_ref_cache(submodule);
+	struct ref_array *packed = get_packed_refs(refs);
+	struct ref_array *loose = get_loose_refs(refs);
 
 	struct ref_array *extra = &extra_refs;
 
@@ -1238,7 +1235,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, NULL, get_packed_refs(NULL))) {
+	     !is_refname_available(refname, NULL, get_packed_refs(get_ref_cache(NULL)))) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -1298,7 +1295,7 @@ static int repack_without_ref(const char *refname)
 	struct ref_entry *ref;
 	int fd, i;
 
-	packed = get_packed_refs(NULL);
+	packed = get_packed_refs(get_ref_cache(NULL));
 	ref = search_ref_array(packed, refname);
 	if (ref == NULL)
 		return 0;
@@ -1381,6 +1378,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	const char *symref = NULL;
+	struct ref_cache *refs = get_ref_cache(NULL);
 
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
@@ -1392,10 +1390,10 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!symref)
 		return error("refname %s not found", oldrefname);
 
-	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(NULL)))
+	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(refs)))
 		return 1;
 
-	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(NULL)))
+	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(refs)))
 		return 1;
 
 	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
-- 
1.7.8
