From: mhagger@alum.mit.edu
Subject: [PATCH v2 33/51] get_ref_dir(): keep track of the current ref_dir
Date: Mon, 12 Dec 2011 06:38:40 +0100
Message-ID: <1323668338-1764-34-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:41:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZyeD-00015m-0m
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896Ab1LLFki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:38 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34850 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab1LLFkf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:35 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8ak015577;
	Mon, 12 Dec 2011 06:40:25 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186866>

From: Michael Haggerty <mhagger@alum.mit.edu>

Look up the ref_dir that will hold the new entries once at the start
of processing of a directory.  This eliminates the need to search down
the reference tree to find the place to put each new reference.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   43 ++++++++++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index 6a11235..6912db3 100644
--- a/refs.c
+++ b/refs.c
@@ -730,29 +730,36 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
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
@@ -767,14 +774,16 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
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
@@ -788,7 +797,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
-			add_ref(dir, create_ref_entry(refname, sha1, flag, 1));
+			add_entry_to_dir(dir, create_ref_entry(refname, sha1, flag, 1));
 		}
 		free(refname);
 		closedir(d);
@@ -798,7 +807,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->did_loose) {
-		get_ref_dir(refs, "refs", &refs->loose);
+		get_ref_dir(refs, "refs/");
 		refs->did_loose = 1;
 	}
 	return &refs->loose;
-- 
1.7.8
