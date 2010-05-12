From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v3 3/5] Add per-repository eol normalization
Date: Thu, 13 May 2010 01:00:53 +0200
Message-ID: <0d500b523d9c184fe2a2e12c8772ac3d316fe7d1.1273700831.git.eyvind.bernhardsen@gmail.com>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com>
Cc: msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 01:01:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCKva-0004Tr-Dd
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 01:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758448Ab0ELXBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 19:01:12 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:45400 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900Ab0ELXBF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 19:01:05 -0400
Received: by ewy8 with SMTP id 8so355550ewy.28
        for <git@vger.kernel.org>; Wed, 12 May 2010 16:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8R9g3W0IGCnL84BGCQqVXHfzf6W0u0NUYZ38qgAbCvs=;
        b=iTNS431tgJe8uJeRVTkLYvUck9pErnvuNivKykPZHtNFKvaD+OBz7zVLpecfK4xpfK
         7eNhlimZDOHpoTqeIwAFBpMdeAyd240EqUPurhTdAI1eYC7kfPJ2wdu1351/drh9mtWL
         iTQvCaEQMOjOZIUlf0TKbOaSkOGW/Db6Nuf/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mwIZtgNN+nPzJsv4CcU4GLCBcfCdipFLkHbrKKVWoykge27dNjcDeQQk9bIxbIUPHc
         Embyd+xcz8bbL7O00+e2JErVX7eSbYkxd8yBkg1rmtHBSQTxlHTlrks2UhLxDJwNYFhD
         c+StYhu3zXlFWyhy0coBbXNQhy9X1ckaHqRWQ=
Received: by 10.213.66.142 with SMTP id n14mr1008065ebi.6.1273705264003;
        Wed, 12 May 2010 16:01:04 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 15sm365675ewy.4.2010.05.12.16.01.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 16:01:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.5.gd739a
In-Reply-To: <cover.1273700831.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146964>

Change the semantics of the "crlf" attribute so that it enables
end-of-line normalization when it is set, regardless of "core.autocrlf".

Add new settings for "crlf": "auto", which enables end-of-line
conversion but does not override the automatic text file detection, and
"crlf" and "lf", which force normalization of the file and set which
line ending it should have in the working directory.

The effect of this change is that a project can enable end-of-line
normalization for all files.  This is similar to the "core.autocrlf"
configuration variable, but since the setting is part of the content, it
is cloned when the project is cloned and can be changed if a previously
un-normalized repository is normalized.

The line ending style to be used for normalized text files in the
working directory is set using "core.autocrlf".  When it is set to
"true", CRLFs are used in the working directory; when set to "input" or
"false", LFs are used.

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 Documentation/config.txt        |    4 +-
 Documentation/gitattributes.txt |  142 +++++++++++++++++++++++++++++++--------
 cache.h                         |    9 ++-
 config.c                        |    2 +-
 convert.c                       |   71 ++++++++++++-------
 environment.c                   |    2 +-
 t/t0025-crlf-auto.sh            |   10 ++--
 7 files changed, 176 insertions(+), 64 deletions(-)

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
index d892e64..bb3b446 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -95,50 +95,136 @@ repository upon 'git add' and 'git commit'.
 `crlf`
 ^^^^^^
 
-This attribute controls the line-ending convention.
+This attribute enables and controls end-of-line normalization.  When a
+text file is normalized, its line endings are converted to LF in the
+repository.  Text files can have their line endings converted to
+CRLF in the working directory, using the `crlf` attribute for
+individual files or the `core.autocrlf` configuration variable for all
+files.
 
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
 
-Unspecified::
+Set to string value "auto"::
+
+	When `crlf` is set to "auto", the path is marked for automatic
+	end-of-line normalization.  If git decides that the content is
+	text, its line endings are normalized to LF on checkin.
 
-	Unspecified `crlf` attribute tells git to apply the
-	`core.autocrlf` conversion when the file content looks
-	like text.
+Set to string value "crlf"::
 
