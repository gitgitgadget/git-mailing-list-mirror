From: mhagger@alum.mit.edu
Subject: [PATCH v4 1/7] invalidate_ref_cache(): rename function from invalidate_cached_refs()
Date: Mon, 17 Oct 2011 04:38:05 +0200
Message-ID: <1318819091-7066-2-git-send-email-mhagger@alum.mit.edu>
References: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 04:38:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFd6I-0001z5-6v
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 04:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240Ab1JQCip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 22:38:45 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:45401 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134Ab1JQCin (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 22:38:43 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BECB73.dip.t-dialin.net [84.190.203.115])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9H2cN3T013403;
	Mon, 17 Oct 2011 04:38:28 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183753>

From: Michael Haggerty <mhagger@alum.mit.edu>

It is the cache that is being invalidated, not the references, and the
new name makes this unambiguous.  Rename other items analogously:

* struct cached_refs -> struct ref_cache
* cached_refs (the variable) -> ref_cache
* clear_cached_refs() -> clear_ref_cache()
* create_cached_refs() -> create_ref_cache()
* get_cached_refs() -> get_ref_cache()

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/refs.c b/refs.c
index 9911c97..02b1ef0 100644
--- a/refs.c
+++ b/refs.c
@@ -134,15 +134,15 @@ static struct ref_entry *search_ref_array(struct ref_array *array, const char *n
  * Future: need to be in "struct repository"
  * when doing a full libification.
  */
-static struct cached_refs {
-	struct cached_refs *next;
+static struct ref_cache {
+	struct ref_cache *next;
 	char did_loose;
 	char did_packed;
 	struct ref_array loose;
 	struct ref_array packed;
 	/* The submodule name, or "" for the main repo. */
 	char name[FLEX_ARRAY];
-} *cached_refs;
+} *ref_cache;
 
 static struct ref_entry *current_ref;
 
@@ -158,7 +158,7 @@ static void free_ref_array(struct ref_array *array)
 	array->refs = NULL;
 }
 
-static void clear_cached_refs(struct cached_refs *ca)
+static void clear_ref_cache(struct ref_cache *ca)
 {
 	if (ca->did_loose)
 		free_ref_array(&ca->loose);
@@ -167,27 +167,27 @@ static void clear_cached_refs(struct cached_refs *ca)
 	ca->did_loose = ca->did_packed = 0;
 }
 
-static struct cached_refs *create_cached_refs(const char *submodule)
+static struct ref_cache *create_ref_cache(const char *submodule)
 {
 	int len;
-	struct cached_refs *refs;
+	struct ref_cache *refs;
 	if (!submodule)
 		submodule = "";
 	len = strlen(submodule) + 1;
-	refs = xcalloc(1, sizeof(struct cached_refs) + len);
+	refs = xcalloc(1, sizeof(struct ref_cache) + len);
 	memcpy(refs->name, submodule, len);
 	return refs;
 }
 
 /*
- * Return a pointer to a cached_refs for the specified submodule. For
+ * Return a pointer to a ref_cache for the specified submodule. For
  * the main repository, use submodule==NULL. The returned structure
  * will be allocated and initialized but not necessarily populated; it
  * should not be freed.
  */
-static struct cached_refs *get_cached_refs(const char *submodule)
+static struct ref_cache *get_ref_cache(const char *submodule)
 {
-	struct cached_refs *refs = cached_refs;
+	struct ref_cache *refs = ref_cache;
 	if (!submodule)
 		submodule = "";
 	while (refs) {
@@ -196,17 +196,17 @@ static struct cached_refs *get_cached_refs(const char *submodule)
 		refs = refs->next;
 	}
 
-	refs = create_cached_refs(submodule);
-	refs->next = cached_refs;
-	cached_refs = refs;
+	refs = create_ref_cache(submodule);
+	refs->next = ref_cache;
+	ref_cache = refs;
 	return refs;
 }
 
-static void invalidate_cached_refs(void)
+static void invalidate_ref_cache(void)
 {
-	struct cached_refs *refs = cached_refs;
+	struct ref_cache *refs = ref_cache;
 	while (refs) {
-		clear_cached_refs(refs);
+		clear_ref_cache(refs);
 		refs = refs->next;
 	}
 }
@@ -257,7 +257,7 @@ void clear_extra_refs(void)
 
 static struct ref_array *get_packed_refs(const char *submodule)
 {
-	struct cached_refs *refs = get_cached_refs(submodule);
+	struct ref_cache *refs = get_ref_cache(submodule);
 
 	if (!refs->did_packed) {
 		const char *packed_refs_file;
@@ -379,7 +379,7 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 
 static struct ref_array *get_loose_refs(const char *submodule)
 {
-	struct cached_refs *refs = get_cached_refs(submodule);
+	struct ref_cache *refs = get_ref_cache(submodule);
 
 	if (!refs->did_loose) {
 		get_ref_dir(submodule, "refs", &refs->loose);
@@ -1228,7 +1228,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	ret |= repack_without_ref(refname);
 
 	unlink_or_warn(git_path("logs/%s", lock->ref_name));
-	invalidate_cached_refs();
+	invalidate_ref_cache();
 	unlock_ref(lock);
 	return ret;
 }
@@ -1527,7 +1527,7 @@ int write_ref_sha1(struct ref_lock *lock,
 		unlock_ref(lock);
 		return -1;
 	}
-	invalidate_cached_refs();
+	invalidate_ref_cache();
 	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
 	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
-- 
1.7.7.rc2
