From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v2 2/7] remove some memcpy() and strchr() calls inside
 create_directories()
Date: Sun, 01 Feb 2009 21:23:10 +0100
Message-ID: <f395c63c938c6be861614df6989a696a71599641.1233499703.git.barvik@broadpark.no>
References: <cover.1233499703.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 01 21:24:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTis9-0001kb-7o
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 21:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643AbZBAUXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 15:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753393AbZBAUXY
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 15:23:24 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:55724 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbZBAUXV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 15:23:21 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KEE0058DLYVCP80@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 01 Feb 2009 21:23:19 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.229])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KEE00JWOLYRG920@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 01 Feb 2009 21:23:19 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <cover.1233499703.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107994>

Remove the call to memcpy() and strchr() for each path component
tested, and instead add each path component as we go forward inside
the while-loop.

Impact: small optimisation

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---

* Kjetil Barvik <barvik@broadpark.no> writes:
| OK, maybe I instead should have tried to merge the function
| create_directories() with the safe_create_leading_directories() and
| *_const() functions?  What do pepople think?
  
* Junio C Hamano <gitster@pobox.com> writes
| Strictly speaking, the safe_create_leading_* functions are meant to
| work on paths inside $GIT_DIR and are not meant for paths inside the
| work tree, which is this function is about.  Their semantics are
| different with respect to adjust_shared_perm().

  Ok, I think I keep the create_directories() function as is.  Also
  because I think a shared "create_directories()" function could maybe
  make the calls to the lstat_cache() function less likely to be
  sorted alphabetically, and therefore be less cache effective.

| I see existing (mis)uses of the safe_create_leading_* in
| builtin-apply.c, builtin-clone.c (the one that creates the
| work_tree, the other one is Ok), merge-recursive.c (both call sites)
| that are used to touch the work tree, but all places that create
| regular files in the work tree do not run adjust_shared_perm() but
| simply honor the user's umask.

  Inside update_file_flags() in merge-recursive.c I see a call to
  make_room_for_path() (if update_wd is non-zero) which calls
  safe_create_leading_directories_const().  

  If we get lots of calls to make_room_for_path() in some cases, maybe
  we will also save some stat() calls if we fix the call to
  safe_create_*() at this place?

  Remember that safe_create_*() calls stat() on each path component to
  make sure that the component exists, same as create_directories()
  used to do before.




 entry.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/entry.c b/entry.c
index 05aa58d..1879b83 100644
--- a/entry.c
+++ b/entry.c
@@ -2,15 +2,19 @@
 #include "blob.h"
 #include "dir.h"
 
-static void create_directories(const char *path, const struct checkout *state)
+static void create_directories(const char *path, int path_len,
+			       const struct checkout *state)
 {
-	int len = strlen(path);
-	char *buf = xmalloc(len + 1);
-	const char *slash = path;
-
-	while ((slash = strchr(slash+1, '/')) != NULL) {
-		len = slash - path;
-		memcpy(buf, path, len);
+	char *buf = xmalloc(path_len + 1);
+	int len = 0;
+
+	while (len < path_len) {
+		do {
+			buf[len] = path[len];
+			len++;
+		} while (len < path_len && path[len] != '/');
+		if (len >= path_len)
+			break;
 		buf[len] = 0;
 
 		/*
@@ -190,6 +194,7 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 
 	memcpy(path, state->base_dir, len);
 	strcpy(path + len, ce->name);
+	len += ce_namelen(ce);
 
 	if (!lstat(path, &st)) {
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID);
@@ -218,6 +223,6 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 			return error("unable to unlink old '%s' (%s)", path, strerror(errno));
 	} else if (state->not_new)
 		return 0;
-	create_directories(path, state);
+	create_directories(path, len, state);
 	return write_entry(ce, path, state, 0);
 }
-- 
1.6.1.349.g99fa5
