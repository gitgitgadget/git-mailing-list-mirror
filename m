From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v5 2/4] Add per-repository eol normalization
Date: Wed, 19 May 2010 22:43:10 +0200
Message-ID: <57d9db59805b4e1d0241e4cde4d514a4dd8a7829.1274301351.git.eyvind.bernhardsen@gmail.com>
References: <cover.1274301351.git.eyvind.bernhardsen@gmail.com>
Cc: msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 19 22:43:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEq6v-0005Dv-Ee
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 22:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234Ab0ESUnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 16:43:23 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:36733 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543Ab0ESUnU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 16:43:20 -0400
Received: by mail-ew0-f216.google.com with SMTP id 8so2831435ewy.28
        for <git@vger.kernel.org>; Wed, 19 May 2010 13:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=aRV7TbPYLo5p4tAytO+DtxCm3J25ee/cQjW+YuL05sg=;
        b=jI0gT5YjI8Q2NXGoGkFT+myUOZc042f9JGDZZ51xIrGX6XqIf9zLWvF+CqLCWLVtDC
         L/z45Po9OTPXQh1zgSlyObpXLQnPQ1dMRc8gfN7Li3mMaAkA/xpLSEGfsNr6HnaztQV3
         pqZzdvc1ASyc6xyMq6Dnn+dsj4tQmO8M/lw4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CqgwzLoH4ShC/D7/aEqZZdcYs49alLylDmS1NpUAKAFHlNWiDPNPQsf2D1pMNaEpkO
         kxhMiXayLN2AQUxhgRdwNRVZIownCR1hrRAfp26Aa/9ldrs5MSDyHrtUCTMNZUET7GpB
         BwyXVyU/2ea7jcnrkv+4w/lOmxIu0JvqNNr9Y=
Received: by 10.213.58.140 with SMTP id g12mr3604137ebh.52.1274301799010;
        Wed, 19 May 2010 13:43:19 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm3814591ewy.9.2010.05.19.13.43.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 May 2010 13:43:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.5.gc3ee8
In-Reply-To: <cover.1274301351.git.eyvind.bernhardsen@gmail.com>
In-Reply-To: <cover.1274301351.git.eyvind.bernhardsen@gmail.com>
References: <cover.1274301351.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147342>

Change the semantics of the "crlf" attribute so that it enables
end-of-line normalization when it is set, regardless of "core.autocrlf".

Add a new setting for "crlf": "auto", which enables end-of-line
conversion but does not override the automatic text file detection.

Add a new attribute "eol" with possible values "crlf" and "lf".  When
set, this attribute enables normalization and forces git to use CRLF or
LF line endings in the working directory, respectively.

The line ending style to be used for normalized text files in the
working directory is set using "core.autocrlf".  When it is set to
"true", CRLFs are used in the working directory; when set to "input" or
"false", LFs are used.

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 Documentation/config.txt        |    4 +-
 Documentation/gitattributes.txt |  152 ++++++++++++++++++++++++++++++--------
 cache.h                         |    9 ++-
 config.c                        |    2 +-
 convert.c                       |  117 +++++++++++++++++++++---------
 environment.c                   |    2 +-
 t/t0025-crlf-auto.sh            |   12 ++--
 7 files changed, 222 insertions(+), 76 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 92f851e..4d3c472 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -208,8 +208,8 @@ core.autocrlf::
 	based on the file's contents.  See linkgit:gitattributes[5].
 
 core.safecrlf::
-	If true, makes git check if converting `CRLF` as controlled by
-	`core.autocrlf` is reversible.  Git will verify if a command
+	If true, makes git check if converting `CRLF` is reversible when
+	end-of-line conversion is active.  Git will verify if a command
 	modifies a file in the work tree either directly or indirectly.
 	For example, committing a file followed by checking out the
 	same file should yield the original file in the work tree.  If
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index d892e64..076f313 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -95,50 +95,138 @@ repository upon 'git add' and 'git commit'.
 `crlf`
 ^^^^^^
 
