From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/WIP] attr: make attributes depend on file type
Date: Mon, 28 Feb 2011 16:26:18 +0100
Message-ID: <f35b1b4b57a563f57f169602440b3b0abdef5a07.1298906628.git.git@drmicha.warpmail.net>
References: <20110228130850.GB9054@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 28 16:29:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu52i-0006im-NY
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 16:29:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab1B1P3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 10:29:44 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50792 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753674Ab1B1P3n (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 10:29:43 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E6B9120709;
	Mon, 28 Feb 2011 10:29:42 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 28 Feb 2011 10:29:42 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=OyjyvF5PHRUqZKEWzrUiQXlh7FY=; b=HhzG9N8QnVjqAXjbB1j4iNfXt5jBFmNfMIF+iIH82YITQ4F62In8z3ABNc0jcfafSOSXswblOEZLzzZrRjZ+OlYj7bzcibAukRXgbRLB0ECG3YGSxIxdzcImVxdjrPJuKBcveIabm5sx80bxtgYu4qkbToaI9PzAAzlHlfSPbeg=
X-Sasl-enc: PdCGP30uPzyaxILq56DwejF+VAccnwSFI25RE3sgUpJj 1298906982
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2FF2F448A94;
	Mon, 28 Feb 2011 10:29:42 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.257.gb09fa
In-Reply-To: <20110228130850.GB9054@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168116>

This is a whether balloon patch (to check whether this balloons or not,
uhm). Hit it hard, not me ;)

It's part of the way to revive the old idea of making attributes depend
on file type. I am not following the old path

pattern is_symlink otherattr

because that would mean something which looks like an attribute
(is_symlink) but is not. Instead,

symlink:pattern attrs

is to specify attrs for pattern if it is a symlink. So, e.g.,

symlink:* diff=symlink

together with a nice diff.symlink.textconv displays symlinks nicely.
Most notable rough edges:

- git_checkattr() gets a new mode parameter. I've stuck it in where I
  could, 0 anywhere else. This is appropriate in many places (where we
know IS_REG a forteriori) but I'm not sure about all of them.

- We/someone could teach git_checkattr other prefixes.

- It is tested with one (1) symlink and works!

- I would bundle it with Jeff's doc and test ;)

- This is not a real commit message.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 archive.c              |    2 +-
 attr.c                 |    5 ++++-
 attr.h                 |    2 +-
 builtin/check-attr.c   |    7 ++++++-
 builtin/pack-objects.c |    2 +-
 convert.c              |    4 ++--
 diff.c                 |    5 ++---
 grep.c                 |    2 +-
 ll-merge.c             |    4 ++--
 userdiff.c             |    4 ++--
 userdiff.h             |    2 +-
 ws.c                   |    2 +-
 12 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/archive.c b/archive.c
index 1944ed4..2870f04 100644
--- a/archive.c
+++ b/archive.c
@@ -124,7 +124,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	path_without_prefix = path.buf + args->baselen;
 
 	setup_archive_check(check);
