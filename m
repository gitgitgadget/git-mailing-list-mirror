From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v6] Add "core.eol" config variable
Date: Fri,  4 Jun 2010 21:29:08 +0200
Message-ID: <1275679748-7214-1-git-send-email-eyvind.bernhardsen@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 21:29:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKcaH-0002lv-UU
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 21:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533Ab0FDT3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 15:29:33 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:46436 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab0FDT3a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 15:29:30 -0400
Received: by ewy23 with SMTP id 23so399433ewy.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=GtWuRQU9dc1WdZoQ6xouWCYdk+QbW6/VSHY/HBBgjjY=;
        b=qnaUd7+grq7PSnpKhLXU6htKyGQpheqJ1SbQObjIGKIMZNP6diNvox+uUHplt4J/u9
         4hIU3PI6gdHbutYH+Ksi5ddkVr8YVhlgYBOS4nY1pJqyrOK/OhOOEaPi/MLamoxw2v7r
         hDaYWz2Gcd4C+lfAiia9UNG1ZOxRjjX/2tWIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=L03PlKCX1VfXQcFlH+MCxcH6DCF4HyGEqUZWLIrWX6twUhXNYbR2wMj7ca+KaSQrI6
         qxCaO5B24O6C55VZaJYszrrpTqejyDwyydjtXr2zbQbQAddRYqEnGdSIYh4j7LT0+hL4
         zSEd0PAfYuaWvCtezhHK6LO4DGtknMaXhGJ5s=
Received: by 10.213.31.133 with SMTP id y5mr754026ebc.68.1275679767748;
        Fri, 04 Jun 2010 12:29:27 -0700 (PDT)
Received: from localhost.localdomain ([62.113.137.5])
        by mx.google.com with ESMTPS id 16sm898906ewy.11.2010.06.04.12.29.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 12:29:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.5.g0ed10.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148436>

Introduce a new configuration variable, "core.eol", that allows the user
to set which line endings to use for end-of-line-normalized files in the
working directory.  It defaults to "native", which means CRLF on Windows
and LF everywhere else.

Note that "core.autocrlf" overrides core.eol.  This means that

[core]
	autocrlf = true

puts CRLFs in the working directory even if core.eol is set to "lf".

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
As Clemens Buchacher noted, "core.autocrlf" doesn't work as a generic
"turn on automatic line ending normalization" setting since it doesn't
always normalize line endings.

This is a replacement for the 'Add "core.eol" config variable' commit
that's currently in pu (the last one in my series).  Instead of implying
that "core.autocrlf=true" is a replacement for "* text=auto", it makes
explicit the fact that autocrlf is only for users who want to work with
CRLFs in their working directory on a repository that doesn't have text
file normalization.  When it is enabled, "core.eol" is ignored.
-- 
Eyvind

 Documentation/config.txt        |   35 ++++++++++-------
 Documentation/gitattributes.txt |   28 +++++++------
 Makefile                        |    3 +
 cache.h                         |   13 ++++++
 config.c                        |   16 +++++++
 convert.c                       |   60 +++++++++++++++++-----------
 environment.c                   |    1 +
 t/t0026-eol-config.sh           |   83 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 188 insertions(+), 51 deletions(-)
 create mode 100755 t/t0026-eol-config.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 207351b..5a0737a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -196,16 +196,13 @@ core.quotepath::
 	quoted without `-z` regardless of the setting of this
 	variable.
 
-core.autocrlf::
-	If true, makes git convert `CRLF` at the end of lines in text files to
-	`LF` when reading from the work tree, and convert in reverse when
-	writing to the work tree.  The variable can be set to
-	'input', in which case the conversion happens only while
-	reading from the work tree but files are written out to the work
-	tree with `LF` at the end of lines.  A file is considered
-	"text" (i.e. be subjected to the autocrlf mechanism) based on
-	the file's `text` attribute, or if `text` is unspecified,
-	based on the file's contents.  See linkgit:gitattributes[5].
+core.eol::
+	Sets the line ending type to use in the working directory for
+	files that have the `text` property set.  Alternatives are
+	'lf', 'crlf' and 'native', which uses the platform's native
+	line ending.  The default value is `native`.  See
+	linkgit:gitattributes[5] for more information on end-of-line
+	conversion.
 
 core.safecrlf::
 	If true, makes git check if converting `CRLF` is reversible when
