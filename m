From: mhagger@alum.mit.edu
Subject: [PATCH v2 34/51] refs: wrap top-level ref_dirs in ref_entries
Date: Mon, 12 Dec 2011 06:38:41 +0100
Message-ID: <1323668338-1764-35-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:41:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZydR-0000k3-Ca
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940Ab1LLFkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:40 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34865 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817Ab1LLFkh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:37 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8al015577;
	Mon, 12 Dec 2011 06:40:28 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186849>

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
 refs.c |   52 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/refs.c b/refs.c
index 6912db3..b4019e6 100644
--- a/refs.c
+++ b/refs.c
@@ -567,28 +567,28 @@ static int is_refname_available(const char *refname, const char *oldrefname,
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
 
-static struct ref_dir extra_refs;
+static struct ref_entry *extra_refs;
 
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
@@ -702,32 +702,37 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 
 void add_extra_ref(const char *refname, const unsigned char *sha1, int flag)
 {
-	add_ref(&extra_refs, create_ref_entry(refname, sha1, flag, 0));
+	if (!extra_refs)
+		extra_refs = create_dir_entry("");
+	add_ref(&extra_refs->u.subdir, create_ref_entry(refname, sha1, flag, 0));
 }
 
 void clear_extra_refs(void)
 {
-	clear_ref_dir(&extra_refs);
+	if (extra_refs) {
+		free_ref_entry(extra_refs);
+		extra_refs = NULL;
+	}
 }
 
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
 
 /*
@@ -744,7 +749,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname)
 
 	assert(dirnamelen && dirname[dirnamelen - 1] == '/');
 
-	dir = find_containing_dir(&refs->loose, dirname, 1);
+	dir = find_containing_dir(&refs->loose->u.subdir, dirname, 1);
 
 	if (*refs->name)
 		path = git_path_submodule(refs->name, "%s", dirname);
@@ -806,11 +811,11 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname)
 
 static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 {
-	if (!refs->did_loose) {
+	if (!refs->loose) {
+		refs->loose = create_dir_entry("");
 		get_ref_dir(refs, "refs/");
-		refs->did_loose = 1;
 	}
-	return &refs->loose;
+	return &refs->loose->u.subdir;
 }
 
 /* We allow "recursive" symbolic refs. Only within reason, though */
@@ -1130,12 +1135,13 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 {
 	int retval = 0;
 	struct ref_cache *refs = get_ref_cache(submodule);
-	struct ref_dir *extra_dir = &extra_refs;
+	struct ref_dir *extra_dir = extra_refs ? &extra_refs->u.subdir : NULL;
 	struct ref_dir *packed_dir = get_packed_refs(refs);
 	struct ref_dir *loose_dir = get_loose_refs(refs);
 
 	if (base && *base) {
-		extra_dir = find_containing_dir(extra_dir, base, 0);
+		if (extra_dir)
+			extra_dir = find_containing_dir(extra_dir, base, 0);
 		packed_dir = find_containing_dir(packed_dir, base, 0);
 		loose_dir = find_containing_dir(loose_dir, base, 0);
 	}
-- 
1.7.8
