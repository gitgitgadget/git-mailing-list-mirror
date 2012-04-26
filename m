From: mhagger@alum.mit.edu
Subject: [PATCH v2 16/18] struct ref_dir: store a reference to the enclosing ref_cache
Date: Fri, 27 Apr 2012 00:27:05 +0200
Message-ID: <1335479227-7877-17-git-send-email-mhagger@alum.mit.edu>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:27:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNXAL-0008Gp-CX
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759532Ab2DZW1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 18:27:49 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:37157 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759521Ab2DZW1j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 18:27:39 -0400
Received: from michael.berlin.jpk.com (michael2.berlin.jpk.com [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id C43E9248140;
	Fri, 27 Apr 2012 00:27:38 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196437>

From: Michael Haggerty <mhagger@alum.mit.edu>

This means that a directory ref_entry contains all of the information
needed by read_loose_refs().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index f6447e3..110e801 100644
--- a/refs.c
+++ b/refs.c
@@ -106,6 +106,8 @@ struct ref_value {
 	unsigned char peeled[20];
 };
 
+struct ref_cache;
+
 struct ref_dir {
 	int nr, alloc;
 
@@ -117,6 +119,9 @@ struct ref_dir {
 	 */
 	int sorted;
 
+	/* A pointer to the ref_cache that contains this ref_dir. */
+	struct ref_cache *ref_cache;
+
 	struct ref_entry **entries;
 };
 
@@ -234,12 +239,14 @@ static void clear_ref_dir(struct ref_dir *dir)
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
+	direntry->u.subdir.ref_cache = ref_cache;
 	direntry->flag = REF_DIR;
 	return direntry;
 }
@@ -296,7 +303,7 @@ static struct ref_dir *search_for_subdir(struct ref_dir *dir,
 	if (!entry) {
 		if (!mkdir)
 			return NULL;
-		entry = create_dir_entry(subdirname);
+		entry = create_dir_entry(dir->ref_cache, subdirname);
 		add_entry_to_dir(dir, entry);
 	}
 	return get_ref_dir(entry);
@@ -753,7 +760,7 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 		const char *packed_refs_file;
 		FILE *f;
 
-		refs->packed = create_dir_entry("");
+		refs->packed = create_dir_entry(refs, "");
 		if (*refs->name)
 			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
 		else
@@ -843,7 +850,7 @@ static void read_loose_refs(struct ref_cache *refs, const char *dirname,
 static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->loose) {
-		refs->loose = create_dir_entry("");
+		refs->loose = create_dir_entry(refs, "");
 		read_loose_refs(refs, "refs/",
 				search_for_subdir(get_ref_dir(refs->loose),
 						  "refs/", 1));
-- 
1.7.10
