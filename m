From: mhagger@alum.mit.edu
Subject: [PATCH v2 03/51] refs: rename parameters result -> sha1
Date: Mon, 12 Dec 2011 06:38:10 +0100
Message-ID: <1323668338-1764-4-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:39:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZyc6-0000LO-L5
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486Ab1LLFji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:39:38 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34541 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab1LLFje (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:39:34 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aG015577;
	Mon, 12 Dec 2011 06:39:19 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186826>

From: Michael Haggerty <mhagger@alum.mit.edu>

Try consistently to use the name "sha1" for parameters to which a SHA1
will be stored.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   20 ++++++++++----------
 refs.h |    2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index 8ddd874..9f7a5ec 100644
--- a/refs.c
+++ b/refs.c
@@ -402,7 +402,7 @@ static struct ref_array *get_loose_refs(const char *submodule)
  * the packed-refs file for the submodule.
  */
 static int resolve_gitlink_packed_ref(char *name, int pathlen,
-				      const char *refname, unsigned char *result)
+				      const char *refname, unsigned char *sha1)
 {
 	int retval = -1;
 	struct ref_entry *ref;
@@ -415,14 +415,14 @@ static int resolve_gitlink_packed_ref(char *name, int pathlen,
 	array = get_packed_refs(name);
 	ref = search_ref_array(array, refname);
 	if (ref != NULL) {
-		memcpy(result, ref->sha1, 20);
+		memcpy(sha1, ref->sha1, 20);
 		retval = 0;
 	}
 	return retval;
 }
 
 static int resolve_gitlink_ref_recursive(char *name, int pathlen,
-					 const char *refname, unsigned char *result,
+					 const char *refname, unsigned char *sha1,
 					 int recursion)
 {
 	int fd, len = strlen(refname);
@@ -433,7 +433,7 @@ static int resolve_gitlink_ref_recursive(char *name, int pathlen,
 	memcpy(name + pathlen, refname, len+1);
 	fd = open(name, O_RDONLY);
 	if (fd < 0)
-		return resolve_gitlink_packed_ref(name, pathlen, refname, result);
+		return resolve_gitlink_packed_ref(name, pathlen, refname, sha1);
 
 	len = read(fd, buffer, sizeof(buffer)-1);
 	close(fd);
@@ -444,7 +444,7 @@ static int resolve_gitlink_ref_recursive(char *name, int pathlen,
 	buffer[len] = 0;
 
 	/* Was it a detached head or an old-fashioned symlink? */
-	if (!get_sha1_hex(buffer, result))
+	if (!get_sha1_hex(buffer, sha1))
 		return 0;
 
 	/* Symref? */
@@ -454,10 +454,10 @@ static int resolve_gitlink_ref_recursive(char *name, int pathlen,
 	while (isspace(*p))
 		p++;
 
-	return resolve_gitlink_ref_recursive(name, pathlen, p, result, recursion+1);
+	return resolve_gitlink_ref_recursive(name, pathlen, p, sha1, recursion+1);
 }
 
-int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *result)
+int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
 {
 	int len = strlen(path), retval;
 	char *gitdir;
@@ -481,7 +481,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *re
 	}
 	gitdir[len] = '/';
 	gitdir[++len] = '\0';
-	retval = resolve_gitlink_ref_recursive(gitdir, len, refname, result, 0);
+	retval = resolve_gitlink_ref_recursive(gitdir, len, refname, sha1, 0);
 	free(gitdir);
 	return retval;
 }
@@ -647,13 +647,13 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 	return fn(entry->name + trim, entry->sha1, entry->flag, cb_data);
 }
 
-static int filter_refs(const char *refname, const unsigned char *sha, int flags,
+static int filter_refs(const char *refname, const unsigned char *sha1, int flags,
 		       void *data)
 {
 	struct ref_filter *filter = (struct ref_filter *)data;
 	if (fnmatch(filter->pattern, refname, 0))
 		return 0;
-	return filter->fn(refname, sha, flags, filter->cb_data);
+	return filter->fn(refname, sha1, flags, filter->cb_data);
 }
 
 int peel_ref(const char *refname, unsigned char *sha1)
diff --git a/refs.h b/refs.h
index e36bd03..4c5d570 100644
--- a/refs.h
+++ b/refs.h
@@ -134,7 +134,7 @@ extern char *shorten_unambiguous_ref(const char *refname, int strict);
 extern int rename_ref(const char *oldref, const char *newref, const char *logmsg);
 
 /** resolve ref in nested "gitlink" repository */
-extern int resolve_gitlink_ref(const char *name, const char *refname, unsigned char *result);
+extern int resolve_gitlink_ref(const char *name, const char *refname, unsigned char *sha1);
 
 /** lock a ref and then write its file */
 enum action_on_err { MSG_ON_ERR, DIE_ON_ERR, QUIET_ON_ERR };
-- 
1.7.8
