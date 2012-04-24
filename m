From: mhagger@alum.mit.edu
Subject: [PATCH 01/30] get_ref_dir(): return early if directory cannot be read
Date: Wed, 25 Apr 2012 00:45:07 +0200
Message-ID: <1335307536-26914-2-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:52:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMoau-00059D-0z
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758134Ab2DXWwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:52:00 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:48854 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758087Ab2DXWv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:51:57 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 44B9324813F;
	Wed, 25 Apr 2012 00:45:50 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196260>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   85 +++++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/refs.c b/refs.c
index 09322fe..d539241 100644
--- a/refs.c
+++ b/refs.c
@@ -754,6 +754,9 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 {
 	DIR *d;
 	const char *path;
+	struct dirent *de;
+	int baselen;
+	char *refname;
 
 	if (*refs->name)
 		path = git_path_submodule(refs->name, "%s", base);
@@ -761,55 +764,55 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 		path = git_path("%s", base);
 
 	d = opendir(path);
-	if (d) {
-		struct dirent *de;
-		int baselen = strlen(base);
-		char *refname = xmalloc(baselen + 257);
+	if (!d)
+		return;
 
-		memcpy(refname, base, baselen);
-		if (baselen && base[baselen-1] != '/')
-			refname[baselen++] = '/';
+	baselen = strlen(base);
+	refname = xmalloc(baselen + 257);
 
-		while ((de = readdir(d)) != NULL) {
-			unsigned char sha1[20];
-			struct stat st;
-			int flag;
-			int namelen;
-			const char *refdir;
+	memcpy(refname, base, baselen);
+	if (baselen && base[baselen-1] != '/')
+		refname[baselen++] = '/';
 
-			if (de->d_name[0] == '.')
-				continue;
-			namelen = strlen(de->d_name);
-			if (namelen > 255)
-				continue;
-			if (has_extension(de->d_name, ".lock"))
-				continue;
-			memcpy(refname + baselen, de->d_name, namelen+1);
-			refdir = *refs->name
-				? git_path_submodule(refs->name, "%s", refname)
-				: git_path("%s", refname);
-			if (stat(refdir, &st) < 0)
-				continue;
-			if (S_ISDIR(st.st_mode)) {
-				get_ref_dir(refs, refname, dir);
-				continue;
-			}
-			if (*refs->name) {
-				hashclr(sha1);
-				flag = 0;
-				if (resolve_gitlink_ref(refs->name, refname, sha1) < 0) {
-					hashclr(sha1);
-					flag |= REF_ISBROKEN;
-				}
-			} else if (read_ref_full(refname, sha1, 1, &flag)) {
+	while ((de = readdir(d)) != NULL) {
+		unsigned char sha1[20];
+		struct stat st;
+		int flag;
+		int namelen;
+		const char *refdir;
+
+		if (de->d_name[0] == '.')
+			continue;
+		namelen = strlen(de->d_name);
+		if (namelen > 255)
+			continue;
+		if (has_extension(de->d_name, ".lock"))
+			continue;
+		memcpy(refname + baselen, de->d_name, namelen+1);
+		refdir = *refs->name
+			? git_path_submodule(refs->name, "%s", refname)
+			: git_path("%s", refname);
+		if (stat(refdir, &st) < 0)
+			continue;
+		if (S_ISDIR(st.st_mode)) {
+			get_ref_dir(refs, refname, dir);
+			continue;
+		}
+		if (*refs->name) {
+			hashclr(sha1);
+			flag = 0;
+			if (resolve_gitlink_ref(refs->name, refname, sha1) < 0) {
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
-			add_ref(dir, create_ref_entry(refname, sha1, flag, 1));
+		} else if (read_ref_full(refname, sha1, 1, &flag)) {
+			hashclr(sha1);
+			flag |= REF_ISBROKEN;
 		}
-		free(refname);
-		closedir(d);
+		add_ref(dir, create_ref_entry(refname, sha1, flag, 1));
 	}
+	free(refname);
+	closedir(d);
 }
 
 static struct ref_dir *get_loose_refs(struct ref_cache *refs)
-- 
1.7.10
