From: Kristian Amlie <kristian.amlie@nokia.com>
Subject: [PATCH 2/2] Make Git respect changes to .gitattributes during checkout.
Date: Fri, 13 Mar 2009 14:24:16 +0100
Message-ID: <1236950656-1967-3-git-send-email-kristian.amlie@nokia.com>
References: <49B8DD1D.3060908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: Kristian Amlie <kristian.amlie@nokia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 14:26:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li7Ol-0001ew-Lh
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 14:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335AbZCMNYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 09:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753647AbZCMNY2
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 09:24:28 -0400
Received: from hoat.troll.no ([62.70.27.150]:59319 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753685AbZCMNYY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 09:24:24 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id A7D87212F7;
	Fri, 13 Mar 2009 14:24:17 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 9CB3421319;
	Fri, 13 Mar 2009 14:24:17 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n2DDOHD2007249;
	Fri, 13 Mar 2009 14:24:17 +0100
Received: from axis.localdomain ( [172.24.90.99])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Fri, 13 Mar 2009 14:24:17 +0100 (CET)
Received: by axis.localdomain (Postfix, from userid 1000)
	id D5C4236182D8; Fri, 13 Mar 2009 14:24:16 +0100 (CET)
In-Reply-To: <1236950656-1967-2-git-send-email-kristian.amlie@nokia.com>
References: <1236950656-1967-1-git-send-email-kristian.amlie@nokia.com>
References: <1236950656-1967-2-git-send-email-kristian.amlie@nokia.com>
x-scalix-Hops: 1
X-Mailer: git-send-email 1.6.1.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113182>

The fix is twofold:

First, we force .gitattributes files to always be the first ones
checked out. This is the part in check_updates().

Second, we make sure that the checked out attributes get honored by
popping off elements on the attribute stack, until we reach the level
where a new .gitattributes was checked out. The next time someone
calls git_checkattr(), it will reconstruct the attributes from that
point.

Note that in unlink_entry() there is code to support the case where
.gitattributes is removed (test case #3 in t2013-checkout-crlf.sh),
but this doesn't work properly because Git tries to read new
attributes from the index, but the old index (where .gitattributes
still exists) is still active.
---
 attr.c                   |   86 +++++++++++++++++++++++++++++++++++++++------
 attr.h                   |    1 +
 entry.c                  |   19 ++++++++++
 t/t2013-checkout-crlf.sh |    2 +-
 unpack-trees.c           |   77 +++++++++++++++++++++++++++++++----------
 5 files changed, 154 insertions(+), 31 deletions(-)

diff --git a/attr.c b/attr.c
index 17f6a4d..2bc0847 100644
--- a/attr.c
+++ b/attr.c
@@ -455,6 +455,23 @@ static void bootstrap_attr_stack(void)
 	}
 }
 
