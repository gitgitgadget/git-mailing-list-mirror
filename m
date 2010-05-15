From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH] Add "core.eol" variable to control end-of-line conversion
Date: Sat, 15 May 2010 22:47:25 +0200
Message-ID: <1273956445-67531-1-git-send-email-eyvind.bernhardsen@gmail.com>
References: <alpine.LFD.2.00.1005141421560.3711@i5.linux-foundation.org>
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 15 22:47:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODOGy-0003Wt-KD
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 22:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453Ab0EOUrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 16:47:31 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:61667 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab0EOUra (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 16:47:30 -0400
Received: by ewy8 with SMTP id 8so1261846ewy.28
        for <git@vger.kernel.org>; Sat, 15 May 2010 13:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/CPyM0H0oX4red6bLmED/phL1OkgSrLZ7tv4XfSvrdg=;
        b=Xg2U5bID+9olewXNWoor1QiXrj0yNJL3w5Fo6OFoNdcjzeQMVyxriREF3LmiJt/kOc
         fPJFhNtFoDcQVpXACCF4o2U6t9c+UKyZ9j7YGdIof/pe9otl1qwjbFln4OfEz85ZXwG+
         E2r4ERjnhi27BfXchoCEBHnWk7HsWyPMgzjnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RVMjqldIWA360pEy/ZSyoWBqmWETssC/gFx8Hv9nxyaHtbomGDU+h17/wPM5z9SnBE
         f5WUZ8VtIN1W9N6c2W0MlrvAFsx3FbI7QMdTCVfeUupLLxaNDaORvouN7gq0CU6vchGV
         LKcAI6xr1amdHfK/ud+jd5QYW867aMLB6oA5s=
Received: by 10.213.37.67 with SMTP id w3mr1187874ebd.69.1273956449110;
        Sat, 15 May 2010 13:47:29 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm1958715ewy.9.2010.05.15.13.47.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 13:47:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.5.gd739a
In-Reply-To: <alpine.LFD.2.00.1005141421560.3711@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147164>

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

It turns out that my resistance to "core.eol" was mostly laziness, so I
just implemented it.

I decided that "core.autocrlf" has to override the native line ending if
"core.eol" isn't set explicitly, which gives some extra complexity in
convert.c.

For 1.8 I would consider making core.autocrlf just turn on normalization
and leave the working directory line ending decision to core.eol, but
that _will_ break people's setups.

Patch is on top of my latest series.
-- 
Eyvind

 Documentation/config.txt        |    8 ++++
 Documentation/gitattributes.txt |    6 ++-
 Makefile                        |    3 +
 cache.h                         |   13 ++++++
 config.c                        |   12 ++++++
 convert.c                       |   39 +++++++++++-------
 environment.c                   |    1 +
 t/t0026-eol-config.sh           |   83 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 149 insertions(+), 16 deletions(-)
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
index 25753b7..8268c09 100644
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
index b60a1ff..4edd940 100644
--- a/config.c
+++ b/config.c
@@ -477,6 +477,18 @@ static int git_default_core_config(const char *var, const char *value)
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
+		return 0;
+	}
+
 	if (!strcmp(var, "core.notesref")) {
 		notes_ref_name = xstrdup(value);
 		return 0;
diff --git a/convert.c b/convert.c
index a309e07..b7ee469 100644
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
@@ -244,12 +238,27 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 	char *to_free = NULL;
 	struct text_stat stats;
 
-	if ((action == CRLF_BINARY) || (action == CRLF_INPUT) ||
-	    (action != CRLF_CRLF && auto_crlf != AUTO_CRLF_TRUE))
+	if (!len)
 		return 0;
 
-	if (!len)
+	switch (action) {
+	case CRLF_CRLF:
+		break;
+	case CRLF_BINARY:
+	case CRLF_INPUT:
 		return 0;
+	case CRLF_GUESS:
+		if (auto_crlf == AUTO_CRLF_FALSE)
+			return 0;
+		/* fall through */
+	case CRLF_TEXT:
+	case CRLF_AUTO:
+		if (eol == EOL_LF ||
+		    (eol == EOL_UNSET &&
+		     (auto_crlf == AUTO_CRLF_INPUT ||
+		      auto_crlf == AUTO_CRLF_FALSE && EOL_NATIVE == EOL_LF)))
+			return 0;
+	}
 
 	gather_stats(src, len, &stats);
 
@@ -670,7 +679,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 {
 	struct git_attr_check check[5];
 	enum action action = CRLF_GUESS;
-	enum eol eol = EOL_UNSET;
+	enum eol eol_attr = EOL_UNSET;
 	int ident = 0, ret = 0;
 	const char *filter = NULL;
 
@@ -682,7 +691,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 			action = git_path_check_crlf(path, check + 0);
 		ident = git_path_check_ident(path, check + 1);
 		drv = git_path_check_convert(path, check + 2);
-		eol = git_path_check_eol(path, check + 3);
+		eol_attr = git_path_check_eol(path, check + 3);
 		if (drv && drv->clean)
 			filter = drv->clean;
 	}
@@ -692,7 +701,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		src = dst->buf;
 		len = dst->len;
 	}
-	action = determine_action(action, eol);
+	action = determine_action(action, eol_attr);
 	ret |= crlf_to_git(path, src, len, dst, action, checksafe);
 	if (ret) {
 		src = dst->buf;
@@ -705,7 +714,7 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 {
 	struct git_attr_check check[5];
 	enum action action = CRLF_GUESS;
-	enum eol eol = EOL_UNSET;
+	enum eol eol_attr = EOL_UNSET;
 	int ident = 0, ret = 0;
 	const char *filter = NULL;
 
@@ -717,7 +726,7 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 			action = git_path_check_crlf(path, check + 0);
 		ident = git_path_check_ident(path, check + 1);
 		drv = git_path_check_convert(path, check + 2);
-		eol = git_path_check_eol(path, check + 3);
+		eol_attr = git_path_check_eol(path, check + 3);
 		if (drv && drv->smudge)
 			filter = drv->smudge;
 	}
@@ -727,7 +736,7 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
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
1.7.1.5.gd739a
