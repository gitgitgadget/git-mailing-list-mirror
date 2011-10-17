From: mhagger@alum.mit.edu
Subject: [PATCH v2 14/14] resolve_gitlink_ref_recursive(): change to work with struct ref_cache
Date: Mon, 17 Oct 2011 09:39:23 +0200
Message-ID: <1318837163-27112-15-git-send-email-mhagger@alum.mit.edu>
References: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 09:40:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFhoY-0008BI-DP
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 09:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933Ab1JQHkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 03:40:46 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:33703 "EHLO
	homer.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755108Ab1JQHkq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 03:40:46 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RFhhn-0000eM-E9; Mon, 17 Oct 2011 09:33:51 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183785>

From: Michael Haggerty <mhagger@alum.mit.edu>

resolve_gitlink_ref() and resolve_gitlink_ref_recursive(), together,
basically duplicated the code in git_path_submodule().  So use that
function instead.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   34 ++++++++++------------------------
 1 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index 984f2f7..7e6cea5 100644
--- a/refs.c
+++ b/refs.c
@@ -430,17 +430,19 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
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
 
@@ -463,15 +465,14 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
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
@@ -481,22 +482,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
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
1.7.7.rc2
