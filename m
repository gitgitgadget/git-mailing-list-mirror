From: mhagger@alum.mit.edu
Subject: [PATCH 24/28] read_loose_refs(): take a (ref_entry *) as argument
Date: Fri, 28 Oct 2011 14:28:37 +0200
Message-ID: <1319804921-17545-25-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:31:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlae-0004ci-6l
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682Ab1J1Mas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:30:48 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55798 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932499Ab1J1Mas (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:30:48 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-SB; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184387>

From: Michael Haggerty <mhagger@alum.mit.edu>

Rename get_ref_dir() to read_loose_refs(), and change its signature.
This is another step towards reading loose references one directory
at a time.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 6b2b2f6..f3910de 100644
--- a/refs.c
+++ b/refs.c
@@ -815,21 +815,20 @@ static struct ref_entry *get_packed_refs(struct ref_cache *refs)
 }
 
 /*
- * dirname must match the name associated with dir; in particular, it
- * must end with '/'.
+ * Fill direntry with loose references read from the filesystem.
  */
-static void get_ref_dir(struct ref_cache *refs, const char *dirname)
+static void read_loose_refs(struct ref_entry *direntry)
 {
 	DIR *d;
 	char *path;
+	char *dirname = direntry->name;
 	int dirnamelen = strlen(dirname);
 	int pathlen;
-	struct ref_entry *direntry;
-
-	assert(dirnamelen && dirname[dirnamelen - 1] == '/');
-
-	direntry = find_containing_direntry(refs->loose, dirname, 1);
+	struct ref_cache *refs;
 
+	assert(direntry->flag & REF_DIR);
+	assert(dirnamelen && direntry->name[dirnamelen - 1] == '/');
+	refs = direntry->u.subdir.ref_cache;
 	if (*refs->name)
 		path = git_path_submodule(refs->name, "%s", dirname);
 	else
@@ -867,7 +866,9 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname)
 			if (S_ISDIR(st.st_mode)) {
 				refname[dirnamelen + namelen] = '/';
 				refname[dirnamelen + namelen + 1] = '\0';
-				get_ref_dir(refs, refname);
+				read_loose_refs(find_containing_direntry(
+								refs->loose,
+								refname, 1));
 				continue;
 			}
 			if (*refs->name) {
@@ -893,7 +894,7 @@ static struct ref_entry *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->loose) {
 		refs->loose = create_dir_entry(refs, "");
-		get_ref_dir(refs, "refs/");
+		read_loose_refs(find_containing_direntry(refs->loose, "refs/", 1));
 	}
 	return refs->loose;
 }
-- 
1.7.7