+static void pop_attr_stack(const char *path, int dirlen)
+{
+	struct attr_stack *elem;
+	while (attr_stack && attr_stack->origin) {
+		int namelen = strlen(attr_stack->origin);
+
+		elem = attr_stack;
+		if (namelen <= dirlen &&
+			!strncmp(elem->origin, path, namelen))
+			break;
+
+		debug_pop(elem);
+		attr_stack = elem->prev;
+		free_attr_elem(elem);
+	}
+}
+
 static void prepare_attr_stack(const char *path, int dirlen)
 {
 	struct attr_stack *elem, *info;
@@ -489,18 +506,7 @@ static void prepare_attr_stack(const char *path, int dirlen)
 	 * Pop the ones from directories that are not the prefix of
 	 * the path we are checking.
 	 */
-	while (attr_stack && attr_stack->origin) {
-		int namelen = strlen(attr_stack->origin);
-
-		elem = attr_stack;
-		if (namelen <= dirlen &&
-		    !strncmp(elem->origin, path, namelen))
-			break;
-
-		debug_pop(elem);
-		attr_stack = elem->prev;
-		free_attr_elem(elem);
-	}
+	pop_attr_stack(path, dirlen);
 
 	/*
 	 * Read from parent directories and push them down
@@ -642,3 +648,59 @@ int git_checkattr(const char *path, int num, struct git_attr_check *check)
 
 	return 0;
 }
+
+void git_attr_invalidate_path(const char *path)
+{
+	int dirlen;
+	const char *cp;
+	struct attr_stack *info, *elem;
+
+	bootstrap_attr_stack();
+
+	/*
+	 * Pop the "info" one that is always at the top of the stack.
+	 */
+	info = attr_stack;
+	attr_stack = info->prev;
+
+	cp = strrchr(path, '/');
+	dirlen = cp ? cp - path : 0;
+	/* Pop everything up to, and including, path. */
+	pop_attr_stack(path, dirlen);
+
+	if (!strcmp(path, "") && attr_stack->origin && !strcmp(attr_stack->origin, "")) {
+		/*
+		 * Special handling when the root attributes must be invalidated.
+		 * Note that we cannot reread the attributes here. The reason is that
+		 * when unlinking the root .gitattributes file, the index entry is
+		 * removed after unlinking. If we reread the attributes here, we
+		 * would get the same attributes as before because .gitattributes
+		 * is still in the index. Thus we must wait until the next call to
+		 * read_attr, when the index has been updated.
+		 */
+		/* $GIT_DIR/info/attributes */
+		elem = info;
+		debug_pop(elem);
+		free_attr_elem(elem);
+
+		/* $GIT_WORK_TREE/.gitattributes */
+		elem = attr_stack;
+		debug_pop(elem);
+		attr_stack = elem->prev;
+		free_attr_elem(elem);
+
+		/* builtins */
+		elem = attr_stack;
+		debug_pop(elem);
+		attr_stack = elem->prev;
+		free_attr_elem(elem);
+
+		assert(!attr_stack);
+	} else {
+		/*
+		 * Finally push the "info" one at the top of the stack.
+		 */
+		info->prev = attr_stack;
+		attr_stack = info;
+	}
+}
diff --git a/attr.h b/attr.h
index f1c2038..8f4135b 100644
--- a/attr.h
+++ b/attr.h
@@ -30,5 +30,6 @@ struct git_attr_check {
 };
 
 int git_checkattr(const char *path, int, struct git_attr_check *);
+void git_attr_invalidate_path(const char *path);
 
 #endif /* ATTR_H */
diff --git a/entry.c b/entry.c
index 05aa58d..7fb27fd 100644
--- a/entry.c
+++ b/entry.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "blob.h"
 #include "dir.h"