-This attribute controls the line-ending convention.
+This attribute enables and controls end-of-line normalization.  When a
+text file is normalized, its line endings are converted to LF in the
+repository.  To control what line ending style is used in the working
+directory, use the `eol` attribute for a single file and the
+`core.autocrlf` configuration variable for all text files.
 
 Set::
 
-	Setting the `crlf` attribute on a path is meant to mark
-	the path as a "text" file.  'core.autocrlf' conversion
-	takes place without guessing the content type by
-	inspection.
+	Setting the `crlf` attribute on a path enables end-of-line
+	normalization and marks the path as a text file.  End-of-line
+	conversion takes place without guessing the content type.
 
 Unset::
 
 	Unsetting the `crlf` attribute on a path tells git not to
 	attempt any end-of-line conversion upon checkin or checkout.
 
+Set to string value "auto"::
+
+	When `crlf` is set to "auto", the path is marked for automatic
+	end-of-line normalization.  If git decides that the content is
+	text, its line endings are normalized to LF on checkin.
+
 Unspecified::
 
-	Unspecified `crlf` attribute tells git to apply the
-	`core.autocrlf` conversion when the file content looks
-	like text.
+	If the `crlf` attribute is unspecified, git uses the `eol`
+	attribute and the `core.autocrlf` configuration variable to
+	determine if the file should be converted.
 
-Set to string value "input"::
+Any other value causes git to act as if `crlf` has been left
+unspecified.
 
-	This is similar to setting the attribute to `true`, but
-	also forces git to act as if `core.autocrlf` is set to
-	`input` for the path.
+`eol`
+^^^^^
 
-Any other value set to `crlf` attribute is ignored and git acts
-as if the attribute is left unspecified.
+This attribute sets a specific line-ending style to be used in the
+working directory.  It enables end-of-line normalization without any
+content checks, similar to setting the `crlf` attribute.
 
+Set to string value "crlf"::
 
-The `core.autocrlf` conversion
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+	This setting forces git to normalize line endings on checkin
+	and convert them to CRLF when the file is checked out,
+	regardless of `crlf` and `core.autocrlf`.
+
+Set to string value "lf"::
+
+	This setting forces git to normalize line endings to LF on
+	checkin and prevents conversion to CRLF when the file is
+	checked out, regardless of `crlf` and `core.autocrlf`.
+	`crlf=input` is a backwards compatibility alias for `eol=lf`.
+
+End-of-line conversion
+^^^^^^^^^^^^^^^^^^^^^^
+
+While git normally leaves file contents alone, it can be configured to
+normalize line endings to LF in the repository and, optionally, to
+convert them to CRLF when files are checked out.
+
+Here is an example that will make git normalize .txt, .vcproj and .sh
+files, ensure that .vcproj files have CRLF and .sh files have LF in
+the working directory, and prevent .jpg files from being normalized
+regardless of their content.
+
+------------------------
+*.txt		crlf
+*.vcproj	eol=crlf
+*.sh		eol=lf
+*.jpg		-crlf
+------------------------
+
+Other source code management systems normalize all text files in their
+repositories, and there are two ways to enable similar automatic
+normalization in git.
+
+If you simply want to have CRLF line endings in your working directory
+regardless of the repository you are working with, you can set the
+config variable "core.autocrlf" without changing any attributes.
+
+------------------------
+[core]
+	autocrlf = true
+------------------------
+
+This does not force normalization of all text files, but does ensure
+that text files that you introduce to the repository have their line
+endings normalized to LF when they are added, and that files that are
+already normalized in the repository stay normalized.  You can also
+set `autocrlf` to "input" to have automatic normalization of new text
+files without conversion to CRLF in the working directory.
+
+If you want to interoperate with a source code management system that
+enforces end-of-line normalization, or you simply want all text files
+in your repository to be normalized, you should instead set the `crlf`
+attribute to "auto" for _all_ files.
+
+------------------------
+*	crlf=auto
+------------------------
+
+This ensures that all files that git considers to be text will have
+normalized (LF) line endings in the repository.
 