@@ -219,7 +216,7 @@ core.safecrlf::
 	irreversible conversion but continue the operation.
 +
 CRLF conversion bears a slight chance of corrupting data.
-autocrlf=true will convert CRLF to LF during commit and LF to
+When it is enabled, git will convert CRLF to LF during commit and LF to
 CRLF during checkout.  A file that contains a mixture of LF and
 CRLF before the commit cannot be recreated by git.  For text
 files this is the right thing to do: it corrects line endings
@@ -243,15 +240,25 @@ converting CRLFs corrupts data.
 +
 Note, this safety check does not mean that a checkout will generate a
 file identical to the original file for a different setting of
-`core.autocrlf`, but only for the current one.  For example, a text
-file with `LF` would be accepted with `core.autocrlf=input` and could
-later be checked out with `core.autocrlf=true`, in which case the
+`core.eol` and `core.autocrlf`, but only for the current one.  For
+example, a text file with `LF` would be accepted with `core.eol=lf`
+and could later be checked out with `core.eol=crlf`, in which case the
 resulting file would contain `CRLF`, although the original file
 contained `LF`.  However, in both work trees the line endings would be
 consistent, that is either all `LF` or all `CRLF`, but never mixed.  A
 file with mixed line endings would be reported by the `core.safecrlf`
 mechanism.
 
+core.autocrlf::
+	Setting this variable to "true" is almost the same as setting
+	the `text` attribute to "auto" on all files except that text
+	files are not guaranteed to be normalized: files that contain
+	`CRLF` in the repository will not be touched.  Use this
+	setting if you want to have `CRLF` line endings in your
+	working directory even though the repository does not have
+	normalized line endings.  This variable can be set to 'input',
+	in which case no output conversion is performed.
+
 core.symlinks::
 	If false, symbolic links are checked out as small plain files that
 	contain the link text. linkgit:git-update-index[1] and
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index f091f08..fce203d 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -99,7 +99,7 @@ This attribute enables and controls end-of-line normalization.  When a
 text file is normalized, its line endings are converted to LF in the
 repository.  To control what line ending style is used in the working
 directory, use the `eol` attribute for a single file and the
-`core.autocrlf` configuration variable for all text files.
+`core.eol` configuration variable for all text files.
 
 Set::
 
@@ -120,9 +120,9 @@ Set to string value "auto"::
 
 Unspecified::
 
-	If the `text` attribute is unspecified, git uses the `eol`
-	attribute and the `core.autocrlf` configuration variable to
-	determine if the file should be converted.
+	If the `text` attribute is unspecified, git uses the
+	`core.autocrlf` configuration variable to determine if the
+	file should be converted.
 
 Any other value causes git to act as if `text` has been left
 unspecified.
@@ -132,19 +132,19 @@ unspecified.
 
 This attribute sets a specific line-ending style to be used in the
 working directory.  It enables end-of-line normalization without any
-content checks, similar to setting the `text` attribute.
+content checks, effectively setting the `text` attribute.
 
 Set to string value "crlf"::
 
-	This setting forces git to normalize line endings on checkin
-	and convert them to CRLF when the file is checked out,
-	regardless of `text` and `core.autocrlf`.
+	This setting forces git to normalize line endings for this
+	file on checkin and convert them to CRLF when the file is
+	checked out.
 
 Set to string value "lf"::
 
 	This setting forces git to normalize line endings to LF on
 	checkin and prevents conversion to CRLF when the file is
-	checked out, regardless of `text` and `core.autocrlf`.
+	checked out.
 
 Backwards compatibility with `crlf` attribute
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -193,9 +193,7 @@ config variable "core.autocrlf" without changing any attributes.
 This does not force normalization of all text files, but does ensure
 that text files that you introduce to the repository have their line
 endings normalized to LF when they are added, and that files that are