-Set to string value "input"::
+	This is similar to setting the attribute to `true`, but forces
+	git to convert line endings to CRLF when the file is checked
+	out, regardless of `core.autocrlf`.
+
+Set to string value "lf"::
 
 	This is similar to setting the attribute to `true`, but
-	also forces git to act as if `core.autocrlf` is set to
-	`input` for the path.
+	prevents git from converting line endings to CRLF when the
+	file is checked out, regardless of `core.autocrlf`.  "input"
+	is an alias for "lf".
 
-Any other value set to `crlf` attribute is ignored and git acts
-as if the attribute is left unspecified.
+Unspecified::
 
+	Leaving the `crlf` attribute unspecified tells git to apply
+	end-of-line normalization only if the `core.autocrlf`
+	configuration variable is set, the content appears to be text,
+	and the file is either new or already normalized in the
+	repository.
 
-The `core.autocrlf` conversion
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+Any other value causes git to act as if `crlf` has been left
+unspecified.
+
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
+*.vcproj	crlf=crlf
+*.sh		crlf=lf
+*.jpg		-crlf
+------------------------
+
+Other source code management systems normalize all text files in their
+repositories, and there are two ways to enable similar automatic
+normalization in git.
 
-If the configuration variable `core.autocrlf` is false, no
-conversion is done.
+If you simply want to have CRLF line endings in your working directory
+regardless of the repository you are working in, you can set the
+config variable "core.autocrlf" without changing any attributes.
 
-When `core.autocrlf` is true, it means that the platform wants
-CRLF line endings for files in the working tree, and you want to
-convert them back to the normal LF line endings when checking
-in to the repository.
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
 
