From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/3] remove pathspec_match, use match_pathspec instead
Date: Wed, 14 Jan 2009 15:54:35 +0100
Message-ID: <1231944876-29930-3-git-send-email-drizzd@aon.at>
References: <1231944876-29930-1-git-send-email-drizzd@aon.at>
 <1231944876-29930-2-git-send-email-drizzd@aon.at>
Cc: Junio C Hamano <gitster@pobox.com>, johannes@familieschneider.info,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 15:56:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN79w-0004vJ-M5
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 15:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbZANOye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 09:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755547AbZANOyd
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 09:54:33 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:43210 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351AbZANOya (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 09:54:30 -0500
Received: from darc.dyndns.org ([84.154.84.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 15:54:22 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LN78e-0007o9-SC; Wed, 14 Jan 2009 15:54:36 +0100
X-Mailer: git-send-email 1.6.1
In-Reply-To: <1231944876-29930-2-git-send-email-drizzd@aon.at>
X-OriginalArrivalTime: 14 Jan 2009 14:54:23.0857 (UTC) FILETIME=[FD2CBE10:01C97657]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105636>

Both versions have the same functionality. This removes any
redundancy.

This also adds makes two extensions to match_pathspec:

- If pathspec is NULL, return 1. This reflects the behavior of git
  commands, for which no paths usually means "match all paths".

- If seen is NULL, do not use it.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 builtin-checkout.c |    6 +++---
 builtin-commit.c   |    2 +-
 builtin-ls-files.c |   40 ++--------------------------------------
 cache.h            |    1 -
 dir.c              |   19 +++++++++++--------
 5 files changed, 17 insertions(+), 51 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index b5dd9c0..84a2825 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -240,7 +240,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
-		pathspec_match(pathspec, ps_matched, ce->name, 0);
+		match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, ps_matched);
 	}
 
 	if (report_path_error(ps_matched, pathspec, 0))
@@ -249,7 +249,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	/* Any unmerged paths? */
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
-		if (pathspec_match(pathspec, NULL, ce->name, 0)) {
+		if (match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL)) {
 			if (!ce_stage(ce))
 				continue;
 			if (opts->force) {
@@ -274,7 +274,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	state.refresh_cache = 1;
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
-		if (pathspec_match(pathspec, NULL, ce->name, 0)) {
+		if (match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL)) {
 			if (!ce_stage(ce)) {
 				errs |= checkout_entry(ce, &state, NULL);
 				continue;
diff --git a/builtin-commit.c b/builtin-commit.c
index 7cf227a..913aa89 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -166,7 +166,7 @@ static int list_paths(struct string_list *list, const char *with_tree,
 		struct cache_entry *ce = active_cache[i];
 		if (ce->ce_flags & CE_UPDATE)
 			continue;
-		if (!pathspec_match(pattern, m, ce->name, 0))
+		if (!match_pathspec(pattern, ce->name, ce_namelen(ce), 0, m))
 			continue;
 		string_list_insert(ce->name, list);
 	}
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index f72eb85..3434031 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -36,42 +36,6 @@ static const char *tag_other = "";
 static const char *tag_killed = "";
 static const char *tag_modified = "";
 
-
-/*
- * Match a pathspec against a filename. The first "skiplen" characters
- * are the common prefix
- */
-int pathspec_match(const char **spec, char *ps_matched,
-		   const char *filename, int skiplen)
-{
-	const char *m;
-
-	while ((m = *spec++) != NULL) {
-		int matchlen = strlen(m + skiplen);
-
-		if (!matchlen)
-			goto matched;
-		if (!strncmp(m + skiplen, filename + skiplen, matchlen)) {
-			if (m[skiplen + matchlen - 1] == '/')
-				goto matched;
-			switch (filename[skiplen + matchlen]) {
-			case '/': case '\0':
-				goto matched;
-			}
-		}
-		if (!fnmatch(m + skiplen, filename + skiplen, 0))
-			goto matched;
-		if (ps_matched)
-			ps_matched++;
-		continue;
-	matched:
-		if (ps_matched)
-			*ps_matched = 1;
-		return 1;
-	}
-	return 0;
-}
-
 static void show_dir_entry(const char *tag, struct dir_entry *ent)
 {
 	int len = prefix_len;
@@ -80,7 +44,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 	if (len >= ent->len)
 		die("git ls-files: internal error - directory entry not superset of prefix");
 
-	if (pathspec && !pathspec_match(pathspec, ps_matched, ent->name, len))
+	if (!match_pathspec(pathspec, ent->name, ent->len, len, ps_matched))
 		return;
 
 	fputs(tag, stdout);
@@ -156,7 +120,7 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 	if (len >= ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of prefix");
 
-	if (pathspec && !pathspec_match(pathspec, ps_matched, ce->name, len))
+	if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), len, ps_matched))
 		return;
 
 	if (tag && *tag && show_valid_bit &&
diff --git a/cache.h b/cache.h
index 2dbd546..eba8afc 100644
--- a/cache.h
+++ b/cache.h
@@ -940,7 +940,6 @@ extern int ws_fix_copy(char *, const char *, int, unsigned, int *);
 extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
 
 /* ls-files */
-int pathspec_match(const char **spec, char *matched, const char *filename, int skiplen);
 int report_path_error(const char *ps_matched, const char **pathspec, int prefix_offset);
 void overlay_tree_on_cache(const char *tree_name, const char *prefix);
 
diff --git a/dir.c b/dir.c
index 87a9758..d3b92de 100644
--- a/dir.c
+++ b/dir.c
@@ -108,25 +108,28 @@ static int match_one(const char *match, const char *name, int namelen)
  * and a mark is left in seen[] array for pathspec element that
  * actually matched anything.
  */
-int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen)
+int match_pathspec(const char **pathspec, const char *name, int namelen,
+		int prefix, char *seen)
 {
-	int retval;
-	const char *match;
+	int i, retval = 0;
+
+	if (!pathspec)
+		return 1;
 
 	name += prefix;
 	namelen -= prefix;
 
-	for (retval = 0; (match = *pathspec++) != NULL; seen++) {
+	for (i = 0; pathspec[i] != NULL; i++) {
 		int how;
-		if (*seen == MATCHED_EXACTLY)
+		const char *match = pathspec[i] + prefix;
+		if (seen && seen[i] == MATCHED_EXACTLY)
 			continue;
-		match += prefix;
 		how = match_one(match, name, namelen);
 		if (how) {
 			if (retval < how)
 				retval = how;
-			if (*seen < how)
-				*seen = how;
+			if (seen && seen[i] < how)
+				seen[i] = how;
 		}
 	}
 	return retval;
-- 
1.6.1
