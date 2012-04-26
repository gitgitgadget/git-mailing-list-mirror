From: mhagger@alum.mit.edu
Subject: [PATCH v2 02/18] get_ref_dir(): use a strbuf to hold refname
Date: Fri, 27 Apr 2012 00:26:51 +0200
Message-ID: <1335479227-7877-3-git-send-email-mhagger@alum.mit.edu>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:28:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNXAU-0008VY-Vq
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759540Ab2DZW2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 18:28:01 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:37053 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759377Ab2DZW1P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 18:27:15 -0400
Received: from michael.berlin.jpk.com (michael2.berlin.jpk.com [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 3567C248140;
	Fri, 27 Apr 2012 00:27:14 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196439>

From: Michael Haggerty <mhagger@alum.mit.edu>

This simplifies the bookkeeping and allows an (artificial) restriction
on refname component length to be removed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   54 ++++++++++++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/refs.c b/refs.c
index d539241..df98622 100644
--- a/refs.c
+++ b/refs.c
@@ -756,7 +756,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 	const char *path;
 	struct dirent *de;
 	int baselen;
-	char *refname;
+	struct strbuf refname;
 
 	if (*refs->name)
 		path = git_path_submodule(refs->name, "%s", base);
@@ -768,50 +768,48 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 		return;
 
 	baselen = strlen(base);
-	refname = xmalloc(baselen + 257);
-
-	memcpy(refname, base, baselen);
-	if (baselen && base[baselen-1] != '/')
-		refname[baselen++] = '/';
+	strbuf_init(&refname, baselen + 257);
+	strbuf_add(&refname, base, baselen);
+	if (baselen && base[baselen-1] != '/') {
+		strbuf_addch(&refname, '/');
+		baselen++;
+	}
 
 	while ((de = readdir(d)) != NULL) {
 		unsigned char sha1[20];
 		struct stat st;
 		int flag;
-		int namelen;
 		const char *refdir;
 
 		if (de->d_name[0] == '.')
 			continue;
-		namelen = strlen(de->d_name);
-		if (namelen > 255)
-			continue;
 		if (has_extension(de->d_name, ".lock"))
 			continue;
-		memcpy(refname + baselen, de->d_name, namelen+1);
+		strbuf_addstr(&refname, de->d_name);
 		refdir = *refs->name
-			? git_path_submodule(refs->name, "%s", refname)
-			: git_path("%s", refname);
-		if (stat(refdir, &st) < 0)
-			continue;
-		if (S_ISDIR(st.st_mode)) {
-			get_ref_dir(refs, refname, dir);
-			continue;
-		}
-		if (*refs->name) {
-			hashclr(sha1);
-			flag = 0;
-			if (resolve_gitlink_ref(refs->name, refname, sha1) < 0) {
+			? git_path_submodule(refs->name, "%s", refname.buf)
+			: git_path("%s", refname.buf);
+		if (stat(refdir, &st) < 0) {
+			/* Silently ignore. */
+		} else if (S_ISDIR(st.st_mode)) {
+			get_ref_dir(refs, refname.buf, dir);
+		} else {
+			if (*refs->name) {
+				hashclr(sha1);
+				flag = 0;
+				if (resolve_gitlink_ref(refs->name, refname.buf, sha1) < 0) {
+					hashclr(sha1);
+					flag |= REF_ISBROKEN;
+				}
+			} else if (read_ref_full(refname.buf, sha1, 1, &flag)) {
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
-		} else if (read_ref_full(refname, sha1, 1, &flag)) {
-			hashclr(sha1);
-			flag |= REF_ISBROKEN;
+			add_ref(dir, create_ref_entry(refname.buf, sha1, flag, 1));
 		}
-		add_ref(dir, create_ref_entry(refname, sha1, flag, 1));
+		strbuf_setlen(&refname, baselen);
 	}
-	free(refname);
+	strbuf_release(&refname);
 	closedir(d);
 }
 
-- 
1.7.10
