From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v2] Add "core.eol" config variable
Date: Sun, 16 May 2010 21:12:39 +0200
Message-ID: <1274037159-85389-1-git-send-email-eyvind.bernhardsen@gmail.com>
Cc: msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 16 21:15:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODjIg-0007iq-Qn
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 21:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899Ab0EPTMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 May 2010 15:12:48 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:46347 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab0EPTMr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 15:12:47 -0400
Received: by ewy8 with SMTP id 8so1531887ewy.28
        for <git@vger.kernel.org>; Sun, 16 May 2010 12:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=pSarkezgE9jEPu/oNtjuFgIiZPE4R01itZHzGiaacj0=;
        b=LUtincg0kAOlJ0tsWI8v2hw1UHwM9ElaEqPrlwZQwoiqzzfnlrja9toECSI7Z+GllC
         iKHfFHx0sgTXt7TFYsIpMijwSLXQs1OfdpZLKE0pSqZ8YoSXm8H/E6CLjx1aFegZbBod
         WvbR3Tf+jd5iP+AizCIdKYSiftKvLjFtPufqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dXENvY4qHWAwDzGCtNFn3YCwLXA95HkkwxqaLMge21X4BqmzsOgG1GPmK08eV2pp8k
         1Kkpy2qICFs/GBo/Oqi5XHpXFY5ZJi9k/tYV9jib+FoKpWDdiEfK9wIAUif0zyfPgQ98
         1b3z6lzRsWk+4MIWHrht1TZF5j2yIawtBKyJY=
Received: by 10.213.68.129 with SMTP id v1mr2105417ebi.1.1274037165246;
        Sun, 16 May 2010 12:12:45 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 14sm2464909ewy.10.2010.05.16.12.12.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 May 2010 12:12:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.5.gc3ee8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147199>

Introduce a new configuration variable, "core.eol", that allows the user
to set which line endings to use for end-of-line-normalized files in the
working directory.  It defaults to "native", which means CRLF on Windows
and LF everywhere else.

For backwards compatibility, "core.autocrlf" will override core.eol if
core.eol is left unset.  This means that

[core]
	autocrlf = true

will give CRLFs in the working directory even on platforms with LF as
their native line ending.

If core.eol is set explicitly (including setting it to "native"), it
will override core.autocrlf so that

[core]
        autocrlf = true
        eol = lf

normalizes all files that look like text, but does not put CRLFs in the
working directory.

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---

Quick fix for the "core.eol" patch; I'd forgotten to update the
safecrlf test.  Also made git complain if core.autocrlf is "input" and
core.eol is explicitly set to "crlf".
-- 
Eyvind


 Documentation/config.txt        |    8 ++++
 Documentation/gitattributes.txt |    6 ++-
 Makefile                        |    3 +
 cache.h                         |   13 ++++++
 config.c                        |   16 +++++++
 convert.c                       |   56 +++++++++++++++++---------
 environment.c                   |    1 +
 t/t0026-eol-config.sh           |   83 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 166 insertions(+), 20 deletions(-)
 create mode 100755 t/t0026-eol-config.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 207351b..7cc15a4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -207,6 +207,14 @@ core.autocrlf::
 	the file's `text` attribute, or if `text` is unspecified,
 	based on the file's contents.  See linkgit:gitattributes[5].
 
+core.eol::
+	Sets the line ending type to use in the working directory for
+	files that have the `text` property set.  Alternatives are
+	'lf', 'crlf' and 'native', which uses the platform's native
+	line ending.  The default value is `native`.  See
+	linkgit:gitattributes[5] for more information on end-of-line
+	conversion.
+
 core.safecrlf::
 	If true, makes git check if converting `CRLF` is reversible when
 	end-of-line conversion is active.  Git will verify if a command
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index f091f08..be1f160 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -207,7 +207,11 @@ attribute to "auto" for _all_ files.
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
index a309e07..9f4ee81 100644
--- a/convert.c
+++ b/convert.c
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
@@ -99,14 +93,40 @@ static int is_binary(unsigned long size, struct text_stat *stats)
 	return 0;
 }
 
