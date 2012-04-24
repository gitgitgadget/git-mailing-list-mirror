From: mhagger@alum.mit.edu
Subject: [PATCH 10/30] refs: wrap top-level ref_dirs in ref_entries
Date: Wed, 25 Apr 2012 00:45:16 +0200
Message-ID: <1335307536-26914-11-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:57:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMofj-00005X-5z
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758485Ab2DXW5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:57:09 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60977 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758467Ab2DXW5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:57:00 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id A086E248154;
	Wed, 25 Apr 2012 00:46:03 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196269>

From: Michael Haggerty <mhagger@alum.mit.edu>

Wrap the top-level ref_dirs in REF_DIR style ref_entries so that we
have the flag and name available when dealing with them.  This
affects:

* cache_ref::loose
* cache_ref::packed
* extra_refs

The next several commits will expand the use of ref_entry as opposed
to ref_dir, culminating in the ability of a ref_entry representing a
directory of loose references to load itself only when used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 989c10d..4c92dc9 100644
--- a/refs.c
+++ b/refs.c
@@ -606,26 +606,26 @@ static int is_refname_available(const char *refname, const char *oldrefname,
  */
 static struct ref_cache {
 	struct ref_cache *next;
-	char did_loose;
-	char did_packed;
-	struct ref_dir loose;
-	struct ref_dir packed;
+	struct ref_entry *loose;
+	struct ref_entry *packed;
 	/* The submodule name, or "" for the main repo. */
 	char name[FLEX_ARRAY];
 } *ref_cache;
 
 static void clear_packed_ref_cache(struct ref_cache *refs)
 {
-	if (refs->did_packed)
-		clear_ref_dir(&refs->packed);
-	refs->did_packed = 0;
+	if (refs->packed) {
+		free_ref_entry(refs->packed);
+		refs->packed = NULL;
+	}
 }
 
 static void clear_loose_ref_cache(struct ref_cache *refs)
 {
-	if (refs->did_loose)
-		clear_ref_dir(&refs->loose);
-	refs->did_loose = 0;
+	if (refs->loose) {
+		free_ref_entry(refs->loose);
+		refs->loose = NULL;
+	}
 }
 
 static struct ref_cache *create_ref_cache(const char *submodule)
@@ -739,22 +739,22 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 
 static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 {
-	if (!refs->did_packed) {
+	if (!refs->packed) {
 		const char *packed_refs_file;
 		FILE *f;
 
+		refs->packed = create_dir_entry("");
 		if (*refs->name)
 			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
 		else
 			packed_refs_file = git_path("packed-refs");
 		f = fopen(packed_refs_file, "r");
 		if (f) {
-			read_packed_refs(f, &refs->packed);
+			read_packed_refs(f, &refs->packed->u.subdir);
 			fclose(f);
 		}
-		refs->did_packed = 1;
 	}
-	return &refs->packed;
+	return &refs->packed->u.subdir;
 }
 
 void add_packed_ref(const char *refname, const unsigned char *sha1)
@@ -832,12 +832,13 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname,
 
 static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 {
-	if (!refs->did_loose) {
+	if (!refs->loose) {
+		refs->loose = create_dir_entry("");
 		get_ref_dir(refs, "refs/",
-			    &search_for_subdir(&refs->loose, "refs/", 1)->u.subdir);
-		refs->did_loose = 1;
+			    &search_for_subdir(&refs->loose->u.subdir,
+					       "refs/", 1)->u.subdir);
 	}
-	return &refs->loose;
+	return &refs->loose->u.subdir;
 }
 
 /* We allow "recursive" symbolic refs. Only within reason, though */
-- 
1.7.10