-If the configuration variable `core.autocrlf` is false, no
-conversion is done.
+NOTE: When `crlf=auto` normalization is enabled in an existing
+repository, any text files containing CRLFs should be normalized.  If
+they are not they will be normalized the next time someone tries to
+change them, causing unfortunate misattribution.  From a clean working
+directory:
 
-When `core.autocrlf` is true, it means that the platform wants
-CRLF line endings for files in the working tree, and you want to
-convert them back to the normal LF line endings when checking
-in to the repository.
+-------------------------------------------------
+$ echo "* crlf=auto" >>.gitattributes
+$ rm .git/index     # Remove the index to force git to
+$ git reset         # re-scan the working directory
+$ git status        # Show files that will be normalized
+$ git add -u
+$ git add .gitattributes
+$ git commit -m "Introduce end-of-line normalization"
+-------------------------------------------------
 
-When `core.autocrlf` is set to "input", line endings are
-converted to LF upon checkin, but there is no conversion done
-upon checkout.
+If any files that should not be normalized show up in 'git status',
+unset their `crlf` attribute before running 'git add -u'.
+
+------------------------
+manual.pdf	-crlf
+------------------------
+
+Conversely, text files that git does not detect can have normalization
+enabled manually.
+
+------------------------
+weirdchars.txt	crlf
+------------------------
 
 If `core.safecrlf` is set to "true" or "warn", git verifies if
 the conversion is reversible for the current setting of
diff --git a/cache.h b/cache.h
index 5eb0573..d1f669e 100644
--- a/cache.h
+++ b/cache.h
@@ -547,7 +547,6 @@ extern int core_compression_seen;
 extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
-extern int auto_crlf;
 extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
