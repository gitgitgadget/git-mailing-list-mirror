From: mhagger@alum.mit.edu
Subject: [PATCH 13/14] Pass a (cached_refs *) to the resolve_gitlink_*() functions
Date: Thu, 13 Oct 2011 09:58:34 +0200
Message-ID: <1318492715-5931-14-git-send-email-mhagger@alum.mit.edu>
References: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 10:00:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REGCx-0002Fc-4Y
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 10:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699Ab1JMH76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 03:59:58 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:34464 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab1JMH75 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 03:59:57 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1REG6O-0002Mo-V4; Thu, 13 Oct 2011 09:53:16 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183460>

From: Michael Haggerty <mhagger@alum.mit.edu>

And remove some redundant arguments from resolve_gitlink_packed_ref().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 01b8efd..8776195 100644
--- a/refs.c
+++ b/refs.c
@@ -414,12 +414,12 @@ static struct ref_array *get_loose_refs(struct cached_refs *refs)
 #define MAXDEPTH 5
 #define MAXREFLEN (1024)
 
-static int resolve_gitlink_packed_ref(char *name, int pathlen,
+static int resolve_gitlink_packed_ref(struct cached_refs *refs,
 				      const char *refname, unsigned char *sha1)
 {
 	int retval = -1;
 	struct ref_entry *ref;
-	struct ref_array *array = get_packed_refs(get_cached_refs(name));
+	struct ref_array *array = get_packed_refs(refs);
 
 	ref = search_ref_array(array, refname);
 	if (ref != NULL) {
@@ -429,7 +429,8 @@ static int resolve_gitlink_packed_ref(char *name, int pathlen,
 	return retval;
 }
 
-static int resolve_gitlink_ref_recursive(char *name, int pathlen,
+static int resolve_gitlink_ref_recursive(struct cached_refs *refs,
+					 char *name, int pathlen,
 					 const char *refname, unsigned char *sha1,
 					 int recursion)
 {
@@ -441,7 +442,7 @@ static int resolve_gitlink_ref_recursive(char *name, int pathlen,
 	memcpy(name + pathlen, refname, len+1);
 	fd = open(name, O_RDONLY);
 	if (fd < 0)
-		return resolve_gitlink_packed_ref(name, pathlen, refname, sha1);
+		return resolve_gitlink_packed_ref(refs, refname, sha1);
 
 	len = read(fd, buffer, sizeof(buffer)-1);
 	close(fd);
@@ -462,19 +463,24 @@ static int resolve_gitlink_ref_recursive(char *name, int pathlen,
 	while (isspace(*p))
 		p++;
 
-	return resolve_gitlink_ref_recursive(name, pathlen, p, sha1, recursion+1);
+	return resolve_gitlink_ref_recursive(refs, name, pathlen, p, sha1, recursion+1);
 }
 
 int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
 {
 	int len = strlen(path), retval;
-	char *gitdir;
+	char *submodule, *gitdir;
+	struct cached_refs *refs;
 	const char *tmp;
 
 	while (len && path[len-1] == '/')
 		len--;
 	if (!len)
 		return -1;
+	submodule = xstrndup(path, len);
+	refs = get_cached_refs(submodule);
+	free(submodule);
+
 	gitdir = xmalloc(len + MAXREFLEN + 8);
 	memcpy(gitdir, path, len);
 	memcpy(gitdir + len, "/.git", 6);
@@ -489,7 +495,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 	}
 	gitdir[len] = '/';
 	gitdir[++len] = '\0';
-	retval = resolve_gitlink_ref_recursive(gitdir, len, refname, sha1, 0);
+	retval = resolve_gitlink_ref_recursive(refs, gitdir, len, refname, sha1, 0);
 	free(gitdir);
 	return retval;
 }
-- 
1.7.7.rc2
