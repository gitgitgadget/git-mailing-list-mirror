From: mhagger@alum.mit.edu
Subject: [PATCH v2 13/51] resolve_gitlink_ref_recursive(): change to work with struct ref_cache
Date: Mon, 12 Dec 2011 06:38:20 +0100
Message-ID: <1323668338-1764-14-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:40:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZycc-0000Sq-HO
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606Ab1LLFkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:03 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34624 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab1LLFjy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:39:54 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aQ015577;
	Mon, 12 Dec 2011 06:39:39 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186844>

From: Michael Haggerty <mhagger@alum.mit.edu>

resolve_gitlink_ref() and resolve_gitlink_ref_recursive(), together,
basically duplicated the code in git_path_submodule().  So use that
function instead.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   34 ++++++++++------------------------
 1 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index bf1f164..ba7a8b0 100644
--- a/refs.c
+++ b/refs.c
@@ -431,17 +431,19 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
 }
 
 static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
-					 char *name, int pathlen,
 					 const char *refname, unsigned char *sha1,
 					 int recursion)
 {
-	int fd, len = strlen(refname);
+	int fd, len;
 	char buffer[128], *p;
+	char *path;
 
-	if (recursion > MAXDEPTH || len > MAXREFLEN)
+	if (recursion > MAXDEPTH || strlen(refname) > MAXREFLEN)
 		return -1;
-	memcpy(name + pathlen, refname, len+1);
-	fd = open(name, O_RDONLY);
+	path = *refs->name
+		? git_path_submodule(refs->name, "%s", refname)
+		: git_path("%s", refname);
+	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		return resolve_gitlink_packed_ref(refs, refname, sha1);
 
@@ -464,15 +466,14 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 	while (isspace(*p))
 		p++;
 
-	return resolve_gitlink_ref_recursive(refs, name, pathlen, p, sha1, recursion+1);
+	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
 }
 
 int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
 {
 	int len = strlen(path), retval;
-	char *submodule, *gitdir;
+	char *submodule;
 	struct ref_cache *refs;
-	const char *tmp;
 
 	while (len && path[len-1] == '/')
 		len--;
@@ -482,22 +483,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 	refs = get_ref_cache(submodule);
 	free(submodule);
 
-	gitdir = xmalloc(len + MAXREFLEN + 8);
-	memcpy(gitdir, path, len);
-	memcpy(gitdir + len, "/.git", 6);
-	len += 5;
-
-	tmp = read_gitfile(gitdir);
-	if (tmp) {
-		free(gitdir);
-		len = strlen(tmp);
-		gitdir = xmalloc(len + MAXREFLEN + 3);
-		memcpy(gitdir, tmp, len);
-	}
-	gitdir[len] = '/';
-	gitdir[++len] = '\0';
-	retval = resolve_gitlink_ref_recursive(refs, gitdir, len, refname, sha1, 0);
-	free(gitdir);
+	retval = resolve_gitlink_ref_recursive(refs, refname, sha1, 0);
 	return retval;
 }
 
-- 
1.7.8