-When `core.autocrlf` is set to "input", line endings are
-converted to LF upon checkin, but there is no conversion done
-upon checkout.
+This ensures that all files that git considers to be text will have
+normalized (LF) line endings in the repository.
+
+NOTE: When `crlf=auto` normalization is enabled in an existing
+repository, any text files containing CRLFs should be normalized.  If
+they are not they will be normalized the next time someone tries to
+change them, causing unfortunate misattribution.  From a clean working
+directory:
+
+-------------------------------------------------
+$ echo "* crlf=auto" >>.gitattributes
+                    # ...this should be the first line in .gitattributes
+$ rm .git/index     # Remove the index to force git to
+$ git reset         # re-scan the working directory
+$ git status        # Show files that will be normalized
+$ git add -u
+$ git add .gitattributes
+$ git commit -m "Introduce end-of-line normalization"
+-------------------------------------------------
+
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
index 46622b0..0eb3d4b 100644
--- a/convert.c
+++ b/convert.c
@@ -8,13 +8,17 @@
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
 
 struct text_stat {
 	/* NUL, CR, LF and CRLF counts */
@@ -89,13 +93,14 @@ static int is_binary(unsigned long size, struct text_stat *stats)
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
@@ -106,7 +111,8 @@ static void check_safe_crlf(const char *path, int action,
 			else /* i.e. SAFE_CRLF_FAIL */
 				die("CRLF would be replaced by LF in %s.", path);
 		}
-	} else if (auto_crlf > 0) {
+	} else if (action == CRLF_CRLF ||
+		   (action == CRLF_GUESS && auto_crlf == AUTO_CRLF_TRUE)) {
 		/*
 		 * CRLFs would be added by checkout:
 		 * check if we have "naked" LFs
@@ -157,18 +163,23 @@ static int has_cr_in_index(const char *path)
 	return has_cr;
 }
 
+static int should_guess_text(enum action action) {
+	return (action == CRLF_GUESS || action == CRLF_AUTO);
+}
+
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
+	if (should_guess_text(action)) {
 		/*
 		 * We're currently not going to even try to convert stuff
 		 * that has bare CR characters. Does anybody do that crazy
@@ -183,12 +194,14 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
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
@@ -201,7 +214,7 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 	if (strbuf_avail(buf) + buf->len < len)
 		strbuf_grow(buf, len - buf->len);
 	dst = buf->buf;
-	if (action == CRLF_GUESS) {
+	if (should_guess_text(action)) {
 		/*
 		 * If we guessed, we already know we rejected a file with
 		 * lone CR, and we can strip a CR without looking at what
@@ -224,13 +237,13 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
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
@@ -246,11 +259,13 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 	if (stats.lf == stats.crlf)
 		return 0;
 
-	if (action == CRLF_GUESS) {
-		/* If we have any CR or CRLF line endings, we do not touch it */
-		/* This is the new safer autocrlf-handling */
-		if (stats.cr > 0 || stats.crlf > 0)
-			return 0;
+	if (should_guess_text(action)) {
+		if (action == CRLF_GUESS) {
+			/* If we have any CR or CRLF line endings, we do not touch it */
+			/* This is the new safer autocrlf-handling */
+			if (stats.cr > 0 || stats.crlf > 0)
+				return 0;
+		}
 
 		/* If we have any bare CR characters, we're not going to touch it */
 		if (stats.cr != stats.crlf)
@@ -591,8 +606,12 @@ static int git_path_check_crlf(const char *path, struct git_attr_check *check)
 		return CRLF_BINARY;
 	else if (ATTR_UNSET(value))
 		;
-	else if (!strcmp(value, "input"))
+	else if (!strcmp(value, "input") || !strcmp(value, "lf"))
 		return CRLF_INPUT;
+	else if (!strcmp(value, "crlf"))
+		return CRLF_CRLF;
+	else if (!strcmp(value, "auto"))
+		return CRLF_AUTO;
 	return CRLF_GUESS;
 }
 
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
index 40048a7..f11fee4 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -41,7 +41,7 @@ test_expect_success 'default settings cause no changes' '
 	test -z "$onediff" -a -z "$twodiff"
 '
 
-test_expect_failure 'crlf=true causes a CRLF file to be normalized' '
+test_expect_success 'crlf=true causes a CRLF file to be normalized' '
 
 	rm -f .gitattributes tmp one two &&
 	echo "two crlf" > .gitattributes &&
@@ -53,7 +53,7 @@ test_expect_failure 'crlf=true causes a CRLF file to be normalized' '
 	test -n "$twodiff"
 '
 
-test_expect_failure 'crlf=crlf gives a normalized file CRLFs with autocrlf=false' '
+test_expect_success 'crlf=crlf gives a normalized file CRLFs with autocrlf=false' '
 
 	rm -f .gitattributes tmp one two &&
 	git config core.autocrlf false &&
@@ -65,7 +65,7 @@ test_expect_failure 'crlf=crlf gives a normalized file CRLFs with autocrlf=false
 	test -z "$onediff"
 '
 
-test_expect_failure 'crlf=crlf gives a normalized file CRLFs with autocrlf=input' '
+test_expect_success 'crlf=crlf gives a normalized file CRLFs with autocrlf=input' '
 
 	rm -f .gitattributes tmp one two &&
 	git config core.autocrlf input &&
@@ -77,7 +77,7 @@ test_expect_failure 'crlf=crlf gives a normalized file CRLFs with autocrlf=input
 	test -z "$onediff"
 '
 
-test_expect_failure 'crlf=lf gives a normalized file LFs with autocrlf=true' '
+test_expect_success 'crlf=lf gives a normalized file LFs with autocrlf=true' '
 
 	rm -f .gitattributes tmp one two &&
 	git config core.autocrlf true &&
@@ -102,7 +102,7 @@ test_expect_success 'autocrlf=true does not normalize CRLF files' '
 	test -z "$onediff" -a -z "$twodiff"
 '
 
-test_expect_failure 'crlf=auto, autocrlf=true _does_ normalize CRLF files' '
+test_expect_success 'crlf=auto, autocrlf=true _does_ normalize CRLF files' '
 
 	rm -f .gitattributes tmp one two &&
 	git config core.autocrlf true &&
-- 
1.7.1.3.g448cb.dirty
