From: mhagger@alum.mit.edu
Subject: [PATCH 10/28] get_ref_dir(): keep track of the current ref_dir
Date: Fri, 28 Oct 2011 14:28:23 +0200
Message-ID: <1319804921-17545-11-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:31:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlb1-0004nM-B8
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719Ab1J1Mbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:31:36 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55872 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932685Ab1J1Mbe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:31:34 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-JK; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184392>

From: Michael Haggerty <mhagger@alum.mit.edu>

Look up the ref_dir that will hold the new entries once at the start
of processing of a directory.  This eliminates the need to search down
the reference tree to find the place to put each new reference.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   43 ++++++++++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index 515b44c..bdd90c5 100644
--- a/refs.c
+++ b/refs.c
@@ -775,29 +775,36 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 	return &refs->packed;
 }
 
-static void get_ref_dir(struct ref_cache *refs, const char *base,
-			struct ref_dir *dir)
+/*
+ * dirname must match the name associated with dir; in particular, it
+ * must end with '/'.
+ */
+static void get_ref_dir(struct ref_cache *refs, const char *dirname)
 {
 	DIR *d;
-	const char *path;
+	char *path;
+	int dirnamelen = strlen(dirname);
+	int pathlen;
+	struct ref_dir *dir;
+
+	assert(dirnamelen && dirname[dirnamelen - 1] == '/');
+
+	dir = find_containing_dir(&refs->loose, dirname, 1);
 
 	if (*refs->name)
-		path = git_path_submodule(refs->name, "%s", base);
+		path = git_path_submodule(refs->name, "%s", dirname);
 	else
-		path = git_path("%s", base);
-
+		path = git_path("%s", dirname);
+	pathlen = strlen(path);
+	assert(pathlen && path[pathlen - 1] == '/');
+	path[pathlen - 1] = '\0';
 
 	d = opendir(path);
 
 	if (d) {
 		struct dirent *de;
-		int baselen = strlen(base);
-		char *refname = xmalloc(baselen + 257);
-
-		memcpy(refname, base, baselen);
-		if (baselen && base[baselen-1] != '/')
-			refname[baselen++] = '/';
-
+		char *refname = xmalloc(dirnamelen + 257);
+		memcpy(refname, dirname, dirnamelen);
 		while ((de = readdir(d)) != NULL) {
 			unsigned char sha1[20];
 			struct stat st;
@@ -812,14 +819,16 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 				continue;
 			if (has_extension(de->d_name, ".lock"))
 				continue;
-			memcpy(refname + baselen, de->d_name, namelen+1);
+			memcpy(refname + dirnamelen, de->d_name, namelen+1);
 			refdir = *refs->name
 				? git_path_submodule(refs->name, "%s", refname)
 				: git_path("%s", refname);
 			if (stat(refdir, &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
-				get_ref_dir(refs, refname, dir);
+				refname[dirnamelen + namelen] = '/';
+				refname[dirnamelen + namelen + 1] = '\0';
+				get_ref_dir(refs, refname);
 				continue;
 			}
 			if (*refs->name) {
@@ -834,7 +843,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 					hashclr(sha1);
 					flag |= REF_ISBROKEN;
 				}
-			add_ref(dir, create_ref_entry(refname, sha1, flag));
+			add_entry_to_dir(dir, create_ref_entry(refname, sha1, flag));
 		}
 		free(refname);
 		closedir(d);
@@ -844,7 +853,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->did_loose) {
-		get_ref_dir(refs, "refs", &refs->loose);
+		get_ref_dir(refs, "refs/");
 		refs->did_loose = 1;
 	}
 	return &refs->loose;
-- 
1.7.7
