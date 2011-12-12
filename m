From: mhagger@alum.mit.edu
Subject: [PATCH v2 10/51] get_ref_dir(): change signature
Date: Mon, 12 Dec 2011 06:38:17 +0100
Message-ID: <1323668338-1764-11-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:40:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZyca-0000Sq-Qs
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539Ab1LLFj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:39:57 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34597 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab1LLFjr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:39:47 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aN015577;
	Mon, 12 Dec 2011 06:39:31 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186836>

From: Michael Haggerty <mhagger@alum.mit.edu>

Change get_ref_dir() to take a (struct ref_cache *) in place of the
submodule name.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index c62c682..91ec395 100644
--- a/refs.c
+++ b/refs.c
@@ -298,14 +298,14 @@ static struct ref_array *get_packed_refs(struct ref_cache *refs)
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
 
@@ -336,19 +336,19 @@ static void get_ref_dir(const char *submodule, const char *base,
 			if (has_extension(de->d_name, ".lock"))
 				continue;
 			memcpy(refname + baselen, de->d_name, namelen+1);
-			refdir = submodule
-				? git_path_submodule(submodule, "%s", refname)
+			refdir = *refs->name
+				? git_path_submodule(refs->name, "%s", refname)
 				: git_path("%s", refname);
 			if (stat(refdir, &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
-				get_ref_dir(submodule, refname, array);
+				get_ref_dir(refs, refname, array);
 				continue;
 			}
-			if (submodule) {
+			if (*refs->name) {
 				hashclr(sha1);
 				flag = 0;
-				if (resolve_gitlink_ref(submodule, refname, sha1) < 0) {
+				if (resolve_gitlink_ref(refs->name, refname, sha1) < 0) {
 					hashclr(sha1);
 					flag |= REF_ISBROKEN;
 				}
@@ -400,7 +400,7 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 static struct ref_array *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->did_loose) {
-		get_ref_dir(refs->name, "refs", &refs->loose);
+		get_ref_dir(refs, "refs", &refs->loose);
 		sort_ref_array(&refs->loose);
 		refs->did_loose = 1;
 	}
-- 
1.7.8
