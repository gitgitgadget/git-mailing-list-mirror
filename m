From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH] Apply -p<value> on git-diffs that create/delete files
Date: Mon, 29 Dec 2008 18:15:45 -0700
Message-ID: <20081230011545.GA81224@bowser.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 02:18:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHTFj-0003bR-DS
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 02:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbYL3BPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 20:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbYL3BPv
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 20:15:51 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:40406 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbYL3BPu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 20:15:50 -0500
Received: by rv-out-0506.google.com with SMTP id k40so4626522rvb.1
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 17:15:49 -0800 (PST)
Received: by 10.141.36.10 with SMTP id o10mr6986888rvj.254.1230599749470;
        Mon, 29 Dec 2008 17:15:49 -0800 (PST)
Received: from aeruder (aeruder.net [208.78.97.67])
        by mx.google.com with ESMTPS id b39sm20453122rvf.0.2008.12.29.17.15.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Dec 2008 17:15:49 -0800 (PST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104144>

The git_header_name checked the filenames given on the
"diff --git" line in a patch file.  It never applied the
-p value.  When applying a patch that deleted/created a file,
this unshortened default name was used as the old/new name.

Using this unshortened name as the old/new name resulted in
one of two incorrect results:

*) If the patch did not have the ---/+++ section
(creating/deleting an empty file, a simple mode change, etc.)
the patch would be applied to the unshortened name.

*) If the patch included the ---/+++ lines, the patch would fail
consistency checks in gitdiff_verify_name when the (shortened)
---/+++ filename didn't match the (unshortened)name grabbed off
the "diff --git" line.

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 builtin-apply.c       |  203 +++++++++++++++----------------------------------
 t/t4120-apply-popt.sh |    5 +-
 2 files changed, 64 insertions(+), 144 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 07244b0..584a910 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -315,7 +315,7 @@ static int name_terminate(const char *name, int namelen, int c, int terminate)
 	return 1;
 }
 