+#include "attr.h"
 
 static void create_directories(const char *path, const struct checkout *state)
 {
@@ -91,6 +92,9 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 {
 	int fd;
 	long wrote;
+	int gitattrlen;
+	int pathlen;
+	char *cp;
 
 	switch (ce->ce_mode & S_IFMT) {
 		char *new;
@@ -171,6 +175,21 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 		return error("git checkout-index: unknown file mode for %s", path);
 	}
 
+	gitattrlen = strlen(GITATTRIBUTES_FILE);
+	pathlen = strlen(path);
+	if (pathlen >= gitattrlen && !strncmp(path + pathlen - gitattrlen,
+				GITATTRIBUTES_FILE, gitattrlen)) {
+		/* Invalidate attributes if a new .gitattributes file was checked out. */
+		cp = strrchr(path, '/');
+		if (!cp) {
+			git_attr_invalidate_path("");
+		} else {
+			*cp = '\0';
+			git_attr_invalidate_path(path);
+			*cp = '/';
+		}
+	}
+
 	if (state->refresh_cache) {
 		struct stat st;
 		lstat(ce->name, &st);
diff --git a/t/t2013-checkout-crlf.sh b/t/t2013-checkout-crlf.sh
index d9d6465..e704c93 100755
--- a/t/t2013-checkout-crlf.sh
+++ b/t/t2013-checkout-crlf.sh
@@ -21,7 +21,7 @@ test_expect_success 'setup' '
 
 '
 
-test_expect_failure 'checkout with existing .gitattributes' '
+test_expect_success 'checkout with existing .gitattributes' '
 
         git checkout master~2 &&
         git checkout master~1 &&
diff --git a/unpack-trees.c b/unpack-trees.c
index e547282..63a41f8 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -7,6 +7,7 @@
 #include "unpack-trees.h"
 #include "progress.h"
 #include "refs.h"
+#include "attr.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -60,6 +61,7 @@ static void unlink_entry(struct cache_entry *ce)
 {
 	char *cp, *prev;
 	char *name = ce->name;
+	int namelen, gitattrlen;
 
 	if (has_symlink_or_noent_leading_path(ce_namelen(ce), ce->name))
 		return;
@@ -82,6 +84,21 @@ static void unlink_entry(struct cache_entry *ce)
 		}
 		prev = cp;
 	}
+
+	if (!prev) {
+		gitattrlen = strlen(GITATTRIBUTES_FILE);
+		namelen = strlen(name);
+		if (namelen >= gitattrlen && !strncmp(name + namelen - gitattrlen,
+				GITATTRIBUTES_FILE, gitattrlen)) {
+			if (cp) {
+				*cp = '\0';
+				git_attr_invalidate_path(name);
+				*cp = '/';
+			} else {
+				git_attr_invalidate_path("");
+			}
+		}
+	}
 }
 
 static struct checkout state;
@@ -92,6 +109,9 @@ static int check_updates(struct unpack_trees_options *o)
 	struct index_state *index = &o->result;
 	int i;
 	int errs = 0;
+	int attr;
+	int gitattrlen;
+	int namelen;
 
 	if (o->update && o->verbose_update) {
 		for (total = cnt = 0; cnt < index->cache_nr; cnt++) {
@@ -105,27 +125,48 @@ static int check_updates(struct unpack_trees_options *o)
 		cnt = 0;
 	}
 
-	for (i = 0; i < index->cache_nr; i++) {
-		struct cache_entry *ce = index->cache[i];
+	gitattrlen = strlen(GITATTRIBUTES_FILE);
 
-		if (ce->ce_flags & CE_REMOVE) {
-			display_progress(progress, ++cnt);
-			if (o->update)
-				unlink_entry(ce);
-			remove_index_entry_at(&o->result, i);
-			i--;
-			continue;
+	/*
+	 * We want to checkout .gitattributes before everything else. So:
+	 * attr == 0 -> .gitattributes
+	 * attr == 1 -> everything else
+	 */
+	for (attr = 0; attr < 2; attr++) {
+		for (i = 0; i < index->cache_nr; i++) {
+			struct cache_entry *ce = index->cache[i];
+
+			namelen = strlen(ce->name);
+			if ((attr == 0) != (namelen >= gitattrlen && strncmp(
+					ce->name + namelen - gitattrlen,
+					GITATTRIBUTES_FILE, gitattrlen) == 0))
+				continue;
+			if (ce->ce_flags & CE_REMOVE) {
+				display_progress(progress, ++cnt);
+				if (o->update)
+					unlink_entry(ce);
+				remove_index_entry_at(&o->result, i);
+				i--;
+				continue;
+			}
 		}
 	}
 
-	for (i = 0; i < index->cache_nr; i++) {
-		struct cache_entry *ce = index->cache[i];
+	for (attr = 0; attr < 2; attr++) {
+		for (i = 0; i < index->cache_nr; i++) {
+			struct cache_entry *ce = index->cache[i];
 
-		if (ce->ce_flags & CE_UPDATE) {
-			display_progress(progress, ++cnt);
-			ce->ce_flags &= ~CE_UPDATE;
-			if (o->update) {
-				errs |= checkout_entry(ce, &state, NULL);
+			namelen = strlen(ce->name);
+			if ((attr == 0) != (namelen >= gitattrlen && strncmp(
+					ce->name + namelen - gitattrlen,
+					GITATTRIBUTES_FILE, gitattrlen) == 0))
+				continue;
+			if (ce->ce_flags & CE_UPDATE) {
+				display_progress(progress, ++cnt);
+				ce->ce_flags &= ~CE_UPDATE;
+				if (o->update) {
+					errs |= checkout_entry(ce, &state, NULL);
+				}
 			}
 		}
 	}
-- 
1.6.1.1