-already normalized in the repository stay normalized.  You can also
-set `autocrlf` to "input" to have automatic normalization of new text
-files without conversion to CRLF in the working directory.
+already normalized in the repository stay normalized.
 
 If you want to interoperate with a source code management system that
 enforces end-of-line normalization, or you simply want all text files
@@ -207,7 +205,11 @@ attribute to "auto" for _all_ files.
 ------------------------
 
 This ensures that all files that git considers to be text will have
-normalized (LF) line endings in the repository.
+normalized (LF) line endings in the repository.  The `core.eol`
+configuration variable controls which line endings git will use for
+normalized files in your working directory; the default is to use the
+native line ending for your platform, or CRLF if `core.autocrlf` is
+set.
 
 NOTE: When `text=auto` normalization is enabled in an existing
 repository, any text files containing CRLFs should be normalized.  If
diff --git a/Makefile b/Makefile
index 910f471..419532e 100644
--- a/Makefile
+++ b/Makefile
@@ -224,6 +224,8 @@ all::
 #
 # Define CHECK_HEADER_DEPENDENCIES to check for problems in the hard-coded
 # dependency rules.
+#
+# Define NATIVE_CRLF if your platform uses CRLF for line endings.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -989,6 +991,7 @@ ifeq ($(uname_S),Windows)
 	NO_CURL = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
