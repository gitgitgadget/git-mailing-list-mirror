From: mhagger@alum.mit.edu
Subject: [PATCH v2 15/18] search_for_subdir(): return (ref_dir *) instead of (ref_entry *)
Date: Fri, 27 Apr 2012 00:27:04 +0200
Message-ID: <1335479227-7877-16-git-send-email-mhagger@alum.mit.edu>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:27:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNXAI-0008Gp-U7
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759523Ab2DZW1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 18:27:39 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:37149 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758989Ab2DZW1i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 18:27:38 -0400
Received: from michael.berlin.jpk.com (michael2.berlin.jpk.com [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 1078724813F;
	Fri, 27 Apr 2012 00:27:37 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196433>

From: Michael Haggerty <mhagger@alum.mit.edu>

That is what all the callers want, so give it to them.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index 2e71bfa..f6447e3 100644
--- a/refs.c
+++ b/refs.c
@@ -289,8 +289,8 @@ static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname
  * directory if it is missing; otherwise, return NULL if the desired
  * directory cannot be found.
  */
-static struct ref_entry *search_for_subdir(struct ref_dir *dir,
-					   const char *subdirname, int mkdir)
+static struct ref_dir *search_for_subdir(struct ref_dir *dir,
+					 const char *subdirname, int mkdir)
 {
 	struct ref_entry *entry = search_ref_dir(dir, subdirname);
 	if (!entry) {
@@ -299,8 +299,7 @@ static struct ref_entry *search_for_subdir(struct ref_dir *dir,
 		entry = create_dir_entry(subdirname);
 		add_entry_to_dir(dir, entry);
 	}
-	assert(entry->flag & REF_DIR);
-	return entry;
+	return get_ref_dir(entry);
 }
 
 /*
@@ -319,14 +318,14 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
 	const char *slash;
 	strbuf_init(&dirname, PATH_MAX);
 	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
-		struct ref_entry *entry;
+		struct ref_dir *subdir;
 		strbuf_add(&dirname,
 			   refname + dirname.len,
 			   (slash + 1) - (refname + dirname.len));
-		entry = search_for_subdir(dir, dirname.buf, mkdir);
-		if (!entry)
+		subdir = search_for_subdir(dir, dirname.buf, mkdir);
+		if (!subdir)
 			break;
-		dir = get_ref_dir(entry);
+		dir = subdir;
 	}
 
 	strbuf_release(&dirname);
@@ -819,7 +818,7 @@ static void read_loose_refs(struct ref_cache *refs, const char *dirname,
 		} else if (S_ISDIR(st.st_mode)) {
 			strbuf_addch(&refname, '/');
 			read_loose_refs(refs, refname.buf,
-					get_ref_dir(search_for_subdir(dir, refname.buf, 1)));
+					search_for_subdir(dir, refname.buf, 1));
 		} else {
 			if (*refs->name) {
 				hashclr(sha1);
@@ -846,8 +845,8 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 	if (!refs->loose) {
 		refs->loose = create_dir_entry("");
 		read_loose_refs(refs, "refs/",
-				get_ref_dir(search_for_subdir(get_ref_dir(refs->loose),
-							      "refs/", 1)));
+				search_for_subdir(get_ref_dir(refs->loose),
+						  "refs/", 1));
 	}
 	return get_ref_dir(refs->loose);
 }
-- 
1.7.10