@@ -561,6 +560,14 @@ enum safe_crlf {
 
 extern enum safe_crlf safe_crlf;
 
+enum auto_crlf {
+	AUTO_CRLF_FALSE = 0,
+	AUTO_CRLF_TRUE = 1,
+	AUTO_CRLF_INPUT = -1,
+};
+
+extern enum auto_crlf auto_crlf;
+
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
 	BRANCH_TRACK_NEVER = 0,
diff --git a/config.c b/config.c
index 6963fbe..b60a1ff 100644
--- a/config.c
+++ b/config.c
@@ -461,7 +461,7 @@ static int git_default_core_config(const char *var, const char *value)
 
 	if (!strcmp(var, "core.autocrlf")) {
 		if (value && !strcasecmp(value, "input")) {
-			auto_crlf = -1;
+			auto_crlf = AUTO_CRLF_INPUT;
 			return 0;
 		}
 		auto_crlf = git_config_bool(var, value);
diff --git a/convert.c b/convert.c
index 46622b0..98bc029 100644
--- a/convert.c
+++ b/convert.c
@@ -8,13 +8,23 @@
  * This should use the pathname to decide on whether it wants to do some
  * more interesting conversions (automatic gzip/unzip, general format
  * conversions etc etc), but by default it just does automatic CRLF<->LF
- * translation when the "auto_crlf" option is set.
+ * translation when the "crlf" attribute or "auto_crlf" option is set.
  */
 
-#define CRLF_GUESS	(-1)
-#define CRLF_BINARY	0
-#define CRLF_TEXT	1
-#define CRLF_INPUT	2
+enum action {
+	CRLF_GUESS = -1,
+	CRLF_BINARY = 0,
+	CRLF_TEXT,
+	CRLF_INPUT,
+	CRLF_CRLF,
+	CRLF_AUTO,
+};
+
+enum eol {
+	EOL_UNSET,
+	EOL_LF,
+	EOL_CRLF,
+};
 
 struct text_stat {
 	/* NUL, CR, LF and CRLF counts */
@@ -89,13 +99,14 @@ static int is_binary(unsigned long size, struct text_stat *stats)
 	return 0;
 }
 
-static void check_safe_crlf(const char *path, int action,
+static void check_safe_crlf(const char *path, enum action action,
                             struct text_stat *stats, enum safe_crlf checksafe)
 {
 	if (!checksafe)
 		return;
 
-	if (action == CRLF_INPUT || auto_crlf <= 0) {
+	if (action == CRLF_INPUT ||
+	    (action == CRLF_GUESS && auto_crlf == AUTO_CRLF_INPUT)) {
 		/*
 		 * CRLFs would not be restored by checkout:
 		 * check if we'd remove CRLFs
@@ -106,7 +117,8 @@ static void check_safe_crlf(const char *path, int action,
 			else /* i.e. SAFE_CRLF_FAIL */
 				die("CRLF would be replaced by LF in %s.", path);
 		}
-	} else if (auto_crlf > 0) {
+	} else if (action == CRLF_CRLF ||
+		   (action == CRLF_GUESS && auto_crlf == AUTO_CRLF_TRUE)) {
 		/*
 		 * CRLFs would be added by checkout:
 		 * check if we have "naked" LFs
@@ -158,17 +170,18 @@ static int has_cr_in_index(const char *path)
 }
 
 static int crlf_to_git(const char *path, const char *src, size_t len,
-                       struct strbuf *buf, int action, enum safe_crlf checksafe)
+		       struct strbuf *buf, enum action action, enum safe_crlf checksafe)
 {
 	struct text_stat stats;
 	char *dst;
 
-	if ((action == CRLF_BINARY) || !auto_crlf || !len)
+	if (action == CRLF_BINARY ||
+	    (action == CRLF_GUESS && auto_crlf == AUTO_CRLF_FALSE) || !len)
 		return 0;
 
 	gather_stats(src, len, &stats);
 
-	if (action == CRLF_GUESS) {
+	if (action == CRLF_AUTO || action == CRLF_GUESS) {
 		/*
 		 * We're currently not going to even try to convert stuff
 		 * that has bare CR characters. Does anybody do that crazy
@@ -183,12 +196,14 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		if (is_binary(len, &stats))
 			return 0;
 
-		/*
-		 * If the file in the index has any CR in it, do not convert.
-		 * This is the new safer autocrlf handling.
-		 */
-		if (has_cr_in_index(path))
-			return 0;
+		if (action == CRLF_GUESS) {
+			/*
+			 * If the file in the index has any CR in it, do not convert.
+			 * This is the new safer autocrlf handling.
+			 */
+			if (has_cr_in_index(path))
+				return 0;
+		}
 	}
 
 	check_safe_crlf(path, action, &stats, checksafe);
@@ -201,7 +216,7 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 	if (strbuf_avail(buf) + buf->len < len)
 		strbuf_grow(buf, len - buf->len);
 	dst = buf->buf;
-	if (action == CRLF_GUESS) {
+	if (action == CRLF_AUTO || action == CRLF_GUESS) {
 		/*
 		 * If we guessed, we already know we rejected a file with
 		 * lone CR, and we can strip a CR without looking at what
@@ -224,13 +239,13 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 }
 
 static int crlf_to_worktree(const char *path, const char *src, size_t len,
-                            struct strbuf *buf, int action)
+			    struct strbuf *buf, enum action action)
 {
 	char *to_free = NULL;
 	struct text_stat stats;
 
 	if ((action == CRLF_BINARY) || (action == CRLF_INPUT) ||
-	    auto_crlf <= 0)
+	    (action != CRLF_CRLF && auto_crlf != AUTO_CRLF_TRUE))
 		return 0;
 
 	if (!len)
@@ -246,11 +261,13 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 	if (stats.lf == stats.crlf)
 		return 0;
 
-	if (action == CRLF_GUESS) {
-		/* If we have any CR or CRLF line endings, we do not touch it */
-		/* This is the new safer autocrlf-handling */
-		if (stats.cr > 0 || stats.crlf > 0)
-			return 0;
+	if (action == CRLF_AUTO || action == CRLF_GUESS) {
+		if (action == CRLF_GUESS) {
+			/* If we have any CR or CRLF line endings, we do not touch it */
+			/* This is the new safer autocrlf-handling */
+			if (stats.cr > 0 || stats.crlf > 0)
+				return 0;
+		}
 
 		/* If we have any bare CR characters, we're not going to touch it */
 		if (stats.cr != stats.crlf)
@@ -424,11 +441,13 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 static void setup_convert_check(struct git_attr_check *check)
 {
 	static struct git_attr *attr_crlf;
+	static struct git_attr *attr_eol;
 	static struct git_attr *attr_ident;
 	static struct git_attr *attr_filter;
 
 	if (!attr_crlf) {
 		attr_crlf = git_attr("crlf");
+		attr_eol = git_attr("eol");
 		attr_ident = git_attr("ident");
 		attr_filter = git_attr("filter");
 		user_convert_tail = &user_convert;
@@ -437,6 +456,7 @@ static void setup_convert_check(struct git_attr_check *check)
 	check[0].attr = attr_crlf;
 	check[1].attr = attr_ident;
 	check[2].attr = attr_filter;
+	check[3].attr = attr_eol;
 }
 
 static int count_ident(const char *cp, unsigned long size)
@@ -593,9 +613,24 @@ static int git_path_check_crlf(const char *path, struct git_attr_check *check)
 		;
 	else if (!strcmp(value, "input"))
 		return CRLF_INPUT;
+	else if (!strcmp(value, "auto"))
+		return CRLF_AUTO;
 	return CRLF_GUESS;
 }
 
+static int git_path_check_eol(const char *path, struct git_attr_check *check)
+{
+	const char *value = check->value;
+
+	if (ATTR_UNSET(value))
+		;
+	else if (!strcmp(value, "lf"))
+		return EOL_LF;
+	else if (!strcmp(value, "crlf"))
+		return EOL_CRLF;
+	return EOL_UNSET;
+}
+
 static struct convert_driver *git_path_check_convert(const char *path,
 					     struct git_attr_check *check)
 {
@@ -617,20 +652,32 @@ static int git_path_check_ident(const char *path, struct git_attr_check *check)
 	return !!ATTR_TRUE(value);
 }
 
+enum action determine_action(enum action crlf_attr, enum eol eol_attr) {
+	if (crlf_attr == CRLF_BINARY)
+		return CRLF_BINARY;
+	if (eol_attr == EOL_LF)
+		return CRLF_INPUT;
+	if (eol_attr == EOL_CRLF)
+		return CRLF_CRLF;
+	return crlf_attr;
+}
+
 int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
-	struct git_attr_check check[3];
-	int crlf = CRLF_GUESS;
+	struct git_attr_check check[4];
+	enum action action = CRLF_GUESS;
+	enum eol eol = EOL_UNSET;
 	int ident = 0, ret = 0;
 	const char *filter = NULL;
 
 	setup_convert_check(check);
 	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
 		struct convert_driver *drv;
-		crlf = git_path_check_crlf(path, check + 0);
+		action = git_path_check_crlf(path, check + 0);
 		ident = git_path_check_ident(path, check + 1);
 		drv = git_path_check_convert(path, check + 2);
+		eol = git_path_check_eol(path, check + 3);
 		if (drv && drv->clean)
 			filter = drv->clean;
 	}
@@ -640,7 +687,8 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_git(path, src, len, dst, crlf, checksafe);
+	action = determine_action(action, eol);
+	ret |= crlf_to_git(path, src, len, dst, action, checksafe);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
@@ -650,17 +698,19 @@ int convert_to_git(const char *path, const char *src, size_t len,
 
 int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst)
 {
-	struct git_attr_check check[3];
-	int crlf = CRLF_GUESS;
+	struct git_attr_check check[4];
+	enum action action = CRLF_GUESS;
+	enum eol eol = EOL_UNSET;
 	int ident = 0, ret = 0;
 	const char *filter = NULL;
 
 	setup_convert_check(check);
 	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
 		struct convert_driver *drv;
-		crlf = git_path_check_crlf(path, check + 0);
+		action = git_path_check_crlf(path, check + 0);
 		ident = git_path_check_ident(path, check + 1);
 		drv = git_path_check_convert(path, check + 2);
+		eol = git_path_check_eol(path, check + 3);
 		if (drv && drv->smudge)
 			filter = drv->smudge;
 	}
@@ -670,7 +720,8 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_worktree(path, src, len, dst, crlf);
+	action = determine_action(action, eol);
+	ret |= crlf_to_worktree(path, src, len, dst, action);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
diff --git a/environment.c b/environment.c
index 876c5e5..db4a5e9 100644
--- a/environment.c
+++ b/environment.c
@@ -38,7 +38,7 @@ const char *pager_program;
 int pager_use_color = 1;
 const char *editor_program;
 const char *excludes_file;
-int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
+enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int read_replace_refs = 1;
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index 2c98338..2781f15 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -39,7 +39,7 @@ test_expect_success 'default settings cause no changes' '
 	test -z "$onediff" -a -z "$twodiff" -a -z "$threediff"
 '
 
-test_expect_failure 'crlf=true causes a CRLF file to be normalized' '
+test_expect_success 'crlf=true causes a CRLF file to be normalized' '
 
 	rm -f .gitattributes tmp one two three &&
 	echo "two crlf" > .gitattributes &&
@@ -51,7 +51,7 @@ test_expect_failure 'crlf=true causes a CRLF file to be normalized' '
 	test -n "$twodiff"
 '
 
-test_expect_failure 'eol=crlf gives a normalized file CRLFs with autocrlf=false' '
+test_expect_success 'eol=crlf gives a normalized file CRLFs with autocrlf=false' '
 
 	rm -f .gitattributes tmp one two three &&
 	git config core.autocrlf false &&
@@ -63,7 +63,7 @@ test_expect_failure 'eol=crlf gives a normalized file CRLFs with autocrlf=false'
 	test -z "$onediff"
 '
 
-test_expect_failure 'eol=crlf gives a normalized file CRLFs with autocrlf=input' '
+test_expect_success 'eol=crlf gives a normalized file CRLFs with autocrlf=input' '
 
 	rm -f .gitattributes tmp one two three &&
 	git config core.autocrlf input &&
@@ -75,7 +75,7 @@ test_expect_failure 'eol=crlf gives a normalized file CRLFs with autocrlf=input'
 	test -z "$onediff"
 '
 
-test_expect_failure 'eol=lf gives a normalized file LFs with autocrlf=true' '
+test_expect_success 'eol=lf gives a normalized file LFs with autocrlf=true' '
 
 	rm -f .gitattributes tmp one two three &&
 	git config core.autocrlf true &&
@@ -101,7 +101,7 @@ test_expect_success 'autocrlf=true does not normalize CRLF files' '
 	test -z "$onediff" -a -z "$twodiff" -a -z "$threediff"
 '
 
-test_expect_failure 'crlf=auto, autocrlf=true _does_ normalize CRLF files' '
+test_expect_success 'crlf=auto, autocrlf=true _does_ normalize CRLF files' '
 
 	rm -f .gitattributes tmp one two three &&
 	git config core.autocrlf true &&
@@ -128,7 +128,7 @@ test_expect_success 'crlf=auto, autocrlf=true does not normalize binary files' '
 	test -z "$threediff"
 '
 
-test_expect_failure 'eol=crlf _does_ normalize binary files' '
+test_expect_success 'eol=crlf _does_ normalize binary files' '
 
 	rm -f .gitattributes tmp one two three &&
 	echo "three eol=crlf" > .gitattributes &&
-- 
1.7.1.5.gc3ee8