+	NATIVE_CRLF = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
diff --git a/cache.h b/cache.h
index d1f669e..ac6bfbd 100644
--- a/cache.h
+++ b/cache.h
@@ -568,6 +568,19 @@ enum auto_crlf {
 
 extern enum auto_crlf auto_crlf;
 
+enum eol {
+	EOL_UNSET,
+	EOL_CRLF,
+	EOL_LF,
+#ifdef NATIVE_CRLF
+	EOL_NATIVE = EOL_CRLF
+#else
+	EOL_NATIVE = EOL_LF
+#endif
+};
+
+extern enum eol eol;
+
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
 	BRANCH_TRACK_NEVER = 0,
diff --git a/config.c b/config.c
index b60a1ff..1479ee6 100644
--- a/config.c
+++ b/config.c
@@ -461,6 +461,8 @@ static int git_default_core_config(const char *var, const char *value)
 
 	if (!strcmp(var, "core.autocrlf")) {
 		if (value && !strcasecmp(value, "input")) {
+			if (eol == EOL_CRLF)
+				return error("core.autocrlf=input conflicts with core.eol=crlf");
 			auto_crlf = AUTO_CRLF_INPUT;
 			return 0;
 		}
@@ -477,6 +479,20 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.eol")) {
+		if (value && !strcasecmp(value, "lf"))
+			eol = EOL_LF;
+		else if (value && !strcasecmp(value, "crlf"))
+			eol = EOL_CRLF;
+		else if (value && !strcasecmp(value, "native"))
+			eol = EOL_NATIVE;
+		else
+			eol = EOL_UNSET;
+		if (eol == EOL_CRLF && auto_crlf == AUTO_CRLF_INPUT)
+			return error("core.autocrlf=input conflicts with core.eol=crlf");
+		return 0;
+	}
+
 	if (!strcmp(var, "core.notesref")) {
 		notes_ref_name = xstrdup(value);
 		return 0;
diff --git a/convert.c b/convert.c
index a309e07..915949e 100644
--- a/convert.c
+++ b/convert.c
@@ -8,7 +8,7 @@
  * This should use the pathname to decide on whether it wants to do some
  * more interesting conversions (automatic gzip/unzip, general format
  * conversions etc etc), but by default it just does automatic CRLF<->LF
- * translation when the "crlf" attribute or "auto_crlf" option is set.
+ * translation when the "text" attribute or "auto_crlf" option is set.
  */
 
 enum action {
@@ -20,12 +20,6 @@ enum action {
 	CRLF_AUTO,
 };
 
-enum eol {
-	EOL_UNSET,
-	EOL_LF,
-	EOL_CRLF,
-};
-
 struct text_stat {
 	/* NUL, CR, LF and CRLF counts */
 	unsigned nul, cr, lf, crlf;
@@ -99,33 +93,55 @@ static int is_binary(unsigned long size, struct text_stat *stats)
 	return 0;
 }
 
+static enum eol determine_output_conversion(enum action action) {
+	switch (action) {
+	case CRLF_BINARY:
+		return EOL_UNSET;
+	case CRLF_CRLF:
+		return EOL_CRLF;
+	case CRLF_INPUT:
+		return EOL_LF;
+	case CRLF_GUESS:
+		if (!auto_crlf)
+			return EOL_UNSET;
+		/* fall through */
+	case CRLF_TEXT:
+	case CRLF_AUTO:
+		if (auto_crlf == AUTO_CRLF_TRUE)
+			return EOL_CRLF;
+		else if (auto_crlf == AUTO_CRLF_INPUT)
+			return EOL_LF;
+		else if (eol == EOL_UNSET)
+			return EOL_NATIVE;
+	}
+	return eol;
+}
+
 static void check_safe_crlf(const char *path, enum action action,
                             struct text_stat *stats, enum safe_crlf checksafe)
 {
 	if (!checksafe)
 		return;
 
-	if (action == CRLF_INPUT ||
-	    (action == CRLF_GUESS && auto_crlf == AUTO_CRLF_INPUT)) {
+	if (determine_output_conversion(action) == EOL_LF) {
 		/*
 		 * CRLFs would not be restored by checkout:
 		 * check if we'd remove CRLFs
 		 */
 		if (stats->crlf) {
 			if (checksafe == SAFE_CRLF_WARN)
-				warning("CRLF will be replaced by LF in %s.", path);
+				warning("CRLF will be replaced by LF in %s.\nThe file will have its original line endings in your working directory.", path);
 			else /* i.e. SAFE_CRLF_FAIL */
 				die("CRLF would be replaced by LF in %s.", path);
 		}
-	} else if (action == CRLF_CRLF ||
-		   (action == CRLF_GUESS && auto_crlf == AUTO_CRLF_TRUE)) {
+	} else if (determine_output_conversion(action) == EOL_CRLF) {
 		/*
 		 * CRLFs would be added by checkout:
 		 * check if we have "naked" LFs
 		 */
 		if (stats->lf != stats->crlf) {
 			if (checksafe == SAFE_CRLF_WARN)
-				warning("LF will be replaced by CRLF in %s", path);
+				warning("LF will be replaced by CRLF in %s.\nThe file will have its original line endings in your working directory.", path);
 			else /* i.e. SAFE_CRLF_FAIL */
 				die("LF would be replaced by CRLF in %s", path);
 		}
@@ -244,11 +260,7 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 	char *to_free = NULL;
 	struct text_stat stats;
 
-	if ((action == CRLF_BINARY) || (action == CRLF_INPUT) ||
-	    (action != CRLF_CRLF && auto_crlf != AUTO_CRLF_TRUE))
-		return 0;
-
-	if (!len)
+	if (!len || determine_output_conversion(action) != EOL_CRLF)
 		return 0;
 
 	gather_stats(src, len, &stats);
@@ -670,7 +682,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 {
 	struct git_attr_check check[5];
 	enum action action = CRLF_GUESS;
-	enum eol eol = EOL_UNSET;
+	enum eol eol_attr = EOL_UNSET;
 	int ident = 0, ret = 0;
 	const char *filter = NULL;
 
@@ -682,7 +694,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 			action = git_path_check_crlf(path, check + 0);
 		ident = git_path_check_ident(path, check + 1);
 		drv = git_path_check_convert(path, check + 2);
-		eol = git_path_check_eol(path, check + 3);
+		eol_attr = git_path_check_eol(path, check + 3);
 		if (drv && drv->clean)
 			filter = drv->clean;
 	}
@@ -692,7 +704,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		src = dst->buf;
 		len = dst->len;
 	}
-	action = determine_action(action, eol);
+	action = determine_action(action, eol_attr);
 	ret |= crlf_to_git(path, src, len, dst, action, checksafe);
 	if (ret) {
 		src = dst->buf;
@@ -705,7 +717,7 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 {
 	struct git_attr_check check[5];
 	enum action action = CRLF_GUESS;
-	enum eol eol = EOL_UNSET;
+	enum eol eol_attr = EOL_UNSET;
 	int ident = 0, ret = 0;
 	const char *filter = NULL;
 
@@ -717,7 +729,7 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 			action = git_path_check_crlf(path, check + 0);
 		ident = git_path_check_ident(path, check + 1);
 		drv = git_path_check_convert(path, check + 2);
-		eol = git_path_check_eol(path, check + 3);
+		eol_attr = git_path_check_eol(path, check + 3);
 		if (drv && drv->smudge)
 			filter = drv->smudge;
 	}
@@ -727,7 +739,7 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 		src = dst->buf;
 		len = dst->len;
 	}
-	action = determine_action(action, eol);
+	action = determine_action(action, eol_attr);
 	ret |= crlf_to_worktree(path, src, len, dst, action);
 	if (ret) {
 		src = dst->buf;
diff --git a/environment.c b/environment.c
index db4a5e9..83d38d3 100644
--- a/environment.c
+++ b/environment.c
@@ -40,6 +40,7 @@ const char *editor_program;
 const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int read_replace_refs = 1;
+enum eol eol = EOL_UNSET;
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
diff --git a/t/t0026-eol-config.sh b/t/t0026-eol-config.sh
new file mode 100755
index 0000000..f37ac8f
--- /dev/null
+++ b/t/t0026-eol-config.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+
+test_description='CRLF conversion'
+
+. ./test-lib.sh
+
+has_cr() {
+	tr '\015' Q <"$1" | grep Q >/dev/null
+}
+
+test_expect_success setup '
+
+	git config core.autocrlf false &&
+
+	echo "one text" > .gitattributes
+
+	for w in Hello world how are you; do echo $w; done >one &&
+	for w in I am very very fine thank you; do echo $w; done >two &&
+	git add . &&
+
+	git commit -m initial &&
+
+	one=`git rev-parse HEAD:one` &&
+	two=`git rev-parse HEAD:two` &&
+
+	echo happy.
+'
+
+test_expect_success 'eol=lf puts LFs in normalized file' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.eol lf &&
+	git read-tree --reset -u HEAD &&
+
+	! has_cr one &&
+	! has_cr two &&
+	onediff=`git diff one` &&
+	twodiff=`git diff two` &&
+	test -z "$onediff" -a -z "$twodiff"
+'
+
+test_expect_success 'eol=crlf puts CRLFs in normalized file' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.eol crlf &&
+	git read-tree --reset -u HEAD &&
+
+	has_cr one &&
+	! has_cr two &&
+	onediff=`git diff one` &&
+	twodiff=`git diff two` &&
+	test -z "$onediff" -a -z "$twodiff"
+'
+
+test_expect_success 'autocrlf=true overrides eol=lf' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.eol lf &&
+	git config core.autocrlf true &&
+	git read-tree --reset -u HEAD &&
+
+	has_cr one &&
+	has_cr two &&
+	onediff=`git diff one` &&
+	twodiff=`git diff two` &&
+	test -z "$onediff" -a -z "$twodiff"
+'
+
+test_expect_success 'autocrlf=true overrides unset eol' '
+
+	rm -f .gitattributes tmp one two &&
+	git config --unset-all core.eol &&
+	git config core.autocrlf true &&
+	git read-tree --reset -u HEAD &&
+
+	has_cr one &&
+	has_cr two &&
+	onediff=`git diff one` &&
+	twodiff=`git diff two` &&
+	test -z "$onediff" -a -z "$twodiff"
+'
+
+test_done
-- 
1.7.1.5.g82828
