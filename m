From: Rohit Mani <rohit.mani@outlook.com>
Subject: [PATCH] use strchrnul() in place of strchr() and strlen()
Date: Wed, 5 Mar 2014 11:29:02 -0800
Message-ID: <BLU0-SMTP1988500CEC43BD4C57254AB91890@phx.gbl>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Rohit Mani <rohit.mani@outlook.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 20:34:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLHaj-0000md-PX
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 20:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbaCETex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 14:34:53 -0500
Received: from blu0-omc3-s20.blu0.hotmail.com ([65.55.116.95]:23519 "EHLO
	blu0-omc3-s20.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750850AbaCETew (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2014 14:34:52 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Mar 2014 14:34:52 EST
Received: from BLU0-SMTP198 ([65.55.116.72]) by blu0-omc3-s20.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 5 Mar 2014 11:29:45 -0800
X-TMN: [NrcuvCsQtZgnbS27GYCj5HXoOCU4NRd/fDog66v0Wlk=]
X-Originating-Email: [rohit.mani@outlook.com]
Received: from rohit-ubuntu.socal.rr.com ([142.136.123.189]) by BLU0-SMTP198.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 5 Mar 2014 11:29:44 -0800
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <y>
X-OriginalArrivalTime: 05 Mar 2014 19:29:44.0276 (UTC) FILETIME=[430FA140:01CF38A9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243471>

Avoid scanning strings twice, once with strchr() and then with
strlen(), by using strchrnul(). Update the conditional expressions
involving the return value of strchrnul() with a check for '\0'.

Signed-off-by: Rohit Mani <rohit.mani@outlook.com>
---
I plan to apply for the GSoC.

 archive.c        |    4 ++--
 cache-tree.c     |   16 +++++++---------
 diff.c           |    9 +++------
 fast-import.c    |   35 ++++++++++++++---------------------
 match-trees.c    |   11 ++++-------
 parse-options.c  |    5 +----
 pretty.c         |    5 ++---
 remote-testsvn.c |    4 ++--
 ws.c             |    7 ++-----
 9 files changed, 37 insertions(+), 59 deletions(-)

diff --git a/archive.c b/archive.c
index 346f3b2..d196215 100644
--- a/archive.c
+++ b/archive.c
@@ -259,8 +259,8 @@ static void parse_treeish_arg(const char **argv,
 	/* Remotes are only allowed to fetch actual refs */
 	if (remote) {
 		char *ref = NULL;
-		const char *colon = strchr(name, ':');
-		int refnamelen = colon ? colon - name : strlen(name);
+		const char *colon = strchrnul(name, ':');
+		int refnamelen = colon - name;
 
 		if (!dwim_ref(name, refnamelen, sha1, &ref))
 			die("no such ref: %.*s", refnamelen, name);
diff --git a/cache-tree.c b/cache-tree.c
index 0bbec43..21a13cf 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -121,11 +121,11 @@ void cache_tree_invalidate_path(struct cache_tree *it, const char *path)
 
 	if (!it)
 		return;
-	slash = strchr(path, '/');
+	slash = strchrnul(path, '/');
 	it->entry_count = -1;
-	if (!slash) {
+	if (*slash == '\0') {
 		int pos;
-		namelen = strlen(path);
+		namelen = slash - path;
 		pos = subtree_pos(it, path, namelen);
 		if (0 <= pos) {
 			cache_tree_free(&it->down[pos]->cache_tree);
@@ -554,9 +554,7 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 		const char *slash;
 		struct cache_tree_sub *sub;
 
-		slash = strchr(path, '/');
-		if (!slash)
-			slash = path + strlen(path);
+		slash = strchrnul(path, '/');
 		/* between path and slash is the name of the
 		 * subtree to look for.
 		 */
@@ -564,10 +562,10 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 		if (!sub)
 			return NULL;
 		it = sub->cache_tree;
-		if (slash)
-			while (*slash && *slash == '/')
+		if (*slash != '\0')
+			while (*slash != '\0' && *slash == '/')
 				slash++;
-		if (!slash || !*slash)
+		if (*slash == '\0' || !*slash)
 			return it; /* prefix ended with slashes */
 		path = slash;
 	}
diff --git a/diff.c b/diff.c
index e800666..83a039b 100644
--- a/diff.c
+++ b/diff.c
@@ -3365,14 +3365,11 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
 	if (c != '-')
 		return 0;
 	arg++;
-	eq = strchr(arg, '=');
-	if (eq)
-		len = eq - arg;
-	else
-		len = strlen(arg);
+	eq = strchrnul(arg, '=');
+	len = eq - arg;
 	if (!len || strncmp(arg, arg_long, len))
 		return 0;
-	if (eq) {
+	if (*eq != '\0') {
 		int n;
 		char *end;
 		if (!isdigit(*++eq))
diff --git a/fast-import.c b/fast-import.c
index 4fd18a3..449595d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1485,14 +1485,12 @@ static int tree_content_set(
 	unsigned int i, n;
 	struct tree_entry *e;
 
-	slash1 = strchr(p, '/');
-	if (slash1)
-		n = slash1 - p;
-	else
-		n = strlen(p);
+	slash1 = strchrnul(p, '/');
+	n = slash1 - p;
+
 	if (!n)
 		die("Empty path component found in input");
-	if (!slash1 && !S_ISDIR(mode) && subtree)
+	if (*slash1 == '\0' && !S_ISDIR(mode) && subtree)
 		die("Non-directories cannot have subtrees");
 
 	if (!root->tree)
@@ -1501,7 +1499,7 @@ static int tree_content_set(
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
 		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
-			if (!slash1) {
+			if (*slash1 == '\0') {
 				if (!S_ISDIR(mode)
 						&& e->versions[1].mode == mode
 						&& !hashcmp(e->versions[1].sha1, sha1))
@@ -1552,7 +1550,7 @@ static int tree_content_set(
 	e->versions[0].mode = 0;
 	hashclr(e->versions[0].sha1);
 	t->entries[t->entry_count++] = e;
-	if (slash1) {
+	if (*slash1 != '\0') {
 		e->tree = new_tree_content(8);
 		e->versions[1].mode = S_IFDIR;
 		tree_content_set(e, slash1 + 1, sha1, mode, subtree);
@@ -1576,11 +1574,8 @@ static int tree_content_remove(
 	unsigned int i, n;
 	struct tree_entry *e;
 
-	slash1 = strchr(p, '/');
-	if (slash1)
-		n = slash1 - p;
-	else
-		n = strlen(p);
+	slash1 = strchrnul(p, '/');
+	n = slash1 - p;
 
 	if (!root->tree)
 		load_tree(root);
@@ -1594,7 +1589,7 @@ static int tree_content_remove(
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
 		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
-			if (slash1 && !S_ISDIR(e->versions[1].mode))
+			if (*slash1 != '\0' && !S_ISDIR(e->versions[1].mode))
 				/*
 				 * If p names a file in some subdirectory, and a
 				 * file or symlink matching the name of the
@@ -1602,7 +1597,7 @@ static int tree_content_remove(
 				 * exist and need not be deleted.
 				 */
 				return 1;
-			if (!slash1 || !S_ISDIR(e->versions[1].mode))
+			if (*slash1 == '\0' || !S_ISDIR(e->versions[1].mode))
 				goto del_entry;
 			if (!e->tree)
 				load_tree(e);
@@ -1644,11 +1639,9 @@ static int tree_content_get(
 	unsigned int i, n;
 	struct tree_entry *e;
 
-	slash1 = strchr(p, '/');
-	if (slash1)
-		n = slash1 - p;
-	else
-		n = strlen(p);
+	slash1 = strchrnul(p, '/');
+	n = slash1 - p;
+
 	if (!n && !allow_root)
 		die("Empty path component found in input");
 
@@ -1664,7 +1657,7 @@ static int tree_content_get(
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
 		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
-			if (!slash1)
+			if (*slash1 == '\0')
 				goto found_entry;
 			if (!S_ISDIR(e->versions[1].mode))
 				return 0;
diff --git a/match-trees.c b/match-trees.c
index 7873cde..7cca0f6 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -182,13 +182,10 @@ static int splice_tree(const unsigned char *hash1,
 	enum object_type type;
 	int status;
 
-	subpath = strchr(prefix, '/');
-	if (!subpath)
-		toplen = strlen(prefix);
-	else {
-		toplen = subpath - prefix;
+	subpath = strchrnul(prefix, '/');
+	toplen = subpath - prefix;
+	if (*subpath != '\0')
 		subpath++;
-	}
 
 	buf = read_sha1_file(hash1, &type, &sz);
 	if (!buf)
@@ -215,7 +212,7 @@ static int splice_tree(const unsigned char *hash1,
 	if (!rewrite_here)
 		die("entry %.*s not found in tree %s",
 		    toplen, prefix, sha1_to_hex(hash1));
-	if (subpath) {
+	if (*subpath != '\0') {
 		status = splice_tree(rewrite_here, subpath, hash2, subtree);
 		if (status)
 			return status;
diff --git a/parse-options.c b/parse-options.c
index 7b8d3fa..a5fa0b8 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -223,13 +223,10 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
                           const struct option *options)
 {
 	const struct option *all_opts = options;
-	const char *arg_end = strchr(arg, '=');
+	const char *arg_end = strchrnul(arg, '=');
 	const struct option *abbrev_option = NULL, *ambiguous_option = NULL;
 	int abbrev_flags = 0, ambiguous_flags = 0;
 
-	if (!arg_end)
-		arg_end = arg + strlen(arg);
-
 	for (; options->type != OPTION_END; options++) {
 		const char *rest, *long_name = options->long_name;
 		int flags = 0, opt_flags = 0;
diff --git a/pretty.c b/pretty.c
index 87db08b..b1f60f9 100644
--- a/pretty.c
+++ b/pretty.c
@@ -549,14 +549,13 @@ static char *get_header(const struct commit *commit, const char *msg,
 	const char *line = msg;
 
 	while (line) {
-		const char *eol = strchr(line, '\n'), *next;
+		const char *eol = strchrnul(line, '\n'), *next;
 
 		if (line == eol)
 			return NULL;
-		if (!eol) {
+		if (*eol == '\0') {
 			warning("malformed commit (header is missing newline): %s",
 				sha1_to_hex(commit->object.sha1));
-			eol = line + strlen(line);
 			next = NULL;
 		} else
 			next = eol + 1;
diff --git a/remote-testsvn.c b/remote-testsvn.c
index 078f1ff..6be55cb 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -78,8 +78,8 @@ static int parse_rev_note(const char *msg, struct rev_note *res)
 	size_t len;
 
 	while (*msg) {
-		end = strchr(msg, '\n');
-		len = end ? end - msg : strlen(msg);
+		end = strchrnul(msg, '\n');
+		len = end - msg;
 
 		key = "Revision-number: ";
 		if (starts_with(msg, key)) {
diff --git a/ws.c b/ws.c
index b498d75..ea4b2b1 100644
--- a/ws.c
+++ b/ws.c
@@ -33,11 +33,8 @@ unsigned parse_whitespace_rule(const char *string)
 		int negated = 0;
 
 		string = string + strspn(string, ", \t\n\r");
-		ep = strchr(string, ',');
-		if (!ep)
-			len = strlen(string);
-		else
-			len = ep - string;
+		ep = strchrnul(string, ',');
+		len = ep - string;
 
 		if (*string == '-') {
 			negated = 1;
-- 
1.7.9.5
