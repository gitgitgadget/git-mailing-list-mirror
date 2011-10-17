From: mhagger@alum.mit.edu
Subject: [PATCH v2 11/14] get_ref_dir(): change signature
Date: Mon, 17 Oct 2011 09:39:20 +0200
Message-ID: <1318837163-27112-12-git-send-email-mhagger@alum.mit.edu>
References: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 09:40:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFhnl-0007mH-9i
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 09:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964Ab1JQHju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 03:39:50 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:33648 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754943Ab1JQHjt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 03:39:49 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RFhhh-0000eM-BI; Mon, 17 Oct 2011 09:33:45 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183779>

From: Michael Haggerty <mhagger@alum.mit.edu>

Change get_ref_dir() to take a (struct ref_cache *) in place of the
submodule name.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 9051b9f..01f6c4b 100644
--- a/refs.c
+++ b/refs.c
@@ -300,14 +300,14 @@ static struct ref_array *get_packed_refs(struct ref_cache *refs)
 	return &refs->packed;
 }
 
-static void get_ref_dir(const char *submodule, const char *base,
+static void get_ref_dir(struct ref_cache *refs, const char *base,
 			struct ref_array *array)
 {
 	DIR *dir;
 	const char *path;
 
-	if (*submodule)
-		path = git_path_submodule(submodule, "%s", base);
+	if (*refs->name)
+		path = git_path_submodule(refs->name, "%s", base);
 	else
 		path = git_path("%s", base);
 
@@ -338,19 +338,19 @@ static void get_ref_dir(const char *submodule, const char *base,
 			if (has_extension(de->d_name, ".lock"))
 				continue;
 			memcpy(ref + baselen, de->d_name, namelen+1);
-			refdir = submodule
-				? git_path_submodule(submodule, "%s", ref)
+			refdir = *refs->name
+				? git_path_submodule(refs->name, "%s", ref)
 				: git_path("%s", ref);
 			if (stat(refdir, &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
-				get_ref_dir(submodule, ref, array);
+				get_ref_dir(refs, ref, array);
 				continue;
 			}
-			if (submodule) {
+			if (*refs->name) {
 				hashclr(sha1);
 				flag = 0;
-				if (resolve_gitlink_ref(submodule, ref, sha1) < 0) {
+				if (resolve_gitlink_ref(refs->name, ref, sha1) < 0) {
 					hashclr(sha1);
 					flag |= REF_BROKEN;
 				}
@@ -403,7 +403,7 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 static struct ref_array *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->did_loose) {
-		get_ref_dir(refs->name, "refs", &refs->loose);
+		get_ref_dir(refs, "refs", &refs->loose);
 		sort_ref_array(&refs->loose);
 		refs->did_loose = 1;
 	}
-- 
1.7.7.rc2
