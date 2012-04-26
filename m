From: mhagger@alum.mit.edu
Subject: [PATCH v2 06/18] get_ref_dir(): take the containing directory as argument
Date: Fri, 27 Apr 2012 00:26:55 +0200
Message-ID: <1335479227-7877-7-git-send-email-mhagger@alum.mit.edu>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:27:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNXA0-0007z0-5z
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759461Ab2DZW1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 18:27:23 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:37082 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755544Ab2DZW1W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 18:27:22 -0400
Received: from michael.berlin.jpk.com (michael2.berlin.jpk.com [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 0A92524813F;
	Fri, 27 Apr 2012 00:27:22 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196430>

From: Michael Haggerty <mhagger@alum.mit.edu>

Previously, the "dir" argument to get_ref_dir() was a pointer to the
top-level ref_dir.  Change the function to expect a pointer to the
ref_dir corresponding to dirname.  This allows entries to be added
directly to dir, without having to recurse through the reference trie
each time (i.e., we can use add_entry_to_dir() instead of add_ref()).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 5e51c10..8670c2e 100644
--- a/refs.c
+++ b/refs.c
@@ -765,7 +765,8 @@ void add_packed_ref(const char *refname, const unsigned char *sha1)
 
 /*
  * Read the loose references for refs from the namespace dirname.
- * dirname must end with '/'.
+ * dirname must end with '/'.  dir must be the directory entry
+ * corresponding to dirname.
  */
 static void get_ref_dir(struct ref_cache *refs, const char *dirname,
 			struct ref_dir *dir)
@@ -806,7 +807,8 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname,
 			/* Silently ignore. */
 		} else if (S_ISDIR(st.st_mode)) {
 			strbuf_addch(&refname, '/');
-			get_ref_dir(refs, refname.buf, dir);
+			get_ref_dir(refs, refname.buf,
+				    &search_for_subdir(dir, refname.buf, 1)->u.subdir);
 		} else {
 			if (*refs->name) {
 				hashclr(sha1);
@@ -819,7 +821,8 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname,
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
-			add_ref(dir, create_ref_entry(refname.buf, sha1, flag, 1));
+			add_entry_to_dir(dir,
+					 create_ref_entry(refname.buf, sha1, flag, 1));
 		}
 		strbuf_setlen(&refname, dirnamelen);
 	}
@@ -830,7 +833,8 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname,
 static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->did_loose) {
-		get_ref_dir(refs, "refs/", &refs->loose);
+		get_ref_dir(refs, "refs/",
+			    &search_for_subdir(&refs->loose, "refs/", 1)->u.subdir);
 		refs->did_loose = 1;
 	}
 	return &refs->loose;
-- 
1.7.10