-	if (!git_checkattr(path_without_prefix, ARRAY_SIZE(check), check)) {
+	if (!git_checkattr(path_without_prefix, ARRAY_SIZE(check), check, mode)) {
 		if (ATTR_TRUE(check[0].value))
 			return 0;
 		convert = ATTR_TRUE(check[1].value);
diff --git a/attr.c b/attr.c
index 6aff695..c4481ac 100644
--- a/attr.c
+++ b/attr.c
@@ -708,7 +708,7 @@ static int macroexpand_one(int attr_nr, int rem)
 	return rem;
 }
 
-int git_checkattr(const char *path, int num, struct git_attr_check *check)
+int git_checkattr(const char *path, int num, struct git_attr_check *check, unsigned short mode)
 {
 	struct attr_stack *stk;
 	const char *cp;
@@ -718,6 +718,9 @@ int git_checkattr(const char *path, int num, struct git_attr_check *check)
 	for (i = 0; i < attr_nr; i++)
 		check_all_attr[i].value = ATTR__UNKNOWN;
 
+	if (S_ISLNK(mode))
+		path = prefix_filename("symlink:", strlen("symlink:"), path);
+	/* else if (IS_WHATEVER(mode)) do_what_you_feel_like */
 	pathlen = strlen(path);
 	cp = strrchr(path, '/');
 	if (!cp)
diff --git a/attr.h b/attr.h
index 8b3f19b..1af0bd4 100644
--- a/attr.h
+++ b/attr.h
@@ -29,7 +29,7 @@ struct git_attr_check {
 	const char *value;
 };
 
-int git_checkattr(const char *path, int, struct git_attr_check *);
+int git_checkattr(const char *path, int, struct git_attr_check *, unsigned short mode);
 
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 3016d29..30be2c2 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -24,7 +24,12 @@ static void check_attr(int cnt, struct git_attr_check *check,
 	const char** name, const char *file)
 {
 	int j;
-	if (git_checkattr(file, cnt, check))
+	unsigned int mode = 0;
+	struct stat st;
+
+	if (!lstat(file, &st))
+		mode = st.st_mode;
+	if (git_checkattr(file, cnt, check, mode))
 		die("git_checkattr died");
 	for (j = 0; j < cnt; j++) {
 		const char *value = check[j].value;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b0503b2..4e9ff68 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -633,7 +633,7 @@ static int no_try_delta(const char *path)
 	struct git_attr_check check[1];
 
 	setup_delta_attr_check(check);
-	if (git_checkattr(path, ARRAY_SIZE(check), check))
+	if (git_checkattr(path, ARRAY_SIZE(check), check, 0))
 		return 0;
 	if (ATTR_FALSE(check->value))
 		return 1;
diff --git a/convert.c b/convert.c
index d5aebed..d5c2b9c 100644
--- a/convert.c
+++ b/convert.c
@@ -736,7 +736,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 	const char *filter = NULL;
 
 	setup_convert_check(check);
-	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
+	if (!git_checkattr(path, ARRAY_SIZE(check), check, 0)) {
 		struct convert_driver *drv;
 		action = git_path_check_crlf(path, check + 4);
 		if (action == CRLF_GUESS)
@@ -773,7 +773,7 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 	const char *filter = NULL;
 
 	setup_convert_check(check);
-	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
+	if (!git_checkattr(path, ARRAY_SIZE(check), check, 0)) {
 		struct convert_driver *drv;
 		action = git_path_check_crlf(path, check + 4);
 		if (action == CRLF_GUESS)
diff --git a/diff.c b/diff.c
index 6640857..22b5d94 100644
--- a/diff.c
+++ b/diff.c
@@ -1784,8 +1784,7 @@ static void diff_filespec_load_driver(struct diff_filespec *one)
 	if (one->driver)
 		return;
 
-	if (S_ISREG(one->mode))
-		one->driver = userdiff_find_by_path(one->path);
+	one->driver = userdiff_find_by_path(one->path, one->mode);
 
 	/* Fallback to default settings */
 	if (!one->driver)
@@ -2683,7 +2682,7 @@ static void run_diff_cmd(const char *pgm,
 	if (!DIFF_OPT_TST(o, ALLOW_EXTERNAL))
 		pgm = NULL;
 	else {
-		struct userdiff_driver *drv = userdiff_find_by_path(attr_path);
+		struct userdiff_driver *drv = userdiff_find_by_path(attr_path, two->mode);
 		if (drv && drv->external)
 			pgm = drv->external;
 	}
diff --git a/grep.c b/grep.c
index 63c4280..05a77fc 100644
--- a/grep.c
+++ b/grep.c
@@ -877,7 +877,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	memset(&xecfg, 0, sizeof(xecfg));
 	if (opt->funcname && !opt->unmatch_name_only && !opt->status_only &&
 	    !opt->name_only && !binary_match_only && !collect_hits) {
-		struct userdiff_driver *drv = userdiff_find_by_path(name);
+		struct userdiff_driver *drv = userdiff_find_by_path(name, 0);
 		if (drv && drv->funcname.pattern) {
 			const struct userdiff_funcname *pe = &drv->funcname;
 			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
diff --git a/ll-merge.c b/ll-merge.c
index 6ce512e..3f351e3 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -330,7 +330,7 @@ static int git_path_check_merge(const char *path, struct git_attr_check check[2]
 		check[0].attr = git_attr("merge");
 		check[1].attr = git_attr("conflict-marker-size");
 	}
-	return git_checkattr(path, 2, check);
+	return git_checkattr(path, 2, check, 0);
 }
 
 static void normalize_file(mmfile_t *mm, const char *path)
@@ -387,7 +387,7 @@ int ll_merge_marker_size(const char *path)
 
 	if (!check.attr)
 		check.attr = git_attr("conflict-marker-size");
-	if (!git_checkattr(path, 1, &check) && check.value) {
+	if (!git_checkattr(path, 1, &check, 0) && check.value) {
 		marker_size = atoi(check.value);
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
diff --git a/userdiff.c b/userdiff.c
index 1ff4797..e5d0adf 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -245,7 +245,7 @@ struct userdiff_driver *userdiff_find_by_name(const char *name) {
 	return userdiff_find_by_namelen(name, len);
 }
 
-struct userdiff_driver *userdiff_find_by_path(const char *path)
+struct userdiff_driver *userdiff_find_by_path(const char *path, unsigned short mode)
 {
 	static struct git_attr *attr;
 	struct git_attr_check check;
@@ -256,7 +256,7 @@ struct userdiff_driver *userdiff_find_by_path(const char *path)
 
 	if (!path)
 		return NULL;
-	if (git_checkattr(path, 1, &check))
+	if (git_checkattr(path, 1, &check, mode))
 		return NULL;
 
 	if (ATTR_TRUE(check.value))
diff --git a/userdiff.h b/userdiff.h
index 942d594..e516f1d 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -21,6 +21,6 @@ struct userdiff_driver {
 
 int userdiff_config(const char *k, const char *v);
 struct userdiff_driver *userdiff_find_by_name(const char *name);
-struct userdiff_driver *userdiff_find_by_path(const char *path);
+struct userdiff_driver *userdiff_find_by_path(const char *path, unsigned short mode);
 
 #endif /* USERDIFF */
diff --git a/ws.c b/ws.c
index 9fb9b14..51929d3 100644
--- a/ws.c
+++ b/ws.c
@@ -88,7 +88,7 @@ unsigned whitespace_rule(const char *pathname)
 	struct git_attr_check attr_whitespace_rule;
 
 	setup_whitespace_attr_check(&attr_whitespace_rule);
-	if (!git_checkattr(pathname, 1, &attr_whitespace_rule)) {
+	if (!git_checkattr(pathname, 1, &attr_whitespace_rule, 0)) {
 		const char *value;
 
 		value = attr_whitespace_rule.value;
-- 
1.7.4.1.257.gb09fa
