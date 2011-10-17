From: mhagger@alum.mit.edu
Subject: [PATCH v2 04/14] refs: rename parameters result -> sha1
Date: Mon, 17 Oct 2011 09:39:13 +0200
Message-ID: <1318837163-27112-5-git-send-email-mhagger@alum.mit.edu>
References: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 09:40:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFhnk-0007mH-8Y
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 09:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911Ab1JQHjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 03:39:41 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:33559 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644Ab1JQHji (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 03:39:38 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RFhhV-0000eM-J2; Mon, 17 Oct 2011 09:33:33 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183775>

From: Michael Haggerty <mhagger@alum.mit.edu>

Try consistently to use the name "sha1" for parameters to which a SHA1
will be stored.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   16 ++++++++--------
 refs.h |    2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index a5d560c..87c8913 100644
--- a/refs.c
+++ b/refs.c
@@ -398,7 +398,7 @@ static struct ref_array *get_loose_refs(const char *submodule)
 #define MAXREFLEN (1024)
 
 static int resolve_gitlink_packed_ref(char *name, int pathlen,
-				      const char *refname, unsigned char *result)
+				      const char *refname, unsigned char *sha1)
 {
 	int retval = -1;
 	struct ref_entry *ref;
@@ -406,14 +406,14 @@ static int resolve_gitlink_packed_ref(char *name, int pathlen,
 
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
@@ -424,7 +424,7 @@ static int resolve_gitlink_ref_recursive(char *name, int pathlen,
 	memcpy(name + pathlen, refname, len+1);
 	fd = open(name, O_RDONLY);
 	if (fd < 0)
-		return resolve_gitlink_packed_ref(name, pathlen, refname, result);
+		return resolve_gitlink_packed_ref(name, pathlen, refname, sha1);
 
 	len = read(fd, buffer, sizeof(buffer)-1);
 	close(fd);
@@ -435,7 +435,7 @@ static int resolve_gitlink_ref_recursive(char *name, int pathlen,
 	buffer[len] = 0;
 
 	/* Was it a detached head or an old-fashioned symlink? */
-	if (!get_sha1_hex(buffer, result))
+	if (!get_sha1_hex(buffer, sha1))
 		return 0;
 
 	/* Symref? */
@@ -445,10 +445,10 @@ static int resolve_gitlink_ref_recursive(char *name, int pathlen,
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
@@ -472,7 +472,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *re
 	}
 	gitdir[len] = '/';
 	gitdir[++len] = '\0';
-	retval = resolve_gitlink_ref_recursive(gitdir, len, refname, result, 0);
+	retval = resolve_gitlink_ref_recursive(gitdir, len, refname, sha1, 0);
 	free(gitdir);
 	return retval;
 }
diff --git a/refs.h b/refs.h
index 13e2aa3..c6b8749 100644
--- a/refs.h
+++ b/refs.h
@@ -133,7 +133,7 @@ extern char *shorten_unambiguous_ref(const char *refname, int strict);
 extern int rename_ref(const char *oldref, const char *newref, const char *logmsg);
 
 /** resolve ref in nested "gitlink" repository */
-extern int resolve_gitlink_ref(const char *name, const char *refname, unsigned char *result);
+extern int resolve_gitlink_ref(const char *name, const char *refname, unsigned char *sha1);
 
 /** lock a ref and then write its file */
 enum action_on_err { MSG_ON_ERR, DIE_ON_ERR, QUIET_ON_ERR };
-- 
1.7.7.rc2