-static char *find_name(const char *line, char *def, int p_value, int terminate)
+static char *find_name(const char *line, char *def, int p_value, int terminate, const char **endp)
 {
 	int len;
 	const char *start = line;
@@ -327,7 +327,7 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 		 * Proposed "new-style" GNU patch/diff format; see
 		 * http://marc.theaimsgroup.com/?l=git&m=112927316408690&w=2
 		 */
-		if (!unquote_c_style(&name, line, NULL)) {
+		if (!unquote_c_style(&name, line, endp)) {
 			char *cp;
 
 			for (cp = name.buf; p_value; p_value--) {
@@ -363,6 +363,10 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 		if (c == '/' && !--p_value)
 			start = line;
 	}
+
+	if (endp)
+		*endp = line;
+
 	if (!start)
 		return def;
 	len = line - start;
@@ -415,7 +419,7 @@ static int guess_p_value(const char *nameline)
 
 	if (is_dev_null(nameline))
 		return -1;
-	name = find_name(nameline, NULL, 0, TERM_SPACE | TERM_TAB);
+	name = find_name(nameline, NULL, 0, TERM_SPACE | TERM_TAB, NULL);
 	if (!name)
 		return -1;
 	cp = strchr(name, '/');
@@ -464,16 +468,16 @@ static void parse_traditional_patch(const char *first, const char *second, struc
 	if (is_dev_null(first)) {
 		patch->is_new = 1;
 		patch->is_delete = 0;
-		name = find_name(second, NULL, p_value, TERM_SPACE | TERM_TAB);
+		name = find_name(second, NULL, p_value, TERM_SPACE | TERM_TAB, NULL);
 		patch->new_name = name;
 	} else if (is_dev_null(second)) {
 		patch->is_new = 0;
 		patch->is_delete = 1;
-		name = find_name(first, NULL, p_value, TERM_SPACE | TERM_TAB);
+		name = find_name(first, NULL, p_value, TERM_SPACE | TERM_TAB, NULL);
 		patch->old_name = name;
 	} else {
-		name = find_name(first, NULL, p_value, TERM_SPACE | TERM_TAB);
-		name = find_name(second, name, p_value, TERM_SPACE | TERM_TAB);
+		name = find_name(first, NULL, p_value, TERM_SPACE | TERM_TAB, NULL);
+		name = find_name(second, name, p_value, TERM_SPACE | TERM_TAB, NULL);
 		patch->old_name = patch->new_name = name;
 	}
 	if (!name)
@@ -497,7 +501,7 @@ static int gitdiff_hdrend(const char *line, struct patch *patch)
 static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name, const char *oldnew)
 {
 	if (!orig_name && !isnull)
-		return find_name(line, NULL, p_value, TERM_TAB);
+		return find_name(line, NULL, p_value, TERM_TAB, NULL);
 
 	if (orig_name) {
 		int len;
@@ -507,7 +511,7 @@ static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name,
 		len = strlen(name);
 		if (isnull)
 			die("git apply: bad git-diff - expected /dev/null, got %s on line %d", name, linenr);
-		another = find_name(line, NULL, p_value, TERM_TAB);
+		another = find_name(line, NULL, p_value, TERM_TAB, NULL);
 		if (!another || memcmp(another, name, len))
 			die("git apply: bad git-diff - inconsistent %s filename on line %d", oldnew, linenr);
 		free(another);
@@ -562,28 +566,28 @@ static int gitdiff_newfile(const char *line, struct patch *patch)
 static int gitdiff_copysrc(const char *line, struct patch *patch)
 {
 	patch->is_copy = 1;
-	patch->old_name = find_name(line, NULL, 0, 0);
+	patch->old_name = find_name(line, NULL, 0, 0, NULL);
 	return 0;
 }
 
 static int gitdiff_copydst(const char *line, struct patch *patch)
 {
 	patch->is_copy = 1;
-	patch->new_name = find_name(line, NULL, 0, 0);
+	patch->new_name = find_name(line, NULL, 0, 0, NULL);
 	return 0;
 }
 
 static int gitdiff_renamesrc(const char *line, struct patch *patch)
 {
 	patch->is_rename = 1;
-	patch->old_name = find_name(line, NULL, 0, 0);
+	patch->old_name = find_name(line, NULL, 0, 0, NULL);
 	return 0;
 }
 
 static int gitdiff_renamedst(const char *line, struct patch *patch)
 {
 	patch->is_rename = 1;
-	patch->new_name = find_name(line, NULL, 0, 0);
+	patch->new_name = find_name(line, NULL, 0, 0, NULL);
 	return 0;
 }
 
@@ -656,137 +660,57 @@ static const char *stop_at_slash(const char *line, int llen)
 }
 
 /*
- * This is to extract the same name that appears on "diff --git"
- * line.  We do not find and return anything if it is a rename
- * patch, and it is OK because we will find the name elsewhere.
+ * This is to extract the same name that appears on "diff --git" line.
+ * The name that is returned also has the root applied to it and the
+ * p_value applied.  We do not find and return anything if it is a
+ * rename patch, and it is OK because we will find the name elsewhere.
  * We need to reliably find name only when it is mode-change only,
- * creation or deletion of an empty file.  In any of these cases,
- * both sides are the same name under a/ and b/ respectively.
+ * creation or deletion of an empty file.  In any of these cases, both
+ * sides are the same name under a/ and b/ respectively.
  */
-static char *git_header_name(char *line, int llen)
+static char *git_header_name(char *line)
 {
-	const char *name;
-	const char *second = NULL;
-	size_t len;
+	char *first = NULL, *second = NULL;
 
 	line += strlen("diff --git ");
-	llen -= strlen("diff --git ");
 
-	if (*line == '"') {
-		const char *cp;
-		struct strbuf first = STRBUF_INIT;
-		struct strbuf sp = STRBUF_INIT;
+	/* First we grab the first name */
+	first = find_name(line, NULL, p_value, TERM_SPACE | TERM_TAB, (const char **)&second);
+	if (!first || !second)
+		goto error1;
 
-		if (unquote_c_style(&first, line, &second))
-			goto free_and_fail1;
+	/* Skip to the second name */
+	while (*second && isspace(*(second))) second++;
 
-		/* advance to the first slash */
-		cp = stop_at_slash(first.buf, first.len);
-		/* we do not accept absolute paths */
-		if (!cp || cp == first.buf)
-			goto free_and_fail1;
-		strbuf_remove(&first, 0, cp + 1 - first.buf);
-
-		/*
-		 * second points at one past closing dq of name.
-		 * find the second name.
-		 */
-		while ((second < line + llen) && isspace(*second))
-			second++;
-
-		if (line + llen <= second)
-			goto free_and_fail1;
-		if (*second == '"') {
-			if (unquote_c_style(&sp, second, NULL))
-				goto free_and_fail1;
-			cp = stop_at_slash(sp.buf, sp.len);
-			if (!cp || cp == sp.buf)
-				goto free_and_fail1;
-			/* They must match, otherwise ignore */
-			if (strcmp(cp + 1, first.buf))
-				goto free_and_fail1;
-			strbuf_release(&sp);
-			return strbuf_detach(&first, NULL);
-		}
-
-		/* unquoted second */
-		cp = stop_at_slash(second, line + llen - second);
-		if (!cp || cp == second)
-			goto free_and_fail1;
-		cp++;
-		if (line + llen - cp != first.len + 1 ||
-		    memcmp(first.buf, cp, first.len))
-			goto free_and_fail1;
-		return strbuf_detach(&first, NULL);
-
-	free_and_fail1:
-		strbuf_release(&first);
-		strbuf_release(&sp);
-		return NULL;
-	}
+	/* Grab the second name */
+	second = find_name(second, NULL, p_value, TERM_SPACE | TERM_TAB, NULL);
 
-	/* unquoted first name */
-	name = stop_at_slash(line, llen);
-	if (!name || name == line)
-		return NULL;
-	name++;
+	/* Make sure they are relative paths or we return NULL */
+	if (!second || *second == '/' || *first == '/')
+		goto error2;
 
-	/*
-	 * since the first name is unquoted, a dq if exists must be
-	 * the beginning of the second name.
-	 */
-	for (second = name; second < line + llen; second++) {
-		if (*second == '"') {
-			struct strbuf sp = STRBUF_INIT;
-			const char *np;
-
-			if (unquote_c_style(&sp, second, NULL))
-				goto free_and_fail2;
-
-			np = stop_at_slash(sp.buf, sp.len);
-			if (!np || np == sp.buf)
-				goto free_and_fail2;
-			np++;
-
-			len = sp.buf + sp.len - np;
-			if (len < second - name &&
-			    !strncmp(np, name, len) &&
-			    isspace(name[len])) {
-				/* Good */
-				strbuf_remove(&sp, 0, np - sp.buf);
-				return strbuf_detach(&sp, NULL);
-			}
+	/* First we see if they match, if they do, we are done. */
+	if (strcmp(first, second)) {
+		const char *first_slash, *second_slash;
+		/* If they don't, we check that we don't have a a/<match> b/<match>, if we
+ 		 * do we return one of those so the error messages go through correctly
+		 * later on */
+		first_slash = stop_at_slash(first, strlen(first));
+		second_slash = stop_at_slash(second, strlen(second));
 
-		free_and_fail2:
-			strbuf_release(&sp);
-			return NULL;
-		}
+		/* If this fails, it must be a rename, just return NULL */
+		if (!first_slash || !second_slash || strcmp(first_slash, second_slash))
+			goto error2;
 	}
 
-	/*
-	 * Accept a name only if it shows up twice, exactly the same
-	 * form.
-	 */
-	for (len = 0 ; ; len++) {
-		switch (name[len]) {
-		default:
-			continue;
-		case '\n':
-			return NULL;
-		case '\t': case ' ':
-			second = name+len;
-			for (;;) {
-				char c = *second++;
-				if (c == '\n')
-					return NULL;
-				if (c == '/')
-					break;
-			}
-			if (second[len] == '\n' && !memcmp(name, second, len)) {
-				return xmemdupz(name, len);
-			}
-		}
-	}
+	free(second);
+	return first;
+
+error2:
+	free(second);
+error1:
+	free(first);
+	return NULL;
 }
 
 /* Verify that we recognize the lines following a git header */
@@ -804,14 +728,7 @@ static int parse_git_header(char *line, int len, unsigned int size, struct patch
 	 * or removing or adding empty files), so we get
 	 * the default name from the header.
 	 */
-	patch->def_name = git_header_name(line, len);
-	if (patch->def_name && root) {
-		char *s = xmalloc(root_len + strlen(patch->def_name) + 1);
-		strcpy(s, root);
-		strcpy(s + root_len, patch->def_name);
-		free(patch->def_name);
-		patch->def_name = s;
-	}
+	patch->def_name = git_header_name(line);
 
 	line += len;
 	size -= len;
diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index 83d4ba6..ccba0b8 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -10,9 +10,12 @@ test_description='git apply -p handling.'
 test_expect_success setup '
 	mkdir sub &&
 	echo A >sub/file1 &&
+	echo A >sub/file2 &&
 	cp sub/file1 file1 &&
-	git add sub/file1 &&
+	cp sub/file2 file2 &&
+	git add sub/file1 sub/file2 &&
 	echo B >sub/file1 &&
+	rm sub/file2 &&
 	git diff >patch.file &&
 	rm sub/file1 &&
 	rmdir sub
-- 
1.6.1.1.g448a
