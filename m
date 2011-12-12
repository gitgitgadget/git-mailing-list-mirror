From: mhagger@alum.mit.edu
Subject: [PATCH v2 12/51] Pass a (ref_cache *) to the resolve_gitlink_*() helper functions
Date: Mon, 12 Dec 2011 06:38:19 +0100
Message-ID: <1323668338-1764-13-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:40:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZycb-0000Sq-WB
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab1LLFkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:00 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34618 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab1LLFjy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:39:54 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aP015577;
	Mon, 12 Dec 2011 06:39:36 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186835>

From: Michael Haggerty <mhagger@alum.mit.edu>

And remove some redundant arguments from resolve_gitlink_packed_ref().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/refs.c b/refs.c
index 91ec395..bf1f164 100644
--- a/refs.c
+++ b/refs.c
@@ -413,30 +413,25 @@ static struct ref_array *get_loose_refs(struct ref_cache *refs)
 
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
@@ -448,7 +443,7 @@ static int resolve_gitlink_ref_recursive(char *name, int pathlen,
 	memcpy(name + pathlen, refname, len+1);
 	fd = open(name, O_RDONLY);
 	if (fd < 0)
-		return resolve_gitlink_packed_ref(name, pathlen, refname, sha1);
+		return resolve_gitlink_packed_ref(refs, refname, sha1);
 
 	len = read(fd, buffer, sizeof(buffer)-1);
 	close(fd);
@@ -469,19 +464,24 @@ static int resolve_gitlink_ref_recursive(char *name, int pathlen,
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
@@ -496,7 +496,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 	}
 	gitdir[len] = '/';
 	gitdir[++len] = '\0';
-	retval = resolve_gitlink_ref_recursive(gitdir, len, refname, sha1, 0);
+	retval = resolve_gitlink_ref_recursive(refs, gitdir, len, refname, sha1, 0);
 	free(gitdir);
 	return retval;
 }
-- 
1.7.8
