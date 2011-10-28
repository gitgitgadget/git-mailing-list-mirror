From: mhagger@alum.mit.edu
Subject: [PATCH v3 13/14] Pass a (ref_cache *) to the resolve_gitlink_*() helper functions
Date: Fri, 28 Oct 2011 13:14:40 +0200
Message-ID: <1319800481-15138-14-git-send-email-mhagger@alum.mit.edu>
References: <1319800481-15138-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 13:21:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJkVG-0007n0-Fv
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 13:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242Ab1J1LVC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 07:21:02 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:54860 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932262Ab1J1LVA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 07:21:00 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJkIZ-00076m-BO; Fri, 28 Oct 2011 13:08:31 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319800481-15138-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184356>

From: Michael Haggerty <mhagger@alum.mit.edu>

And remove some redundant arguments from resolve_gitlink_packed_ref().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/refs.c b/refs.c
index 7d58ef9..1867ff0 100644
--- a/refs.c
+++ b/refs.c
@@ -415,30 +415,25 @@ static struct ref_array *get_loose_refs(struct ref_cache *refs)
 
 /*
  * Called by resolve_gitlink_ref_recursive() after it failed to read
- * from "name", which is "module/.git/<refname>". Find <refname> in
- * the packed-refs file for the submodule.
+ * from the loose refs in ref_cache refs. Find <refname> in the
+ * packed-refs file for the submodule.
  */
-static int resolve_gitlink_packed_ref(char *name, int pathlen,
+static int resolve_gitlink_packed_ref(struct ref_cache *refs,
 				      const char *refname, unsigned char *sha1)
 {
-	int retval = -1;
 	struct ref_entry *ref;
-	struct ref_array *array;
+	struct ref_array *array = get_packed_refs(refs);
 
-	/* being defensive: resolve_gitlink_ref() did this for us */
-	if (pathlen < 6 || memcmp(name + pathlen - 6, "/.git/", 6))
-		die("Oops");
-	name[pathlen - 6] = '\0'; /* make it path to the submodule */
-	array = get_packed_refs(get_ref_cache(name));
 	ref = search_ref_array(array, refname);
-	if (ref != NULL) {
-		memcpy(sha1, ref->sha1, 20);
-		retval = 0;
-	}
-	return retval;
+	if (ref == NULL)
+		return -1;
+
+	memcpy(sha1, ref->sha1, 20);
+	return 0;
 }
 
-static int resolve_gitlink_ref_recursive(char *name, int pathlen,
+static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
+					 char *name, int pathlen,
 					 const char *refname, unsigned char *sha1,
 					 int recursion)
 {
@@ -450,7 +445,7 @@ static int resolve_gitlink_ref_recursive(char *name, int pathlen,
 	memcpy(name + pathlen, refname, len+1);
 	fd = open(name, O_RDONLY);
 	if (fd < 0)
-		return resolve_gitlink_packed_ref(name, pathlen, refname, sha1);
+		return resolve_gitlink_packed_ref(refs, refname, sha1);
 
 	len = read(fd, buffer, sizeof(buffer)-1);
 	close(fd);
@@ -471,19 +466,24 @@ static int resolve_gitlink_ref_recursive(char *name, int pathlen,
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
+	struct ref_cache *refs;
 	const char *tmp;
 
 	while (len && path[len-1] == '/')
 		len--;
 	if (!len)
 		return -1;
+	submodule = xstrndup(path, len);
+	refs = get_ref_cache(submodule);
+	free(submodule);
+
 	gitdir = xmalloc(len + MAXREFLEN + 8);
 	memcpy(gitdir, path, len);
 	memcpy(gitdir + len, "/.git", 6);
@@ -498,7 +498,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 	}
 	gitdir[len] = '/';
 	gitdir[++len] = '\0';
-	retval = resolve_gitlink_ref_recursive(gitdir, len, refname, sha1, 0);
+	retval = resolve_gitlink_ref_recursive(refs, gitdir, len, refname, sha1, 0);
 	free(gitdir);
 	return retval;
 }
-- 
1.7.7
