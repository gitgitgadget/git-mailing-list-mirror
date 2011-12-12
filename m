From: mhagger@alum.mit.edu
Subject: [PATCH v2 47/51] read_loose_refs(): take a (ref_entry *) as argument
Date: Mon, 12 Dec 2011 06:38:54 +0100
Message-ID: <1323668338-1764-48-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:41:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZyeD-00015m-Id
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936Ab1LLFlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:41:09 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:35026 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084Ab1LLFlC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:41:02 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8b0015577;
	Mon, 12 Dec 2011 06:40:53 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186867>

From: Michael Haggerty <mhagger@alum.mit.edu>

Rename get_ref_dir() to read_loose_refs(), and change its signature.
This is another step towards reading loose references one directory
at a time.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 4088167..a85a8a5 100644
--- a/refs.c
+++ b/refs.c
@@ -770,21 +770,20 @@ static struct ref_entry *get_packed_refs(struct ref_cache *refs)
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
@@ -822,7 +821,9 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname)
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
@@ -847,7 +848,7 @@ static struct ref_entry *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->loose) {
 		refs->loose = create_dir_entry(refs, "");
-		get_ref_dir(refs, "refs/");
+		read_loose_refs(find_containing_direntry(refs->loose, "refs/", 1));
 	}
 	return refs->loose;
 }
-- 
1.7.8
