From: mhagger@alum.mit.edu
Subject: [PATCH v2 46/51] struct ref_dir: store a reference to the enclosing ref_cache
Date: Mon, 12 Dec 2011 06:38:53 +0100
Message-ID: <1323668338-1764-47-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:41:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZydX-0000k3-Kb
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355Ab1LLFlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:41:07 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:35016 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab1LLFlB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:41:01 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8ax015577;
	Mon, 12 Dec 2011 06:40:52 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186861>

From: Michael Haggerty <mhagger@alum.mit.edu>

This means that it contains enough information to serve as the sole
argument to get_ref_dir(), which will be changed in the next commit.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 4a3546b..4088167 100644
--- a/refs.c
+++ b/refs.c
@@ -106,6 +106,8 @@ struct ref_value {
 	unsigned char peeled[20];
 };
 
+struct ref_cache;
+
 struct ref_dir {
 	int nr, alloc;
 
@@ -113,6 +115,12 @@ struct ref_dir {
 	int sorted;
 
 	struct ref_entry **entries;
+
+	/*
+	 * A pointer to the ref_cache that contains this ref_dir, or
+	 * NULL if this ref_dir is used for extra_refs.
+	 */
+	struct ref_cache *ref_cache;
 };
 
 /* ISSYMREF=0x01, ISPACKED=0x02, and ISBROKEN=0x04 are public interfaces */
@@ -226,13 +234,15 @@ static void clear_ref_dir(struct ref_dir *dir)
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
 
@@ -312,7 +322,8 @@ static struct ref_entry *find_containing_direntry(struct ref_entry *direntry,
 				direntry = NULL;
 				break;
 			}
-			entry = create_dir_entry(refname_copy);
+			entry = create_dir_entry(direntry->u.subdir.ref_cache,
+						 refname_copy);
 			add_entry(direntry, entry);
 		}
 		slash[1] = tmp;
@@ -726,7 +737,7 @@ static void read_packed_refs(FILE *f, struct ref_entry *direntry)
 void add_extra_ref(const char *refname, const unsigned char *sha1, int flag)
 {
 	if (!extra_refs)
-		extra_refs = create_dir_entry("");
+		extra_refs = create_dir_entry(NULL, "");
 	add_ref(extra_refs, create_ref_entry(refname, sha1, flag, 0));
 }
 
@@ -744,7 +755,7 @@ static struct ref_entry *get_packed_refs(struct ref_cache *refs)
 		const char *packed_refs_file;
 		FILE *f;
 
-		refs->packed = create_dir_entry("");
+		refs->packed = create_dir_entry(refs, "");
 		if (*refs->name)
 			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
 		else
@@ -835,7 +846,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname)
 static struct ref_entry *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->loose) {
-		refs->loose = create_dir_entry("");
+		refs->loose = create_dir_entry(refs, "");
 		get_ref_dir(refs, "refs/");
 	}
 	return refs->loose;
-- 
1.7.8
