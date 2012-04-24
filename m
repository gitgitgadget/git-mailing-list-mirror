From: mhagger@alum.mit.edu
Subject: [PATCH 26/30] struct ref_dir: store a reference to the enclosing ref_cache
Date: Wed, 25 Apr 2012 00:45:32 +0200
Message-ID: <1335307536-26914-27-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:57:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMogD-0000SK-IE
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436Ab2DXW5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:57:31 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60969 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758442Ab2DXW5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:57:00 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 8F1B1248173;
	Wed, 25 Apr 2012 00:46:24 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196276>

From: Michael Haggerty <mhagger@alum.mit.edu>

This means that it contains enough information to serve as the sole
argument to get_ref_dir(), which will be changed in a moment.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 90bdd7c..11ebc02 100644
--- a/refs.c
+++ b/refs.c
@@ -106,6 +106,8 @@ struct ref_value {
 	unsigned char peeled[20];
 };
 
+struct ref_cache;
+
 struct ref_dir {
 	int nr, alloc;
 
@@ -118,6 +120,9 @@ struct ref_dir {
 	int sorted;
 
 	struct ref_entry **entries;
+
+	/* A pointer to the ref_cache that contains this ref_dir. */
+	struct ref_cache *ref_cache;
 };
 
 /* ISSYMREF=0x01, ISPACKED=0x02, and ISBROKEN=0x04 are public interfaces */
@@ -230,13 +235,15 @@ static void clear_ref_dir(struct ref_dir *dir)
  * dirname is the name of the directory with a trailing slash (e.g.,
  * "refs/heads/") or "" for the top-level directory.
  */
-static struct ref_entry *create_dir_entry(const char *dirname)
+static struct ref_entry *create_dir_entry(struct ref_cache *ref_cache,
+					  const char *dirname)
 {
 	struct ref_entry *direntry;
 	int len = strlen(dirname);
 	direntry = xcalloc(1, sizeof(struct ref_entry) + len + 1);
 	memcpy(direntry->name, dirname, len + 1);
 	direntry->flag = REF_DIR;
+	direntry->u.subdir.ref_cache = ref_cache;
 	return direntry;
 }
 
@@ -296,7 +303,8 @@ static struct ref_entry *search_for_subdir(struct ref_entry *direntry,
 	if (!entry) {
 		if (!mkdir)
 			return NULL;
-		entry = create_dir_entry(subdirname);
+		entry = create_dir_entry(direntry->u.subdir.ref_cache,
+					 subdirname);
 		add_entry(direntry, entry);
 	}
 	assert(entry->flag & REF_DIR);
@@ -760,7 +768,7 @@ static struct ref_entry *get_packed_refs(struct ref_cache *refs)
 		const char *packed_refs_file;
 		FILE *f;
 
-		refs->packed = create_dir_entry("");
+		refs->packed = create_dir_entry(refs, "");
 		if (*refs->name)
 			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
 		else
@@ -851,7 +859,7 @@ static void get_ref_dir(struct ref_cache *refs, struct ref_entry *direntry)
 static struct ref_entry *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->loose) {
-		refs->loose = create_dir_entry("");
+		refs->loose = create_dir_entry(refs, "");
 		get_ref_dir(refs,
 			    search_for_subdir(refs->loose, "refs/", 1));
 	}
-- 
1.7.10
