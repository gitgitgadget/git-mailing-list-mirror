From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] Replace has_wildcard with PATHSPEC_NOGLOB
Date: Sat,  9 Apr 2011 23:54:17 +0700
Message-ID: <1302368060-23827-3-git-send-email-pclouds@gmail.com>
References: <1302368060-23827-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 09 18:54:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8bQv-0004g8-Lt
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 18:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855Ab1DIQys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 12:54:48 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33520 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329Ab1DIQyp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 12:54:45 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so4332135iyb.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 09:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=OvWRHzFkL0gZHYb3QMO0cbhYZIwievQSCxXBpPTas78=;
        b=rlHO+7A+PTm8gtNJmJ8IKGSNerrPiHdmJfnHTdWWfcw7Kgm3oGTMX+/dP+cOZ/+wVn
         ygPrlRFRRcZDrzyYd/H9MAYwhuPMI3TrDXPC1itPFsGii1aKFZGTB5JtqtOGOzOPB2F4
         hCkqUr5mrcCN21ikIV49OExHXzCsRjnEWIlCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=X11c7/lYCuZN73EKBvGIiTGgNGp6d5JY/hYzzpp82wnCl1CAL/l6yUekUvB04yWEFG
         4UN2kaaMHwYUsi+aW2qzV748gNQZxUltgoj/hinSRh//hWAPER8sje89Bg0k1HYMQWMC
         MDVaid6D065hOZe9k3cq5q5mD3U+gLxqcTgI4=
Received: by 10.42.141.8 with SMTP id m8mr2575488icu.355.1302368084682;
        Sat, 09 Apr 2011 09:54:44 -0700 (PDT)
Received: from tre ([115.73.238.90])
        by mx.google.com with ESMTPS id i20sm2752993iby.48.2011.04.09.09.54.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Apr 2011 09:54:43 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Sat, 09 Apr 2011 23:54:37 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1302368060-23827-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171197>

---
 cache.h     |   22 ++++++++++++++++++++--
 dir.c       |   11 +++++++----
 setup.c     |   17 -----------------
 tree-walk.c |   25 ++++++++++++-------------
 4 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/cache.h b/cache.h
index 27ac8a7..da1a46c 100644
--- a/cache.h
+++ b/cache.h
@@ -501,16 +501,34 @@ extern int index_name_is_other(const struct index_state *, const char *, int);
 extern int ie_match_stat(const struct index_state *, struct cache_entry *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, struct cache_entry *, struct stat *, unsigned int);
 
+/*
+ * Magic pathspec
+ *
+ * NEEDSWORK: These need to be moved to dir.h or even to a new
+ * pathspec.h when we restructure get_pathspec() users to use the
+ * "struct pathspec" interface.
+ *
+ * Possible future magic semantics include stuff like:
+ *
+ *	{ PATHSPEC_NOGLOB, '!', "noglob" },
+ *	{ PATHSPEC_RECURSIVE, '*', "recursive" },
+ *	{ PATHSPEC_REGEXP, '\0', "regexp" },
+ *
+ */
+#define PATHSPEC_FROMTOP    (1<<0)
+#define PATHSPEC_ICASE      (1<<1)
+#define PATHSPEC_NOGLOB     (1<<2)
+
 struct pathspec {
 	const char **raw; /* get_pathspec() result, not freed by free_pathspec() */
 	int nr;
-	unsigned int has_wildcard:1;
+	unsigned int use_wildcard:1;
 	unsigned int recursive:1;
 	int max_depth;
 	struct pathspec_item {
 		const char *match;
 		int len;
-		unsigned int has_wildcard:1;
+		unsigned magic;
 	} *items;
 };
 
diff --git a/dir.c b/dir.c
index 6eb04ea..58cedd3 100644
--- a/dir.c
+++ b/dir.c
@@ -230,7 +230,8 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 			return MATCHED_RECURSIVELY;
 	}
 
-	if (item->has_wildcard && !fnmatch(match, name, 0))
+	if (!(item->magic & PATHSPEC_NOGLOB) &&
+	    !fnmatch(match, name, 0))
 		return MATCHED_FNMATCH;
 
 	return 0;
@@ -1280,15 +1281,17 @@ int init_pathspec(struct pathspec *pathspec, const char **paths)
 		return 0;
 
 	pathspec->items = xmalloc(sizeof(struct pathspec_item)*pathspec->nr);
+	memset(pathspec->items, 0, sizeof(struct pathspec_item)*pathspec->nr);
 	for (i = 0; i < pathspec->nr; i++) {
 		struct pathspec_item *item = pathspec->items+i;
 		const char *path = paths[i];
 
 		item->match = path;
 		item->len = strlen(path);
-		item->has_wildcard = !no_wildcard(path);
-		if (item->has_wildcard)
-			pathspec->has_wildcard = 1;
+		if (no_wildcard(path))
+			item->magic |= PATHSPEC_NOGLOB;
+		else
+			pathspec->use_wildcard = 1;
 	}
 
 	qsort(pathspec->items, pathspec->nr,
diff --git a/setup.c b/setup.c
index 4e5ac5e..1e7dfb1 100644
--- a/setup.c
+++ b/setup.c
@@ -126,23 +126,6 @@ void verify_non_filename(const char *prefix, const char *arg)
 	    "Use '--' to separate filenames from revisions", arg);
 }
 
-/*
- * Magic pathspec
- *
- * NEEDSWORK: These need to be moved to dir.h or even to a new
- * pathspec.h when we restructure get_pathspec() users to use the
- * "struct pathspec" interface.
- *
- * Possible future magic semantics include stuff like:
- *
- *	{ PATHSPEC_NOGLOB, '!', "noglob" },
- *	{ PATHSPEC_RECURSIVE, '*', "recursive" },
- *	{ PATHSPEC_REGEXP, '\0', "regexp" },
- *
- */
-#define PATHSPEC_FROMTOP    (1<<0)
-#define PATHSPEC_ICASE      (1<<1)
-
 struct pathspec_magic {
 	unsigned bit;
 	char mnemonic; /* this cannot be ':'! */
diff --git a/tree-walk.c b/tree-walk.c
index 322becc..026d88e 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -559,7 +559,7 @@ int tree_entry_interesting(const struct name_entry *entry,
 {
 	int i;
 	int pathlen, baselen = base->len - base_offset;
-	int never_interesting = ps->has_wildcard ? 0 : -1;
+	int never_interesting = ps->use_wildcard ? 0 : -1;
 
 	if (!ps->nr) {
 		if (!ps->recursive || ps->max_depth == -1)
@@ -598,23 +598,22 @@ int tree_entry_interesting(const struct name_entry *entry,
 					&never_interesting))
 				return 1;
 
-			if (ps->items[i].has_wildcard) {
-				if (!fnmatch(match + baselen, entry->path, 0))
-					return 1;
+			if (ps->items[i].magic & PATHSPEC_NOGLOB)
+				continue;
 
-				/*
-				 * Match all directories. We'll try to
-				 * match files later on.
-				 */
-				if (ps->recursive && S_ISDIR(entry->mode))
-					return 1;
-			}
+			if (!fnmatch(match + baselen, entry->path, 0))
+				return 1;
 
-			continue;
+			/*
+			 * Match all directories. We'll try to match
+			 * files later on.
+			 */
+			if (ps->recursive && S_ISDIR(entry->mode))
+				return 1;
 		}
 
 match_wildcards:
-		if (!ps->items[i].has_wildcard)
+		if (ps->items[i].magic & PATHSPEC_NOGLOB)
 			continue;
 
 		/*
-- 
1.7.4.74.g639db
