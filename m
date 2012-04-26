From: mhagger@alum.mit.edu
Subject: [PATCH v2 12/18] refs: wrap top-level ref_dirs in ref_entries
Date: Fri, 27 Apr 2012 00:27:01 +0200
Message-ID: <1335479227-7877-13-git-send-email-mhagger@alum.mit.edu>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:27:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNXA2-0007z0-H7
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759499Ab2DZW1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 18:27:35 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:37129 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759488Ab2DZW1d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 18:27:33 -0400
Received: from michael.berlin.jpk.com (michael2.berlin.jpk.com [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 33A31248140;
	Fri, 27 Apr 2012 00:27:32 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196431>

From: Michael Haggerty <mhagger@alum.mit.edu>

Make it turtles all the way down.  This affects the loose and packed
fields of ref_cache instances.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

This change is not crucial, as it was in v1 of the patch series.
Nevertheless I think that it improves the code consistency.

 refs.c |   37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 94b20a3..de14e75 100644
--- a/refs.c
+++ b/refs.c
@@ -607,26 +607,26 @@ static int is_refname_available(const char *refname, const char *oldrefname,
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
@@ -740,22 +740,22 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 
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
@@ -833,12 +833,13 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname,
 
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