+static enum eol get_output_conversion(enum action action) {
+	switch (action) {
+	case CRLF_BINARY:
+		return EOL_UNSET;
+	case CRLF_CRLF:
+		return EOL_CRLF;
+	case CRLF_INPUT:
+		return EOL_LF;
+	case CRLF_GUESS:
+		if (auto_crlf == AUTO_CRLF_FALSE)
+			return EOL_UNSET;
+		/* fall through */
+	case CRLF_TEXT:
+	case CRLF_AUTO:
+		if (eol == EOL_UNSET) {
+			if (auto_crlf == AUTO_CRLF_FALSE)
+				return EOL_NATIVE;
+			else if (auto_crlf == AUTO_CRLF_TRUE)
+				return EOL_CRLF;
+			else
+				return EOL_LF;
+		} else {
+			return eol;
+		}
+	}
+}
+
 static void check_safe_crlf(const char *path, enum action action,
                             struct text_stat *stats, enum safe_crlf checksafe)
 {
 	if (!checksafe)
 		return;
 
-	if (action == CRLF_INPUT ||
-	    (action == CRLF_GUESS && auto_crlf == AUTO_CRLF_INPUT)) {
+	if (get_output_conversion(action) == EOL_LF) {
 		/*
 		 * CRLFs would not be restored by checkout:
 		 * check if we'd remove CRLFs
@@ -117,8 +137,7 @@ static void check_safe_crlf(const char *path, enum action action,
 			else /* i.e. SAFE_CRLF_FAIL */
 				die("CRLF would be replaced by LF in %s.", path);
 		}
-	} else if (action == CRLF_CRLF ||
-		   (action == CRLF_GUESS && auto_crlf == AUTO_CRLF_TRUE)) {
+	} else if (get_output_conversion(action) == EOL_CRLF) {
 		/*
 		 * CRLFs would be added by checkout:
 		 * check if we have "naked" LFs
@@ -244,11 +263,10 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 	char *to_free = NULL;
 	struct text_stat stats;
 
-	if ((action == CRLF_BINARY) || (action == CRLF_INPUT) ||
-	    (action != CRLF_CRLF && auto_crlf != AUTO_CRLF_TRUE))
+	if (!len)
 		return 0;
 
-	if (!len)
+	if (get_output_conversion(action) != EOL_CRLF)
 		return 0;
 
 	gather_stats(src, len, &stats);
@@ -670,7 +688,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 {
 	struct git_attr_check check[5];
 	enum action action = CRLF_GUESS;
-	enum eol eol = EOL_UNSET;
+	enum eol eol_attr = EOL_UNSET;
 	int ident = 0, ret = 0;
 	const char *filter = NULL;
 
@@ -682,7 +700,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 			action = git_path_check_crlf(path, check + 0);
 		ident = git_path_check_ident(path, check + 1);
 		drv = git_path_check_convert(path, check + 2);
-		eol = git_path_check_eol(path, check + 3);
+		eol_attr = git_path_check_eol(path, check + 3);
 		if (drv && drv->clean)
 			filter = drv->clean;
 	}
@@ -692,7 +710,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		src = dst->buf;
 		len = dst->len;
 	}
-	action = determine_action(action, eol);
+	action = determine_action(action, eol_attr);
 	ret |= crlf_to_git(path, src, len, dst, action, checksafe);
 	if (ret) {
 		src = dst->buf;
@@ -705,7 +723,7 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 {
 	struct git_attr_check check[5];
 	enum action action = CRLF_GUESS;
-	enum eol eol = EOL_UNSET;
+	enum eol eol_attr = EOL_UNSET;
 	int ident = 0, ret = 0;
 	const char *filter = NULL;
 
@@ -717,7 +735,7 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 			action = git_path_check_crlf(path, check + 0);
 		ident = git_path_check_ident(path, check + 1);
 		drv = git_path_check_convert(path, check + 2);
-		eol = git_path_check_eol(path, check + 3);
+		eol_attr = git_path_check_eol(path, check + 3);
 		if (drv && drv->smudge)
 			filter = drv->smudge;
 	}
@@ -727,7 +745,7 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
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
index 0000000..5b6c297
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
+test_expect_success 'eol=lf overrides autocrlf=true' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.eol lf &&
+	git config core.autocrlf true &&
+	git read-tree --reset -u HEAD &&
+
+	! has_cr one &&
+	! has_cr two &&
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
1.7.1.5.gc3ee8
