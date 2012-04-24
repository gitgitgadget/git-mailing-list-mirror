From: mhagger@alum.mit.edu
Subject: [PATCH 18/30] get_ref_dir(): take (ref_entry *) instead of (ref_dir *)
Date: Wed, 25 Apr 2012 00:45:24 +0200
Message-ID: <1335307536-26914-19-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:57:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMofQ-0008NB-G6
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758456Ab2DXW46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:56:58 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60960 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758440Ab2DXW44 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:56:56 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 0C30F248164;
	Wed, 25 Apr 2012 00:46:16 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196262>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 140fbe2..2057380 100644
--- a/refs.c
+++ b/refs.c
@@ -769,11 +769,11 @@ void add_packed_ref(const char *refname, const unsigned char *sha1)
 
 /*
  * Read the loose references for refs from the namespace dirname.
- * dirname must end with '/'.  dir must be the directory entry
+ * dirname must end with '/'.  direntry must be the directory entry
  * corresponding to dirname.
  */
 static void get_ref_dir(struct ref_cache *refs, const char *dirname,
-			struct ref_dir *dir)
+			struct ref_entry *direntry)
 {
 	DIR *d;
 	const char *path;
@@ -781,6 +781,8 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname,
 	int dirnamelen = strlen(dirname);
 	struct strbuf refname;
 
+	assert(direntry->flag & REF_DIR);
+
 	if (*refs->name)
 		path = git_path_submodule(refs->name, "%s", dirname);
 	else
@@ -812,7 +814,8 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname,
 		} else if (S_ISDIR(st.st_mode)) {
 			strbuf_addch(&refname, '/');
 			get_ref_dir(refs, refname.buf,
-				    &search_for_subdir(dir, refname.buf, 1)->u.subdir);
+				    search_for_subdir(&direntry->u.subdir,
+						      refname.buf, 1));
 		} else {
 			if (*refs->name) {
 				hashclr(sha1);
@@ -825,7 +828,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname,
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
-			add_entry_to_dir(dir,
+			add_entry_to_dir(&direntry->u.subdir,
 					 create_ref_entry(refname.buf, sha1, flag, 1));
 		}
 		strbuf_setlen(&refname, dirnamelen);
@@ -839,8 +842,8 @@ static struct ref_entry *get_loose_refs(struct ref_cache *refs)
 	if (!refs->loose) {
 		refs->loose = create_dir_entry("");
 		get_ref_dir(refs, "refs/",
-			    &search_for_subdir(&refs->loose->u.subdir,
-					       "refs/", 1)->u.subdir);
+			    search_for_subdir(&refs->loose->u.subdir,
+					      "refs/", 1));
 	}
 	return refs->loose;
 }
-- 
1.7.10
