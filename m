From: mhagger@alum.mit.edu
Subject: [PATCH 23/28] struct ref_dir: store a reference to the enclosing ref_cache
Date: Fri, 28 Oct 2011 14:28:36 +0200
Message-ID: <1319804921-17545-24-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:32:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlbi-0005AX-HZ
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447Ab1J1McQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:32:16 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:55977 "EHLO
	homer.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932387Ab1J1McO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:32:14 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-RK; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184401>

From: Michael Haggerty <mhagger@alum.mit.edu>

This means that it contains enough information to serve as the sole
argument to get_ref_dir(), which will be changed in the next commit.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 98c8569..6b2b2f6 100644
--- a/refs.c
+++ b/refs.c
@@ -143,6 +143,8 @@ struct ref_value {
 	unsigned char peeled[20];
 };
 
+struct ref_cache;
+
 struct ref_dir {
 	int nr, alloc;
 
@@ -150,6 +152,12 @@ struct ref_dir {
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
@@ -261,7 +269,8 @@ static void clear_ref_dir(struct ref_dir *dir)
  * dirname is the name of the directory with a trailing slash (e.g.,
  * "refs/heads/") or "" for the top-level directory.
  */
-static struct ref_entry *create_dir_entry(const char *dirname)
+static struct ref_entry *create_dir_entry(struct ref_cache *ref_cache,
+					  const char *dirname)
 {
 	struct ref_entry *direntry;
 	if (*dirname) {
@@ -275,6 +284,7 @@ static struct ref_entry *create_dir_entry(const char *dirname)
 		direntry->name[0] = '\0';
 	}
 	direntry->flag = REF_DIR;
+	direntry->u.subdir.ref_cache = ref_cache;
 	return direntry;
 }
 
@@ -354,7 +364,8 @@ static struct ref_entry *find_containing_direntry(struct ref_entry *direntry,
 				direntry = NULL;
 				break;
 			}
-			entry = create_dir_entry(refname_copy);
+			entry = create_dir_entry(direntry->u.subdir.ref_cache,
+						 refname_copy);
 			add_entry(direntry, entry);
 		}
 		slash[1] = tmp;
@@ -771,7 +782,7 @@ static void read_packed_refs(FILE *f, struct ref_entry *direntry)
 void add_extra_ref(const char *refname, const unsigned char *sha1, int flag)
 {
 	if (!extra_refs)
-		extra_refs = create_dir_entry("");
+		extra_refs = create_dir_entry(NULL, "");
 	add_ref(extra_refs, create_ref_entry(refname, sha1, flag));
 }
 
@@ -789,7 +800,7 @@ static struct ref_entry *get_packed_refs(struct ref_cache *refs)
 		const char *packed_refs_file;
 		FILE *f;
 
-		refs->packed = create_dir_entry("");
+		refs->packed = create_dir_entry(refs, "");
 		if (*refs->name)
 			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
 		else
@@ -881,7 +892,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname)
 static struct ref_entry *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->loose) {
-		refs->loose = create_dir_entry("");
+		refs->loose = create_dir_entry(refs, "");
 		get_ref_dir(refs, "refs/");
 	}
 	return refs->loose;
-- 
1.7.7
